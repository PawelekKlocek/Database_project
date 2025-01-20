select * from users;
select * from matches where extract(month from match_date) = 8;
select * from teams where captain_id is null;
select * from matches where team1_score + team2_score > 3;


insert into users (first_name, last_name, email, password, phone_nr, role)
values
    ('tobiasz', 'mazur', 'tobzur@oracle.com', 'haslo000', '444-127-888', 'player'),
    ('marek', 'dudek', 'dudi@o2.com', 'haslo999', '999-888-777', 'referee');

insert into teams (name, city_name, category, captain_id)
values
    ('wikingowie gdansk', 'gdańsk', 'amateur', 4),
    ('akademia sukcesu w łódź', 'łódź', 'junior', null);

insert into referees (user_id, license, years_of_experience)
values
    (7, 'pzpn', 3);

-- wyswietlenie wszystkich zawodników drużyny o id 2
select u.first_name, u.last_name from users u join team_players tp on u.user_id = tp.user_id where tp.team_id = 2;

-- wysiwetlenie wszystkich zółych kartek z meczu o id = 1
select * from cards where match_id = 1 and type = 'yellow';

-- wyświetlenie wszstkich wieczornych meczy
select * from matches where match_date > '2024-08-20 19:00:00';

update teams set category = 'professional' where team_id = 3;
update team_players set position = 'bramkarz' where team_player_id = 1;
update leagues set start_date = '2024-08-10' where league_id = 2;
update matches set team1_score = 2, team2_score = 2 where match_id = 3;
update standings set points = 5 where team_id = 2 and league_id = 1;

delete from team_players where team_player_id = 1;
delete from goals where goal_id = 1;
delete from standings where league_id = 1 and team_id = 1;

-- zapytania zagniezdzone
select name from teams
where team_id in (select team_id from team_players where position = 'napastnik');

select name from pitch
where pitch_id in (select pitch_id from matches where league_id in (select league_id from leagues where name = 'ekstraklasa'));

-- zapytanie join które wysiwetli mecze z nazwami druzyn i ligi
select m.match_id, l.name as league_name, t1.name as team1_name, t2.name as team2_name, m.match_date
from matches m
         join leagues l on m.league_id = l.league_id
         join teams t1 on m.team1_id = t1.team_id
         join teams t2 on m.team2_id = t2.team_id;

-- zapytanei join które wyswietli wszelkie informacje zwiazane ze strzelcami
select g.goal_id, m.match_id, u.first_name, u.last_name, g.time, g.type
from goals g
         join matches m on g.match_id = m.match_id
         join users u on g.player_id = u.user_id;

-- zapytanie znajdujace liczbe goli strzelonych przez kazdego gracza
select u.first_name, u.last_name, count(g.goal_id) as total_goals
from users u
         left join goals g on u.user_id = g.player_id
group by u.first_name, u.last_name
order by total_goals desc;

-- zapytanie znajdujace liczbe zołtych i czerwonych kartek w kazydym meczu
select match_id,
       count(case when type = 'yellow' then 1 end) as yellow_cards,
       count(case when type = 'red' then 1 end) as red_cards
from cards
group by match_id;

-- wszyscy zawodnicy który strzeeli wiecej niz dwa gole
select u.first_name, u.last_name, count(g.goal_id) as total_goals
from users u
         left join goals g on u.user_id = g.player_id
group by u.first_name, u.last_name
having count(g.goal_id) > 2;

