-- UVA Intramural Soccer League Database System
-- join_queries.sql
-- Meaningful join queries for user-facing reports.
-- Run after schema.sql and inserts.sql.

PRAGMA foreign_keys = ON;

-- Team captains by season
SELECT
  s.season_name,
  t.team_name,
  t.division,
  p.first_name || ' ' || p.last_name AS captain_name,
  p.email AS captain_email
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Player p ON ts.captain_player_id = p.player_id
ORDER BY s.season_name, t.team_name;

-- Full roster by team and season
SELECT
  s.season_name,
  t.team_name,
  p.first_name || ' ' || p.last_name AS player_name,
  p.skill_level,
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
ORDER BY
  s.season_name,
  t.team_name,
  CASE WHEN ts.captain_player_id = p.player_id THEN 0 ELSE 1 END,
  p.last_name,
  p.first_name;

-- Completed game results
SELECT
  g.game_id,
  s.season_name,
  g.game_date,
  g.start_time,
  l.field_name AS location,
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
JOIN Location l ON g.location_id = l.location_id
JOIN Team_Season hts ON g.home_team_season_id = hts.team_season_id
JOIN Team home ON hts.team_id = home.team_id
JOIN Team_Season ats ON g.away_team_season_id = ats.team_season_id
JOIN Team away ON ats.team_id = away.team_id
WHERE g.game_status = 'Completed'
ORDER BY g.game_date, g.start_time;

-- Upcoming scheduled games
SELECT
  g.game_id,
  s.season_name,
  g.game_date,
  g.start_time,
  l.field_name AS location,
  home.team_name AS home_team,
  away.team_name AS away_team,
  g.game_status
FROM Game g
JOIN Season s ON g.season_id = s.season_id
JOIN Location l ON g.location_id = l.location_id
JOIN Team_Season hts ON g.home_team_season_id = hts.team_season_id
JOIN Team home ON hts.team_id = home.team_id
JOIN Team_Season ats ON g.away_team_season_id = ats.team_season_id
JOIN Team away ON ats.team_id = away.team_id
WHERE g.game_status = 'Scheduled'
ORDER BY g.game_date, g.start_time;

-- Referee assignments
SELECT
  g.game_id,
  g.game_date,
  g.start_time,
  home.team_name AS home_team,
  away.team_name AS away_team,
  r.first_name || ' ' || r.last_name AS referee_name,
  gr.assignment_role
FROM Game_Referee gr
JOIN Game g ON gr.game_id = g.game_id
JOIN Referee r ON gr.referee_id = r.referee_id
JOIN Team_Season hts ON g.home_team_season_id = hts.team_season_id
JOIN Team home ON hts.team_id = home.team_id
JOIN Team_Season ats ON g.away_team_season_id = ats.team_season_id
JOIN Team away ON ats.team_id = away.team_id
ORDER BY g.game_date, g.start_time, gr.assignment_role;

-- Roster size by team and season
SELECT
  s.season_name,
  t.team_name,
  COUNT(tr.player_id) AS roster_size
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Team_Roster tr ON ts.team_season_id = tr.team_season_id
GROUP BY s.season_name, t.team_name
ORDER BY s.season_name, t.team_name;

-- players who played for different teams in diff seasons (one-team-per-season rule and cross-season movement)
SELECT
  p.first_name || ' ' || p.last_name AS player_name,
  s1.season_name AS season_1,
  t1.team_name   AS team_1,
  s2.season_name AS season_2,
  t2.team_name   AS team_2
FROM Team_Roster tr1
JOIN Team_Roster tr2 ON tr1.player_id = tr2.player_id AND tr1.season_id < tr2.season_id
JOIN Player p        ON tr1.player_id = p.player_id
JOIN Team_Season ts1 ON tr1.team_season_id = ts1.team_season_id
JOIN Team t1         ON ts1.team_id = t1.team_id
JOIN Season s1       ON ts1.season_id = s1.season_id
JOIN Team_Season ts2 ON tr2.team_season_id = ts2.team_season_id
JOIN Team t2         ON ts2.team_id = t2.team_id
JOIN Season s2       ON ts2.season_id = s2.season_id
WHERE t1.team_id <> t2.team_id
ORDER BY player_name;

--ref workload: game officiated per ref, w date range
SELECT
  r.first_name || ' ' || r.last_name AS referee_name,
  r.certification,
  COUNT(gr.game_id) AS games_officiated,
  MIN(g.game_date)  AS first_game,
  MAX(g.game_date)  AS last_game
FROM Referee r
LEFT JOIN Game_Referee gr ON r.referee_id = gr.referee_id
LEFT JOIN Game g          ON gr.game_id = g.game_id
GROUP BY r.referee_id, r.first_name, r.last_name, r.certification
ORDER BY games_officiated DESC, referee_name;