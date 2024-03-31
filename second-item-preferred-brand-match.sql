WITH tbl AS (SELECT ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY o.order_date) AS row_num,
                    CASE
                        WHEN item_brand IS NULL THEN 0
                        ELSE
                            COUNT(item_brand) OVER (PARTITION BY u.user_id) END      AS total_sold,
                    u.user_id                                                        AS seller_id,
                    i.item_brand,
                    u.preferred_brand
             FROM playground.users u
                      LEFT JOIN playground.orders o ON o.seller_id = u.user_id
                      LEFT JOIN playground.items i ON i.item_id = o.item_id)

SELECT seller_id,
       CASE
           WHEN item_brand = preferred_brand THEN 'yes'
           ELSE 'no' END AS has_pref_brand
FROM tbl
WHERE row_num = 2

UNION ALL

SELECT seller_id, 'no' AS has_pref_brand
FROM tbl
WHERE total_sold < 2
ORDER BY seller_id
