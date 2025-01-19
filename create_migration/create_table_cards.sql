create table cards (
    card_id serial primary key,
    match_id int references matches(match_id) on delete cascade,
    player_id int references users(user_id) on delete cascade,
    type varchar(20) not null,
    time int not null
);
