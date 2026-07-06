# uva-intramural-soccer-db
Database project for managing UVA intramural soccer players, teams, games, referees, locations, and seasons.

## Quick Start

1. Install dependencies:

```bash
py -m pip install -r requirements.txt
```

2. Run the Streamlit app (the database is created automatically on first launch):

```bash
py -m streamlit run app/app.py
```

3. Sign in with a demo account:

| Role | Username | Password |
|------|----------|----------|
| Admin | `admin` | `admin` |
| Cavs Captain | `jmiller` | `cavs` |
| Blue Hawks Captain | `apatel` | `hawks` |
| Vikings Captain | `srossi` | `vikings` |
| Golden Ducks Captain | `dadams` | `ducks` |
| Silver Sharks Captain | `cturner` | `sharks` |

## Project Structure

- `app/` — Streamlit web interface
  - `app.py` — main entry point and router
  - `auth.py` — login and navigation
  - `ui.py` — UVA-themed styling
  - `views/` — page modules (Dashboard, Players, Teams, etc.)
- `data/` — SQLite database (auto-generated)
- `sql/` — Schema, sample data, queries, and views
- `docs/` — Project documentation

## Screens

- **Login** — admin and team captain demo accounts
- **Dashboard** — league totals and upcoming games
- **Players** — view, add, edit, and deactivate players
- **Teams** — team directory, season participation, captain assignment
- **Roster** — view rosters by season; captains can add/remove players
- **Games** — schedule, filter, and record scores
- **Referees** — referee directory and game assignments
- **Locations** — field directory and usage summary
- **Reports** — standings, participation, inactive/ineligible players
