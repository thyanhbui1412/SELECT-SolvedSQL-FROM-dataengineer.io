with unpivot_tbl as  (SELECT country, 'beer' as preferred_drink, beer_servings as servings
FROM playground.drinks
union all
SELECT country, 'spirit' as preferred_drink, spirit_servings as servings
FROM playground.drinks
union all
SELECT country, 'wine' as preferred_drink, wine_servings as servings
FROM playground.drinks),
ranked_preference as (select country, preferred_drink, row_number() over(partition by country order by servings ) as ranked
from unpivot_tbl)

select country, preferred_drink 
from ranked_preference
where  ranked =1  and preferred_drink <> 'beer'
order by country
