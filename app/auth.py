"""Authentication and navigation helpers."""

from __future__ import annotations

import streamlit as st

from db import authenticate
from ui import NAV_ITEMS, apply_login_layout, inject_login_fixes


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
    apply_login_layout()
    st.markdown('<div class="login-shell-marker"></div>', unsafe_allow_html=True)

    brand_col, form_col = st.columns([1.05, 1], gap="small")

    with brand_col:
        st.markdown(
            """
            <div class="login-brand">
                <div class="logo">⚽</div>
                <h1>UVA Intramural<br>Soccer League</h1>
                <p>Database system for managing players, teams, games,
                referees, and league reports.</p>
                <ul>
                    <li>Administrator and captain role-based access</li>
                    <li>Live data from SQLite views and reports</li>
                    <li>Roster, scheduling, and standings tools</li>
                </ul>
            </div>
            """,
            unsafe_allow_html=True,
        )

    with form_col:
        st.markdown(
            """
            <div class="login-form-panel">
                <h2>Welcome back</h2>
                <p class="subtitle">Sign in with a demo account to continue.</p>
            </div>
            """,
            unsafe_allow_html=True,
        )

        username = st.text_input("Username", key="login_username", autocomplete="off")
        password = st.text_input("Password", key="login_password", autocomplete="new-password")

        if st.button("Sign In", use_container_width=True, type="primary", key="login_submit"):
            user = authenticate(username, password)
            if user:
                st.session_state["user"] = user
                st.session_state["page"] = "Dashboard"
                st.rerun()
            st.error("Invalid username or password.")

        st.markdown(
            """
            <div class="demo-grid">
                <div class="demo-chip"><strong>Admin</strong><br>admin / admin</div>
                <div class="demo-chip"><strong>Cavs</strong><br>jmiller / cavs</div>
                <div class="demo-chip"><strong>Hawks</strong><br>apatel / hawks</div>
                <div class="demo-chip"><strong>Vikings</strong><br>srossi / vikings</div>
                <div class="demo-chip"><strong>Ducks</strong><br>dadams / ducks</div>
                <div class="demo-chip"><strong>Sharks</strong><br>cturner / sharks</div>
            </div>
            """,
            unsafe_allow_html=True,
        )

    inject_login_fixes()


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
