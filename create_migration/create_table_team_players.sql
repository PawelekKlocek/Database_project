create table team_players (
    team_player_id serial primary key,
    team_id int references teams(team_id) on delete cascade,
    user_id int references users(user_id) on delete cascade,
    position varchar(30),
    join_date timestamp default current_timestamp
);
