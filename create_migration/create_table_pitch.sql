create table pitch (
    pitch_id serial primary key,
    name varchar(50) unique not null,
    city varchar(50) not null,
    is_outdoor boolean default TRUE
);
