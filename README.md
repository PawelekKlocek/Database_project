# Database_project - Documentation
Fully User-Integrated Database For Association Of Football Divisions And Games

<br>

## How to run?
The database is built on an online, free server space known as Railway, the database's "image" is shared in a file section as a db.dump so feel encouraged to check it out.
You can type the following snippet of code:
```sh
createdb bazunia_byq
pg_restore --dbname=bazunia_byq --no-owner --clean db.dump
```
<br>

## Workflow environment
It is required to have fully configured Postgresql, we recommend a 17.2 version in a version on your local machine.

<br>

## Project general requirements
Each team is responsible for creating and implementing its own database project, covering the full system lifecycle: from requirements analysis, through database schema design and implementation, to testing and technical documentation. You can work with any database management system (e.g., PostgreSQL, MariaDB, MySQL, Oracle, SQL Server), depending on your preferences and experience. Each team member is responsible for a specific area of work (e.g., requirements analysis, logical and physical design, function implementation, query optimization, documentation). Both teamwork and individual contributions will be evaluated.

### Project Requirements that we handled:
-  Correctly functioning core database features  
-  Schema design following basic normalization rules (2NF)  
-  Advanced functionality, including complex SQL queries (e.g., nested queries, views)  
-  Use of triggers or stored procedures/functions specific to the chosen DBMS  
-  Well-prepared technical documentation with ERD diagrams and implementation descriptions  
-  Database structure meeting 3NF standards  
-  Implementation of transactions and different isolation levels  

<br>

# Database Schema

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

## Users Table
- **Primary Key:** `user_id` uniquely identifies each user.
- **Mandatory Fields:** `first_name`, `last_name`, `email`, and `password` must have values.
- **Unique Constraint:** `email` must contain unique values.
- **Optional Fields:** `phone_nr`, `role`, and `registration_date` can be left empty.
- **Length Restrictions:** `first_name` and `last_name` are limited to 50 characters, while `email` can have up to 100 characters.


### Table: Teams
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `team_id`        | SERIAL      | -       | Unique identifier for each team (Primary Key).   |
| `name`           | VARCHAR     | 100     | Name of the team.                               |
| `city_name`      | VARCHAR     | 50      | City where the team is based.                   |
| `category`       | VARCHAR     | 50      | Category of the team (e.g., amateur, professional). |
| `captain_id`     | INT         | -       | Foreign key to `Users.user_id` (team captain).  |
| `creation_date`  | TIMESTAMP   | -       | Date and time the team was created.             |

### Teams Table
- **Primary Key:** `team_id` uniquely identifies each team.
- **Mandatory Fields:** `name` and `category` must have values.
- **Foreign Keys:** `captain_id` references `user_id` in the Users table.
- **Length Restrictions:** `name` is limited to 100 characters, and `city_name` to 50 characters.


### Table: Team_Players
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `team_player_id` | SERIAL      | -       | Unique identifier for each team-player relation (Primary Key). |
| `team_id`        | INT         | -       | Foreign key to `Teams.team_id`.                 |
| `user_id`        | INT         | -       | Foreign key to `Users.user_id`.                 |
| `position`       | VARCHAR     | 30      | Position of the player (e.g., goalkeeper, defender). |
| `join_date`      | TIMESTAMP   | -       | Date and time the player joined the team.       |

### Team_Players Table
- **Primary Key:** `team_player_id` uniquely identifies each player-team relation.
- **Foreign Keys:** `team_id` references `team_id` in the Teams table, and `user_id` references `user_id` in the Users table.
- **Optional Fields:** `position` and `join_date` can be left empty.
- **Length Restrictions:** `position` is limited to 30 characters.

  
### Table: Leagues
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `league_id`      | SERIAL      | -       | Unique identifier for each league (Primary Key). |
| `name`           | VARCHAR     | 100     | Name of the league.                             |
| `category`       | VARCHAR     | 50      | Category of the league (e.g., junior, senior).  |
| `season`         | VARCHAR     | 20      | Season of the league (e.g., 2025).              |
| `start_date`     | DATE        | -       | Start date of the league.                       |
| `end_date`       | DATE        | -       | End date of the league.                         |

### Leagues Table
- **Primary Key:** `league_id` uniquely identifies each league.
- **Mandatory Fields:** `name`, `category`, and `season` must have values.
- **Length Restrictions:** `name` is limited to 100 characters, `category` to 50, and `season` to 20 characters.


