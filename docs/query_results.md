# Query Results

Generated from the project database (schema + inserts + views).


## Join Queries


### 1. Team captains by season

```sql
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
ORDER BY s.season_name, t.team_name
```

**Result (7 rows):**

```
| season_name | team_name     | division | captain_name | captain_email        |
|-------------|---------------|----------|--------------|----------------------|
| Spring 2026 | Blue Hawks    | A        | Aiden Patel  | apatel@virginia.edu  |
| Spring 2026 | Golden Ducks  | B        | Daniel Adams | dadams@virginia.edu  |
| Spring 2026 | Silver Sharks | A        | Chloe Turner | cturner@virginia.edu |
| Spring 2026 | UVA Cavs      | A        | Jacob Miller | jmiller@virginia.edu |
| Spring 2026 | Vikings       | B        | Sofia Rossi  | srossi@virginia.edu  |
| Summer 2026 | Blue Hawks    | A        | Aiden Patel  | apatel@virginia.edu  |
| Summer 2026 | UVA Cavs      | A        | Jacob Miller | jmiller@virginia.edu |
```


### 2. Full roster by team and season

```sql
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
  p.first_name
```

**Result (56 rows):**

```
| season_name | team_name     | player_name    | skill_level  | jersey_number | roster_status | captain |
|-------------|---------------|----------------|--------------|---------------|---------------|---------|
| Spring 2026 | Blue Hawks    | Aiden Patel    | Advanced     | 10            | Active        | Yes     |
| Spring 2026 | Blue Hawks    | Dylan Brown    | Advanced     | 9             | Active        | No      |
| Spring 2026 | Blue Hawks    | Cole Hernandez | Intermediate | 5             | Active        | No      |
| Spring 2026 | Blue Hawks    | Caleb Johnson  | Intermediate | 6             | Active        | No      |
| Spring 2026 | Blue Hawks    | Ryan Kim       | Beginner     | 4             | Active        | No      |
| Spring 2026 | Blue Hawks    | Nathan Lopez   | Intermediate | 7             | Active        | No      |
| Spring 2026 | Blue Hawks    | Adrian Rivera  | Advanced     | 11            | Active        | No      |
| Spring 2026 | Blue Hawks    | Isaac Wright   | Beginner     | 2             | Active        | No      |
| Spring 2026 | Golden Ducks  | Daniel Adams   | Advanced     | 10            | Active        | Yes     |
| Spring 2026 | Golden Ducks  | Marcus Bell    | Intermediate | 8             | Active        | No      |
| Spring 2026 | Golden Ducks  | Eli Foster     | Beginner     | 3             | Active        | No      |
| Spring 2026 | Golden Ducks  | Diego Morales  | Advanced     | 11            | Active        | No      |
| Spring 2026 | Golden Ducks  | Leo Murphy     | Advanced     | 9             | Active        | No      |
| Spring 2026 | Golden Ducks  | Sean O'Connor  | Intermediate | 5             | Active        | No      |
| Spring 2026 | Golden Ducks  | Gabriel Reyes  | Intermediate | 7             | Active        | No      |
| Spring 2026 | Golden Ducks  | Julian Torres  | Beginner     | 4             | Active        | No      |
| Spring 2026 | Silver Sharks | Chloe Turner   | Advanced     | 10            | Active        | Yes     |
| Spring 2026 | Silver Sharks | Ella Bennett   | Intermediate | 8             | Active        | No      |
| Spring 2026 | Silver Sharks | Ruby Coleman   | Advanced     | 5             | Active        | No      |
| Spring 2026 | Silver Sharks | Hannah Cooper  | Advanced     | 9             | Active        | No      |
| Spring 2026 | Silver Sharks | Lily Evans     | Beginner     | 4             | Active        | No      |
| Spring 2026 | Silver Sharks | Zoe Parker     | Intermediate | 7             | Active        | No      |
| Spring 2026 | Silver Sharks | Nora Price     | Beginner     | 3             | Inactive      | No      |
| Spring 2026 | Silver Sharks | Aria Sanders   | Intermediate | 11            | Active        | No      |
| Spring 2026 | UVA Cavs      | Jacob Miller   | Advanced     | 10            | Active        | Yes     |
| Spring 2026 | UVA Cavs      | Mason Davis    | Intermediate | 11            | Active        | No      |
| Spring 2026 | UVA Cavs      | Ethan Garcia   | Advanced     | 9             | Active        | No      |
| Spring 2026 | UVA Cavs      | Lucas Martinez | Beginner     | 8             | Active        | No      |
| Spring 2026 | UVA Cavs      | Henry Nguyen   | Advanced     | 3             | Active        | No      |
| Spring 2026 | UVA Cavs      | Liam O'Brien   | Intermediate | 7             | Active        | No      |
| Spring 2026 | UVA Cavs      | Owen Thompson  | Intermediate | 5             | Active        | No      |
| Spring 2026 | UVA Cavs      | Noah Williams  | Beginner     | 4             | Active        | No      |
| Spring 2026 | Vikings       | Sofia Rossi    | Advanced     | 10            | Active        | Yes     |
| Spring 2026 | Vikings       | Maya Anderson  | Intermediate | 8             | Active        | No      |
| Spring 2026 | Vikings       | Olivia Clark   | Beginner     | 4             | Active        | No      |
| Spring 2026 | Vikings       | Grace Hall     | Intermediate | 6             | Active        | No      |
| Spring 2026 | Vikings       | Emma Lewis     | Advanced     | 9             | Active        | No      |
| Spring 2026 | Vikings       | Mia Scott      | Advanced     | 11            | Active        | No      |
| Spring 2026 | Vikings       | Ava Walker     | Intermediate | 7             | Active        | No      |
| Spring 2026 | Vikings       | Isabella Young | Beginner     | 3             | Active        | No      |
| Summer 2026 | Blue Hawks    | Aiden Patel    | Advanced     | 10            | Active        | Yes     |
| Summer 2026 | Blue Hawks    | Dylan Brown    | Advanced     | 9             | Active        | No      |
| Summer 2026 | Blue Hawks    | Caleb Johnson  | Intermediate | 6             | Active        | No      |
| Summer 2026 | Blue Hawks    | Ryan Kim       | Beginner     | 4             | Active        | No      |
| Summer 2026 | Blue Hawks    | Nathan Lopez   | Intermediate | 7             | Active        | No      |
| Summer 2026 | Blue Hawks    | Adrian Rivera  | Advanced     | 11            | Active        | No      |
| Summer 2026 | Blue Hawks    | Owen Thompson  | Intermediate | 5             | Active        | No      |
| Summer 2026 | Blue Hawks    | Isaac Wright   | Beginner     | 2             | Active        | No      |
| Summer 2026 | UVA Cavs      | Jacob Miller   | Advanced     | 10            | Active        | Yes     |
| Summer 2026 | UVA Cavs      | Mason Davis    | Intermediate | 11            | Active        | No      |
| Summer 2026 | UVA Cavs      | Ethan Garcia   | Advanced     | 9             | Active        | No      |
| Summer 2026 | UVA Cavs      | Cole Hernandez | Intermediate | 5             | Active        | No      |
| Summer 2026 | UVA Cavs      | Lucas Martinez | Beginner     | 8             | Active        | No      |
| Summer 2026 | UVA Cavs      | Henry Nguyen   | Advanced     | 3             | Active        | No      |
| Summer 2026 | UVA Cavs      | Liam O'Brien   | Intermediate | 7             | Active        | No      |
| Summer 2026 | UVA Cavs      | Noah Williams  | Beginner     | 4             | Active        | No      |
```


