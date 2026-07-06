"""Shared UI styling and layout helpers."""

from __future__ import annotations

import streamlit as st

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
                background: white;
                border: 1px solid #e7ebf1;
                border-radius: 18px;
                padding: 1.5rem;
                box-shadow: 0 16px 40px rgba(35, 45, 75, 0.08);
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
