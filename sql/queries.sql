-- UVA Intramural Soccer League Database System
-- queries.sql
-- Required SQL SELECT statements for the project status report.
-- Run after schema.sql and inserts.sql. If views.sql has also been run, the optional
-- view-based queries at the bottom can be used for cleaner demos.

PRAGMA foreign_keys = ON;

-- ============================================================
-- 1. SELECT ALL ROWS FROM EACH TABLE
-- ============================================================

SELECT * FROM Team;
SELECT * FROM Player;
SELECT * FROM Season;
SELECT * FROM Team_Season;
SELECT * FROM Team_Roster;
SELECT * FROM Game;
SELECT * FROM Location;
SELECT * FROM Referee;
SELECT * FROM Game_Referee;
SELECT * FROM User_Account;

-- ============================================================
-- 2. FILTERED SELECT QUERIES
-- These use criteria to select only some rows.
-- ============================================================

-- 2.1 Active teams in Division A.
SELECT team_id, team_name, division, team_status
FROM Team
WHERE division = 'A'
  AND team_status = 'Active'
ORDER BY team_name;

-- 2.2 Eligible and active players with advanced skill level.
SELECT
  player_id,
  student_id,
  first_name || ' ' || last_name AS player_name,
  email,
  skill_level,
  eligibility_status
FROM Player
WHERE skill_level = 'Advanced'
  AND eligibility_status = 'Eligible'
  AND is_active = 1
ORDER BY last_name, first_name;

-- 2.3 Players who are ineligible or inactive and may need administrator review.
SELECT
  player_id,
  student_id,
  first_name || ' ' || last_name AS player_name,
  eligibility_status,
  is_active
FROM Player
WHERE eligibility_status <> 'Eligible'
   OR is_active = 0
ORDER BY last_name, first_name;

-- 2.4 Team captains for Spring 2026.
SELECT
  t.team_name,
  s.season_name,
  p.first_name || ' ' || p.last_name AS captain_name,
  p.email AS captain_email
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Player p ON ts.captain_player_id = p.player_id
WHERE s.season_name = 'Spring 2026'
ORDER BY t.team_name;

-- 2.5 Roster for UVA Cavs in Spring 2026.
SELECT
  t.team_name,
  s.season_name,
  p.first_name || ' ' || p.last_name AS player_name,
  tr.jersey_number,
  tr.roster_status,
  CASE
    WHEN ts.captain_player_id = p.player_id THEN 'Yes'
    ELSE 'No'
  END AS captain
FROM Team_Roster tr
JOIN Player p ON tr.player_id = p.player_id
JOIN Team_Season ts ON tr.team_season_id = ts.team_season_id
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON tr.season_id = s.season_id
WHERE t.team_name = 'UVA Cavs'
  AND s.season_name = 'Spring 2026'
ORDER BY
  CASE WHEN ts.captain_player_id = p.player_id THEN 0 ELSE 1 END,
  tr.jersey_number;

-- 2.6 Completed games with readable team names and scores.
SELECT
  g.game_id,
  s.season_name,
  g.game_date,
  g.start_time,
  home.team_name AS home_team,
  away.team_name AS away_team,
  g.home_score,
  g.away_score,
  CASE
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
WHERE g.game_status = 'Completed'
ORDER BY g.game_date, g.start_time;

-- 2.7 Scheduled Summer 2026 games that still need scores.
SELECT
  g.game_id,
  g.game_date,
  g.start_time,
  home.team_name AS home_team,
  away.team_name AS away_team,
  l.field_name AS location
FROM Game g
JOIN Team_Season hts ON g.home_team_season_id = hts.team_season_id
JOIN Team home ON hts.team_id = home.team_id
JOIN Team_Season ats ON g.away_team_season_id = ats.team_season_id
JOIN Team away ON ats.team_id = away.team_id
JOIN Location l ON g.location_id = l.location_id
JOIN Season s ON g.season_id = s.season_id
WHERE g.game_status = 'Scheduled'
  AND s.season_name = 'Summer 2026'
ORDER BY g.game_date, g.start_time;

-- 2.8 Referees who are currently available and active.
SELECT
  referee_id,
  first_name || ' ' || last_name AS referee_name,
  email,
  phone,
  certification
FROM Referee
WHERE availability = 'Available'
  AND is_active = 1
ORDER BY certification DESC, last_name, first_name;

-- 2.9 Available locations with capacity of at least 200.
SELECT location_id, field_name, field_type, capacity, availability_status
FROM Location
WHERE availability_status = 'Available'
  AND capacity >= 200
ORDER BY capacity DESC;

-- 2.10 Referee assignments for games on or after March 1, 2026.
SELECT
  g.game_id,
  g.game_date,
  g.start_time,
  r.first_name || ' ' || r.last_name AS referee_name,
  gr.assignment_role
