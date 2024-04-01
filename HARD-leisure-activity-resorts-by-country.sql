WITH agg AS (SELECT country, leisure_activity_type, SUM(number_of_places) AS total
             FROM playground.country_activities
             GROUP BY country, leisure_activity_type
             ORDER BY country)
SELECT country,
       SUM(CASE WHEN leisure_activity_type = 'Adventure park' THEN total ELSE 0 END) AS adventure_park,
       SUM(CASE WHEN leisure_activity_type = 'Golf' THEN total ELSE 0 END)           AS golf,
       SUM(CASE WHEN leisure_activity_type = 'River cruise' THEN total ELSE 0 END)   AS river_cruise,
       SUM(CASE WHEN leisure_activity_type = 'Kart racing' THEN total ELSE 0 END)    AS kart_racing
FROM agg
GROUP BY country
