create table standings (
    standing_id serial primary key,
    league_id int references leagues(league_id) on delete cascade,
    team_id int references teams(team_id) on delete cascade,
    matches_played int not null default 0,
    wins int not null default 0,
    draws int not null default 0,
    losses int not null default 0,
    points int not null default 0,
    goals_scored int not null default 0,
    goals_conceded int not null default 0
);
