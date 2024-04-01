with subcategory_rollup as (
  SELECT region, sub_category, count(*) as purchase_count
  FROM playground.superstore
  group by  region, sub_category),
  small as (select region,max(purchase_count) as highest 
  from subcategory_rollup 
  group by region)
select big.region, big.sub_category, purchase_count from subcategory_rollup big 
  join  small 
    on big.region = small.region and small.highest =       big.purchase_count 
  order by region 
