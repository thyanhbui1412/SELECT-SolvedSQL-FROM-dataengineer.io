WITH agg AS (SELECT distinct 
                    d.name AS dep_name,
                    d.id AS d_id,
                    SUM(e.salary) OVER (PARTITION BY d.id)       AS total_salary,
                    COUNT(e.id) OVER (PARTITION BY d.name) AS emp_number
             FROM playground.emp e
                      JOIN playground.dept d ON e.department = d.id),
     ranked AS (SELECT dep_name,
                                emp_number,
                                total_salary,
                                row_number() OVER (ORDER BY total_salary DESC, emp_number desc, d_id asc) AS ranking
                FROM agg)
SELECT *
FROM ranked
where ranking %2 <>0