### 3. Completed game results

```sql
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
ORDER BY g.game_date, g.start_time
```

**Result (10 rows):**

```
| game_id | season_name | game_date  | start_time | location          | home_team     | away_team     | home_score | away_score | result       |
|---------|-------------|------------|------------|-------------------|---------------|---------------|------------|------------|--------------|
| 1       | Spring 2026 | 2026-02-14 | 10:00:00   | Carr's Hill Field | UVA Cavs      | Blue Hawks    | 3          | 1          | UVA Cavs     |
| 2       | Spring 2026 | 2026-02-21 | 12:00:00   | Lambeth Field     | Vikings       | UVA Cavs      | 2          | 2          | Tie          |
| 3       | Spring 2026 | 2026-02-28 | 14:00:00   | Carr's Hill Field | UVA Cavs      | Golden Ducks  | 4          | 0          | UVA Cavs     |
| 4       | Spring 2026 | 2026-03-07 | 10:00:00   | The Park at UVA   | Silver Sharks | UVA Cavs      | 1          | 2          | UVA Cavs     |
| 5       | Spring 2026 | 2026-03-14 | 12:00:00   | Lambeth Field     | Blue Hawks    | Vikings       | 1          | 4          | Vikings      |
| 6       | Spring 2026 | 2026-03-21 | 14:00:00   | Nameless Fields   | Golden Ducks  | Blue Hawks    | 3          | 0          | Golden Ducks |
| 7       | Spring 2026 | 2026-03-28 | 10:00:00   | Carr's Hill Field | Blue Hawks    | Silver Sharks | 2          | 2          | Tie          |
| 8       | Spring 2026 | 2026-04-04 | 12:00:00   | Lambeth Field     | Vikings       | Golden Ducks  | 3          | 1          | Vikings      |
| 9       | Spring 2026 | 2026-04-11 | 14:00:00   | The Park at UVA   | Silver Sharks | Vikings       | 0          | 1          | Vikings      |
| 10      | Spring 2026 | 2026-04-18 | 10:00:00   | Nameless Fields   | Golden Ducks  | Silver Sharks | 2          | 1          | Golden Ducks |
```


### 4. Upcoming scheduled games

```sql
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
ORDER BY g.game_date, g.start_time
```

**Result (5 rows):**

```
| game_id | season_name | game_date  | start_time | location          | home_team  | away_team  | game_status |
|---------|-------------|------------|------------|-------------------|------------|------------|-------------|
| 11      | Summer 2026 | 2026-07-04 | 10:00:00   | Carr's Hill Field | UVA Cavs   | Blue Hawks | Scheduled   |
| 12      | Summer 2026 | 2026-07-11 | 12:00:00   | Lambeth Field     | Blue Hawks | UVA Cavs   | Scheduled   |
| 13      | Summer 2026 | 2026-07-18 | 10:00:00   | Carr's Hill Field | UVA Cavs   | Blue Hawks | Scheduled   |
| 14      | Summer 2026 | 2026-07-25 | 14:00:00   | The Park at UVA   | Blue Hawks | UVA Cavs   | Scheduled   |
| 15      | Summer 2026 | 2026-08-01 | 10:00:00   | Carr's Hill Field | UVA Cavs   | Blue Hawks | Scheduled   |
```


### 5. Referee assignments

```sql
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
ORDER BY g.game_date, g.start_time, gr.assignment_role
```

**Result (21 rows):**

