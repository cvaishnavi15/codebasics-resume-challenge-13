WITH cte AS (
    SELECT 
        dc.city_name,
        dd.month_name,
        SUM(ft.fare_amount) AS total_revenue,
        RANK() OVER (PARTITION BY dc.city_name ORDER BY SUM(ft.fare_amount) DESC) AS rank_of,
        SUM(ft.fare_amount) * 100.0 / SUM(SUM(ft.fare_amount)) OVER (PARTITION BY dc.city_name) AS percentage_contribution
    FROM 
        fact_trips ft
    JOIN 
        dim_city dc ON ft.city_id = dc.city_id
    JOIN 
        dim_date dd ON ft.date = dd.date
    GROUP BY 
        dc.city_name, dd.month_name
)
SELECT 
    city_name,
    month_name AS highest_revenue_month,
    total_revenue AS revenue,
    ROUND(percentage_contribution,2) AS percentage_contribution
FROM 
    cte
WHERE 
    rank_of = 1
ORDER BY 
    city_name;
