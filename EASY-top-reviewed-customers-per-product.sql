
with ranked_tbl as (
  select 
    product_id, 
    customer_id, 
    review_score, 
    helpful_votes, 
    row_number() over(partition by product_id order by review_score desc, helpful_votes desc) as rank_num --handle ties based on 2 dimensions
from playground.product_reviews)
select 
    product_id, 
    customer_id, 
    review_score, 
    helpful_votes
  from ranked_tbl 
  where rank_num = 1
