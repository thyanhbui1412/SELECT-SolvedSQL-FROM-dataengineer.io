
-- count distinct article, group by viewer, date
with agg as (SELECT
  viewer_id,
  view_date,
  count(distinct article_id) as count_article
FROM playground.views
GROUP BY viewer_id,view_date)
-- filter count of article>1 
  SELECT
    DISTINCT viewer_id
  FROM agg
  WHERE count_article>1
