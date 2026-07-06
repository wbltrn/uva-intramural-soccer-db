"""Locations view."""

from __future__ import annotations

import streamlit as st

from auth import is_admin
from db import execute, run_query
from ui import page_header, show_table


def render() -> None:
    page_header(
        "Locations",
        "Manage intramural field locations and review field usage across the season.",
    )

    if is_admin():
        tab_fields, tab_add = st.tabs(["Field Directory", "Add Location"])
        with tab_add:
            with st.form("add_location_form"):
                c1, c2 = st.columns(2)
                field_name = c1.text_input("Field Name")
                field_address = c2.text_input("Address")
                field_type = c1.selectbox("Field Type", ["Grass", "Turf"])
                capacity = c2.number_input("Capacity", min_value=0, step=50, value=200)
                availability = c1.selectbox(
                    "Availability",
                    ["Available", "Unavailable", "Maintenance"],
                )
                if st.form_submit_button("Add Location", type="primary"):
                    if not field_name:
                        st.warning("Field name is required.")
                    else:
                        execute(
                            """
                            INSERT INTO Location
                                (field_name, field_address, field_type, capacity, availability_status)
                            VALUES (?, ?, ?, ?, ?)
                            """,
                            (field_name, field_address, field_type, capacity, availability),
                        )
                        st.success(f"Added location: {field_name}")
                        st.rerun()
        with tab_fields:
            _show_locations()
    else:
        _show_locations()

    st.subheader("Usage Summary")
    usage = run_query(
        """
        SELECT field_name, field_type, capacity, availability_status, total_games
        FROM v_location_usage
        ORDER BY total_games DESC
        """
    )
    show_table(usage, height=280)


def _show_locations() -> None:
    locations = run_query(
        """
        SELECT field_name, field_address, field_type, capacity, availability_status
        FROM Location
        ORDER BY field_name
        """
    )
    show_table(locations, height=300)
