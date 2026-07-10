"""Shared UI styling and layout helpers."""

from __future__ import annotations

import streamlit as st
import streamlit.components.v1 as components

UVA_ORANGE = "#E57200"
UVA_NAVY = "#232D4B"
UVA_LIGHT = "#F8F9FB"

NAV_ITEMS = [
    ("Dashboard", "📊"),
    ("Players", "👤"),
    ("Teams", "🏆"),
    ("Roster", "📋"),
    ("Games", "⚽"),
    ("Referees", "🧑‍⚖️"),
    ("Locations", "📍"),
    ("Reports", "📈"),
]


def apply_theme() -> None:
    st.markdown(
        f"""
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

            html, body, [class*="css"] {{
                font-family: 'Inter', sans-serif;
            }}

            .block-container {{
                padding-top: 1.5rem;
                padding-bottom: 2rem;
                max-width: 1200px;
            }}

            [data-testid="stSidebar"] {{
                background: linear-gradient(180deg, {UVA_NAVY} 0%, #1a2238 100%);
            }}

            [data-testid="stSidebar"] * {{
                color: #f5f7fa !important;
            }}

            [data-testid="stSidebar"] .stRadio label {{
                background: rgba(255, 255, 255, 0.06);
                border-radius: 10px;
                padding: 0.55rem 0.75rem;
                margin-bottom: 0.35rem;
                border: 1px solid rgba(255, 255, 255, 0.08);
            }}

            [data-testid="stSidebar"] .stRadio label:hover {{
                background: rgba(229, 114, 0, 0.18);
                border-color: rgba(229, 114, 0, 0.45);
            }}

            div[data-testid="stMetric"] {{
                background: white;
                border: 1px solid #e8edf3;
                border-radius: 14px;
                padding: 0.9rem 1rem;
                box-shadow: 0 8px 24px rgba(35, 45, 75, 0.06);
            }}

            div[data-testid="stMetric"] label {{
                color: #5b6778 !important;
                font-weight: 600;
            }}

            div[data-testid="stMetric"] [data-testid="stMetricValue"] {{
                color: {UVA_NAVY} !important;
                font-weight: 700;
            }}

            .hero-banner {{
                background: linear-gradient(135deg, {UVA_NAVY} 0%, #2f3f67 55%, {UVA_ORANGE} 160%);
                color: white;
                border-radius: 18px;
                padding: 1.6rem 1.8rem;
                margin-bottom: 1.2rem;
                box-shadow: 0 14px 30px rgba(35, 45, 75, 0.18);
            }}

            .hero-banner h1 {{
                margin: 0;
                font-size: 1.9rem;
                font-weight: 700;
            }}

            .hero-banner p {{
                margin: 0.45rem 0 0 0;
                opacity: 0.92;
                font-size: 1rem;
            }}

            .page-header {{
                margin-bottom: 0.35rem;
            }}

            .page-header h2 {{
                color: {UVA_NAVY};
                margin: 0;
                font-size: 1.75rem;
                font-weight: 700;
            }}

            .page-header p {{
                color: #5f6b7a;
                margin: 0.35rem 0 1rem 0;
            }}

            .login-card {{
                display: none !important;
            }}

            .badge {{
                display: inline-block;
                background: rgba(229, 114, 0, 0.12);
                color: {UVA_ORANGE};
                border: 1px solid rgba(229, 114, 0, 0.25);
                border-radius: 999px;
                padding: 0.2rem 0.65rem;
                font-size: 0.78rem;
                font-weight: 600;
                margin-right: 0.35rem;
            }}

            .section-card {{
                background: white;
                border: 1px solid #e8edf3;
                border-radius: 14px;
                padding: 1rem 1.1rem;
                margin-bottom: 1rem;
            }}

            .stTabs [data-baseweb="tab-list"] {{
                gap: 8px;
            }}

            .stTabs [data-baseweb="tab"] {{
                border-radius: 10px 10px 0 0;
                padding: 0.55rem 1rem;
                font-weight: 600;
            }}

            div[data-testid="stDataFrame"] {{
                border: 1px solid #e8edf3;
                border-radius: 12px;
                overflow: hidden;
            }}
        </style>
        """,
        unsafe_allow_html=True,
    )


