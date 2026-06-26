-- Table for players
CREATE TABLE Players (
  player_id  INTEGER PRIMARY KEY,
  name  TEXT NOT NULL,
  age  INTEGER,
  team_id INTEGER,
  FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);
  
