# Design

This document describes the database and system design for the UVA Intramural Soccer League database system.

## System Overview

The system is designed to help UVA Intramural Sports manage soccer league operations. It stores information about players, teams, seasons, games, referees, locations, rosters, and user accounts. The system supports both administrative operations and team captain interactions.

## Technology Stack

The project uses the following technologies:

- SQLite for the relational database
- Streamlit for the user interface
- Python for application logic
- GitHub for version control
- SQL scripts for database creation, sample data, queries, views, and reports

## System Architecture

The system follows a simple layered architecture.

### 1. User Interface Layer

- Built with Streamlit
- Allows users to view tables, submit forms, and display reports
- Provides dashboards, roster views, game schedules, and standings reports

### 2. Application Logic Layer

- Implemented in Python
- Connects the Streamlit interface to the SQLite database
- Handles data retrieval, report generation, and role-based behavior

### 3. Database Layer

- Implemented using SQLite
- Stores relational data in normalized tables
- Uses primary keys, foreign keys, constraints, and associative entities

## Database Naming Convention

Entity names use singular nouns to follow database modeling conventions.

Examples:

- Player instead of Players
- Team instead of Teams
- Season instead of Seasons
- Game instead of Games
- Referee instead of Referees
- Location instead of Locations
- User_Account instead of User_Accounts

Associative entities also use singular naming:

- Team_Season
- Team_Roster
- Game_Referee

## Main Entities

### Player

The Player entity stores information about students participating in intramural soccer. Attributes include player ID, student ID, first name, last name, email, phone number, skill level, eligibility status, and active status.

### Team

The Team entity stores information about intramural soccer teams. Attributes include team ID, team name, division, team status, and created date.

### Season

The Season entity stores information about each intramural soccer season. Attributes include season ID, season name, start date, end date, registration deadline, and season status.

### Team_Season

The Team_Season entity connects Team and Season. This allows the same Team to participate in multiple Seasons and allows each Season to include multiple Teams. The entity also stores the designated captain for a Team during a specific Season through the captain_player_id attribute.

### Team_Roster

The Team_Roster entity connects Player and Team_Season. This allows roster membership to be tracked by Season. The design supports the business rule that a Player may belong to only one Team per Season but may join a different Team in a future Season.

### Game

The Game entity stores scheduled and completed soccer games. Attributes include game ID, season ID, home team, away team, location, game date, start time, scores, game status, and winner.

### Location

The Location entity stores information about fields used for intramural soccer games. Attributes include location ID, field name, field address, field type, capacity, and availability status.

### Referee

The Referee entity stores information about referees. Attributes include referee ID, first name, last name, email, phone number, certification level, availability status, and active status.

### Game_Referee

The Game_Referee entity connects Game and Referee. This allows one Game to have multiple Referees and one Referee to officiate multiple Games.

### User_Account

The User_Account entity supports authentication and authorization. It stores user login information, password hash, access role, and optional links to Player and Team_Season records.

## Relationship Design

The database uses associative entities to resolve many-to-many relationships.

### Player and Team_Season

A Player can be assigned to a Team for a specific Season through Team_Roster. Team_Roster tracks roster membership and ensures that Players are associated with the correct Team during a Season.

### Team and Season

A Team can participate in multiple Seasons, and each Season can include multiple Teams. This relationship is represented through Team_Season.

### Team Captain Assignment

Each Team_Season record may have one designated captain through captain_player_id. The captain must also be listed on the corresponding Team roster.

### Game and Referee

A Game may have one or more Referees assigned, and a Referee may officiate many Games. This relationship is represented through Game_Referee.

### Game and Team_Season

Each Game references two Team_Season records: one for the home Team and one for the away Team. This design ensures that Game participation is tracked at the season level.

### Game and Location

Each Game is assigned to exactly one Location. A Location may host many Games over time but cannot host multiple Games at the same date and time.

## Normalization

The database design was reviewed for Third Normal Form (3NF). The design separates data into related entities so that non-key attributes depend only on the primary key of their respective tables.

Examples of normalization include:

- Player information is stored only in Player.
- Team information is stored only in Team.
- Season information is stored only in Season.
- Roster membership is stored in Team_Roster instead of directly in Player or Team.
- Referee assignments are stored in Game_Referee instead of directly in Game or Referee.
- Team participation by Season is stored in Team_Season.
- Team captain information is stored in Team_Season rather than being duplicated across multiple tables.

This approach reduces redundancy and helps maintain data consistency.

## Date and Time Design

The schema uses DATE and TIME data types to clearly represent the intended meaning of date and time values.

Examples include:

- Team.created_date → DATE
- Season.start_date → DATE
- Season.end_date → DATE
- Season.registration_deadline → DATE
- Game.game_date → DATE
- Game.start_time → TIME

SQLite does not provide native DATE or TIME storage classes. Therefore, date and time values are stored using ISO-8601 formatted text values.

Examples:

- Date format: YYYY-MM-DD
- Time format: HH:MM:SS

Sample values:

- 2026-02-07
- 2026-04-25
- 10:00:00

## Views

Views are used to simplify reporting and support the Streamlit interface. The project includes the following views:

- v_dashboard_counts
- v_roster_sizes
- v_team_roster
- v_game_details
- v_referee_assignments
- v_location_usage
- v_team_standings
- v_player_participation

These views simplify common reports by combining related tables and calculations into reusable query structures.

## Design Decisions

SQLite was selected because it is lightweight, easy to configure, and well suited for a course project with a moderate-sized dataset. Using SQLite allows each team member to recreate the database locally using shared SQL scripts.

Streamlit was selected because it allows the team to rapidly develop an interactive web-based interface using Python. Streamlit supports dashboards, forms, reports, and database connectivity without requiring a separate frontend framework.

## Current Implementation Files

The main SQL implementation files are stored in the `sql/` folder:

- schema.sql
- inserts.sql
- queries.sql
- views.sql
- join_queries.sql
- associative_entity_queries.sql

The Streamlit application is stored in the `app/` folder:

- app.py

Project documentation is stored in the `docs/` folder:

- design.md
- requirements.md
- business_rules.md
- security_requirements.md
- status_report_2_notes.md