def apply_login_layout() -> None:
    st.markdown(
        f"""
        <style>
            [data-testid="stSidebar"],
            [data-testid="collapsedControl"] {{
                display: none;
            }}

            .login-shell-marker {{
                display: none !important;
                height: 0 !important;
                margin: 0 !important;
                padding: 0 !important;
            }}

            .stApp:has(.login-shell-marker) {{
                background: #eef1f6;
            }}

            .stApp:has(.login-shell-marker) .block-container {{
                padding-top: 3rem;
                max-width: 900px;
            }}

            .login-shell-marker + div[data-testid="stHorizontalBlock"] {{
                background: white;
                border-radius: 20px;
                overflow: hidden;
                border: 1px solid #e4e9f0;
                box-shadow: 0 24px 60px rgba(35, 45, 75, 0.12);
                margin-bottom: 0.5rem;
            }}

            .login-shell-marker + div[data-testid="stHorizontalBlock"] > div[data-testid="column"]:first-child {{
                background: linear-gradient(160deg, {UVA_NAVY} 0%, #2a3a62 48%, {UVA_ORANGE} 220%);
            }}

            .login-shell-marker + div[data-testid="stHorizontalBlock"] > div[data-testid="column"]:last-child {{
                background: white;
                padding: 2rem 1.6rem 1.5rem 1.4rem;
            }}

            .login-shell {{
                display: none;
            }}

            .login-brand {{
                color: white;
                padding: 2.4rem 1.8rem 2.2rem 2rem;
                min-height: 460px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }}

            .login-brand .logo {{
                width: 52px;
                height: 52px;
                border-radius: 14px;
                background: rgba(255, 255, 255, 0.14);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.6rem;
                margin-bottom: 1.25rem;
            }}

            .login-brand h1 {{
                margin: 0;
                font-size: 1.65rem;
                line-height: 1.25;
                font-weight: 700;
            }}

            .login-brand p {{
                margin: 0.75rem 0 0 0;
                color: rgba(255, 255, 255, 0.88);
                font-size: 0.95rem;
                line-height: 1.55;
            }}

            .login-brand ul {{
                margin: 1.5rem 0 0 0;
                padding-left: 1.1rem;
                color: rgba(255, 255, 255, 0.9);
                font-size: 0.88rem;
                line-height: 1.7;
            }}

            .login-form-panel {{
                padding: 0 0.25rem;
            }}

            .login-form-panel h2 {{
                margin: 0;
                color: {UVA_NAVY};
                font-size: 1.45rem;
                font-weight: 700;
            }}

            .login-form-panel .subtitle {{
                margin: 0.35rem 0 1.25rem 0;
                color: #6b7785;
                font-size: 0.92rem;
            }}

            .demo-grid {{
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 0.55rem;
                margin-top: 1rem;
            }}

            .demo-chip {{
                background: {UVA_LIGHT};
                border: 1px solid #e4e9f0;
                border-radius: 10px;
                padding: 0.55rem 0.65rem;
                font-size: 0.78rem;
                color: #4f5d6d;
                line-height: 1.45;
            }}

            .demo-chip strong {{
                color: {UVA_NAVY};
                font-weight: 600;
            }}

            div[data-testid="stForm"] {{
                border: none !important;
                padding: 0 !important;
            }}

            .stApp:has(.login-shell-marker) [data-testid="stVerticalBlockBorderWrapper"],
            .stApp:has(.login-shell-marker) [data-testid="stElementContainer"] {{
                background: transparent !important;
                border: none !important;
                box-shadow: none !important;
            }}

            [data-testid="InputInstructions"],
            span[data-testid="InputInstructions"],
            [data-testid="stTextInput"] [data-testid="InputInstructions"] {{
                display: none !important;
                visibility: hidden !important;
                width: 0 !important;
                height: 0 !important;
                opacity: 0 !important;
                font-size: 0 !important;
                line-height: 0 !important;
                overflow: hidden !important;
                pointer-events: none !important;
                position: absolute !important;
                left: -9999px !important;
            }}

            [data-testid="InputInstructions"]::before {{
                content: none !important;
                display: none !important;
            }}

            button[kind="primary"] {{
                background-color: {UVA_ORANGE} !important;
                border-color: {UVA_ORANGE} !important;
                color: white !important;
                border-radius: 10px !important;
                font-weight: 600 !important;
            }}

            button[kind="primary"]:hover {{
                background-color: #cf6600 !important;
                border-color: #cf6600 !important;
                color: white !important;
            }}

            div[data-testid="stTextInput"] input {{
                border-radius: 10px !important;
                background-color: white !important;
            }}

            div[data-testid="stTextInput"] input:focus,
            div[data-testid="stTextInput"] input:focus-visible {{
                border-color: {UVA_ORANGE} !important;
                box-shadow: 0 0 0 1px {UVA_ORANGE} !important;
                outline: none !important;
            }}

            div[data-testid="stTextInput"] input::placeholder,
            div[data-testid="stTextInput"] input::-webkit-input-placeholder {{
                color: transparent !important;
                opacity: 0 !important;
            }}

            div[data-testid="stTextInput"] input:-webkit-autofill,
            div[data-testid="stTextInput"] input:-webkit-autofill:hover,
            div[data-testid="stTextInput"] input:-webkit-autofill:focus {{
                -webkit-box-shadow: 0 0 0 1000px white inset !important;
                box-shadow: 0 0 0 1000px white inset !important;
                -webkit-text-fill-color: {UVA_NAVY} !important;
            }}

            [data-testid="stHtml"],
            [data-testid="stHtml"] > div,
            [data-testid="stHtml"] iframe {{
                background: transparent !important;
                border: none !important;
                box-shadow: none !important;
                height: 0 !important;
                min-height: 0 !important;
                margin: 0 !important;
                padding: 0 !important;
                overflow: hidden !important;
            }}

            @media (max-width: 800px) {{
                .login-shell {{
                    grid-template-columns: 1fr;
                }}
                .login-brand {{
                    padding: 1.6rem 1.4rem;
                }}
            }}
        </style>
        """,
        unsafe_allow_html=True,
    )


