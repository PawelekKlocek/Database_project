-- funnkcja i trigger plpql liczaca punkty danych zespolow po meczu
--
create or replace function points_calculator(team_score INT, opponent_score INT)
returns INT as $$
begin
    IF team_score > opponent_score then
        return 3;
    elsif team_score = opponent_score then
        return 1;
    else
        return 0;
    end if;
end;
$$ language plpgsql;

create or replace function update_standings_after_match()
    returns trigger as $$
declare
    team1_points int;
    team2_points int;
begin
    team1_points := points_calculator(new.team1_score, new.team2_score);
    team2_points := points_calculator(new.team2_score, new.team1_score);

    update standings
    set matches_played = matches_played + 1,
        wins = wins + case when team1_points = 3 then 1 else 0 end,
        draws = draws + case when team1_points = 1 then 1 else 0 end,
        losses = losses + case when team1_points = 0 then 1 else 0 end,
        points = points + team1_points,
        goals_scored = goals_scored + new.team1_score,
        goals_conceded = goals_conceded + new.team2_score
    where team_id = new.team1_id and league_id = new.league_id;

    update standings
    set matches_played = matches_played + 1,
        wins = wins + case when team2_points = 3 then 1 else 0 end,
        draws = draws + case when team2_points = 1 then 1 else 0 end,
        losses = losses + case when team2_points = 0 then 1 else 0 end,
        points = points + team2_points,
        goals_scored = goals_scored + new.team2_score,
        goals_conceded = goals_conceded + new.team1_score
    where team_id = new.team2_id and league_id = new.league_id;

    return new;
end;
$$ language plpgsql;

create trigger after_match_insert
    after insert on matches
    for each row
execute function update_standings_after_match();

insert into matches (league_id, match_date, team1_id, team2_id, team1_score, team2_score, referee_id, pitch_id)
values (1, '2024-08-23 19:00:00', 3, 2, 3, 1, 2, 1);
select * from standings where league_id = 1;




--funkcja i trigger do zamienia dwóch żółtych karte na czerwoną
--
create or replace function red_card(p_player_id int, p_type varchar)
    returns varchar as $$
declare
    yellow_card_count int;
begin
    if p_type = 'yellow' then
        select count(*) into yellow_card_count
        from cards
        where player_id = p_player_id and type = 'yellow';

        if yellow_card_count >= 2 then
            return 'red';
        else
            return 'yellow';
        end if;
    else
        return p_type;
    end if;
end;
$$ language plpgsql;

create or replace function check_red_card_trigger()
    returns trigger as $$
begin
    if new.type = 'yellow' then
        new.type := red_card(new.player_id, new.type);
        if new.type = 'red' then
            delete from cards where player_id = new.player_id and match_id = new.match_id and type = 'yellow' and card_id != new.card_id;
            update cards set type = 'red' where card_id = new.card_id;
        end if;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger after_card_insert
    after insert on cards
    for each row
execute function check_red_card_trigger();

insert into cards (match_id, player_id, type, time) values (1, 1, 'yellow', 10);

insert into cards (match_id, player_id, type, time) values (1, 1, 'yellow', 41);

select * from cards where player_id = 1;
