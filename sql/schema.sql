-- Table for teams
CREATE TABLE Teams (
  team_id  INTEGER PRIMARY KEY,
  team_name TEXT NOT NULL
);

-- Table for players
CREATE TABLE Players (
  player_id  INTEGER PRIMARY KEY,
  name  TEXT NOT NULL,
  age  INTEGER,
  team_id INTEGER,
  FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

-- Table for games
CREATE TABLE Games (
  game_id INTEGER PRIMARY KEY,
  team1_id INTEGER,
  team2_id INTEGER,
  game_date TEXT,
  location_id INTEGER,
  referee_id INTEGER,
  season_id INTEGER,
  FOREIGN KEY (season_id) REFERENCES Seasons(season_id),
  FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
  FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
  FOREIGN KEY (location_id) REFERENCES Locations(location_id),
  FOREIGN KEY (referee_id) REFERENCES Referees(referee_id)
);

-- Table for referees
CREATE TABLE Referees (
  referee_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

-- Table for locations 
CREATE TABLE Locations (
  location_id INTEGER PRIMARY KEY,
  field_name TEXT NOT NULL
);

-- Table for seasons
CREATE TABLE Seasons (
  season_id INTEGER PRIMARY KEY,
  season_name TEXT NOT NULL
);