def inject_login_fixes() -> None:
    """Remove Streamlit input hints and browser autofill artifacts on the login page."""
    components.html(
        """
        <script>
        (function () {
            const doc = window.parent.document;
            const root = doc.querySelector('.main') || doc.body;

            const scrubHints = () => {
                doc.querySelectorAll('[data-testid="InputInstructions"]').forEach((node) => {
                    node.remove();
                });
            };

            const scrubInputs = () => {
                doc.querySelectorAll('[data-testid="stTextInput"] input').forEach((input) => {
                    input.removeAttribute('placeholder');
                    input.setAttribute('placeholder', '');
                    input.setAttribute(
                        'autocomplete',
                        input.type === 'password' ? 'new-password' : 'off'
                    );
                    if (input.type === 'password' && !input.dataset.userEdited) {
                        input.value = '';
                    }
                });
            };

            const attachListeners = () => {
                doc.querySelectorAll('[data-testid="stTextInput"] input').forEach((input) => {
                    if (input.dataset.loginListener) return;
                    input.dataset.loginListener = '1';
                    input.addEventListener('input', () => {
                        input.dataset.userEdited = '1';
                    });
                });
            };

            const run = () => {
                scrubHints();
                scrubInputs();
                attachListeners();
            };

            run();
            new MutationObserver(run).observe(root, { childList: true, subtree: true });
        })();
        </script>
        """,
        height=0,
        width=0,
    )


def hero(title: str, subtitle: str) -> None:
    st.markdown(
        f"""
        <div class="hero-banner">
            <h1>{title}</h1>
            <p>{subtitle}</p>
        </div>
        """,
        unsafe_allow_html=True,
    )


def page_header(title: str, subtitle: str) -> None:
    st.markdown(
        f"""
        <div class="page-header">
            <h2>{title}</h2>
            <p>{subtitle}</p>
        </div>
        """,
        unsafe_allow_html=True,
    )


def show_table(df, height: int | None = None) -> None:
    kwargs = {"use_container_width": True, "hide_index": True}
    if height:
        kwargs["height"] = height
    st.dataframe(df, **kwargs)


def metric_row(items: list[tuple[str, int | str, str | None]]) -> None:
    cols = st.columns(len(items))
    for col, (label, value, delta) in zip(cols, items):
        col.metric(label, value, delta)
