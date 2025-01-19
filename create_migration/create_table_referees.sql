create table referees (
    referee_id serial primary key,
    user_id int references users(user_id) on delete cascade,
    license varchar(50) not null,
    years_of_experience int not null default 0
);
