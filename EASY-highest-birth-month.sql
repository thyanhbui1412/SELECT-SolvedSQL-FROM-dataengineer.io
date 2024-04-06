--calculate total births in a month
-- rank the total births desc
--choose the highest birth by filtering rank =1

with monthly_sum as (SELECT month,  sum(births) as total_births
FROM playground.us_birth_stats 
group by month),
rank_birth as ( select month, total_births, rank() over (order by total_births desc) as ranked from monthly_sum)
select month,
total_births
from rank_birth
where ranked=1
