"""Database helpers for the UVA Intramural Soccer Streamlit app."""

from __future__ import annotations

import sqlite3
from pathlib import Path

import pandas as pd

ROOT_DIR = Path(__file__).resolve().parent.parent
DB_PATH = ROOT_DIR / "data" / "soccer.db"
SQL_DIR = ROOT_DIR / "sql"

SQL_SCRIPTS = ("schema.sql", "inserts.sql", "views.sql")

# Demo passwords for the course project (simplified auth).
DEMO_PASSWORDS = {
    "admin": "admin",
    "jmiller": "cavs",
    "apatel": "hawks",
    "srossi": "vikings",
    "dadams": "ducks",
    "cturner": "sharks",
}


def get_connection() -> sqlite3.Connection:
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    return conn


def init_database(force: bool = False) -> None:
    """Create the SQLite database from SQL scripts if it does not exist."""
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)
    if DB_PATH.exists() and not force:
        return

    conn = get_connection()
    try:
        for script_name in SQL_SCRIPTS:
            script_path = SQL_DIR / script_name
            conn.executescript(script_path.read_text(encoding="utf-8"))
        conn.commit()
    finally:
        conn.close()


def run_query(sql: str, params: tuple | list = ()) -> pd.DataFrame:
    conn = get_connection()
    try:
        return pd.read_sql_query(sql, conn, params=params)
    finally:
        conn.close()


def execute(sql: str, params: tuple | list = ()) -> None:
    conn = get_connection()
    try:
        conn.execute(sql, params)
        conn.commit()
    finally:
        conn.close()


def authenticate(username: str, password: str) -> dict | None:
    """Return user record if credentials are valid, otherwise None."""
    df = run_query(
        """
        SELECT
            ua.user_id,
            ua.username,
            ua.role,
            ua.player_id,
            ua.team_season_id,
            p.name AS player_name,
            t.team_name
        FROM User_Account ua
        LEFT JOIN Player p ON ua.player_id = p.player_id
        LEFT JOIN Team_Season ts ON ua.team_season_id = ts.team_season_id
        LEFT JOIN Team t ON ts.team_id = t.team_id
        WHERE ua.username = ?
        """,
        (username.strip(),),
    )
    if df.empty:
        return None

    user = df.iloc[0]
    expected = DEMO_PASSWORDS.get(user["username"])
    if expected is None or password != expected:
        return None

    return user.to_dict()
