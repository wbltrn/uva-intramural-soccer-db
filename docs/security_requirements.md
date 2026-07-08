# Security and Access Requirements

This document describes the security and access control requirements for the UVA Intramural Soccer League database system. These requirements are separate from business rules because they focus on system permissions, data privacy, authentication, and user access.

## User Roles

The system supports two primary user roles:

1. Administrator
2. Team Captain

Each role is granted different levels of access based on its responsibilities within the intramural soccer program.

## Administrator Access

Administrators have full access to the system and are responsible for managing league-wide operations.

Administrator permissions include:

- Viewing all records in the database
- Adding new records
- Editing existing records
- Deleting records when appropriate
- Managing Players, Teams, Seasons, Games, Referees, Locations, Team Rosters, Team_Season records, and User Accounts
- Assigning Referees to Games
- Managing Team captain assignments
- Recording Game scores and results
- Scheduling and updating Games
- Managing Location information
- Running and viewing all reports

Administrators are considered the highest access level within the system.

## Team Captain Access

Team Captains have limited access focused on managing their own Team.

Team Captain permissions include:

- Viewing league schedules
- Viewing league standings
- Viewing Game results
- Viewing Team information
- Viewing their own Team roster
- Managing or requesting updates to their own Team roster
- Viewing reports related to their own Team and Season

Team Captains should not be able to:

- Modify other Teams
- Edit Season information
- Manage Referees
- Modify Game assignments
- Access restricted administrative functions
- View or edit User Account information belonging to other users

## Authentication and Authorization

Authentication and authorization are supported through the User_Account entity.

Each User_Account stores:

- Username
- Password hash
- Role
- Optional Player association
- Optional Team_Season association

The system uses role information to determine which functionality and data a user may access.

## Restricted Information

Certain information is restricted to authorized users only.

Restricted information includes:

- Student IDs
- Player email addresses
- Player phone numbers
- Referee email addresses
- Referee phone numbers
- Referee certification details
- User Account information
- Password hashes

Sensitive information should only be visible to users with appropriate authorization.

## Privacy Requirements

The database stores student-related information and contact information for Players and Referees.

To protect privacy:

- Sensitive personal information should not be displayed in public reports.
- Team Captains should only have access to information necessary to manage their own Team.
- Passwords are never stored in plain text.
- User authentication data should remain accessible only to authorized administrators.
- Contact information should be displayed only when required for legitimate league operations.

## User_Account Entity

The User_Account entity provides support for authentication and authorization within the database system.

Responsibilities of the User_Account entity include:

- Associating users with system roles
- Supporting login functionality
- Managing role-based permissions
- Linking Team Captains to Team_Season records when applicable
- Linking users to Player records when applicable

## Role-Based Access Control

The system follows a simplified role-based access control (RBAC) model.

### Administrator Role

Administrators may:

- Create records
- Read records
- Update records
- Delete records
- Run reports
- Manage users
- Manage schedules
- Assign referees

### Team Captain Role

Team Captains may:

- Read league information
- View schedules and standings
- View roster information
- Manage roster information for their own Team

Team Captains may not:

- Delete league-wide records
- Modify other Teams
- Manage Referee assignments
- Access administrative features

## Implementation Notes

For the course project, security controls are implemented primarily through the Streamlit interface and application logic.

The SQLite database stores authentication and authorization data, while the Streamlit application determines which functionality is available to each user role.

Because this is a course project, the implementation is intentionally simplified while still demonstrating role-based access control, authentication concepts, and data privacy requirements.
