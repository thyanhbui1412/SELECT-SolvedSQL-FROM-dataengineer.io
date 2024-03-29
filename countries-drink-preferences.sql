WITH unpivot_tbl AS (SELECT country, 'Beer' AS preferred_drink, beer_servings AS servings
                     FROM playground.drinks
                     UNION ALL
                     SELECT country, 'Spirit' AS preferred_drink, spirit_servings AS servings
                     FROM playground.drinks
                     UNION ALL
                     SELECT country, 'Wine' AS preferred_drink, wine_servings AS servings
                     FROM playground.drinks),
     ranked_preference AS (SELECT country,
                                  preferred_drink,
                                  ROW_NUMBER() OVER (PARTITION BY country ORDER BY servings DESC ) AS ranked
                           FROM unpivot_tbl)

SELECT country, preferred_drink
FROM ranked_preference
WHERE ranked = 1
  AND preferred_drink <> 'Beer'
ORDER BY country
