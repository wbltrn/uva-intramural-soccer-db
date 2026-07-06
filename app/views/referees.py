"""Referees view."""

from __future__ import annotations

import streamlit as st

from auth import is_admin
from db import execute, run_query
from ui import page_header, show_table


def render() -> None:
    page_header(
        "Referees",
        "Manage referee records and view game assignments across the league.",
    )

    if is_admin():
        tab_directory, tab_assign = st.tabs(["Referee Directory", "Assign to Game"])
        with tab_directory:
            _show_referees()
            with st.expander("Add Referee"):
                with st.form("add_referee_form"):
                    c1, c2 = st.columns(2)
                    name = c1.text_input("Name")
                    email = c2.text_input("Email")
                    phone = c1.text_input("Phone")
                    certification = c2.text_input("Certification")
                    availability = c1.selectbox(
                        "Availability", ["Available", "Unavailable"]
                    )
                    if st.form_submit_button("Add Referee", type="primary"):
                        if not name:
                            st.warning("Referee name is required.")
                        else:
                            execute(
                                """
                                INSERT INTO Referee
                                    (name, email, phone, certification, availability)
                                VALUES (?, ?, ?, ?, ?)
                                """,
                                (name, email, phone, certification, availability),
                            )
                            st.success(f"Added referee: {name}")
                            st.rerun()
        with tab_assign:
            _render_assignment_form()
    else:
        st.info("Referee contact and certification details are restricted to administrators.")
        refs = run_query(
            """
            SELECT name, availability,
                   CASE WHEN active_status = 1 THEN 'Active' ELSE 'Inactive' END AS status
            FROM Referee
            ORDER BY name
            """
        )
        show_table(refs)

    st.subheader("Game Assignments")
    assignments = run_query(
        """
        SELECT game_date, start_time, home_team, away_team,
               referee_name, assignment_role
        FROM v_referee_assignments
        ORDER BY game_date, start_time
        """
    )
    if is_admin():
        show_table(assignments, height=320)
    else:
        show_table(
            assignments.drop(columns=["referee_name"], errors="ignore"),
            height=320,
        )


def _show_referees() -> None:
    refs = run_query(
        """
        SELECT referee_id, name, email, phone, certification, availability,
               CASE WHEN active_status = 1 THEN 'Active' ELSE 'Inactive' END AS status
        FROM Referee
        ORDER BY name
        """
    )
    show_table(refs, height=300)


def _render_assignment_form() -> None:
    games = run_query(
        """
        SELECT game_id, game_date || ' — ' || home_team || ' vs ' || away_team AS label
        FROM v_game_details
        ORDER BY game_date DESC
        """
    )
    referees = run_query(
        "SELECT referee_id, name FROM Referee WHERE active_status = 1 ORDER BY name"
    )
    if games.empty or referees.empty:
        st.warning("Games and active referees are required for assignments.")
        return

    game_labels = dict(zip(games["game_id"], games["label"]))
    ref_labels = dict(zip(referees["referee_id"], referees["name"]))

    with st.form("assign_ref_form"):
        game_id = st.selectbox(
            "Game",
            games["game_id"].tolist(),
            format_func=lambda gid: game_labels[gid],
        )
        referee_id = st.selectbox(
            "Referee",
            referees["referee_id"].tolist(),
            format_func=lambda rid: ref_labels[rid],
        )
        role = st.selectbox("Role", ["Head Referee", "Assistant"])
        if st.form_submit_button("Assign Referee", type="primary"):
            try:
                execute(
                    """
                    INSERT INTO Game_Referee (game_id, referee_id, assignment_role)
                    VALUES (?, ?, ?)
                    """,
                    (game_id, referee_id, role),
                )
                st.success("Referee assigned to game.")
                st.rerun()
            except Exception:
                st.error("This referee may already be assigned to the selected game.")
