insert into users (first_name, last_name, email, password, phone_nr, role)
values
    ('jan', 'kowalski', 'jan.kowalski@gmail;.com', 'haslo123', '123-456-789', 'player'),
    ('artur', 'nowak', 'vidal.arturo.nowak@yahoo.com', 'haslo456', '987-654-321', 'referee'),
    ('piotr', 'adamczyk', 'piotro.adamczyk@op.com', 'haslo789', '555-123-456', 'player'),
    ('mariusz', 'woźniak', 'mario.wozniak@og.com', 'hasloabc', '111-222-333', 'admin'),
    ('krzysztof', 'lewandowski', 'krzysztof.lewandowski@canva.com', 'haslodfg', '444-555-666', 'player');

insert into teams (name, city_name, category, captain_id)
values
    ('orly warszawa', 'warszawa', 'amateur', 1),
    ('lwy krakow', 'kraków', 'professional', 3),
    ('smoki poznan', 'poznań', 'amateur', 5),
    ('rekord bielsko', 'bielsko-biała', 'junior', null);

insert into team_players (team_id, user_id, position)
values
    (1, 1, 'napastnik'),
    (1, 3, 'pomocnik'),
    (2, 3, 'obrońca'),
    (2, 5, 'bramkarz'),
    (3, 5, 'napastnik');

insert into leagues (name, category, season, start_date, end_date)
values
    ('ekstraklasa', 'senior', '2024/2025', '2024-08-01', '2025-05-31'),
    ('i liga', 'senior', '2024/2025', '2024-08-01', '2025-05-31'),
    ('liga mlodziezowa', 'junior', '2024/2025', '2024-09-01', '2025-06-30');


insert into pitch (name, city, is_outdoor)
values
    ('orlik miejski', 'warszawa', true),
    ('hala sportowa', 'kraków', false),
    ('orlik', 'poznań', true),
    ('stadion 1', 'bielsko-biała', true);

insert into matches (league_id, match_date, team1_id, team2_id, team1_score, team2_score, referee_id, pitch_id)
values
    (1, '2024-08-10 18:00:00', 1, 2, 2, 1, 2, 1),
    (1, '2024-08-12 20:00:00', 3, 1, 0, 3, 2, 2),
    (2, '2024-08-15 16:00:00', 2, 3, 1, 1, 2, 3);

insert into goals (match_id, player_id, time, type)
values
    (1, 1, 25, 'regular'),
    (1, 3, 45, 'regular'),
    (1, 1, 60, 'penalty'),
    (2, 5, 10, 'regular'),
    (2, 5, 80, 'own goal');

insert into cards (match_id, player_id, type, time)
values
    (1, 3, 'yellow', 30),
    (1, 1, 'red', 75),
    (2, 5, 'yellow', 40),
    (2, 1, 'yellow', 65);

insert into standings (league_id, team_id, matches_played, wins, draws, losses, points, goals_scored, goals_conceded)
values
    (1, 1, 2, 2, 0, 0, 6, 5, 1),
    (1, 2, 2, 1, 0, 1, 3, 2, 4),
    (1, 3, 2, 0, 0, 2, 0, 1, 3),
    (2,1, 1, 1,0,0, 3, 3, 0),
    (2,2,1,0,1,0,1,1,1),
    (2,3,1,0,1,0,1,1,1);

insert into referees (user_id, license, years_of_experience)
values
    (2, 'uefa-ref amature', 5);
