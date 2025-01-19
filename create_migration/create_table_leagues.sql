create table leagues (
     league_id serial primary key,
     name varchar(100) not null,
     category varchar(50),
     season varchar(20),
     start_date date not null,
     end_date date not null
);
