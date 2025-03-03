with new_pass as(
(SELECT 
distinct(dc.city_name), 
sum(new_passengers) over (partition by city_id) as new_passengers
FROM fact_passenger_summary fs
join dim_city dc
using(city_id)
order by new_passengers desc 
limit 3)
union
(SELECT 
distinct(dc.city_name), 
sum(new_passengers) over (partition by city_id) as new_passengers
FROM fact_passenger_summary fs
join dim_city dc
using(city_id)
order by new_passengers asc 
limit 3
)
),
ranked_cities as (
select *,
RANK() OVER (ORDER BY new_passengers DESC) AS rank_top,
RANK() OVER (ORDER BY new_passengers ASC) AS rank_bottom 
from new_pass
)
select city_name, new_passengers,
CASE 
	WHEN rank_top <= 3 THEN 'Top 3'
	WHEN rank_bottom <= 3 THEN 'Bottom 3'
	ELSE 'Other' 
END as city_category
from new_pass n
join ranked_cities r 
using(city_name, new_passengers)
