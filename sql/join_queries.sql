-- Team captains by season
SELECT
  s.season_name,
  t.team_name,
  t.division,
  p.name AS captain_name,
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
  p.name AS player_name,
  p.skill_level,
  tr.jersey_number,
  tr.roster_status,
  CASE
    WHEN tr.is_captain = 1 THEN 'Yes'
    ELSE 'No'
  END AS captain
FROM Team_Roster tr
JOIN Player p ON tr.player_id = p.player_id
JOIN Team_Season ts ON tr.team_season_id = ts.team_season_id
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON tr.season_id = s.season_id
ORDER BY s.season_name, t.team_name, tr.is_captain DESC, p.name;

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
  r.name AS referee_name,
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
