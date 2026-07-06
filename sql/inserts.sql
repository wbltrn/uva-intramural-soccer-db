-- UVA Intramural Soccer League - Sample Data 

--1. Seasons

INSERT INTO Season (season_id, season_name, start_date, end_date, registration_deadline, season_status) VALUES
  (1, 'Spring 2026', '2026-02-07', '2026-04-25', '2026-01-30', 'Completed'),
  (2, 'Summer 2026', '2026-06-05', '2026-08-14', '2026-05-29', 'Active');


--2. Teams
INSERT INTO Team (team_id, team_name, division, team_status, created_date) VALUES
  (1, 'UVA Cavs',      'A', 'Active', '2026-01-15'),
  (2, 'Blue Hawks',    'A', 'Active', '2026-01-16'),
  (3, 'Vikings',       'B', 'Active', '2026-01-17'),
  (4, 'Golden Ducks',  'B', 'Active', '2026-01-18'),
  (5, 'Silver Sharks', 'A', 'Active', '2026-01-20');

--3. Locations
INSERT INTO Location (location_id, field_name, field_address, field_type, capacity, availability_status) VALUES
  (1, 'Carr''s Hill Field', 'University Avenue, Charlottesville, VA 22903', 'Grass', 200, 'Available'),
  (2, 'Lambeth Field',      'Venable, VA 22903',   'Grass', 300, 'Available'),
  (3, 'The Park at UVA',    'Charlottesville, VA 22903',   'Turf',  150, 'Available'),
  (4, 'Nameless Fields',    '110 Newcomb Rd N, Charlottesville, VA 22903',    'Turf',  250, 'Maintenance');

--4. Referees
INSERT INTO Referee (referee_id, name, email, phone, certification, availability, active_status) VALUES
  (1, 'Marcus Lee',  'mlee@virginia.edu',    '434-555-0101', 'Level 2',  'Available',   1),
  (2, 'Priya Nair',  'pnair@virginia.edu',   '434-555-0102', 'Level 1',  'Available',   1),
  (3, 'Tom Becker',  'tbecker@virginia.edu', '434-555-0103', 'National', 'Available',   1),
  (4, 'Sara Klein',  'sklein@virginia.edu',  '434-555-0104', 'Level 2',  'Unavailable', 1),
  (5, 'David Okoye', 'dokoye@virginia.edu',  '434-555-0105', 'Level 1',  'Available',   1),
  (6, 'Emily Chen',  'echen@virginia.edu',   '434-555-0106', 'Level 2',  'Available',   0);

