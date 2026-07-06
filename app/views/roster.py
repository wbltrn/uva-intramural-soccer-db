"""Roster view."""

from __future__ import annotations

import streamlit as st

from auth import current_user, is_admin
from db import execute, run_query
from ui import page_header, show_table


def render() -> None:
    page_header(
        "Roster",
        "View and manage team rosters by season. Captains can update their own team.",
    )

    seasons = run_query("SELECT season_id, season_name FROM Season ORDER BY start_date")
    season_name = st.selectbox("Season", seasons["season_name"].tolist())
    season_id = int(
        seasons.loc[seasons["season_name"] == season_name, "season_id"].iloc[0]
    )

    user = current_user()
    can_manage = is_admin() or user.get("role") == "Captain"

    if can_manage:
        team_season_id = _resolve_team_season_id(user, season_id)
        if team_season_id:
            with st.expander("Manage Roster", expanded=False):
                _render_roster_management(team_season_id, season_id)

    if is_admin():
        df = run_query(
            """
            SELECT team_name, player_name, student_id, jersey_number,
                   skill_level, eligibility_status, captain, roster_status
            FROM v_team_roster
            WHERE season_name = ?
            ORDER BY team_name, captain DESC, player_name
            """,
            (season_name,),
        )
    else:
        team_name = user.get("team_name")
        df = run_query(
            """
            SELECT player_name, jersey_number, skill_level,
                   eligibility_status, captain, roster_status
            FROM v_team_roster
            WHERE season_name = ? AND team_name = ?
            ORDER BY captain DESC, player_name
            """,
            (season_name, team_name),
        )

    st.subheader("Roster Members")
    show_table(df, height=360)

    st.subheader("Roster Compliance")
    sizes = run_query(
        """
        SELECT team_name, roster_size, roster_rule_status
        FROM v_roster_sizes
        WHERE season_name = ?
        ORDER BY team_name
        """,
        (season_name,),
    )
    show_table(sizes)


def _resolve_team_season_id(user: dict, season_id: int) -> int | None:
    if is_admin():
        options = run_query(
            """
            SELECT ts.team_season_id, t.team_name
            FROM Team_Season ts
            JOIN Team t ON ts.team_id = t.team_id
            WHERE ts.season_id = ?
            ORDER BY t.team_name
            """,
            (season_id,),
        )
        if options.empty:
            return None
        labels = dict(zip(options["team_season_id"], options["team_name"]))
        return st.selectbox(
            "Team to manage",
            options["team_season_id"].tolist(),
            format_func=lambda x: labels[x],
            key="roster_manage_team",
        )

    ts = run_query(
        """
        SELECT ts.team_season_id
        FROM Team_Season ts
        WHERE ts.season_id = ?
          AND ts.team_id = (
              SELECT team_id FROM Team_Season WHERE team_season_id = ?
          )
        """,
        (season_id, user.get("team_season_id")),
    )
    if ts.empty:
        return None
    return int(ts.iloc[0]["team_season_id"])


def _render_roster_management(team_season_id: int, season_id: int) -> None:
    c1, c2 = st.columns(2)

    with c1:
        st.markdown("**Add Player to Roster**")
        rostered = run_query(
            "SELECT player_id FROM Team_Roster WHERE season_id = ?",
            (season_id,),
        )
        rostered_ids = set(rostered["player_id"].tolist()) if not rostered.empty else set()

        available = run_query(
            """
            SELECT player_id, name, student_id
            FROM Player
            WHERE active_status = 1 AND eligibility_status = 'Eligible'
            ORDER BY name
            """
        )
        if not available.empty:
            available = available[~available["player_id"].isin(rostered_ids)]

        if available.empty:
            st.caption("No eligible unassigned players for this season.")
        else:
            labels = {
                row.player_id: f"{row.name} ({row.student_id})"
                for row in available.itertuples()
            }
            with st.form("add_roster_form"):
                player_id = st.selectbox(
                    "Player",
                    available["player_id"].tolist(),
                    format_func=lambda pid: labels[pid],
                )
                jersey = st.number_input("Jersey Number", min_value=0, max_value=99, step=1)
                if st.form_submit_button("Add to Roster", type="primary"):
                    execute(
                        """
                        INSERT INTO Team_Roster
                            (player_id, team_season_id, season_id, jersey_number)
                        VALUES (?, ?, ?, ?)
                        """,
                        (player_id, team_season_id, season_id, jersey),
                    )
                    st.success("Player added to roster.")
                    st.rerun()

    with c2:
        st.markdown("**Remove Player from Roster**")
        current = run_query(
            """
            SELECT tr.roster_id, p.name
            FROM Team_Roster tr
            JOIN Player p ON tr.player_id = p.player_id
            WHERE tr.team_season_id = ?
            ORDER BY p.name
            """,
            (team_season_id,),
        )
        if current.empty:
            st.caption("No players on this roster.")
        else:
            remove_labels = dict(zip(current["roster_id"], current["name"]))
            with st.form("remove_roster_form"):
                roster_id = st.selectbox(
                    "Player to remove",
                    current["roster_id"].tolist(),
                    format_func=lambda rid: remove_labels[rid],
                )
                if st.form_submit_button("Remove from Roster", type="primary"):
                    execute("DELETE FROM Team_Roster WHERE roster_id = ?", (roster_id,))
                    st.success("Player removed from roster.")
                    st.rerun()
