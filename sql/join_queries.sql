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
