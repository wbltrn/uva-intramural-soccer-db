"""Games view."""

from __future__ import annotations

import streamlit as st

from auth import is_admin
from db import execute, run_query
from ui import page_header, show_table


def render() -> None:
    page_header(
        "Games",
        "Browse scheduled and completed matches. Admins can schedule games and record scores.",
    )

    if is_admin():
        tab_view, tab_schedule, tab_score = st.tabs(
            ["Game Schedule", "Schedule Game", "Record Score"]
        )
    else:
        tab_view = st.container()
        tab_schedule = None
        tab_score = None

    with tab_view:
        season_filter = st.selectbox(
            "Filter by season",
            ["All Seasons"]
            + run_query("SELECT season_name FROM Season ORDER BY start_date")[
                "season_name"
            ].tolist(),
        )
        status_filter = st.selectbox(
            "Filter by status", ["All", "Scheduled", "Completed", "Cancelled"]
        )

        query = """
            SELECT season_name, game_date, start_time, home_team, away_team,
                   home_score, away_score, game_status, location, result
            FROM v_game_details
            WHERE 1=1
        """
        params: list = []
        if season_filter != "All Seasons":
            query += " AND season_name = ?"
            params.append(season_filter)
        if status_filter != "All":
            query += " AND game_status = ?"
            params.append(status_filter)
        query += " ORDER BY game_date, start_time"

        show_table(run_query(query, params), height=420)

    if is_admin() and tab_schedule is not None:
        with tab_schedule:
            _render_schedule_form()

    if is_admin() and tab_score is not None:
        with tab_score:
            _render_score_form()


def _render_schedule_form() -> None:
    seasons = run_query("SELECT season_id, season_name FROM Season ORDER BY start_date")
    locations = run_query(
        "SELECT location_id, field_name FROM Location WHERE availability_status = 'Available'"
    )
    if seasons.empty or locations.empty:
        st.warning("Seasons and available locations are required before scheduling.")
        return

    with st.form("schedule_game_form"):
        c1, c2 = st.columns(2)
        season_id = c1.selectbox(
            "Season",
            seasons["season_id"].tolist(),
            format_func=lambda sid: seasons.set_index("season_id").loc[sid, "season_name"],
        )
        location_id = c2.selectbox(
            "Location",
            locations["location_id"].tolist(),
            format_func=lambda lid: locations.set_index("location_id").loc[lid, "field_name"],
        )

        team_seasons = run_query(
            """
            SELECT ts.team_season_id, t.team_name
            FROM Team_Season ts
            JOIN Team t ON ts.team_id = t.team_id
            WHERE ts.season_id = ?
            ORDER BY t.team_name
            """,
            (season_id,),
        )
        if len(team_seasons) < 2:
            st.warning("At least two teams are needed in this season to schedule a game.")
            return

        labels = dict(zip(team_seasons["team_season_id"], team_seasons["team_name"]))
        home_id = c1.selectbox(
            "Home Team",
            team_seasons["team_season_id"].tolist(),
            format_func=lambda x: labels[x],
        )
        away_options = [
            ts_id for ts_id in team_seasons["team_season_id"].tolist() if ts_id != home_id
        ]
        away_id = c2.selectbox(
            "Away Team",
            away_options,
            format_func=lambda x: labels[x],
        )
        game_date = c1.date_input("Game Date")
        start_time = c2.text_input("Start Time (HH:MM:SS)", value="10:00:00")

        if st.form_submit_button("Schedule Game", type="primary"):
            execute(
                """
                INSERT INTO Game
                    (season_id, home_team_season_id, away_team_season_id,
                     location_id, game_date, start_time)
                VALUES (?, ?, ?, ?, ?, ?)
                """,
                (
                    season_id,
                    home_id,
                    away_id,
                    location_id,
                    game_date.isoformat(),
                    start_time,
                ),
            )
            st.success("Game scheduled.")
            st.rerun()


def _render_score_form() -> None:
    game_options = run_query(
        """
        SELECT game_id, game_date || ' — ' || home_team || ' vs ' || away_team AS label
        FROM v_game_details
        WHERE game_status = 'Scheduled'
        ORDER BY game_date
        """
    )
    if game_options.empty:
        st.info("No scheduled games available to score.")
        return

    labels = dict(zip(game_options["game_id"], game_options["label"]))
    with st.form("score_game_form"):
        game_id = st.selectbox(
            "Game",
            game_options["game_id"].tolist(),
            format_func=lambda gid: labels[gid],
        )
        c1, c2 = st.columns(2)
        home_score = c1.number_input("Home Score", min_value=0, step=1)
        away_score = c2.number_input("Away Score", min_value=0, step=1)
        if st.form_submit_button("Save Score", type="primary"):
            game = run_query(
                "SELECT home_team_season_id, away_team_season_id FROM Game WHERE game_id = ?",
                (game_id,),
            ).iloc[0]
            if home_score > away_score:
                winner = int(game["home_team_season_id"])
            elif away_score > home_score:
                winner = int(game["away_team_season_id"])
            else:
                winner = None
            execute(
                """
                UPDATE Game
                SET home_score = ?, away_score = ?,
                    game_status = 'Completed',
                    winner_team_season_id = ?
                WHERE game_id = ?
                """,
                (home_score, away_score, winner, game_id),
            )
            st.success("Game score saved.")
            st.rerun()
