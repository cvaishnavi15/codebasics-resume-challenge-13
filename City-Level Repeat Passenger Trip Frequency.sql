SELECT 
    dc.city_name,
    ROUND(SUM(CASE WHEN drtd.trip_count = 2 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `2-Trips`,
    ROUND(SUM(CASE WHEN drtd.trip_count = 3 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `3-Trips`,
    ROUND(SUM(CASE WHEN drtd.trip_count = 4 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `4-Trips`,
    ROUND(SUM(CASE WHEN drtd.trip_count = 5 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `5-Trips`,
    ROUND(SUM(CASE WHEN drtd.trip_count = 6 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `6-Trips`,
    ROUND(SUM(CASE WHEN drtd.trip_count = 7 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `7-Trips`,
    ROUND(SUM(CASE WHEN drtd.trip_count = 8 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `8-Trips`,
    ROUND(SUM(CASE WHEN drtd.trip_count = 9 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `9-Trips`,
    ROUND(SUM(CASE WHEN drtd.trip_count = 10 THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count), 2) AS `10-Trips`
FROM 
    dim_repeat_trip_distribution drtd
JOIN 
    dim_city dc ON drtd.city_id = dc.city_id
WHERE 
    drtd.trip_count BETWEEN 2 AND 10
GROUP BY 
    dc.city_name
ORDER BY 
    dc.city_name;
