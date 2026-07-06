# Security and Access Requirements

This document describes the security and access control requirements for the UVA Intramural Soccer League database system. These requirements are separate from business rules because they focus on system permissions, data privacy, and user access.

## User Roles

The system will support at least two user roles:

1. Administrator
2. Team Captain

## Administrator Access

Administrators will have full access to the system. This includes the ability to:

- View all records
- Add new records
- Edit existing records
- Delete records when appropriate
- Manage Players, Teams, Seasons, Games, Referees, Locations, Team Rosters, and User Accounts
- Assign Referees to Games
- Record Game scores and results
- View all reports

## Team Captain Access

Team Captains will have limited access to the system. This includes the ability to:

- View league-wide schedules and standings
- View their own Team roster
- View their own Team’s Game results
- Manage or request updates to their own Team roster
- View reports related to their own Team

Team Captains should not be able to modify records for other Teams.

## Restricted Information

Certain data should be restricted to authorized users only. Restricted information includes:

- Student IDs
- Player contact information
- Referee contact information
- Referee certification details
- User account information

## User Account Entity

The User_Account entity supports authentication and authorization. It stores information such as username, password hash, role, and optional links to Player and Team_Season records.

## Privacy Considerations

The database stores student-related information, including student IDs, contact information, and roster membership. To protect privacy, sensitive fields should only be visible to authorized users. Public or captain-level views should avoid exposing unnecessary personal information.

## Implementation Note

For the course project, role-based access may be implemented in a simplified way through the Streamlit interface. Administrators and Team Captains will be treated as separate user types, and the interface will determine which features each user can access.
