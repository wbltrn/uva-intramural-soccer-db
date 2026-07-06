"""Reports view."""

from __future__ import annotations

import streamlit as st

from auth import is_admin
from db import run_query
from ui import page_header, show_table


def render() -> None:
    page_header(
        "Reports",
        "League analytics including standings, participation, and assignment summaries.",
    )

    tab_standings, tab_participation, tab_inactive = st.tabs(
        ["Standings", "Player Participation", "Inactive / Ineligible"]
    )

    with tab_standings:
        seasons = run_query("SELECT season_name FROM Season ORDER BY start_date")
        season = st.selectbox("Season", seasons["season_name"].tolist())
        standings = run_query(
            """
            SELECT team_name, games_played, wins, losses, ties,
                   goals_for, goals_against, goal_difference, points
            FROM v_team_standings
            WHERE season_name = ?
            ORDER BY points DESC, goal_difference DESC
            """,
            (season,),
        )
        if standings.empty:
            st.info("No completed games yet for standings in this season.")
        else:
            show_table(standings, height=320)

    with tab_participation:
        participation = run_query(
            """
            SELECT player_name, skill_level, seasons_played, teams_played_for
            FROM v_player_participation
            ORDER BY seasons_played DESC, player_name
            """
        )
        show_table(participation, height=360)

    with tab_inactive:
        inactive = run_query(
            """
            SELECT name, student_id, eligibility_status,
                   CASE WHEN active_status = 1 THEN 'Active' ELSE 'Inactive' END AS status
            FROM Player
            WHERE active_status = 0 OR eligibility_status = 'Ineligible'
            ORDER BY name
            """
        )
        if is_admin():
            show_table(inactive)
        else:
            show_table(inactive.drop(columns=["student_id"], errors="ignore"))
