"""Dashboard view."""

from __future__ import annotations

import streamlit as st

from db import run_query
from ui import metric_row, page_header, show_table


def render() -> None:
    page_header(
        "Dashboard",
        "League overview with key totals, season activity, and upcoming matches.",
    )

    counts = run_query("SELECT category, total FROM v_dashboard_counts")
    lookup = dict(zip(counts["category"], counts["total"]))

    metric_row(
        [
            ("Teams", int(lookup.get("Teams", 0)), None),
            ("Players", int(lookup.get("Players", 0)), None),
            ("Games", int(lookup.get("Games", 0)), None),
            ("Referees", int(lookup.get("Referees", 0)), None),
        ]
    )

    st.markdown("")
    left, right = st.columns(2)

    with left:
        st.subheader("League Summary")
        show_table(counts)

    with right:
        st.subheader("Season Activity")
        activity = counts[counts["category"].isin(
            ["Completed Games", "Scheduled Games", "Seasons", "Locations"]
        )]
        show_table(activity)

    st.subheader("Upcoming Games")
    upcoming = run_query(
        """
        SELECT game_date, start_time, home_team, away_team, location, game_status
        FROM v_game_details
        WHERE game_status = 'Scheduled'
        ORDER BY game_date, start_time
        """
    )
    if upcoming.empty:
        st.info("No scheduled games on the calendar.")
    else:
        show_table(upcoming, height=260)
