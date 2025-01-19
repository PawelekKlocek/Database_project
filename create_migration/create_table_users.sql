create table users (
    user_id serial PRIMARY KEY,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) unique not null,
    password varchar(100) not null,
    phone_nr varchar(15),
    role varchar(20) not null,
    registrarion_date timestamp default current_timestamp
);
