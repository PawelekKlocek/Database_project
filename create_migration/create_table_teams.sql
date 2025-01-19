create table teams (
    team_id serial primary key,
    name varchar(100) not null,
    city_name varchar(50) not null,
    category varchar(50),
    captain_id int references users(user_id) on delete set null,
    creation_date timestamp default current_timestamp
);
