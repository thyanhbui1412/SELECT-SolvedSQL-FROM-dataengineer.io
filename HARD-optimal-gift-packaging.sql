WITH package AS (SELECT *, length * width * height AS pkg_volume FROM playground.packages),
     gift AS (SELECT *, length * width * height AS gft_volume FROM playground.gifts),

     pkg_selection AS (SELECT DISTINCT p.package_type,
                                       g.id,
                                       p.length,
                                       p.width,
                                       p.height,
                                       g.length,
                                       g.width,
                                       g.height,
                                       p.pkg_volume,
                                       g.gft_volume,
                                       (p.pkg_volume - g.gft_volume) AS extra_vol
                       FROM gift g
                                JOIN package p ON g.length <= p.length AND
                                                  g.width <= p.width AND
                                                  g.height <= p.height AND
                                                  g.gft_volume <= p.pkg_volume),

     optimized AS (SELECT id,
                          package_type,
                          extra_vol,
                          ROW_NUMBER() OVER (PARTITION BY id ORDER BY extra_vol) AS optimizer
                   FROM pkg_selection)
SELECT package_type, COUNT(id) AS number
FROM optimized
WHERE optimizer = 1
GROUP BY package_type
ORDER BY package_type
