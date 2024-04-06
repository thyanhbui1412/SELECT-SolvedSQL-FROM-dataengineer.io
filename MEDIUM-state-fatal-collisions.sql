-- assume all states have collisions, use windows function to calculate nation avg fatal coll per bi miles
-- compare with case when
SELECT state,
       fatal_collisions_per_billion_miles,
       CASE
           WHEN fatal_collisions_per_billion_miles >= AVG(fatal_collisions_per_billion_miles) OVER ()
               THEN 'Above Average'
           ELSE 'Below Average' END AS comparison_to_national_avg
FROM playground.bad_drivers
ORDER BY state