```
| game_id | game_date  | start_time | home_team     | away_team     | referee_name | assignment_role |
|---------|------------|------------|---------------|---------------|--------------|-----------------|
| 1       | 2026-02-14 | 10:00:00   | UVA Cavs      | Blue Hawks    | Priya Nair   | Assistant       |
| 1       | 2026-02-14 | 10:00:00   | UVA Cavs      | Blue Hawks    | Marcus Lee   | Head Referee    |
| 2       | 2026-02-21 | 12:00:00   | Vikings       | UVA Cavs      | Tom Becker   | Head Referee    |
| 3       | 2026-02-28 | 14:00:00   | UVA Cavs      | Golden Ducks  | David Okoye  | Assistant       |
| 3       | 2026-02-28 | 14:00:00   | UVA Cavs      | Golden Ducks  | Marcus Lee   | Head Referee    |
| 4       | 2026-03-07 | 10:00:00   | Silver Sharks | UVA Cavs      | Priya Nair   | Head Referee    |
| 5       | 2026-03-14 | 12:00:00   | Blue Hawks    | Vikings       | Sara Klein   | Assistant       |
| 5       | 2026-03-14 | 12:00:00   | Blue Hawks    | Vikings       | Tom Becker   | Head Referee    |
| 6       | 2026-03-21 | 14:00:00   | Golden Ducks  | Blue Hawks    | David Okoye  | Head Referee    |
| 7       | 2026-03-28 | 10:00:00   | Blue Hawks    | Silver Sharks | Priya Nair   | Assistant       |
| 7       | 2026-03-28 | 10:00:00   | Blue Hawks    | Silver Sharks | Marcus Lee   | Head Referee    |
| 8       | 2026-04-04 | 12:00:00   | Vikings       | Golden Ducks  | Tom Becker   | Head Referee    |
| 9       | 2026-04-11 | 14:00:00   | Silver Sharks | Vikings       | Emily Chen   | Assistant       |
| 9       | 2026-04-11 | 14:00:00   | Silver Sharks | Vikings       | David Okoye  | Head Referee    |
| 10      | 2026-04-18 | 10:00:00   | Golden Ducks  | Silver Sharks | Tom Becker   | Assistant       |
| 10      | 2026-04-18 | 10:00:00   | Golden Ducks  | Silver Sharks | Priya Nair   | Head Referee    |
| 11      | 2026-07-04 | 10:00:00   | UVA Cavs      | Blue Hawks    | Marcus Lee   | Head Referee    |
| 12      | 2026-07-11 | 12:00:00   | Blue Hawks    | UVA Cavs      | Priya Nair   | Head Referee    |
| 13      | 2026-07-18 | 10:00:00   | UVA Cavs      | Blue Hawks    | Tom Becker   | Head Referee    |
| 14      | 2026-07-25 | 14:00:00   | Blue Hawks    | UVA Cavs      | David Okoye  | Head Referee    |
| 15      | 2026-08-01 | 10:00:00   | UVA Cavs      | Blue Hawks    | Marcus Lee   | Head Referee    |
```


### 6. Roster size by team and season

```sql
SELECT
  s.season_name,
  t.team_name,
  COUNT(tr.player_id) AS roster_size
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Team_Roster tr ON ts.team_season_id = tr.team_season_id
GROUP BY s.season_name, t.team_name
ORDER BY s.season_name, t.team_name
```

**Result (7 rows):**

```
| season_name | team_name     | roster_size |
|-------------|---------------|-------------|
| Spring 2026 | Blue Hawks    | 8           |
| Spring 2026 | Golden Ducks  | 8           |
| Spring 2026 | Silver Sharks | 8           |
| Spring 2026 | UVA Cavs      | 8           |
| Spring 2026 | Vikings       | 8           |
| Summer 2026 | Blue Hawks    | 8           |
| Summer 2026 | UVA Cavs      | 8           |
```


### 7. players who played for different teams in diff seasons (one-team-per-season rule and cross-season movement)

```sql
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
ORDER BY player_name
```

**Result (2 rows):**

```
| player_name    | season_1    | team_1     | season_2    | team_2     |
|----------------|-------------|------------|-------------|------------|
| Cole Hernandez | Spring 2026 | Blue Hawks | Summer 2026 | UVA Cavs   |
| Owen Thompson  | Spring 2026 | UVA Cavs   | Summer 2026 | Blue Hawks |
```


### 8. ref workload: game officiated per ref, w date range

```sql
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
ORDER BY games_officiated DESC, referee_name
```

**Result (6 rows):**

```
| referee_name | certification | games_officiated | first_game | last_game  |
|--------------|---------------|------------------|------------|------------|
| Marcus Lee   | Level 2       | 5                | 2026-02-14 | 2026-08-01 |
| Priya Nair   | Level 1       | 5                | 2026-02-14 | 2026-07-11 |
| Tom Becker   | National      | 5                | 2026-02-21 | 2026-07-18 |
| David Okoye  | Level 1       | 4                | 2026-02-28 | 2026-07-25 |
| Emily Chen   | Level 2       | 1                | 2026-04-11 | 2026-04-11 |
| Sara Klein   | Level 2       | 1                | 2026-03-14 | 2026-03-14 |
```


## Associative Entity Queries


### 1. Team_Season associative entity — Shows each team-season record with team, season, and captain details.

```sql
SELECT
  ts.team_season_id,
  t.team_name,
  t.division,
  s.season_name,
  p.first_name || ' ' || p.last_name AS captain_name,
  p.email AS captain_email
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Player p ON ts.captain_player_id = p.player_id
ORDER BY s.season_name, t.team_name
```

**Result (7 rows):**

```
| team_season_id | team_name     | division | season_name | captain_name | captain_email        |
|----------------|---------------|----------|-------------|--------------|----------------------|
| 2              | Blue Hawks    | A        | Spring 2026 | Aiden Patel  | apatel@virginia.edu  |
| 4              | Golden Ducks  | B        | Spring 2026 | Daniel Adams | dadams@virginia.edu  |
| 5              | Silver Sharks | A        | Spring 2026 | Chloe Turner | cturner@virginia.edu |
| 1              | UVA Cavs      | A        | Spring 2026 | Jacob Miller | jmiller@virginia.edu |
| 3              | Vikings       | B        | Spring 2026 | Sofia Rossi  | srossi@virginia.edu  |
| 7              | Blue Hawks    | A        | Summer 2026 | Aiden Patel  | apatel@virginia.edu  |
| 6              | UVA Cavs      | A        | Summer 2026 | Jacob Miller | jmiller@virginia.edu |
```


### 2. Team_Roster associative entity — Shows each roster record with player, team, season, and captain status.

```sql
SELECT
  tr.roster_id,
  s.season_name,
  t.team_name,
  p.first_name || ' ' || p.last_name AS player_name,
  p.email,
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
  p.first_name
```

**Result (56 rows):**

