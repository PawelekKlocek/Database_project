# Database_project
# Dokumentacja
## Data structure

### Table: Users
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `user_id`        | SERIAL      | -       | Unique identifier for each user (Primary Key).   |
| `first_name`     | VARCHAR     | 50      | First name of the user.                         |
| `last_name`      | VARCHAR     | 50      | Last name of the user.                          |
| `email`          | VARCHAR     | 100     | Email address of the user.                      |
| `password`       | VARCHAR     | 100     | Encrypted password of the user.                 |
| `phone_nr`       | VARCHAR     | 15      | Phone number of the user.                       |
| `role`           | VARCHAR     | 20      | Role of the user (e.g., player, referee).       |
| `registration_date` | TIMESTAMP | -       | Date and time the user was registered.          |


### Table: Teams
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `team_id`        | SERIAL      | -       | Unique identifier for each team (Primary Key).   |
| `name`           | VARCHAR     | 100     | Name of the team.                               |
| `city_name`      | VARCHAR     | 50      | City where the team is based.                   |
| `category`       | VARCHAR     | 50      | Category of the team (e.g., amateur, professional). |
| `captain_id`     | INT         | -       | Foreign key to `Users.user_id` (team captain).  |
| `creation_date`  | TIMESTAMP   | -       | Date and time the team was created.             |


### Table: Team_Players
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `team_player_id` | SERIAL      | -       | Unique identifier for each team-player relation (Primary Key). |
| `team_id`        | INT         | -       | Foreign key to `Teams.team_id`.                 |
| `user_id`        | INT         | -       | Foreign key to `Users.user_id`.                 |
| `position`       | VARCHAR     | 30      | Position of the player (e.g., goalkeeper, defender). |
| `join_date`      | TIMESTAMP   | -       | Date and time the player joined the team.       |


### Table: Leagues
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `league_id`      | SERIAL      | -       | Unique identifier for each league (Primary Key). |
| `name`           | VARCHAR     | 100     | Name of the league.                             |
| `category`       | VARCHAR     | 50      | Category of the league (e.g., junior, senior).  |
| `season`         | VARCHAR     | 20      | Season of the league (e.g., 2025).              |
| `start_date`     | DATE        | -       | Start date of the league.                       |
| `end_date`       | DATE        | -       | End date of the league.                         |


#### **Table: Pitch**
| **Field Name**    | **Data Type** | **Length** | **Description**                                   |
|-------------------|---------------|------------|---------------------------------------------------|
| `pitch_id`        | `SERIAL`      | -          | Unique identifier for each pitch (Primary Key).   |
| `name`            | `VARCHAR(50)` | 50         | Name of the pitch (e.g., "Stadium 1").            |
| `city`            | `VARCHAR(50)` | 50         | City where the pitch is located.                  |
| `is_outdoor`      | `BOOLEAN`     | -          | Indicates if the pitch is outdoor (default `TRUE`). |


### Table: Matches
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `match_id`       | SERIAL      | -       | Unique identifier for each match (Primary Key).  |
| `league_id`      | INT         | -       | Foreign key to `Leagues.league_id`.             |
| `match_date`     | TIMESTAMP   | -       | Date and time the match was played.             |
| `team1_id`       | INT         | -       | Foreign key to `Teams.team_id` (first team).    |
| `team2_id`       | INT         | -       | Foreign key to `Teams.team_id` (second team).   |
| `team1_score`    | INT         | -       | Score of the first team.                        |
| `team2_score`    | INT         | -       | Score of the second team.                       |
| `referee_id`     | INT         | -       | Foreign key to `Users.user_id` (referee).       |
| `pitch_id`       | INT         | -       | Foreign key to `Pitch.pitch_id` (referee).       |


### Table: Goals
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `goal_id`        | SERIAL      | -       | Unique identifier for each goal (Primary Key).   |
| `match_id`       | INT         | -       | Foreign key to `Matches.match_id`.              |
| `player_id`      | INT         | -       | Foreign key to `Users.user_id` (player who scored). |
| `time`           | INT         | -       | Minute of the match when the goal was scored.   |
| `type`           | VARCHAR     | 20      | Type of goal (e.g., regular, own goal, penalty). |


### Table: Cards
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `card_id`        | SERIAL      | -       | Unique identifier for each card (Primary Key).   |
| `match_id`       | INT         | -       | Foreign key to `Matches.match_id`.              |
| `player_id`      | INT         | -       | Foreign key to `Users.user_id` (player who received the card). |
| `type`           | VARCHAR     | 20      | Type of card (yellow, red).                     |
| `time`           | INT         | -       | Minute of the match when the card was issued.   |


### Table: Standings
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `standing_id`    | SERIAL      | -       | Unique identifier for each league standing entry (Primary Key). |
| `league_id`      | INT         | -       | Foreign key to `Leagues.league_id`.             |
| `team_id`        | INT         | -       | Foreign key to `Teams.team_id`.                 |
| `matches_played` | INT         | -       | Number of matches played by the team.           |
| `wins`           | INT         | -       | Number of matches won by the team.              |
| `draws`          | INT         | -       | Number of matches drawn by the team.            |
| `losses`         | INT         | -       | Number of matches lost by the team.             |
| `points`         | INT         | -       | Total points of the team.                       |
| `goals_scored`   | INT         | -       | Number of goals scored by the team.             |
| `goals_conceded` | INT         | -       | Number of goals conceded by the team.           |


### Table: Referees
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `referee_id`     | SERIAL      | -       | Unique identifier for each referee (Primary Key).|
| `user_id`        | INT         | -       | Foreign key to `Users.user_id`.                 |
| `license`        | VARCHAR     | 50      | Referee license (e.g., UEFA, local).            |
| `years_of_experience` | INT    | -       | Number of years of experience as a referee.     |


## Diagram ERD
![FLS](https://github.com/user-attachments/assets/cd1d4226-47ad-4ec1-808f-109d550ffa99)
