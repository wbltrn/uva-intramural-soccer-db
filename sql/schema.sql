-- Table for teams
CREATE TABLE Teams (
  team_id  INTEGER PRIMARY KEY,
  team_name TEXT NOT NULL,
  division TEXT,
  team_status TEXT DEFAULT 'Active',
  created_date TEXT
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

-- Table for games
CREATE TABLE Games (
  game_id              INTEGER PRIMARY KEY,
  season_id            INTEGER,
  home_team_season_id  INTEGER,
  away_team_season_id  INTEGER,
  location_id          INTEGER,
  game_date            TEXT,
  start_time           TEXT,
  home_score           INTEGER,
  away_score           INTEGER,
  game_status          TEXT DEFAULT 'Scheduled',
  winner_team_season_id INTEGER,
  FOREIGN KEY (season_id) REFERENCES Seasons(season_id),
  FOREIGN KEY (home_team_season_id) REFERENCES Team_Seasons(team_season_id),
  FOREIGN KEY (away_team_season_id) REFERENCES Team_Seasons(team_season_id),
  FOREIGN KEY (location_id) REFERENCES Locations(location_id),
  FOREIGN KEY (winner_team_season_id) REFERENCES Team_Seasons(team_season_id)
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

-- Table for locations 
CREATE TABLE Locations (
  location_id INTEGER PRIMARY KEY,
  field_name TEXT NOT NULL,
  field_address TEXT,
  field_type TEXT,
  capacity INTEGER,
  availability_status TEXT DEFAULT 'Available'
);

-- Table for seasons
CREATE TABLE Seasons (
  season_id INTEGER PRIMARY KEY,
  season_name TEXT NOT NULL,
  start_date TEXT,
  end_date TEXT,
  registration_deadline TEXT,
  season_status TEXT DEFAULT 'Upcoming'
);