```
| roster_id | season_name | team_name     | player_name    | email                   | jersey_number | roster_status | captain |
|-----------|-------------|---------------|----------------|-------------------------|---------------|---------------|---------|
| 9         | Spring 2026 | Blue Hawks    | Aiden Patel    | apatel@virginia.edu     | 10            | Active        | Yes     |
| 12        | Spring 2026 | Blue Hawks    | Dylan Brown    | dbrown@virginia.edu     | 9             | Active        | No      |
| 16        | Spring 2026 | Blue Hawks    | Cole Hernandez | chernandez@virginia.edu | 5             | Active        | No      |
| 10        | Spring 2026 | Blue Hawks    | Caleb Johnson  | cjohnson@virginia.edu   | 6             | Active        | No      |
| 11        | Spring 2026 | Blue Hawks    | Ryan Kim       | rkim@virginia.edu       | 4             | Active        | No      |
| 13        | Spring 2026 | Blue Hawks    | Nathan Lopez   | nlopez@virginia.edu     | 7             | Active        | No      |
| 15        | Spring 2026 | Blue Hawks    | Adrian Rivera  | arivera@virginia.edu    | 11            | Active        | No      |
| 14        | Spring 2026 | Blue Hawks    | Isaac Wright   | iwright@virginia.edu    | 2             | Active        | No      |
| 25        | Spring 2026 | Golden Ducks  | Daniel Adams   | dadams@virginia.edu     | 10            | Active        | Yes     |
| 29        | Spring 2026 | Golden Ducks  | Marcus Bell    | mbell@virginia.edu      | 8             | Active        | No      |
| 30        | Spring 2026 | Golden Ducks  | Eli Foster     | efoster@virginia.edu    | 3             | Active        | No      |
| 31        | Spring 2026 | Golden Ducks  | Diego Morales  | dmorales@virginia.edu   | 11            | Active        | No      |
| 28        | Spring 2026 | Golden Ducks  | Leo Murphy     | lmurphy@virginia.edu    | 9             | Active        | No      |
| 32        | Spring 2026 | Golden Ducks  | Sean O'Connor  | soconnor@virginia.edu   | 5             | Active        | No      |
| 26        | Spring 2026 | Golden Ducks  | Gabriel Reyes  | greyes@virginia.edu     | 7             | Active        | No      |
| 27        | Spring 2026 | Golden Ducks  | Julian Torres  | jtorres@virginia.edu    | 4             | Active        | No      |
| 33        | Spring 2026 | Silver Sharks | Chloe Turner   | cturner@virginia.edu    | 10            | Active        | Yes     |
| 37        | Spring 2026 | Silver Sharks | Ella Bennett   | ebennett@virginia.edu   | 8             | Active        | No      |
| 40        | Spring 2026 | Silver Sharks | Ruby Coleman   | rcoleman@virginia.edu   | 5             | Active        | No      |
| 36        | Spring 2026 | Silver Sharks | Hannah Cooper  | hcooper@virginia.edu    | 9             | Active        | No      |
| 35        | Spring 2026 | Silver Sharks | Lily Evans     | levans@virginia.edu     | 4             | Active        | No      |
| 34        | Spring 2026 | Silver Sharks | Zoe Parker     | zparker@virginia.edu    | 7             | Active        | No      |
| 38        | Spring 2026 | Silver Sharks | Nora Price     | nprice@virginia.edu     | 3             | Inactive      | No      |
| 39        | Spring 2026 | Silver Sharks | Aria Sanders   | asanders@virginia.edu   | 11            | Active        | No      |
| 1         | Spring 2026 | UVA Cavs      | Jacob Miller   | jmiller@virginia.edu    | 10            | Active        | Yes     |
| 5         | Spring 2026 | UVA Cavs      | Mason Davis    | mdavis@virginia.edu     | 11            | Active        | No      |
| 4         | Spring 2026 | UVA Cavs      | Ethan Garcia   | egarcia@virginia.edu    | 9             | Active        | No      |
| 6         | Spring 2026 | UVA Cavs      | Lucas Martinez | lmartinez@virginia.edu  | 8             | Active        | No      |
| 7         | Spring 2026 | UVA Cavs      | Henry Nguyen   | hnguyen@virginia.edu    | 3             | Active        | No      |
| 2         | Spring 2026 | UVA Cavs      | Liam O'Brien   | lobrien@virginia.edu    | 7             | Active        | No      |
| 8         | Spring 2026 | UVA Cavs      | Owen Thompson  | othompson@virginia.edu  | 5             | Active        | No      |
| 3         | Spring 2026 | UVA Cavs      | Noah Williams  | nwilliams@virginia.edu  | 4             | Active        | No      |
| 17        | Spring 2026 | Vikings       | Sofia Rossi    | srossi@virginia.edu     | 10            | Active        | Yes     |
| 18        | Spring 2026 | Vikings       | Maya Anderson  | manderson@virginia.edu  | 8             | Active        | No      |
| 19        | Spring 2026 | Vikings       | Olivia Clark   | oclark@virginia.edu     | 4             | Active        | No      |
| 24        | Spring 2026 | Vikings       | Grace Hall     | ghall@virginia.edu      | 6             | Active        | No      |
| 20        | Spring 2026 | Vikings       | Emma Lewis     | elewis@virginia.edu     | 9             | Active        | No      |
| 23        | Spring 2026 | Vikings       | Mia Scott      | mscott@virginia.edu     | 11            | Active        | No      |
| 21        | Spring 2026 | Vikings       | Ava Walker     | awalker@virginia.edu    | 7             | Active        | No      |
| 22        | Spring 2026 | Vikings       | Isabella Young | iyoung@virginia.edu     | 3             | Active        | No      |
| 49        | Summer 2026 | Blue Hawks    | Aiden Patel    | apatel@virginia.edu     | 10            | Active        | Yes     |
| 52        | Summer 2026 | Blue Hawks    | Dylan Brown    | dbrown@virginia.edu     | 9             | Active        | No      |
| 50        | Summer 2026 | Blue Hawks    | Caleb Johnson  | cjohnson@virginia.edu   | 6             | Active        | No      |
| 51        | Summer 2026 | Blue Hawks    | Ryan Kim       | rkim@virginia.edu       | 4             | Active        | No      |
| 53        | Summer 2026 | Blue Hawks    | Nathan Lopez   | nlopez@virginia.edu     | 7             | Active        | No      |
| 55        | Summer 2026 | Blue Hawks    | Adrian Rivera  | arivera@virginia.edu    | 11            | Active        | No      |
| 56        | Summer 2026 | Blue Hawks    | Owen Thompson  | othompson@virginia.edu  | 5             | Active        | No      |
| 54        | Summer 2026 | Blue Hawks    | Isaac Wright   | iwright@virginia.edu    | 2             | Active        | No      |
| 41        | Summer 2026 | UVA Cavs      | Jacob Miller   | jmiller@virginia.edu    | 10            | Active        | Yes     |
| 45        | Summer 2026 | UVA Cavs      | Mason Davis    | mdavis@virginia.edu     | 11            | Active        | No      |
| 44        | Summer 2026 | UVA Cavs      | Ethan Garcia   | egarcia@virginia.edu    | 9             | Active        | No      |
| 48        | Summer 2026 | UVA Cavs      | Cole Hernandez | chernandez@virginia.edu | 5             | Active        | No      |
| 46        | Summer 2026 | UVA Cavs      | Lucas Martinez | lmartinez@virginia.edu  | 8             | Active        | No      |
| 47        | Summer 2026 | UVA Cavs      | Henry Nguyen   | hnguyen@virginia.edu    | 3             | Active        | No      |
| 42        | Summer 2026 | UVA Cavs      | Liam O'Brien   | lobrien@virginia.edu    | 7             | Active        | No      |
| 43        | Summer 2026 | UVA Cavs      | Noah Williams  | nwilliams@virginia.edu  | 4             | Active        | No      |
```


