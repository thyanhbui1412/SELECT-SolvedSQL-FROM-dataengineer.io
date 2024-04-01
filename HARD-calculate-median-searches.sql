with tbl as (SELECT num_users,searches,
  lead(searches) over(order by searches) as nextSearches,
  row_number(*) over() as nth, 
  0.5*COUNT(searches) over() as mid,
  round((0.5*COUNT(searches) over())) as rounded_mid 
  FROM playground.search_freq
  order by searches)

  select 
  case when mid=rounded_mid 
      then cast(0.5*(searches + nextSearches) as double)
    else cast(searches as double) end as median
  from tbl
  where rounded_mid = nth