--5. Players (40) — grouped 8 per team for Spring 2026 rosters
-- Cavs (1-8)
INSERT INTO Player (player_id, student_id, name, email, phone, skill_level, eligibility_status, active_status) VALUES
  (1,  'S1001', 'Jacob Miller',    'jmiller@virginia.edu',  '434-555-0201', 'Advanced',     'Eligible',   1),
  (2,  'S1002', 'Liam O''Brien',   'lobrien@virginia.edu',  '434-555-0202', 'Intermediate', 'Eligible',   1),
  (3,  'S1003', 'Noah Williams',   'nwilliams@virginia.edu','434-555-0203', 'Beginner',     'Eligible',   1),
  (4,  'S1004', 'Ethan Garcia',    'egarcia@virginia.edu',  '434-555-0204', 'Advanced',     'Eligible',   1),
  (5,  'S1005', 'Mason Davis',     'mdavis@virginia.edu',   '434-555-0205', 'Intermediate', 'Eligible',   1),
  (6,  'S1006', 'Lucas Martinez',  'lmartinez@virginia.edu','434-555-0206', 'Beginner',     'Eligible',   1),
  (7,  'S1007', 'Henry Nguyen',    'hnguyen@virginia.edu',  '434-555-0207', 'Advanced',     'Eligible',   1),
  (8,  'S1008', 'Owen Thompson',   'othompson@virginia.edu','434-555-0208', 'Intermediate', 'Eligible',   1),
  -- Blue Hawks (9-16)
  (9,  'S1009', 'Aiden Patel',     'apatel@virginia.edu',   '434-555-0209', 'Advanced',     'Eligible',   1),
  (10, 'S1010', 'Caleb Johnson',   'cjohnson@virginia.edu', '434-555-0210', 'Intermediate', 'Eligible',   1),
  (11, 'S1011', 'Ryan Kim',        'rkim@virginia.edu',     '434-555-0211', 'Beginner',     'Eligible',   1),
  (12, 'S1012', 'Dylan Brown',     'dbrown@virginia.edu',   '434-555-0212', 'Advanced',     'Eligible',   1),
  (13, 'S1013', 'Nathan Lopez',    'nlopez@virginia.edu',   '434-555-0213', 'Intermediate', 'Eligible',   1),
  (14, 'S1014', 'Isaac Wright',    'iwright@virginia.edu',  '434-555-0214', 'Beginner',     'Ineligible', 1),
  (15, 'S1015', 'Adrian Rivera',   'arivera@virginia.edu',  '434-555-0215', 'Advanced',     'Eligible',   1),
  (16, 'S1016', 'Cole Hernandez',  'chernandez@virginia.edu','434-555-0216','Intermediate', 'Eligible',   1),
  -- Vikings (17-24)
  (17, 'S1017', 'Sofia Rossi',     'srossi@virginia.edu',   '434-555-0217', 'Advanced',     'Eligible',   1),
  (18, 'S1018', 'Maya Anderson',   'manderson@virginia.edu','434-555-0218', 'Intermediate', 'Eligible',   1),
  (19, 'S1019', 'Olivia Clark',    'oclark@virginia.edu',   '434-555-0219', 'Beginner',     'Eligible',   1),
  (20, 'S1020', 'Emma Lewis',      'elewis@virginia.edu',   '434-555-0220', 'Advanced',     'Eligible',   1),
  (21, 'S1021', 'Ava Walker',      'awalker@virginia.edu',  '434-555-0221', 'Intermediate', 'Eligible',   1),
  (22, 'S1022', 'Isabella Young',  'iyoung@virginia.edu',   '434-555-0222', 'Beginner',     'Eligible',   1),
  (23, 'S1023', 'Mia Scott',       'mscott@virginia.edu',   '434-555-0223', 'Advanced',     'Eligible',   1),
  (24, 'S1024', 'Grace Hall',      'ghall@virginia.edu',    '434-555-0224', 'Intermediate', 'Eligible',   1),
  -- Golden Ducks (25-32)
  (25, 'S1025', 'Daniel Adams',    'dadams@virginia.edu',   '434-555-0225', 'Advanced',     'Eligible',   1),
  (26, 'S1026', 'Gabriel Reyes',   'greyes@virginia.edu',   '434-555-0226', 'Intermediate', 'Eligible',   1),
  (27, 'S1027', 'Julian Torres',   'jtorres@virginia.edu',  '434-555-0227', 'Beginner',     'Eligible',   1),
  (28, 'S1028', 'Leo Murphy',      'lmurphy@virginia.edu',  '434-555-0228', 'Advanced',     'Eligible',   1),
  (29, 'S1029', 'Marcus Bell',     'mbell@virginia.edu',    '434-555-0229', 'Intermediate', 'Eligible',   1),
  (30, 'S1030', 'Eli Foster',      'efoster@virginia.edu',  '434-555-0230', 'Beginner',     'Eligible',   1),
  (31, 'S1031', 'Diego Morales',   'dmorales@virginia.edu', '434-555-0231', 'Advanced',     'Eligible',   1),
  (32, 'S1032', 'Sean O''Connor',  'soconnor@virginia.edu', '434-555-0232', 'Intermediate', 'Eligible',   1),
  -- Silver Sharks (33-40)
  (33, 'S1033', 'Chloe Turner',    'cturner@virginia.edu',  '434-555-0233', 'Advanced',     'Eligible',   1),
  (34, 'S1034', 'Zoe Parker',      'zparker@virginia.edu',  '434-555-0234', 'Intermediate', 'Eligible',   1),
  (35, 'S1035', 'Lily Evans',      'levans@virginia.edu',   '434-555-0235', 'Beginner',     'Eligible',   1),
  (36, 'S1036', 'Hannah Cooper',   'hcooper@virginia.edu',  '434-555-0236', 'Advanced',     'Eligible',   1),
  (37, 'S1037', 'Ella Bennett',    'ebennett@virginia.edu', '434-555-0237', 'Intermediate', 'Eligible',   1),
  (38, 'S1038', 'Nora Price',      'nprice@virginia.edu',   '434-555-0238', 'Beginner',     'Ineligible', 0),
  (39, 'S1039', 'Aria Sanders',    'asanders@virginia.edu', '434-555-0239', 'Intermediate', 'Eligible',   1),
  (40, 'S1040', 'Ruby Coleman',    'rcoleman@virginia.edu', '434-555-0240', 'Advanced',     'Eligible',   1);

