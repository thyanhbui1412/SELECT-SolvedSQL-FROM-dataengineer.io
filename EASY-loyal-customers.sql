
--check if theres a customer_name without order_id
SELECT  customer_id, customer_name, count(distinct order_id) as order_count
FROM playground.superstore 
GROUP BY customer_id, customer_name
HAVING count(distinct order_id) >20
ORDER BY order_count desc, customer_name asc
