# Requirements

This document outlines the main requirements for the UVA Intramural Soccer League database system.

## Project Goal

The goal of this project is to create a database system that helps manage UVA Intramural Soccer league operations. The system will store and organize information about players, teams, seasons, games, referees, locations, rosters, and user accounts.

## Intended Users

The primary users of the system are:

- UVA Intramural Sports administrators
- Team captains

Administrators will manage league-wide data, while team captains will primarily view information and manage their own team roster.

## Functional Requirements

### Player Management

- The system shall allow administrators to add new players.
- The system shall allow administrators to edit existing player information.
- The system shall allow administrators to remove or deactivate players.
- The system shall store player information such as student ID, name, email, phone number, skill level, eligibility status, and active status.

### Team Management

- The system shall allow administrators to create teams.
- The system shall allow administrators to update team information.
- The system shall allow administrators to deactivate or remove teams when appropriate.
- The system shall store team information such as team name, division, team status, and created date.

### Season Management

- The system shall allow administrators to create and manage seasons.
- The system shall store season information such as season name, start date, end date, registration deadline, and season status.
- The system shall connect teams to seasons through the Team_Season entity.

### Roster Management

- The system shall allow players to be assigned to teams for a specific season.
- The system shall track roster information through the Team_Roster entity.
- The system shall store jersey number, roster status, and captain status for roster records.
- The system shall support the rule that each player may belong to only one team per season.

### Game Scheduling

- The system shall allow administrators to schedule games.
- Each game shall include a season, home team, away team, location, game date, and start time.
- The system shall store game status, home score, away score, and winner when applicable.
- The system shall prevent a team from being scheduled to play against itself.

### Referee Management

- The system shall allow administrators to store referee information.
- The system shall allow administrators to assign referees to games.
- The system shall support multiple referees being assigned to one game through the Game_Referee entity.

### Location Management

- The system shall store location information for fields used by the intramural soccer league.
- Location information shall include field name, field address, field type, capacity, and availability status.
- The system shall support reports that show how often each location is used.

### Reporting Requirements

The system shall support reports such as:

- Team standings
- Game results
- Upcoming scheduled games
- Player participation
- Team roster sizes
- Referee assignments
- Location usage
- Players who are inactive or ineligible

## Database Requirements

The database shall include primary keys, foreign keys, and constraints where appropriate. The database shall include associative entities to represent many-to-many relationships.

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

## Security Requirements

- Administrators shall have full access to view, add, edit, and delete records.
- Team captains shall have limited access to their own team information.
- Sensitive information such as student IDs, contact information, referee certification details, and user account data shall be restricted to authorized users.
- User roles shall be managed through the User_Account entity.

## Technology Requirements

- The database system will use SQLite.
- The user interface will be built using Streamlit with Python.
- SQL scripts will be stored in the sql/ folder.
- Project documentation will be stored in the docs/ folder.
- The Streamlit app will be stored in the app/ folder.

## SQLite Date and Time Note

SQLite does not have native DATE or TIME storage classes. However, this project uses DATE and TIME in the schema to clearly represent the intended data types. Date and time values will be stored using ISO-8601 formatted text values, such as YYYY-MM-DD for dates and HH:MM:SS for times.
