CREATE DEFINER=`root`@`localhost` PROCEDURE `city_monthly_actual_vs_target_trips_report`(IN in_city VARCHAR(30))
BEGIN
with cte1 as 
(
SELECT 
dd.month_name,
sum(tt.total_target_trips) as target_trips
FROM targets_db.monthly_target_trips tt
join trips_db.dim_date dd
on tt.month=dd.date
join trips_db.dim_city dc
using(city_id)
 where dc.city_name= in_city
group by month_name
),
cte2 as 
(
SELECT 
dd.month_name,
count(ft.trip_id) as actual_trips
FROM trips_db.fact_trips ft
join trips_db.dim_date dd
using(date)
join trips_db.dim_city dc
using(city_id)
where dc.city_name= in_city
group by dd.month_name
)
select 
month_name,
cte2.actual_trips,
cte1.target_trips,
if(cte2.actual_trips>cte1.target_trips,"above target","below target") as performance_status,
round((cte1.target_trips-cte2.actual_trips)*100/cte1.target_trips,2) as pct_difference
from cte1 
join cte2 
using(month_name);
END