FROM Game_Referee gr
JOIN Game g ON gr.game_id = g.game_id
JOIN Referee r ON gr.referee_id = r.referee_id
WHERE g.game_date >= '2026-03-01'
ORDER BY g.game_date, g.start_time, gr.assignment_role;

-- ============================================================
-- 3. SUMMARY QUERIES
-- These summarize data using COUNT, GROUP BY, aggregation, and calculated results.
-- ============================================================

-- 3.1 Dashboard counts for the whole database.
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

-- 3.2 Roster size by team and season. This also helps check the 8-to-18 player roster rule.
SELECT
  t.team_name,
  s.season_name,
  COUNT(tr.player_id) AS roster_size
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Team_Roster tr ON ts.team_season_id = tr.team_season_id
GROUP BY ts.team_season_id, t.team_name, s.season_name
ORDER BY s.season_name, t.team_name;

-- 3.3 Validation query: teams whose roster size is outside the 8-to-18 player range.
SELECT
  t.team_name,
  s.season_name,
  COUNT(tr.player_id) AS roster_size
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Team_Roster tr ON ts.team_season_id = tr.team_season_id
GROUP BY ts.team_season_id, t.team_name, s.season_name
HAVING COUNT(tr.player_id) < 8 OR COUNT(tr.player_id) > 18;

-- 3.4 Team standings calculated from completed game scores.
WITH all_team_games AS (
  SELECT
    g.season_id,
    g.home_team_season_id AS team_season_id,
    g.home_score AS goals_for,
    g.away_score AS goals_against,
    CASE
      WHEN g.home_score > g.away_score THEN 1 ELSE 0
    END AS win,
    CASE
      WHEN g.home_score = g.away_score THEN 1 ELSE 0
    END AS tie,
    CASE
      WHEN g.home_score < g.away_score THEN 1 ELSE 0
    END AS loss
  FROM Game g
  WHERE g.game_status = 'Completed'

  UNION ALL

  SELECT
    g.season_id,
    g.away_team_season_id AS team_season_id,
    g.away_score AS goals_for,
    g.home_score AS goals_against,
    CASE
      WHEN g.away_score > g.home_score THEN 1 ELSE 0
    END AS win,
    CASE
      WHEN g.away_score = g.home_score THEN 1 ELSE 0
    END AS tie,
    CASE
      WHEN g.away_score < g.home_score THEN 1 ELSE 0
    END AS loss
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
GROUP BY s.season_name, t.team_name
ORDER BY s.season_name, points DESC, goal_difference DESC, goals_for DESC;

-- 3.5 Games by status for each season.
SELECT
  s.season_name,
  g.game_status,
  COUNT(*) AS number_of_games
FROM Game g
JOIN Season s ON g.season_id = s.season_id
GROUP BY s.season_name, g.game_status
ORDER BY s.season_name, g.game_status;

-- 3.6 Number of games scheduled at each location.
SELECT
  l.field_name,
  l.field_type,
  l.capacity,
  COUNT(g.game_id) AS total_games
FROM Location l
LEFT JOIN Game g ON l.location_id = g.location_id
GROUP BY l.location_id, l.field_name, l.field_type, l.capacity
ORDER BY total_games DESC, l.field_name;

-- 3.7 Number of referee assignments by referee.
SELECT
  r.first_name || ' ' || r.last_name AS referee_name,
  r.certification,
  COUNT(gr.game_id) AS total_assignments
FROM Referee r
LEFT JOIN Game_Referee gr ON r.referee_id = gr.referee_id
GROUP BY r.referee_id, r.first_name, r.last_name, r.certification
ORDER BY total_assignments DESC, referee_name;

-- 3.8 Player participation count across seasons.
SELECT
  p.first_name || ' ' || p.last_name AS player_name,
  COUNT(DISTINCT tr.season_id) AS seasons_played,
  COUNT(DISTINCT tr.team_season_id) AS team_season_records
FROM Player p
LEFT JOIN Team_Roster tr ON p.player_id = tr.player_id
GROUP BY p.player_id, p.first_name, p.last_name
ORDER BY seasons_played DESC, player_name;

-- 3.9 Player count by skill level.
SELECT
  skill_level,
  COUNT(*) AS total_players
FROM Player
GROUP BY skill_level
ORDER BY total_players DESC, skill_level;

-- 3.10 Average goals per completed game.
SELECT
  ROUND(AVG(home_score + away_score), 2) AS average_total_goals_per_game,
  SUM(home_score + away_score) AS total_goals,
  COUNT(*) AS completed_games
FROM Game
WHERE game_status = 'Completed';

-- ============================================================
-- 4. OPTIONAL VIEW-BASED DEMO QUERIES
-- Run views.sql first before using this section.
-- ============================================================

SELECT * FROM v_game_details ORDER BY game_date, start_time;
SELECT * FROM v_team_standings ORDER BY season_name, points DESC, goal_difference DESC;
SELECT * FROM v_roster_sizes ORDER BY season_name, team_name;
SELECT * FROM v_referee_assignments ORDER BY game_date, start_time, assignment_role;
