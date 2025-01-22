-- tranzakcja polegajaca na transferze zawodnika z jednej do drugiej drużyny
--
insert into users (first_name, last_name, email, password, phone_nr, role)
values ('robur', 'lewandowski', 'robercik@fcb.com', 'rl9rl9', '123-123-123', 'player');

insert into team_players (team_id, user_id, position)
values (7, 8, 'napastnik');

select * from team_players;

begin;
delete from team_players
where user_id = 8 and team_id = 7;

insert into team_players (team_id, user_id, position, join_date)
values (9, 8, 'napastnik', current_timestamp);

commit;


-- tranzakcje polegajaca na spadku/awansie zespołów do niższej/wyższej ligi
--
insert into standings (league_id, team_id) values (5, 5);
insert into standings (league_id, team_id) values (4, 6);

select * from standings;


begin;

update standings
set league_id = 4
where team_id = 5 and league_id = 5;

update standings
set league_id = 5
where team_id = 6 and league_id = 4;

commit;



--tranzakcja zostaje wycofana ze wzgledu na brak druzuny o podanym id
--
begin;

update standings
set league_id = 4
where team_id = 99 and league_id = 5;

update standings
set league_id = 5
where team_id = 99 and league_id = 4;

rollback;
