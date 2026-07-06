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
- SQL scripts for database creation, sample data, queries, and views

## System Architecture

The system follows a simple layered architecture.

1. User Interface Layer
   - Built with Streamlit
   - Allows users to view tables, submit forms, and display reports

2. Application Logic Layer
   - Implemented in Python
   - Connects the Streamlit interface to the SQLite database
   - Handles report display and basic role-based behavior

3. Database Layer
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

The Player entity stores information about students participating in intramural soccer. Attributes include player ID, student ID, name, email, phone number, skill level, eligibility status, and active status.

### Team

The Team entity stores information about intramural soccer teams. Attributes include team ID, team name, division, team status, and created date.

### Season

The Season entity stores information about each intramural soccer season. Attributes include season ID, season name, start date, end date, registration deadline, and season status.

### Team_Season

The Team_Season entity connects Team and Season. This allows the same team to participate in multiple seasons and allows each season to include multiple teams. It also stores the captain for a team during a specific season.

### Team_Roster

The Team_Roster entity connects Player to Team_Season. This allows roster membership to be tracked by season. This design supports the rule that a player may belong to only one team per season but may join a different team in a future season.

### Game

The Game entity stores scheduled and completed soccer games. Attributes include game ID, season ID, home team, away team, location, game date, start time, scores, game status, and winner.

### Location

The Location entity stores information about fields used for intramural soccer games. Attributes include location ID, field name, field address, field type, capacity, and availability status.

### Referee

The Referee entity stores information about referees. Attributes include referee ID, name, email, phone number, certification, availability, and active status.

### Game_Referee

The Game_Referee entity connects Game and Referee. This allows one game to have multiple referees and one referee to be assigned to multiple games.

### User_Account

The User_Account entity supports access control. It stores user login information, password hash, role, and optional links to Player and Team_Season records.

## Relationship Design

The database uses associative entities to resolve many-to-many relationships.

### Player and Team_Season

A player can be assigned to a team for a specific season through Team_Roster. Team_Roster makes it possible to track which players are on which team during each season.

### Team and Season

A team can participate in multiple seasons, and each season can include multiple teams. This relationship is represented through Team_Season.

### Game and Referee

A game can have one or more referees, and a referee can officiate many games. This relationship is represented through Game_Referee.

### Game and Team_Season

Each game has two team-season references: one for the home team and one for the away team. This makes it possible to identify which version of a team is playing during a specific season.

### Game and Location

Each game is assigned to one location. A location can host many games over time.

## Normalization

The database design was reviewed for Third Normal Form (3NF). The design separates data into related entities so that non-key attributes depend on the primary key of their table.

Examples of normalization include:

- Player information is stored only in Player.
- Team information is stored only in Team.
- Season information is stored only in Season.
- Roster membership is stored in Team_Roster instead of directly in Player or Team.
- Referee assignments are stored in Game_Referee instead of directly in Game or Referee.
- Team participation by season is stored in Team_Season.

This reduces redundant data and supports clearer relationships between entities.

## Date and Time Design

The schema uses DATE and TIME data types for readability and to represent the intended meaning of the data. SQLite does not have native DATE or TIME storage classes, so these values are stored using ISO-8601 formatted text values.

Examples:

- Date format: YYYY-MM-DD
- Time format: HH:MM:SS

Example values:

- 2026-02-07
- 2026-04-25
- 10:00:00

## Views

Views are used to make reports and the Streamlit interface easier to build. The project includes views such as:

- v_dashboard_counts
- v_roster_sizes
- v_team_roster
- v_game_details
- v_referee_assignments
- v_location_usage
- v_team_standings
- v_player_participation

These views simplify common reports by combining related tables and calculations.

## Design Decisions

The group chose SQLite because it is lightweight, easy to set up, and appropriate for a smaller course project. SQLite allows each team member to recreate the database locally using shared SQL scripts.

The group chose Streamlit because it allows the team to quickly build an interactive interface using Python. Streamlit is suitable for displaying tables, forms, dashboards, and reports without requiring a complex frontend framework.

## Current Implementation Files

The main SQL implementation files are stored in the sql/ folder:

- schema.sql
- inserts.sql
- queries.sql
- views.sql

The Streamlit app is stored in the app/ folder:

- app.py
