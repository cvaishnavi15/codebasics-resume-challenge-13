with cte1 as 
(select count(trip_id) as total_trips, 
city_id, 
sum(distance_travelled_km) as total_km, 
avg(distance_travelled_km) as avg_km,
sum(fare_amount) as total_fare,
avg(fare_amount) as avg_fare
from fact_trips
group by city_id
)
select c.city_name as city_name, 
cte.total_trips as total_trips,
round(total_fare/total_trips,2) as avg_fare_per_trip,
round(avg_fare/avg_km,2) as avg_fare_per_km,
cte.total_trips*100/sum(cte.total_trips) over() as percentage_contribution_to_total_trips
from cte1 as cte 
join dim_city as c
on cte.city_id=c.city_id
order by total_trips desc