### Table: Pitch
| Field Name        | Data Type     | Length     | Description                                       |
|-------------------|---------------|------------|---------------------------------------------------|
| `pitch_id`        | `SERIAL`      | -          | Unique identifier for each pitch (Primary Key).   |
| `name`            | `VARCHAR(50)` | 50         | Name of the pitch (e.g., "Stadium 1").            |
| `city`            | `VARCHAR(50)` | 50         | City where the pitch is located.                  |
| `is_outdoor`      | `BOOLEAN`     | -          | Indicates if the pitch is outdoor (default `TRUE`). |

### Pitch Table
- **Primary Key:** `pitch_id` uniquely identifies each pitch.
- **Mandatory Fields:** `name`, `city`, and `is_outdoor` must have values.
- **Length Restrictions:** `name` and `city` are limited to 50 characters.
- **Default Values:** `is_outdoor` defaults to `TRUE`.


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

### Matches Table
- **Primary Key:** `match_id` uniquely identifies each match.
- **Foreign Keys:** `league_id` references `league_id` in the Leagues table, `team1_id` and `team2_id` reference `team_id` in the Teams table, `referee_id` references `user_id` in the Users table, and `pitch_id` references `pitch_id` in the Pitch table.
- **Optional Fields:** `team1_score` and `team2_score` can be left empty.

  
### Table: Goals
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `goal_id`        | SERIAL      | -       | Unique identifier for each goal (Primary Key).   |
| `match_id`       | INT         | -       | Foreign key to `Matches.match_id`.              |
| `player_id`      | INT         | -       | Foreign key to `Users.user_id` (player who scored). |
| `time`           | INT         | -       | Minute of the match when the goal was scored.   |
| `type`           | VARCHAR     | 20      | Type of goal (e.g., regular, own goal, penalty). |

### Goals Table
- **Primary Key:** `goal_id` uniquely identifies each goal.
- **Foreign Keys:** `match_id` references `match_id` in the Matches table, and `player_id` references `user_id` in the Users table.
- **Mandatory Fields:** `time` and `type` must have values.
- **Length Restrictions:** `type` is limited to 20 characters.
  

### Table: Cards
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `card_id`        | SERIAL      | -       | Unique identifier for each card (Primary Key).   |
| `match_id`       | INT         | -       | Foreign key to `Matches.match_id`.              |
| `player_id`      | INT         | -       | Foreign key to `Users.user_id` (player who received the card). |
| `type`           | VARCHAR     | 20      | Type of card (yellow, red).                     |
| `time`           | INT         | -       | Minute of the match when the card was issued.   |

### Cards Table
- **Primary Key:** `card_id` uniquely identifies each card.
- **Foreign Keys:** `match_id` references `match_id` in the Matches table, and `player_id` references `user_id` in the Users table.
- **Mandatory Fields:** `type` and `time` must have values.
- **Length Restrictions:** `type` is limited to 20 characters.
  

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

### Standings Table
- **Primary Key:** `standing_id` uniquely identifies each league standing entry.
- **Foreign Keys:** `league_id` references `league_id` in the Leagues table, and `team_id` references `team_id` in the Teams table.
- **Mandatory Fields:** `matches_played`, `wins`, `draws`, `losses`, `points`, `goals_scored`, and `goals_conceded` must have values.


### Table: Referees
| Field Name       | Data Type   | Length  | Description                                      |
|------------------|-------------|---------|--------------------------------------------------|
| `referee_id`     | SERIAL      | -       | Unique identifier for each referee (Primary Key).|
| `user_id`        | INT         | -       | Foreign key to `Users.user_id`.                 |
| `license`        | VARCHAR     | 50      | Referee license (e.g., UEFA, local).            |
| `years_of_experience` | INT    | -       | Number of years of experience as a referee.     |

### Referees Table
- **Primary Key:** `referee_id` uniquely identifies each referee.
- **Foreign Keys:** `user_id` references `user_id` in the Users table.
- **Mandatory Fields:** `license` and `years_of_experience` must have values.
- **Length Restrictions:** `license` is limited to 50 characters.

<br>

## Diagram ERD
![db_diagram](./db_diagram.svg)

<br>

## Database created views

### 1. **view_teams_with_players**
#### Description:
This view provides details about teams, including their names, cities, categories, the name of the captain, and the players in the team along with their positions.

| Field Name        | Data Type   | Description                                      |
|-------------------|-------------|-------------------------------------------------|
| `team_id`         | INT         | Unique identifier for each team.                |
| `team_name`       | VARCHAR     | Name of the team.                               |
| `city_name`       | VARCHAR     | City where the team is based.                   |
| `category`        | VARCHAR     | Category of the team (e.g., amateur, professional). |
| `captain_name`    | VARCHAR     | Name of the team captain.                       |
| `player_name`     | VARCHAR     | Name of the player in the team.                 |
| `position`        | VARCHAR     | Position of the player in the team.             |

