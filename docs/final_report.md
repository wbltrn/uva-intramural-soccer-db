# Final Project Notes

This document summarizes the final implementation, design decisions, repository structure, and completed project requirements for the UVA Intramural Soccer League Database System.

## Project Summary

The UVA Intramural Soccer League Database System was developed to support the management of players, teams, seasons, games, referees, locations, rosters, and user accounts. The system provides tools for league administration, roster management, scheduling, referee assignment, reporting, and standings calculation.

The project consists of:

- SQLite relational database
- Streamlit user interface
- SQL scripts for schema creation, sample data, queries, joins, and views
- Project documentation
- Entity Relationship Diagram (ERD)
- Demonstration video

## Final Design Updates

The final design incorporates several improvements made throughout project development.

### Naming Conventions

Entity names use singular nouns throughout the database design.

Examples include:

- Player
- Team
- Season
- Game
- Referee
- Location
- User_Account

Associative entities include:

- Team_Season
- Team_Roster
- Game_Referee

### Date and Time Data Types

The database uses DATE and TIME data types where appropriate.

Examples include:

- Team.created_date
- Season.start_date
- Season.end_date
- Season.registration_deadline
- Game.game_date
- Game.start_time

SQLite stores these values using ISO-8601 formatted text values.

### Player and Referee Names

Player and Referee records store names using separate attributes:

- first_name
- last_name

This supports improved searching, sorting, reporting, and user interface display.

### Captain Management

Team captain information is stored through:

```text
Team_Season.captain_player_id
