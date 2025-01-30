--widok który pozowoli wyodrębnić wiecej szczegołow na temat ligi
create view view_league_standings as
select
    l.name as league_name,
    t.name as team_name,
    s.matches_played,
    s.wins,
    s.draws,
    s.losses,
    s.points,
    s.goals_scored,
    s.goals_conceded
from leagues l
         join standings s on l.league_id = s.league_id
         join teams t on s.team_id = t.team_id;

SELECT * FROM view_league_standings;

--szczegóły zawodników wraz z przypisanymi do nich druzynami i ich szczegółami
create view view_teams_with_players as
select
    t.team_id,
    t.name as team_name,
    t.city_name,
    t.category,
    u.first_name || ' ' || u.last_name as captain_name,
    p.first_name || ' ' || p.last_name as player_name,
    tp.position
from teams t
         left join users u on t.captain_id = u.user_id
         left join team_players tp on t.team_id = tp.team_id
         left join users p on tp.user_id = p.user_id;

select * from view_teams_with_players;

--widok reprezentujacy szczegółowe reprezentowanie meczy
create view view_match_details as
select
    m.match_id,
    l.name as league_name,
    t1.name as team1_name,
    t2.name as team2_name,
    m.team1_score,
    m.team2_score,
    m.match_date,
    r.first_name || ' ' || r.last_name as referee_name,
    p.name as pitch_name
from matches m
         join leagues l on m.league_id = l.league_id
         join teams t1 on m.team1_id = t1.team_id
         join teams t2 on m.team2_id = t2.team_id
         left join users r on m.referee_id = r.user_id
         left join pitch p on m.pitch_id = p.pitch_id;

select * from view_match_details;
