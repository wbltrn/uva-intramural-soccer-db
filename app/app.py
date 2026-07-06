"""UVA Intramural Soccer League — Streamlit web interface."""

from __future__ import annotations

import streamlit as st

from auth import is_logged_in, render_sidebar, show_login
from db import init_database
from ui import apply_theme
from views import dashboard, games, locations, players, referees, reports, roster, teams

st.set_page_config(
    page_title="UVA Intramural Soccer",
    page_icon="⚽",
    layout="wide",
    initial_sidebar_state="expanded",
)

init_database()
apply_theme()

ROUTES = {
    "Dashboard": dashboard.render,
    "Players": players.render,
    "Teams": teams.render,
    "Roster": roster.render,
    "Games": games.render,
    "Referees": referees.render,
    "Locations": locations.render,
    "Reports": reports.render,
}


def main() -> None:
    if not is_logged_in():
        show_login()
        return

    page = render_sidebar()
    render_fn = ROUTES.get(page, dashboard.render)
    render_fn()


if __name__ == "__main__":
    main()
