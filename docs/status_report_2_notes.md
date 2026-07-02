# Second Status Report Notes

This document tracks updates and tasks for the second project status report.

## Feedback Addressed From Previous Report

The following updates were made based on instructor feedback:

- Entity names were updated from plural nouns to singular nouns.
  - Players became Player.
  - Teams became Team.
  - Seasons became Season.
  - Games became Game.
  - Referees became Referee.
  - Locations became Location.
  - Team_Seasons became Team_Season.
  - Game_Referees became Game_Referee.
  - User_Accounts became User_Account.

- The schema was updated to use DATE and TIME data types for date and time-related attributes.
  - Season start and end dates use DATE.
  - Registration deadline uses DATE.
  - Team created date uses DATE.
  - Game date uses DATE.
  - Game start time uses TIME.

- Although SQLite does not have native DATE or TIME storage classes, the schema uses DATE and TIME to clearly communicate the intended data types. Dates and times are stored using ISO-8601 formatted text values such as YYYY-MM-DD and HH:MM:SS.

- Business rules were revised to use paired relationship statements.
  - Each relationship is now described from both entity perspectives when appropriate.
  - Business rules now focus on relationships, cardinality, participation constraints, and organizational policies.

- Security and application requirements were separated from business rules.
  - Administrator permissions are described separately.
  - Team Captain permissions are described separately.
  - Privacy restrictions for student IDs, contact information, and referee certification details are documented separately.

- The System Architecture section was updated to reference Figure 1 directly in the text.

- The database design section was updated to mention that the design was reviewed for Third Normal Form (3NF).

## Current Repository Structure

The repository is organized into the following folders:

- app/
  - Contains the Streamlit application.

- data/
  - Contains CSV files used for reference or sample data.

- docs/
  - Contains project documentation, business rules, security requirements, and status report notes.

- sql/
  - Contains SQL files for schema creation, data inserts, queries, and views.

## SQL Files

The main SQL files are:

- schema.sql
  - Creates all database tables.
  - Includes primary keys, foreign keys, constraints, and singular entity names.

- inserts.sql
  - Inserts sample data into the database.
  - Uses ISO-formatted dates and times.

- queries.sql
  - Includes SELECT statements, filtered queries, and summary queries.

- views.sql
  - Creates views for reports and Streamlit display.

## Second Status Report Tasks To Complete

The second status report should include the following additional work:

1. Add SQL SELECT statements that join tables for meaningful user results.
2. Add one SQL query for each associative entity.
3. Ensure associative entity queries join related tables and include useful attributes from each table.
4. Consider using views for complex join queries.
5. Demonstrate at least part of the user interface.
6. Update the written report with progress since the previous submission.
7. Record a video demonstrating the current state of the user interface.

## Associative Entities

The main associative entities are:

- Team_Roster
  - Connects Player to Team_Season.

- Team_Season
  - Connects Team to Season.

- Game_Referee
  - Connects Game to Referee.

## Recommended Remaining Work Split

### Person 1: Join Queries and Associative Entity Queries

Responsibilities:

- Create meaningful join queries.
- Create one query for each associative entity.
- Test queries with schema.sql and inserts.sql.

Deliverables:

- join_queries.sql
- associative_entity_queries.sql

### Person 2: Views and SQL Testing

Responsibilities:

- Update and test views.sql.
- Check that all SQL files use singular table names.
- Fix any remaining SQL syntax issues.
- Run the full SQL setup from scratch.

Deliverables:

- Updated views.sql
- Tested SQL workflow

### Person 3: Streamlit UI and Demo

Responsibilities:

- Update the Streamlit application.
- Connect the app to the SQLite database.
- Display table data, joined reports, and summary reports.
- Prepare screenshots and help record the demo video.

Deliverables:

- Updated app.py
- UI screenshots
- Demo video section

