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