--6. Team_Seasons (which team plays which season, + captain)
INSERT INTO Team_Season (team_season_id, team_id, season_id, captain_player_id) VALUES
  -- Spring 2026 (season 1): all 5 teams
  (1, 1, 1, 1),    -- Cavs,          captain Jacob Miller (player 1)
  (2, 2, 1, 9),    -- Blue Hawks,    captain Aiden Patel (player 9)
  (3, 3, 1, 17),   -- Vikings,       captain Sofia Rossi (player 17)
  (4, 4, 1, 25),   -- Golden Ducks,  captain Daniel Adams (player 25)
  (5, 5, 1, 33),   -- Silver Sharks, captain Chloe Turner (player 33)
  -- Summer 2026 (season 2): only Cavs + Blue Hawks return
  (6, 1, 2, 1),    -- Cavs,          captain Jacob Miller (player 1)
  (7, 2, 2, 9);    -- Blue Hawks,    captain Aiden Patel (player 9)

--7. Team_Roster (8 players per team-season)
INSERT INTO Team_Roster (roster_id, player_id, team_season_id, season_id, jersey_number, roster_status, is_captain) VALUES
  --Spring 2026 (season 1)
  --Cavs (ts1)
  (1,   1, 1, 1, 10, 'Active',   1),
  (2,   2, 1, 1,  7, 'Active',   0),
  (3,   3, 1, 1,  4, 'Active',   0),
  (4,   4, 1, 1,  9, 'Active',   0),
  (5,   5, 1, 1, 11, 'Active',   0),
  (6,   6, 1, 1,  8, 'Active',   0),
  (7,   7, 1, 1,  3, 'Active',   0),
  (8,   8, 1, 1,  5, 'Active',   0),
  --Blue Hawks (ts2)
  (9,   9, 2, 1, 10, 'Active',   1),
  (10, 10, 2, 1,  6, 'Active',   0),
  (11, 11, 2, 1,  4, 'Active',   0),
  (12, 12, 2, 1,  9, 'Active',   0),
  (13, 13, 2, 1,  7, 'Active',   0),
  (14, 14, 2, 1,  2, 'Active',   0),
  (15, 15, 2, 1, 11, 'Active',   0),
  (16, 16, 2, 1,  5, 'Active',   0),
  --Vikings (ts3)
  (17, 17, 3, 1, 10, 'Active',   1),
  (18, 18, 3, 1,  8, 'Active',   0),
  (19, 19, 3, 1,  4, 'Active',   0),
  (20, 20, 3, 1,  9, 'Active',   0),
  (21, 21, 3, 1,  7, 'Active',   0),
  (22, 22, 3, 1,  3, 'Active',   0),
  (23, 23, 3, 1, 11, 'Active',   0),
  (24, 24, 3, 1,  6, 'Active',   0),
  --Golden Ducks (ts4)
  (25, 25, 4, 1, 10, 'Active',   1),
  (26, 26, 4, 1,  7, 'Active',   0),
  (27, 27, 4, 1,  4, 'Active',   0),
  (28, 28, 4, 1,  9, 'Active',   0),
  (29, 29, 4, 1,  8, 'Active',   0),
  (30, 30, 4, 1,  3, 'Active',   0),
  (31, 31, 4, 1, 11, 'Active',   0),
  (32, 32, 4, 1,  5, 'Active',   0),
  --Silver Sharks (ts5)
  (33, 33, 5, 1, 10, 'Active',   1),
  (34, 34, 5, 1,  7, 'Active',   0),
  (35, 35, 5, 1,  4, 'Active',   0),
  (36, 36, 5, 1,  9, 'Active',   0),
  (37, 37, 5, 1,  8, 'Active',   0),
  (38, 38, 5, 1,  3, 'Inactive', 0),
  (39, 39, 5, 1, 11, 'Active',   0),
  (40, 40, 5, 1,  5, 'Active',   0),
  --Summer 2026 (season 2) — Cavs & Blue Hawks, 2 players swapped --
  --Cavs (ts6): #16 Cole joins from Blue Hawks; #8 Owen left
  (41,  1, 6, 2, 10, 'Active',   1),
  (42,  2, 6, 2,  7, 'Active',   0),
  (43,  3, 6, 2,  4, 'Active',   0),
  (44,  4, 6, 2,  9, 'Active',   0),
  (45,  5, 6, 2, 11, 'Active',   0),
  (46,  6, 6, 2,  8, 'Active',   0),
  (47,  7, 6, 2,  3, 'Active',   0),
  (48, 16, 6, 2,  5, 'Active',   0),
  --Blue Hawks (ts7): #8 Owen joins from Cavs; #16 Cole left
  (49,  9, 7, 2, 10, 'Active',   1),
  (50, 10, 7, 2,  6, 'Active',   0),
  (51, 11, 7, 2,  4, 'Active',   0),
  (52, 12, 7, 2,  9, 'Active',   0),
  (53, 13, 7, 2,  7, 'Active',   0),
  (54, 14, 7, 2,  2, 'Active',   0),
  (55, 15, 7, 2, 11, 'Active',   0),
  (56,  8, 7, 2,  5, 'Active',   0);

