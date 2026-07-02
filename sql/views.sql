-- UVA Intramural Soccer League Database System
-- views.sql
-- Optional views that make reports and the Streamlit app easier to read.
-- Run after schema.sql and inserts.sql.

PRAGMA foreign_keys = ON;

DROP VIEW IF EXISTS v_dashboard_counts;
DROP VIEW IF EXISTS v_roster_sizes;
DROP VIEW IF EXISTS v_team_roster;
DROP VIEW IF EXISTS v_game_details;
DROP VIEW IF EXISTS v_referee_assignments;
DROP VIEW IF EXISTS v_location_usage;
DROP VIEW IF EXISTS v_team_standings;
DROP VIEW IF EXISTS v_player_participation;

CREATE VIEW v_dashboard_counts AS
SELECT 'Teams' AS category, COUNT(*) AS total FROM Team
UNION ALL
SELECT 'Players', COUNT(*) FROM Player
UNION ALL
SELECT 'Seasons', COUNT(*) FROM Season
UNION ALL
SELECT 'Games', COUNT(*) FROM Game
UNION ALL
SELECT 'Completed Games', COUNT(*) FROM Game WHERE game_status = 'Completed'
UNION ALL
SELECT 'Scheduled Games', COUNT(*) FROM Game WHERE game_status = 'Scheduled'
UNION ALL
SELECT 'Referees', COUNT(*) FROM Referee
UNION ALL
SELECT 'Locations', COUNT(*) FROM Location;

CREATE VIEW v_roster_sizes AS
SELECT
  ts.team_season_id,
  t.team_name,
  s.season_name,
  COUNT(tr.player_id) AS roster_size,
  CASE
    WHEN COUNT(tr.player_id) BETWEEN 8 AND 18 THEN 'Valid'
    ELSE 'Needs Review'
  END AS roster_rule_status
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Team_Roster tr ON ts.team_season_id = tr.team_season_id
GROUP BY ts.team_season_id, t.team_name, s.season_name;

CREATE VIEW v_team_roster AS
SELECT
  tr.roster_id,
  t.team_name,
  s.season_name,
  p.player_id,
  p.student_id,
  p.name AS player_name,
  p.email,
  p.phone,
  p.skill_level,
  p.eligibility_status,
  tr.jersey_number,
  tr.roster_status,
  CASE WHEN tr.is_captain = 1 THEN 'Yes' ELSE 'No' END AS captain
FROM Team_Roster tr
JOIN Player p ON tr.player_id = p.player_id
JOIN Team_Season ts ON tr.team_season_id = ts.team_season_id
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON tr.season_id = s.season_id;

CREATE VIEW v_game_details AS
SELECT
  g.game_id,
  s.season_name,
  g.game_date,
  g.start_time,
  home.team_name AS home_team,
  away.team_name AS away_team,
  l.field_name AS location,
  g.home_score,
  g.away_score,
  g.game_status,
  CASE
    WHEN g.game_status <> 'Completed' THEN 'Not completed'
    WHEN g.home_score = g.away_score THEN 'Tie'
    WHEN g.home_score > g.away_score THEN home.team_name
    ELSE away.team_name
  END AS result
FROM Game g
JOIN Season s ON g.season_id = s.season_id
JOIN Team_Season hts ON g.home_team_season_id = hts.team_season_id
JOIN Team home ON hts.team_id = home.team_id
JOIN Team_Season ats ON g.away_team_season_id = ats.team_season_id
JOIN Team away ON ats.team_id = away.team_id
JOIN Location l ON g.location_id = l.location_id;

CREATE VIEW v_referee_assignments AS
SELECT
  gr.game_referee_id,
  g.game_id,
  g.game_date,
  g.start_time,
  home.team_name AS home_team,
  away.team_name AS away_team,
  r.name AS referee_name,
  r.certification,
  gr.assignment_role
FROM Game_Referee gr
JOIN Game g ON gr.game_id = g.game_id
JOIN Team_Season hts ON g.home_team_season_id = hts.team_season_id
JOIN Team home ON hts.team_id = home.team_id
JOIN Team_Season ats ON g.away_team_season_id = ats.team_season_id
JOIN Team away ON ats.team_id = away.team_id
JOIN Referee r ON gr.referee_id = r.referee_id;

CREATE VIEW v_location_usage AS
SELECT
  l.location_id,
  l.field_name,
  l.field_type,
  l.capacity,
  l.availability_status,
  COUNT(g.game_id) AS total_games
FROM Location l
LEFT JOIN Game g ON l.location_id = g.location_id
GROUP BY l.location_id, l.field_name, l.field_type, l.capacity, l.availability_status;

CREATE VIEW v_player_participation AS
SELECT
  p.player_id,
  p.name AS player_name,
  p.skill_level,
  COUNT(DISTINCT tr.season_id) AS seasons_played,
  COUNT(DISTINCT tr.team_season_id) AS teams_played_for
FROM Player p
LEFT JOIN Team_Roster tr ON p.player_id = tr.player_id
GROUP BY p.player_id, p.name, p.skill_level;

CREATE VIEW v_team_standings AS
WITH all_team_games AS (
  SELECT
    g.season_id,
    g.home_team_season_id AS team_season_id,
    g.home_score AS goals_for,
    g.away_score AS goals_against,
    CASE WHEN g.home_score > g.away_score THEN 1 ELSE 0 END AS win,
    CASE WHEN g.home_score = g.away_score THEN 1 ELSE 0 END AS tie,
    CASE WHEN g.home_score < g.away_score THEN 1 ELSE 0 END AS loss
  FROM Game g
  WHERE g.game_status = 'Completed'

  UNION ALL

  SELECT
    g.season_id,
    g.away_team_season_id AS team_season_id,
    g.away_score AS goals_for,
    g.home_score AS goals_against,
    CASE WHEN g.away_score > g.home_score THEN 1 ELSE 0 END AS win,
    CASE WHEN g.away_score = g.home_score THEN 1 ELSE 0 END AS tie,
    CASE WHEN g.away_score < g.home_score THEN 1 ELSE 0 END AS loss
  FROM Game g
  WHERE g.game_status = 'Completed'
)
SELECT
  s.season_name,
  t.team_name,
  COUNT(*) AS games_played,
  SUM(win) AS wins,
  SUM(loss) AS losses,
  SUM(tie) AS ties,
  SUM(goals_for) AS goals_for,
  SUM(goals_against) AS goals_against,
  SUM(goals_for - goals_against) AS goal_difference,
  SUM(win * 3 + tie) AS points
FROM all_team_games atg
JOIN Team_Season ts ON atg.team_season_id = ts.team_season_id
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON atg.season_id = s.season_id
GROUP BY s.season_name, t.team_name;
