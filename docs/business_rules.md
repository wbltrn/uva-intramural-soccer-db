# Business Rules

This document lists the business rules for the UVA Intramural Soccer League database system. These rules focus on entity relationships, cardinality, participation constraints, and organizational policies that affect the database design.

## Player and Team Roster

1. Each Player may belong to only one Team during a specific Season.
2. Each Team may have many Players on its roster during a specific Season.
3. A Player may join a different Team in a future Season.
4. Each Team_Roster record represents one Player assigned to one Team_Season record.

## Team and Season

5. Each Team may participate in multiple Seasons.
6. Each Season may include multiple Teams.
7. Each Team_Season record represents one Team participating in one Season.
8. A Team may appear only once per Season.

## Team Captain

9. Each Team_Season record may have one designated captain.
10. A Player may serve as captain for at most one Team_Season record at a time.
11. The captain must be a Player associated with the Team_Season record.

## Roster Size

12. Each Team must maintain a roster for each Season in which the Team participates.
13. Each Team roster must include at least 8 Players and no more than 18 Players during a Season.

## Game and Team

14. Each Game must involve exactly two Teams: one home team and one away team.
15. Each Team may participate in many Games during a Season.
16. A Team cannot play against itself in the same Game.

## Game and Season

17. Each Game must belong to exactly one Season.
18. Each Season may contain many Games.

## Game and Location

19. Each Game must be played at exactly one Location.
20. Each Location may host many Games.
21. A Location cannot host more than one Game at the same date and time.

## Game and Referee

22. Each Game may have one or more Referees assigned.
23. Each Referee may officiate many Games throughout a Season.
24. A Referee should not be assigned to overlapping Games occurring at the same date and time.

## Game Results and Standings

25. Game standings are determined using completed Game results.
26. A win earns 3 points, a tie earns 1 point, and a loss earns 0 points.
27. Match outcomes are derived from the recorded home score and away score.
28. If the home score and away score are equal, the Game result is recorded as a tie.
29. If the home score is greater than the away score, the home Team is the winner.
30. If the away score is greater than the home score, the away Team is the winner.
