with filtered as (SELECT player_name, season, pts
                  FROM bootcamp.nba_player_seasons
                  WHERE pts >= 20
                  order by player_name),


     lagged as (SELECT player_name,
                       season,
                       pts,
                       lag(season, 1) over (partition by player_name order by season) as prev_scored_season,
                       (season - 1)                                                   as prev_season
                from filtered),
     streak_identifier as (select *,
                                  sum(case when prev_scored_season <> prev_season then 1 else 0 end) OVER (
                                      PARTITION BY
                                          player_name
                                      ORDER BY
                                          season) as streak_changed
                           from lagged)
        ,
     streaked as (select player_name,
                         season,
                         count(*) over (partition by player_name,streak_changed order by season) as streak_cnt
                  from streak_identifier)
        ,
     streak_count as (select player_name, max(streak_cnt) as consecutive_seasons
                      from streaked
                      group by player_name)
        ,
     streak_rank as (select player_name,
                            consecutive_seasons,
                            rank() over (order by consecutive_seasons desc) as streak_ranked
                     from streak_count
                     order by streak_ranked)

select player_name, consecutive_seasons
from streak_rank
where streak_ranked <= 10
order by consecutive_seasons desc, player_name asc
--Kobe Bryant is a good test case. 
