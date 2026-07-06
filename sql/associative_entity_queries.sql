-- Team_Season associative entity
SELECT
  ts.team_season_id,
  t.team_name,
  t.division,
  s.season_name,
  p.name AS captain_name,
  p.email AS captain_email
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Player p ON ts.captain_player_id = p.player_id
ORDER BY s.season_name, t.team_name;

-- Team_Roster associative entity
SELECT
  tr.roster_id,
  s.season_name,
  t.team_name,
  p.name AS player_name,
  p.email,
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

-- Game_Referee associative entity
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
JOIN Referee r ON gr.referee_id = r.referee_id
JOIN Team_Season hts ON g.home_team_season_id = hts.team_season_id
JOIN Team home ON hts.team_id = home.team_id
JOIN Team_Season ats ON g.away_team_season_id = ats.team_season_id
JOIN Team away ON ats.team_id = away.team_id
ORDER BY g.game_date, g.start_time, gr.assignment_role;


