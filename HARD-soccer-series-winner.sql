WITH win AS (SELECT match_id,
                    CASE
                        WHEN first_team_score > second_team_score THEN 1
                        WHEN first_team_score = second_team_score THEN 0
                        ELSE 2 END AS winner,
                    match_host
             FROM playground.scores),

     winning_cnt AS (SELECT winner, COUNT(*) AS winning_time
                     FROM win
                     GROUP BY winner)

SELECT winner
FROM winning_cnt
WHERE winning_time = (SELECT MAX(winning_time) FROM winning_cnt)
