--if new price is null then it should be 10
--if a product only has new price after 2023-08-17, then 10
--if product has new price from 2023-08-17 and older, then take the latest date.

WITH null_treat AS (SELECT product_id, COALESCE(new_price, 10) AS price, change_date
                    FROM playground.product_prices),
     later AS (SELECT product_id, CAST('10' AS INT) AS price
               FROM null_treat
               GROUP BY product_id
               HAVING MIN(change_date) > date('2023-08-17')),
     flag AS
         (SELECT product_id,
                 price,
                 ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS newest_flagged
          FROM null_treat
          WHERE change_date <= date('2023-08-17')),
     before AS (SELECT product_id, price
                FROM flag
                WHERE newest_flagged = 1)
SELECT product_id, price
FROM later
UNION
SELECT product_id, price
FROM before
ORDER BY product_id 
