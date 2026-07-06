"""Players view."""

from __future__ import annotations

import streamlit as st

from auth import is_admin
from db import execute, run_query
from ui import page_header, show_table


def render() -> None:
    page_header(
        "Players",
        "View registered players and manage player records (admin only).",
    )

    if is_admin():
        tab_list, tab_add, tab_edit = st.tabs(["All Players", "Add Player", "Edit / Deactivate"])

        with tab_add:
            with st.form("add_player_form"):
                c1, c2 = st.columns(2)
                student_id = c1.text_input("Student ID")
                name = c2.text_input("Full Name")
                email = c1.text_input("Email")
                phone = c2.text_input("Phone")
                skill = c1.selectbox("Skill Level", ["Beginner", "Intermediate", "Advanced"])
                eligibility = c2.selectbox("Eligibility", ["Eligible", "Ineligible"])
                if st.form_submit_button("Add Player", type="primary"):
                    if not student_id or not name:
                        st.warning("Student ID and name are required.")
                    else:
                        execute(
                            """
                            INSERT INTO Player
                                (student_id, name, email, phone, skill_level, eligibility_status)
                            VALUES (?, ?, ?, ?, ?, ?)
                            """,
                            (student_id, name, email, phone, skill, eligibility),
                        )
                        st.success(f"Added player: {name}")
                        st.rerun()

        with tab_edit:
            players = run_query(
                "SELECT player_id, name, student_id FROM Player ORDER BY name"
            )
            if players.empty:
                st.info("No players available to edit.")
            else:
                labels = dict(zip(players["player_id"], players["name"]))
                player_id = st.selectbox(
                    "Select player",
                    players["player_id"].tolist(),
                    format_func=lambda pid: labels[pid],
                )
                current = run_query(
                    "SELECT * FROM Player WHERE player_id = ?", (player_id,)
                ).iloc[0]

                with st.form("edit_player_form"):
                    c1, c2 = st.columns(2)
                    email = c1.text_input("Email", value=current["email"] or "")
                    phone = c2.text_input("Phone", value=current["phone"] or "")
                    skill = c1.selectbox(
                        "Skill Level",
                        ["Beginner", "Intermediate", "Advanced"],
                        index=["Beginner", "Intermediate", "Advanced"].index(
                            current["skill_level"] or "Beginner"
                        ),
                    )
                    eligibility = c2.selectbox(
                        "Eligibility",
                        ["Eligible", "Ineligible"],
                        index=["Eligible", "Ineligible"].index(
                            current["eligibility_status"] or "Eligible"
                        ),
                    )
                    active = c1.checkbox("Active", value=bool(current["active_status"]))
                    if st.form_submit_button("Save Changes", type="primary"):
                        execute(
                            """
                            UPDATE Player
                            SET email = ?, phone = ?, skill_level = ?,
                                eligibility_status = ?, active_status = ?
                            WHERE player_id = ?
                            """,
                            (email, phone, skill, eligibility, int(active), player_id),
                        )
                        st.success("Player updated.")
                        st.rerun()

        with tab_list:
            _show_player_table()
    else:
        st.info("Team captains can view limited player information across the league.")
        _show_player_table()


def _show_player_table() -> None:
    if is_admin():
        df = run_query(
            """
            SELECT player_id, student_id, name, email, phone,
                   skill_level, eligibility_status,
                   CASE WHEN active_status = 1 THEN 'Active' ELSE 'Inactive' END AS status
            FROM Player
            ORDER BY name
            """
        )
    else:
        df = run_query(
            """
            SELECT name, skill_level, eligibility_status,
                   CASE WHEN active_status = 1 THEN 'Active' ELSE 'Inactive' END AS status
            FROM Player
            ORDER BY name
            """
        )
    show_table(df, height=420)
    st.caption(f"{len(df)} players in the system")