--8. Games (Spring 2026 = 10 completed w/ scores; Summer 2026 = 5 scheduled)
INSERT INTO Game (game_id, season_id, home_team_season_id, away_team_season_id, location_id, game_date, start_time, home_score, away_score, game_status, winner_team_season_id) VALUES
  --Spring 2026 (season 1) — completed
  (1,  1, 1, 2, 1, '2026-02-14', '10:00:00', 3, 1, 'Completed', 1),
  (2,  1, 3, 1, 2, '2026-02-21', '12:00:00', 2, 2, 'Completed', NULL),   -- tie
  (3,  1, 1, 4, 1, '2026-02-28', '14:00:00', 4, 0, 'Completed', 1),
  (4,  1, 5, 1, 3, '2026-03-07', '10:00:00', 1, 2, 'Completed', 1),
  (5,  1, 2, 3, 2, '2026-03-14', '12:00:00', 1, 4, 'Completed', 3),
  (6,  1, 4, 2, 4, '2026-03-21', '14:00:00', 3, 0, 'Completed', 4),
  (7,  1, 2, 5, 1, '2026-03-28', '10:00:00', 2, 2, 'Completed', NULL),   -- tie
  (8,  1, 3, 4, 2, '2026-04-04', '12:00:00', 3, 1, 'Completed', 3),
  (9,  1, 5, 3, 3, '2026-04-11', '14:00:00', 0, 1, 'Completed', 3),
  (10, 1, 4, 5, 4, '2026-04-18', '10:00:00', 2, 1, 'Completed', 4),
  --Summer 2026 (season 2) — scheduled, no scores yet
  (11, 2, 6, 7, 1, '2026-07-04', '10:00:00', NULL, NULL, 'Scheduled', NULL),
  (12, 2, 7, 6, 2, '2026-07-11', '12:00:00', NULL, NULL, 'Scheduled', NULL),
  (13, 2, 6, 7, 1, '2026-07-18', '10:00:00', NULL, NULL, 'Scheduled', NULL),
  (14, 2, 7, 6, 3, '2026-07-25', '14:00:00', NULL, NULL, 'Scheduled', NULL),
  (15, 2, 6, 7, 1, '2026-08-01', '10:00:00', NULL, NULL, 'Scheduled', NULL);

--9. Game_Referees (refs assigned to games, some have a head + assistant)
INSERT INTO Game_Referee (game_referee_id, game_id, referee_id, assignment_role) VALUES
  (1,   1, 1, 'Head Referee'),
  (2,   1, 2, 'Assistant'),
  (3,   2, 3, 'Head Referee'),
  (4,   3, 1, 'Head Referee'),
  (5,   3, 5, 'Assistant'),
  (6,   4, 2, 'Head Referee'),
  (7,   5, 3, 'Head Referee'),
  (8,   5, 4, 'Assistant'),
  (9,   6, 5, 'Head Referee'),
  (10,  7, 1, 'Head Referee'),
  (11,  7, 2, 'Assistant'),
  (12,  8, 3, 'Head Referee'),
  (13,  9, 5, 'Head Referee'),
  (14,  9, 6, 'Assistant'),
  (15, 10, 2, 'Head Referee'),
  (16, 10, 3, 'Assistant'),
  (17, 11, 1, 'Head Referee'),
  (18, 12, 2, 'Head Referee'),
  (19, 13, 3, 'Head Referee'),
  (20, 14, 5, 'Head Referee'),
  (21, 15, 1, 'Head Referee');

--10. User_Accounts (1 admin + 5 team captains)
INSERT INTO User_Account (user_id, username, password_hash, role, player_id, team_season_id) VALUES
  (1, 'admin',   'hash_admin_9f8a', 'Admin',   NULL, NULL),
  (2, 'jmiller', 'hash_jm_4b2c',    'Captain', 1,  1),
  (3, 'apatel',  'hash_ap_7d1e',    'Captain', 9,  2),
  (4, 'srossi',  'hash_sr_3c9f',    'Captain', 17, 3),
  (5, 'dadams',  'hash_da_8e5a',    'Captain', 25, 4),
  (6, 'cturner', 'hash_ct_2f6b',    'Captain', 33, 5);