### 3. Game_Referee associative entity — Shows each referee assignment with game, team, and referee details.

```sql
SELECT
  gr.game_referee_id,
  g.game_id,
  g.game_date,
  g.start_time,
  home.team_name AS home_team,
  away.team_name AS away_team,
  r.first_name || ' ' || r.last_name AS referee_name,
  r.certification,
  gr.assignment_role
FROM Game_Referee gr
JOIN Game g ON gr.game_id = g.game_id
JOIN Referee r ON gr.referee_id = r.referee_id
JOIN Team_Season hts ON g.home_team_season_id = hts.team_season_id
JOIN Team home ON hts.team_id = home.team_id
JOIN Team_Season ats ON g.away_team_season_id = ats.team_season_id
JOIN Team away ON ats.team_id = away.team_id
ORDER BY g.game_date, g.start_time, gr.assignment_role
```

**Result (21 rows):**

```
| game_referee_id | game_id | game_date  | start_time | home_team     | away_team     | referee_name | certification | assignment_role |
|-----------------|---------|------------|------------|---------------|---------------|--------------|---------------|-----------------|
| 2               | 1       | 2026-02-14 | 10:00:00   | UVA Cavs      | Blue Hawks    | Priya Nair   | Level 1       | Assistant       |
| 1               | 1       | 2026-02-14 | 10:00:00   | UVA Cavs      | Blue Hawks    | Marcus Lee   | Level 2       | Head Referee    |
| 3               | 2       | 2026-02-21 | 12:00:00   | Vikings       | UVA Cavs      | Tom Becker   | National      | Head Referee    |
| 5               | 3       | 2026-02-28 | 14:00:00   | UVA Cavs      | Golden Ducks  | David Okoye  | Level 1       | Assistant       |
| 4               | 3       | 2026-02-28 | 14:00:00   | UVA Cavs      | Golden Ducks  | Marcus Lee   | Level 2       | Head Referee    |
| 6               | 4       | 2026-03-07 | 10:00:00   | Silver Sharks | UVA Cavs      | Priya Nair   | Level 1       | Head Referee    |
| 8               | 5       | 2026-03-14 | 12:00:00   | Blue Hawks    | Vikings       | Sara Klein   | Level 2       | Assistant       |
| 7               | 5       | 2026-03-14 | 12:00:00   | Blue Hawks    | Vikings       | Tom Becker   | National      | Head Referee    |
| 9               | 6       | 2026-03-21 | 14:00:00   | Golden Ducks  | Blue Hawks    | David Okoye  | Level 1       | Head Referee    |
| 11              | 7       | 2026-03-28 | 10:00:00   | Blue Hawks    | Silver Sharks | Priya Nair   | Level 1       | Assistant       |
| 10              | 7       | 2026-03-28 | 10:00:00   | Blue Hawks    | Silver Sharks | Marcus Lee   | Level 2       | Head Referee    |
| 12              | 8       | 2026-04-04 | 12:00:00   | Vikings       | Golden Ducks  | Tom Becker   | National      | Head Referee    |
| 14              | 9       | 2026-04-11 | 14:00:00   | Silver Sharks | Vikings       | Emily Chen   | Level 2       | Assistant       |
| 13              | 9       | 2026-04-11 | 14:00:00   | Silver Sharks | Vikings       | David Okoye  | Level 1       | Head Referee    |
| 16              | 10      | 2026-04-18 | 10:00:00   | Golden Ducks  | Silver Sharks | Tom Becker   | National      | Assistant       |
| 15              | 10      | 2026-04-18 | 10:00:00   | Golden Ducks  | Silver Sharks | Priya Nair   | Level 1       | Head Referee    |
| 17              | 11      | 2026-07-04 | 10:00:00   | UVA Cavs      | Blue Hawks    | Marcus Lee   | Level 2       | Head Referee    |
| 18              | 12      | 2026-07-11 | 12:00:00   | Blue Hawks    | UVA Cavs      | Priya Nair   | Level 1       | Head Referee    |
| 19              | 13      | 2026-07-18 | 10:00:00   | UVA Cavs      | Blue Hawks    | Tom Becker   | National      | Head Referee    |
| 20              | 14      | 2026-07-25 | 14:00:00   | Blue Hawks    | UVA Cavs      | David Okoye  | Level 1       | Head Referee    |
| 21              | 15      | 2026-08-01 | 10:00:00   | UVA Cavs      | Blue Hawks    | Marcus Lee   | Level 2       | Head Referee    |
```


## Filtered & Summary Queries


### 1. 2.1 Active teams in Division A.

```sql
SELECT team_id, team_name, division, team_status
FROM Team
WHERE division = 'A'
  AND team_status = 'Active'
ORDER BY team_name
```

**Result (3 rows):**

```
| team_id | team_name     | division | team_status |
|---------|---------------|----------|-------------|
| 2       | Blue Hawks    | A        | Active      |
| 5       | Silver Sharks | A        | Active      |
| 1       | UVA Cavs      | A        | Active      |
```


### 2. 2.2 Eligible and active players with advanced skill level.

```sql
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
ORDER BY last_name, first_name
```

**Result (15 rows):**

