create table matches (
    match_id serial primary key,
    league_id int references leagues(league_id) on delete cascade,
    match_date timestamp not null,
    team1_id int references teams(team_id) on delete cascade,
    team2_id int references teams(team_id) on delete cascade,
    team1_score int,
    team2_score int,
    referee_id int references users(user_id) on delete set null
);
