--find maxes, mins
with identifier as (SELECT  
  salary, 
  rank() over(order by salary desc) as maxes,
  rank() over(order by salary asc) as mins  
FROM playground.employees_salary )

--calculate dif
select (select sum(salary)
from identifier
where maxes=1) 
- 
(select sum(salary)
from identifier
where mins=1) 
as difference