```
| player_id | student_id | player_name   | email                 | skill_level | eligibility_status |
|-----------|------------|---------------|-----------------------|-------------|--------------------|
| 25        | S1025      | Daniel Adams  | dadams@virginia.edu   | Advanced    | Eligible           |
| 12        | S1012      | Dylan Brown   | dbrown@virginia.edu   | Advanced    | Eligible           |
| 40        | S1040      | Ruby Coleman  | rcoleman@virginia.edu | Advanced    | Eligible           |
| 36        | S1036      | Hannah Cooper | hcooper@virginia.edu  | Advanced    | Eligible           |
| 4         | S1004      | Ethan Garcia  | egarcia@virginia.edu  | Advanced    | Eligible           |
| 20        | S1020      | Emma Lewis    | elewis@virginia.edu   | Advanced    | Eligible           |
| 1         | S1001      | Jacob Miller  | jmiller@virginia.edu  | Advanced    | Eligible           |
| 31        | S1031      | Diego Morales | dmorales@virginia.edu | Advanced    | Eligible           |
| 28        | S1028      | Leo Murphy    | lmurphy@virginia.edu  | Advanced    | Eligible           |
| 7         | S1007      | Henry Nguyen  | hnguyen@virginia.edu  | Advanced    | Eligible           |
| 9         | S1009      | Aiden Patel   | apatel@virginia.edu   | Advanced    | Eligible           |
| 15        | S1015      | Adrian Rivera | arivera@virginia.edu  | Advanced    | Eligible           |
| 17        | S1017      | Sofia Rossi   | srossi@virginia.edu   | Advanced    | Eligible           |
| 23        | S1023      | Mia Scott     | mscott@virginia.edu   | Advanced    | Eligible           |
| 33        | S1033      | Chloe Turner  | cturner@virginia.edu  | Advanced    | Eligible           |
```


### 3. 2.3 Players who are ineligible or inactive and may need administrator review.

```sql
SELECT
  player_id,
  student_id,
  first_name || ' ' || last_name AS player_name,
  eligibility_status,
  is_active
FROM Player
WHERE eligibility_status <> 'Eligible'
   OR is_active = 0
ORDER BY last_name, first_name
```

**Result (2 rows):**

```
| player_id | student_id | player_name  | eligibility_status | is_active |
|-----------|------------|--------------|--------------------|-----------|
| 38        | S1038      | Nora Price   | Ineligible         | 0         |
| 14        | S1014      | Isaac Wright | Ineligible         | 1         |
```


### 4. 2.4 Team captains for Spring 2026.

```sql
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
ORDER BY t.team_name
```

**Result (5 rows):**

```
| team_name     | season_name | captain_name | captain_email        |
|---------------|-------------|--------------|----------------------|
| Blue Hawks    | Spring 2026 | Aiden Patel  | apatel@virginia.edu  |
| Golden Ducks  | Spring 2026 | Daniel Adams | dadams@virginia.edu  |
| Silver Sharks | Spring 2026 | Chloe Turner | cturner@virginia.edu |
| UVA Cavs      | Spring 2026 | Jacob Miller | jmiller@virginia.edu |
| Vikings       | Spring 2026 | Sofia Rossi  | srossi@virginia.edu  |
```


### 5. 2.5 Roster for UVA Cavs in Spring 2026.

```sql
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
  tr.jersey_number
```

**Result (8 rows):**

```
| team_name | season_name | player_name    | jersey_number | roster_status | captain |
|-----------|-------------|----------------|---------------|---------------|---------|
| UVA Cavs  | Spring 2026 | Jacob Miller   | 10            | Active        | Yes     |
| UVA Cavs  | Spring 2026 | Henry Nguyen   | 3             | Active        | No      |
| UVA Cavs  | Spring 2026 | Noah Williams  | 4             | Active        | No      |
| UVA Cavs  | Spring 2026 | Owen Thompson  | 5             | Active        | No      |
| UVA Cavs  | Spring 2026 | Liam O'Brien   | 7             | Active        | No      |
| UVA Cavs  | Spring 2026 | Lucas Martinez | 8             | Active        | No      |
| UVA Cavs  | Spring 2026 | Ethan Garcia   | 9             | Active        | No      |
| UVA Cavs  | Spring 2026 | Mason Davis    | 11            | Active        | No      |
```


### 6. 2.6 Completed games with readable team names and scores.

```sql
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
ORDER BY g.game_date, g.start_time
```

**Result (10 rows):**

```
| game_id | season_name | game_date  | start_time | home_team     | away_team     | home_score | away_score | result       |
|---------|-------------|------------|------------|---------------|---------------|------------|------------|--------------|
| 1       | Spring 2026 | 2026-02-14 | 10:00:00   | UVA Cavs      | Blue Hawks    | 3          | 1          | UVA Cavs     |
| 2       | Spring 2026 | 2026-02-21 | 12:00:00   | Vikings       | UVA Cavs      | 2          | 2          | Tie          |
| 3       | Spring 2026 | 2026-02-28 | 14:00:00   | UVA Cavs      | Golden Ducks  | 4          | 0          | UVA Cavs     |
| 4       | Spring 2026 | 2026-03-07 | 10:00:00   | Silver Sharks | UVA Cavs      | 1          | 2          | UVA Cavs     |
| 5       | Spring 2026 | 2026-03-14 | 12:00:00   | Blue Hawks    | Vikings       | 1          | 4          | Vikings      |
| 6       | Spring 2026 | 2026-03-21 | 14:00:00   | Golden Ducks  | Blue Hawks    | 3          | 0          | Golden Ducks |
| 7       | Spring 2026 | 2026-03-28 | 10:00:00   | Blue Hawks    | Silver Sharks | 2          | 2          | Tie          |
| 8       | Spring 2026 | 2026-04-04 | 12:00:00   | Vikings       | Golden Ducks  | 3          | 1          | Vikings      |
| 9       | Spring 2026 | 2026-04-11 | 14:00:00   | Silver Sharks | Vikings       | 0          | 1          | Vikings      |
| 10      | Spring 2026 | 2026-04-18 | 10:00:00   | Golden Ducks  | Silver Sharks | 2          | 1          | Golden Ducks |
```


### 7. 2.7 Scheduled Summer 2026 games that still need scores.

```sql
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
ORDER BY g.game_date, g.start_time
```

**Result (5 rows):**

