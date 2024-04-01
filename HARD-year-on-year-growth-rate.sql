WITH year_sum AS (SELECT EXTRACT(YEAR FROM transaction_date) AS year, product_id, spend FROM playground.dates)
   , yoy AS (SELECT year,
                    product_id,
                    spend                              AS current_year_spend,
                    LAG(spend, 1) OVER (ORDER BY year) AS previous_year_spend
             FROM year_sum)
SELECT *, ROUND(100.00 * (current_year_spend - previous_year_spend) / previous_year_spend, 2) AS yoy_rate
FROM yoy
