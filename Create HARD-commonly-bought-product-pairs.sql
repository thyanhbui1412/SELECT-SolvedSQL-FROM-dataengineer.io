WITH pair AS (SELECT t1.product_name AS product1, t2.product_name AS product2, COUNT(*) AS freq
              FROM playground.product_transactions t1
                       JOIN
                   playground.product_transactions t2
                   ON t1.transaction_id = t2.transaction_id AND t1.product_name < t2.product_name --beautiful join here
              GROUP BY t1.product_name, t2.product_name),
     added_rank AS (SELECT product1, product2, freq, RANK() OVER ( ORDER BY freq DESC) AS rank_col
                    FROM pair)
SELECT product1, product2, freq
FROM added_rank
WHERE rank_col <= 3
ORDER BY freq DESC, product1 ASC, product2 ASC
