# Requirements

This document outlines the primary requirements for the UVA Intramural Soccer League database system.

## Project Goal

The goal of this project is to create a database system that supports the management of UVA Intramural Soccer league operations. The system will store and organize information about Players, Teams, Seasons, Games, Referees, Locations, Rosters, and User Accounts.

## Intended Users

The primary users of the system are:

- UVA Intramural Sports administrators
- Team captains

Administrators are responsible for managing league-wide data, scheduling, and reporting. Team captains are responsible for viewing league information and managing roster information for their own Team.

## Functional Requirements

### Player Management

- The system shall allow administrators to add new Players.
- The system shall allow administrators to edit existing Player information.
- The system shall allow administrators to remove or deactivate Players.
- The system shall store Player information including:
  - student ID
  - first name
  - last name
  - email
  - phone number
  - skill level
  - eligibility status
  - active status

### Team Management

- The system shall allow administrators to create Teams.
- The system shall allow administrators to update Team information.
- The system shall allow administrators to deactivate or remove Teams when appropriate.
- The system shall store Team information including:
  - team name
  - division
  - team status
  - created date

### Season Management

- The system shall allow administrators to create and manage Seasons.
- The system shall store Season information including:
  - season name
  - start date
  - end date
  - registration deadline
  - season status
- The system shall connect Teams to Seasons through the Team_Season entity.

### Roster Management

- The system shall allow Players to be assigned to Teams for a specific Season.
- The system shall track roster information through the Team_Roster entity.
- The system shall store:
  - jersey number
  - roster status
- The system shall support the rule that each Player may belong to only one Team per Season.
- The system shall support captain assignments through the Team_Season entity.

### Team Captain Management

- Each Team_Season may have one designated captain.
- The captain must be a Player listed on the Team roster for that Season.
- A Player may serve as captain for at most one Team_Season record at a time.
- Captain information shall be stored through the captain_player_id attribute in Team_Season.

### Game Scheduling

- The system shall allow administrators to schedule Games.
- Each Game shall include:
  - Season
  - home Team
  - away Team
  - Location
  - game date
  - start time
- The system shall store:
  - game status
  - home score
  - away score
  - winning Team when applicable
- The system shall prevent a Team from playing against itself.
- The system shall prevent multiple Games from being scheduled at the same Location, date, and start time.

### Referee Management

- The system shall allow administrators to store Referee information.
- The system shall allow administrators to assign Referees to Games.
- The system shall support multiple Referees being assigned to a single Game through the Game_Referee entity.
- The system shall store Referee information including:
  - first name
  - last name
  - email
  - phone number
  - certification
  - availability
  - active status

### Location Management

- The system shall store information about fields used by the intramural soccer league.
- Location information shall include:
  - field name
  - field address
  - field type
  - capacity
  - availability status
- The system shall support reports showing location usage and scheduling activity.

### User Account Management

- The system shall store user login information through the User_Account entity.
- User accounts shall support role-based access control.
- User roles shall include:
  - Administrator
  - Team Captain
- User accounts may optionally be associated with a Player and Team_Season record.

### Reporting Requirements

The system shall support reports such as:

- Team standings
- Game results
- Upcoming scheduled Games
- Player participation
- Team roster sizes
- Referee assignments
- Location usage
- Team captains by Season
- Players who are inactive or ineligible

## Database Requirements

The database shall include:

- Primary keys
- Foreign keys
- Entity integrity constraints
- Referential integrity constraints
- Business rule constraints
- Associative entities for many-to-many relationships

Main entities include:

- Player
- Team
- Season
- Team_Season
- Team_Roster
- Game
- Location
- Referee
- Game_Referee
- User_Account

Key associative entities include:

- Team_Season
- Team_Roster
- Game_Referee

The database shall support Third Normal Form (3NF) to reduce redundancy and maintain data consistency.

## Security Requirements

- Administrators shall have full create, read, update, and delete access to all records.
- Team Captains shall have limited access to their own Team information.
- Student IDs shall be restricted to authorized users.
- Player contact information shall be restricted to authorized users.
- Referee contact information and certification details shall be restricted to authorized users.
- User account information shall be restricted to authorized users.
- User roles and permissions shall be managed through the User_Account entity.

## Technology Requirements

- The database system shall use SQLite.
- The user interface shall be built using Streamlit and Python.
- SQL scripts shall be stored in the `sql/` folder.
- Project documentation shall be stored in the `docs/` folder.
- The Streamlit application shall be stored in the `app/` folder.
- Source code and version control shall be managed through GitHub.

## Data Type Requirements

The database shall use appropriate data types for date and time attributes.

Examples include:

- Team.created_date → DATE
- Season.start_date → DATE
- Season.end_date → DATE
- Season.registration_deadline → DATE
- Game.game_date → DATE
- Game.start_time → TIME

Although SQLite does not have native DATE or TIME storage classes, these attributes shall be stored using ISO-8601 formatted text values.

Examples:

- Date format: YYYY-MM-DD
- Time format: HH:MM:SS

Sample values:

- 2026-02-07
- 2026-04-25
- 10:00:00