```
| game_id | game_date  | start_time | home_team  | away_team  | location          |
|---------|------------|------------|------------|------------|-------------------|
| 11      | 2026-07-04 | 10:00:00   | UVA Cavs   | Blue Hawks | Carr's Hill Field |
| 12      | 2026-07-11 | 12:00:00   | Blue Hawks | UVA Cavs   | Lambeth Field     |
| 13      | 2026-07-18 | 10:00:00   | UVA Cavs   | Blue Hawks | Carr's Hill Field |
| 14      | 2026-07-25 | 14:00:00   | Blue Hawks | UVA Cavs   | The Park at UVA   |
| 15      | 2026-08-01 | 10:00:00   | UVA Cavs   | Blue Hawks | Carr's Hill Field |
```


### 8. 2.8 Referees who are currently available and active.

```sql
SELECT
  referee_id,
  first_name || ' ' || last_name AS referee_name,
  email,
  phone,
  certification
FROM Referee
WHERE availability = 'Available'
  AND is_active = 1
ORDER BY certification DESC, last_name, first_name
```

**Result (4 rows):**

```
| referee_id | referee_name | email                | phone        | certification |
|------------|--------------|----------------------|--------------|---------------|
| 3          | Tom Becker   | tbecker@virginia.edu | 434-555-0103 | National      |
| 1          | Marcus Lee   | mlee@virginia.edu    | 434-555-0101 | Level 2       |
| 2          | Priya Nair   | pnair@virginia.edu   | 434-555-0102 | Level 1       |
| 5          | David Okoye  | dokoye@virginia.edu  | 434-555-0105 | Level 1       |
```


### 9. 2.9 Available locations with capacity of at least 200.

```sql
SELECT location_id, field_name, field_type, capacity, availability_status
FROM Location
WHERE availability_status = 'Available'
  AND capacity >= 200
ORDER BY capacity DESC
```

**Result (2 rows):**

```
| location_id | field_name        | field_type | capacity | availability_status |
|-------------|-------------------|------------|----------|---------------------|
| 2           | Lambeth Field     | Grass      | 300      | Available           |
| 1           | Carr's Hill Field | Grass      | 200      | Available           |
```


### 10. 2.10 Referee assignments for games on or after March 1, 2026.

```sql
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
ORDER BY g.game_date, g.start_time, gr.assignment_role
```

**Result (16 rows):**

```
| game_id | game_date  | start_time | referee_name | assignment_role |
|---------|------------|------------|--------------|-----------------|
| 4       | 2026-03-07 | 10:00:00   | Priya Nair   | Head Referee    |
| 5       | 2026-03-14 | 12:00:00   | Sara Klein   | Assistant       |
| 5       | 2026-03-14 | 12:00:00   | Tom Becker   | Head Referee    |
| 6       | 2026-03-21 | 14:00:00   | David Okoye  | Head Referee    |
| 7       | 2026-03-28 | 10:00:00   | Priya Nair   | Assistant       |
| 7       | 2026-03-28 | 10:00:00   | Marcus Lee   | Head Referee    |
| 8       | 2026-04-04 | 12:00:00   | Tom Becker   | Head Referee    |
| 9       | 2026-04-11 | 14:00:00   | Emily Chen   | Assistant       |
| 9       | 2026-04-11 | 14:00:00   | David Okoye  | Head Referee    |
| 10      | 2026-04-18 | 10:00:00   | Tom Becker   | Assistant       |
| 10      | 2026-04-18 | 10:00:00   | Priya Nair   | Head Referee    |
| 11      | 2026-07-04 | 10:00:00   | Marcus Lee   | Head Referee    |
| 12      | 2026-07-11 | 12:00:00   | Priya Nair   | Head Referee    |
| 13      | 2026-07-18 | 10:00:00   | Tom Becker   | Head Referee    |
| 14      | 2026-07-25 | 14:00:00   | David Okoye  | Head Referee    |
| 15      | 2026-08-01 | 10:00:00   | Marcus Lee   | Head Referee    |
```


### 11. 3.1 Dashboard counts for the whole database.

```sql
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
SELECT 'Locations', COUNT(*) FROM Location
```

**Result (8 rows):**

```
| category        | total |
|-----------------|-------|
| Teams           | 5     |
| Players         | 40    |
| Seasons         | 2     |
| Games           | 15    |
| Completed Games | 10    |
| Scheduled Games | 5     |
| Referees        | 6     |
| Locations       | 4     |
```


### 12. 3.2 Roster size by team and season. This also helps check the 8-to-18 player roster rule.

```sql
SELECT
  t.team_name,
  s.season_name,
  COUNT(tr.player_id) AS roster_size
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Team_Roster tr ON ts.team_season_id = tr.team_season_id
GROUP BY ts.team_season_id, t.team_name, s.season_name
ORDER BY s.season_name, t.team_name
```

**Result (7 rows):**

```
| team_name     | season_name | roster_size |
|---------------|-------------|-------------|
| Blue Hawks    | Spring 2026 | 8           |
| Golden Ducks  | Spring 2026 | 8           |
| Silver Sharks | Spring 2026 | 8           |
| UVA Cavs      | Spring 2026 | 8           |
| Vikings       | Spring 2026 | 8           |
| Blue Hawks    | Summer 2026 | 8           |
| UVA Cavs      | Summer 2026 | 8           |
```


### 13. 3.3 Validation query: teams whose roster size is outside the 8-to-18 player range.

```sql
SELECT
  t.team_name,
  s.season_name,
  COUNT(tr.player_id) AS roster_size
FROM Team_Season ts
JOIN Team t ON ts.team_id = t.team_id
JOIN Season s ON ts.season_id = s.season_id
LEFT JOIN Team_Roster tr ON ts.team_season_id = tr.team_season_id
GROUP BY ts.team_season_id, t.team_name, s.season_name
HAVING COUNT(tr.player_id) < 8 OR COUNT(tr.player_id) > 18
```

**Result (0 rows):**

```
| team_name | season_name | roster_size |
|-----------|-------------|-------------|
```


### 14. 3.4 Team standings calculated from completed game scores.

```sql
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
ORDER BY s.season_name, points DESC, goal_difference DESC, goals_for DESC
```

**Result (5 rows):**

