"""Authentication and navigation helpers."""

from __future__ import annotations

import streamlit as st

from db import authenticate
from ui import NAV_ITEMS, hero


def is_admin() -> bool:
    return st.session_state.get("user", {}).get("role") == "Admin"


def is_captain() -> bool:
    return st.session_state.get("user", {}).get("role") == "Captain"


def is_logged_in() -> bool:
    return "user" in st.session_state


def current_user() -> dict:
    return st.session_state["user"]


def logout() -> None:
    st.session_state.pop("user", None)
    st.session_state.pop("page", None)


def show_login() -> None:
    hero(
        "UVA Intramural Soccer League",
        "Manage players, teams, schedules, referees, and league reports.",
    )

    left, center, right = st.columns([1, 1.2, 1])
    with center:
        st.markdown('<div class="login-card">', unsafe_allow_html=True)
        st.markdown("### Sign In")
        st.caption("Use your administrator or team captain demo account.")

        with st.form("login_form", clear_on_submit=False):
            username = st.text_input("Username", placeholder="admin")
            password = st.text_input("Password", type="password", placeholder="••••••")
            submitted = st.form_submit_button("Sign In", use_container_width=True, type="primary")

        if submitted:
            user = authenticate(username, password)
            if user:
                st.session_state["user"] = user
                st.session_state["page"] = "Dashboard"
                st.rerun()
            st.error("Invalid username or password.")

        st.markdown("</div>", unsafe_allow_html=True)

        with st.expander("Demo accounts", expanded=True):
            st.markdown(
                """
                | Role | Username | Password |
                |------|----------|----------|
                | Admin | `admin` | `admin` |
                | Cavs Captain | `jmiller` | `cavs` |
                | Blue Hawks Captain | `apatel` | `hawks` |
                | Vikings Captain | `srossi` | `vikings` |
                | Golden Ducks Captain | `dadams` | `ducks` |
                | Silver Sharks Captain | `cturner` | `sharks` |
                """
            )


def render_sidebar() -> str:
    user = current_user()
    st.sidebar.markdown("## ⚽ UVA Soccer DB")
    st.sidebar.markdown(
        f'<span class="badge">{user["role"]}</span>',
        unsafe_allow_html=True,
    )
    st.sidebar.caption(f"Signed in as **{user['username']}**")
    if user.get("team_name"):
        st.sidebar.caption(f"Team: **{user['team_name']}**")

    st.sidebar.markdown("---")
    st.sidebar.markdown("**Navigation**")

    labels = [f"{icon}  {name}" for name, icon in NAV_ITEMS]
    name_by_label = {label: name for name, label in zip([n for n, _ in NAV_ITEMS], labels)}

    if "page" not in st.session_state:
        st.session_state["page"] = "Dashboard"

    current_label = next(
        (label for label in labels if name_by_label[label] == st.session_state["page"]),
        labels[0],
    )
    selected_label = st.sidebar.radio(
        "Pages",
        labels,
        index=labels.index(current_label),
        label_visibility="collapsed",
    )
    st.session_state["page"] = name_by_label[selected_label]

    st.sidebar.markdown("---")
    if st.sidebar.button("Log Out", use_container_width=True, type="primary"):
        logout()
        st.rerun()

    return st.session_state["page"]
