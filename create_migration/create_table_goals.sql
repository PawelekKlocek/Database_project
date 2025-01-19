create table goals (
    goal_id serial primary key,
    match_id int references matches(match_id) on delete cascade,
    player_id int references users(user_id) on delete cascade,
    time int not null,
    type varchar(20) not null
);