```
| season_name | team_name     | games_played | wins | losses | ties | goals_for | goals_against | goal_difference | points |
|-------------|---------------|--------------|------|--------|------|-----------|---------------|-----------------|--------|
| Spring 2026 | UVA Cavs      | 4            | 3    | 0      | 1    | 11        | 4             | 7               | 10     |
| Spring 2026 | Vikings       | 4            | 3    | 0      | 1    | 10        | 4             | 6               | 10     |
| Spring 2026 | Golden Ducks  | 4            | 2    | 2      | 0    | 6         | 8             | -2              | 6      |
| Spring 2026 | Silver Sharks | 4            | 0    | 3      | 1    | 4         | 7             | -3              | 1      |
| Spring 2026 | Blue Hawks    | 4            | 0    | 3      | 1    | 4         | 12            | -8              | 1      |
```


### 15. 3.5 Games by status for each season.

```sql
SELECT
  s.season_name,
  g.game_status,
  COUNT(*) AS number_of_games
FROM Game g
JOIN Season s ON g.season_id = s.season_id
GROUP BY s.season_name, g.game_status
ORDER BY s.season_name, g.game_status
```

**Result (2 rows):**

```
| season_name | game_status | number_of_games |
|-------------|-------------|-----------------|
| Spring 2026 | Completed   | 10              |
| Summer 2026 | Scheduled   | 5               |
```


### 16. 3.6 Number of games scheduled at each location.

```sql
SELECT
  l.field_name,
  l.field_type,
  l.capacity,
  COUNT(g.game_id) AS total_games
FROM Location l
LEFT JOIN Game g ON l.location_id = g.location_id
GROUP BY l.location_id, l.field_name, l.field_type, l.capacity
ORDER BY total_games DESC, l.field_name
```

**Result (4 rows):**

```
| field_name        | field_type | capacity | total_games |
|-------------------|------------|----------|-------------|
| Carr's Hill Field | Grass      | 200      | 6           |
| Lambeth Field     | Grass      | 300      | 4           |
| The Park at UVA   | Turf       | 150      | 3           |
| Nameless Fields   | Turf       | 250      | 2           |
```


### 17. 3.7 Number of referee assignments by referee.

```sql
SELECT
  r.first_name || ' ' || r.last_name AS referee_name,
  r.certification,
  COUNT(gr.game_id) AS total_assignments
FROM Referee r
LEFT JOIN Game_Referee gr ON r.referee_id = gr.referee_id
GROUP BY r.referee_id, r.first_name, r.last_name, r.certification
ORDER BY total_assignments DESC, referee_name
```

**Result (6 rows):**

```
| referee_name | certification | total_assignments |
|--------------|---------------|-------------------|
| Marcus Lee   | Level 2       | 5                 |
| Priya Nair   | Level 1       | 5                 |
| Tom Becker   | National      | 5                 |
| David Okoye  | Level 1       | 4                 |
| Emily Chen   | Level 2       | 1                 |
| Sara Klein   | Level 2       | 1                 |
```


### 18. 3.8 Player participation count across seasons.

```sql
SELECT
  p.first_name || ' ' || p.last_name AS player_name,
  COUNT(DISTINCT tr.season_id) AS seasons_played,
  COUNT(DISTINCT tr.team_season_id) AS team_season_records
FROM Player p
LEFT JOIN Team_Roster tr ON p.player_id = tr.player_id
GROUP BY p.player_id, p.first_name, p.last_name
ORDER BY seasons_played DESC, player_name
```

**Result (40 rows):**

```
| player_name    | seasons_played | team_season_records |
|----------------|----------------|---------------------|
| Adrian Rivera  | 2              | 2                   |
| Aiden Patel    | 2              | 2                   |
| Caleb Johnson  | 2              | 2                   |
| Cole Hernandez | 2              | 2                   |
| Dylan Brown    | 2              | 2                   |
| Ethan Garcia   | 2              | 2                   |
| Henry Nguyen   | 2              | 2                   |
| Isaac Wright   | 2              | 2                   |
| Jacob Miller   | 2              | 2                   |
| Liam O'Brien   | 2              | 2                   |
| Lucas Martinez | 2              | 2                   |
| Mason Davis    | 2              | 2                   |
| Nathan Lopez   | 2              | 2                   |
| Noah Williams  | 2              | 2                   |
| Owen Thompson  | 2              | 2                   |
| Ryan Kim       | 2              | 2                   |
| Aria Sanders   | 1              | 1                   |
| Ava Walker     | 1              | 1                   |
| Chloe Turner   | 1              | 1                   |
| Daniel Adams   | 1              | 1                   |
| Diego Morales  | 1              | 1                   |
| Eli Foster     | 1              | 1                   |
| Ella Bennett   | 1              | 1                   |
| Emma Lewis     | 1              | 1                   |
| Gabriel Reyes  | 1              | 1                   |
| Grace Hall     | 1              | 1                   |
| Hannah Cooper  | 1              | 1                   |
| Isabella Young | 1              | 1                   |
| Julian Torres  | 1              | 1                   |
| Leo Murphy     | 1              | 1                   |
| Lily Evans     | 1              | 1                   |
| Marcus Bell    | 1              | 1                   |
| Maya Anderson  | 1              | 1                   |
| Mia Scott      | 1              | 1                   |
| Nora Price     | 1              | 1                   |
| Olivia Clark   | 1              | 1                   |
| Ruby Coleman   | 1              | 1                   |
| Sean O'Connor  | 1              | 1                   |
| Sofia Rossi    | 1              | 1                   |
| Zoe Parker     | 1              | 1                   |
```


### 19. 3.9 Player count by skill level.

```sql
SELECT
  skill_level,
  COUNT(*) AS total_players
FROM Player
GROUP BY skill_level
ORDER BY total_players DESC, skill_level
```

**Result (3 rows):**

```
| skill_level  | total_players |
|--------------|---------------|
| Advanced     | 15            |
| Intermediate | 15            |
| Beginner     | 10            |
```


### 20. 3.10 Average goals per completed game.

```sql
SELECT
  ROUND(AVG(home_score + away_score), 2) AS average_total_goals_per_game,
  SUM(home_score + away_score) AS total_goals,
  COUNT(*) AS completed_games
FROM Game
WHERE game_status = 'Completed'
```

**Result (1 rows):**

```
| average_total_goals_per_game | total_goals | completed_games |
|------------------------------|-------------|-----------------|
| 3.5                          | 35          | 10              |
```
