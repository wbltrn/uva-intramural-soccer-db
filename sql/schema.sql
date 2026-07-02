-- Table for teams
CREATE TABLE Teams (
  team_id  INTEGER PRIMARY KEY,
  team_name TEXT NOT NULL,
  division TEXT,
  team_status TEXT DEFAULT 'Active',
  created_date DATE DEFAULT CURRENT_DATE
);

-- Table for players
CREATE TABLE Players (
  player_id  INTEGER PRIMARY KEY,
  student_id TEXT UNIQUE NOT NULL,
  name  TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  skill_level TEXT CHECK (skill_level IN ('Beginner','Intermediate','Advanced')),
  eligibility_status TEXT DEFAULT 'Eligible',
  active_status INTEGER DEFAULT 1
);

-- Table for seasons
CREATE TABLE Seasons (
  season_id INTEGER PRIMARY KEY,
  season_name TEXT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  registration_deadline DATE,
  season_status TEXT DEFAULT 'Upcoming',
  CHECK (end_date >= start_date),
  CHECK (registration_deadline IS NULL OR registration_deadline <= start_date)
);

-- Table for locations 
CREATE TABLE Locations (
  location_id INTEGER PRIMARY KEY,
  field_name TEXT NOT NULL,
  field_address TEXT,
  field_type TEXT,
  capacity INTEGER,
  availability_status TEXT DEFAULT 'Available'
);

-- Table for referees
CREATE TABLE Referees (
  referee_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  certification TEXT,
  availability TEXT,
  active_status INTEGER DEFAULT 1
);

--table linking a team to a season
CREATE TABLE Team_Seasons (
  team_season_id    INTEGER PRIMARY KEY,
  team_id           INTEGER NOT NULL,
  season_id         INTEGER NOT NULL,
  captain_player_id INTEGER,
  UNIQUE (team_id, season_id),
  FOREIGN KEY (team_id) REFERENCES Teams(team_id),
  FOREIGN KEY (season_id) REFERENCES Seasons(season_id),
  FOREIGN KEY (captain_player_id) REFERENCES Players(player_id)
);

--table linking players to teams for a specific season
CREATE TABLE Team_Roster (
  roster_id INTEGER PRIMARY KEY,
  player_id INTEGER NOT NULL,
  team_season_id INTEGER NOT NULL,
  season_id INTEGER NOT NULL,
  jersey_number INTEGER,
  roster_status TEXT DEFAULT 'Active',
  is_captain INTEGER DEFAULT 0,
  UNIQUE (player_id, season_id),
  FOREIGN KEY (player_id) REFERENCES Players(player_id),
  FOREIGN KEY (team_season_id) REFERENCES Team_Seasons(team_season_id),
  FOREIGN KEY (season_id) REFERENCES Seasons(season_id)
);

-- Table for games
CREATE TABLE Games (
  game_id              INTEGER PRIMARY KEY,
  season_id            INTEGER NOT NULL,
  home_team_season_id  INTEGER NOT NULL,
  away_team_season_id  INTEGER NOT NULL,
  location_id          INTEGER NOT NULL,
  game_date            DATE NOT NULL,
  start_time           TIME NOT NULL,
  home_score           INTEGER,
  away_score           INTEGER,
  game_status          TEXT DEFAULT 'Scheduled',
  winner_team_season_id INTEGER,
  FOREIGN KEY (season_id) REFERENCES Seasons(season_id),
  FOREIGN KEY (home_team_season_id) REFERENCES Team_Seasons(team_season_id),
  FOREIGN KEY (away_team_season_id) REFERENCES Team_Seasons(team_season_id),
  FOREIGN KEY (location_id) REFERENCES Locations(location_id),
  FOREIGN KEY (winner_team_season_id) REFERENCES Team_Seasons(team_season_id),
  CHECK (home_team_season_id <> away_team_season_id),
  CHECK (home_score IS NULL OR home_score >= 0),
  CHECK (away_score IS NULL OR away_score >= 0)
);

--table linking referees to games
CREATE TABLE Game_Referees (
  game_referee_id INTEGER PRIMARY KEY,
  game_id         INTEGER NOT NULL,
  referee_id      INTEGER NOT NULL,
  assignment_role TEXT,
  UNIQUE (game_id, referee_id),
  FOREIGN KEY (game_id) REFERENCES Games(game_id),
  FOREIGN KEY (referee_id) REFERENCES Referees(referee_id)
);

--table for user logins and access roles
CREATE TABLE User_Accounts (
  user_id        INTEGER PRIMARY KEY,
  username       TEXT UNIQUE NOT NULL,
  password_hash  TEXT NOT NULL,
  role           TEXT CHECK (role IN ('Admin','Captain')),
  player_id      INTEGER,
  team_season_id INTEGER,
  FOREIGN KEY (player_id) REFERENCES Players(player_id),
  FOREIGN KEY (team_season_id) REFERENCES Team_Seasons(team_season_id)
);
