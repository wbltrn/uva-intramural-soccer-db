"""Teams view."""

from __future__ import annotations

import streamlit as st

from auth import is_admin
from db import execute, run_query
from ui import page_header, show_table


def render() -> None:
    page_header(
        "Teams",
        "Browse intramural teams, season participation, and captain assignments.",
    )

    if is_admin():
        tab_overview, tab_manage = st.tabs(["Team Directory", "Manage Teams"])

        with tab_manage:
            c1, c2 = st.columns(2)
            with c1:
                with st.form("add_team_form"):
                    st.markdown("**Create Team**")
                    team_name = st.text_input("Team Name")
                    division = st.selectbox("Division", ["A", "B"])
                    if st.form_submit_button("Add Team", type="primary"):
                        if not team_name:
                            st.warning("Team name is required.")
                        else:
                            execute(
                                "INSERT INTO Team (team_name, division) VALUES (?, ?)",
                                (team_name, division),
                            )
                            st.success(f"Added team: {team_name}")
                            st.rerun()

            with c2:
                with st.form("assign_captain_form"):
                    st.markdown("**Assign Captain**")
                    team_seasons = run_query(
                        """
                        SELECT ts.team_season_id,
                               s.season_name || ' — ' || t.team_name AS label
                        FROM Team_Season ts
                        JOIN Team t ON ts.team_id = t.team_id
                        JOIN Season s ON ts.season_id = s.season_id
                        ORDER BY s.start_date, t.team_name
                        """
                    )
                    if team_seasons.empty:
                        st.caption("No team-season records available.")
                    else:
                        labels = dict(
                            zip(team_seasons["team_season_id"], team_seasons["label"])
                        )
                        ts_id = st.selectbox(
                            "Team / Season",
                            team_seasons["team_season_id"].tolist(),
                            format_func=lambda x: labels[x],
                        )
                        roster = run_query(
                            """
                            SELECT p.player_id, p.name
                            FROM Team_Roster tr
                            JOIN Player p ON tr.player_id = p.player_id
                            WHERE tr.team_season_id = ?
                            ORDER BY p.name
                            """,
                            (ts_id,),
                        )
                        if roster.empty:
                            st.caption("No roster players for this team-season.")
                        else:
                            player_labels = dict(zip(roster["player_id"], roster["name"]))
                            captain_id = st.selectbox(
                                "Captain",
                                roster["player_id"].tolist(),
                                format_func=lambda pid: player_labels[pid],
                            )
                            if st.form_submit_button("Assign Captain", type="primary"):
                                execute(
                                    "UPDATE Team_Season SET captain_player_id = ? WHERE team_season_id = ?",
                                    (captain_id, ts_id),
                                )
                                execute(
                                    """
                                    UPDATE Team_Roster SET is_captain = 0
                                    WHERE team_season_id = ?
                                    """,
                                    (ts_id,),
                                )
                                execute(
                                    """
                                    UPDATE Team_Roster SET is_captain = 1
                                    WHERE team_season_id = ? AND player_id = ?
                                    """,
                                    (ts_id, captain_id),
                                )
                                st.success("Captain assigned.")
                                st.rerun()

        with tab_overview:
            _show_team_tables()
    else:
        _show_team_tables()


def _show_team_tables() -> None:
    teams = run_query(
        """
        SELECT team_name, division, team_status, created_date
        FROM Team
        ORDER BY team_name
        """
    )
    st.subheader("All Teams")
    show_table(teams)

    st.subheader("Teams by Season")
    season_df = run_query(
        """
        SELECT s.season_name, t.team_name, t.division,
               COALESCE(p.name, 'Unassigned') AS captain
        FROM Team_Season ts
        JOIN Team t ON ts.team_id = t.team_id
        JOIN Season s ON ts.season_id = s.season_id
        LEFT JOIN Player p ON ts.captain_player_id = p.player_id
        ORDER BY s.season_name, t.team_name
        """
    )
    show_table(season_df, height=320)