### 2. **view_league_standings**
#### Description:
This view provides the standings for each league, showing the teams, the number of matches they have played, wins, losses, draws, points, and goals scored and conceded.

| Field Name        | Data Type   | Description                                      |
|-------------------|-------------|-------------------------------------------------|
| `league_name`     | VARCHAR     | Name of the league.                             |
| `team_name`       | VARCHAR     | Name of the team.                               |
| `matches_played`  | INT         | Number of matches played by the team.           |
| `wins`            | INT         | Number of wins by the team.                     |
| `draws`           | INT         | Number of draws by the team.                    |
| `losses`          | INT         | Number of losses by the team.                   |
| `points`          | INT         | Points accumulated by the team.                 |
| `goals_scored`    | INT         | Total goals scored by the team.                 |
| `goals_conceded`  | INT         | Total goals conceded by the team.               |

### 3. **view_match_details**
#### Description:
This view provides detailed information about each match, including the teams involved, match score, date, referee, and pitch used.

| Field Name        | Data Type   | Description                                      |
|-------------------|-------------|-------------------------------------------------|
| `match_id`        | INT         | Unique identifier for each match.               |
| `league_name`     | VARCHAR     | Name of the league in which the match is played.|
| `team1_name`      | VARCHAR     | Name of team 1.                                 |
| `team2_name`      | VARCHAR     | Name of team 2.                                 |
| `team1_score`     | INT         | Score of team 1 in the match.                   |
| `team2_score`     | INT         | Score of team 2 in the match.                   |
| `match_date`      | TIMESTAMP   | Date and time when the match was played.        |
| `referee_name`    | VARCHAR     | Name of the referee who officiated the match.   |
| `pitch_name`      | VARCHAR     | Name of the pitch where the match took place.   |

<br>

## Database queries
Example database queries can be found in the `db_queries.sql` file. The file contains various SQL queries like:
- Nested queries
- UPDATE operations
- DELETE operations
- GROUP BY clauses
- HAVING clauses
- different JOIN-s operations

### Example query that lets us display a specific pitches for the league ekstraklasa
```sh
select name from pitch
where pitch_id in (select pitch_id from matches where league_id in (select league_id from leagues where name = 'ekstraklasa'));
```

<br>

## PL/pgSQL functions and triggers
The file `plsql_functions_triggers.sql` contains specialized functions and triggers for match operations. Here are the key components:

### Match points calculator
The system includes a sophisticated points calculation mechanism consisting of:
1. **Points calculator function**: Calculates match points based on team scores:
   - Win (3 points): When team scores more than opponent
   - Draw (1 point): When scores are equal
   - Loss (0 points): When team scores less than opponent

2. **Standings update trigger**: Automatically updates team standings after each match, managing:
   - Matches played count
   - Wins/draws/losses tallies
   - Total points
   - Goals scored and conceded

### Yellow/Red card management
The system features an automated card management system:
1. **Red card function**: Monitors yellow cards and converts them to red cards when appropriate:
   - Tracks yellow card count per player
   - Automatically converts to red card after two yellows

2. **Card check trigger**: Processes card updates after each card is issued:
   - Monitors yellow card quantity
   - Automatically converts two yellows to red card when threshold is reached
   - Manages card records in the database
  
### The example of use
```sh
insert into matches (league_id, match_date, team1_id, team2_id, team1_score, team2_score, referee_id, pitch_id)
values (1, '2024-08-23 19:00:00', 3, 2, 3, 1, 2, 1);
select * from standings where league_id = 1;

insert into cards (match_id, player_id, type, time) values (1, 1, 'yellow', 10);
insert into cards (match_id, player_id, type, time) values (1, 1, 'yellow', 41);
select * from cards where player_id = 1;
```
<br>

## Transactions
The `transaction.sql` file contains critical transaction operations. Key transactions include:

### Player transfer transaction
Handles player transfers between teams:
- Removes player from current team
- Adds player to new team
- Ensures data consistency during transfer process

### Team promotion/relegation
Manages team movement between leagues:
- Handles team promotion to higher league
- Processes team relegation to lower league
- Maintains league integrity

### Transaction safety
The system includes rollback mechanisms for failed operations:
- Validates team existence before operations
- Automatically rolls back on invalid team IDs
- Preserves data integrity during failed operations

### To sum up the transactions
- All transactions implement ACID properties
- Functions include error handling
- Triggers are optimized for performance
- System maintains referential integrity throughout operations

### Example transaction that lets us maintain the continuity of the appropriate number of teams in the leagues after the promotion/relegation of the league (teams quantity must be constant)
```sh
begin;

update standings
set league_id = 4
where team_id = 5 and league_id = 5;

update standings
set league_id = 5
where team_id = 6 and league_id = 4;

commit;
```
