-- PHASE 1 PREPPING DATA

-- checking for duplicates
SELECT call_id, call_datetime, call_date, first_name, last_name, phone_number, customer_id, employee_id, call_category, call_length_minutes,
COUNT(*) AS row_count
FROM support_calls_2025
GROUP BY call_id, call_datetime, call_date, first_name, last_name, phone_number, customer_id, employee_id, call_category, call_length_minutes
HAVING COUNT(*) > 1;

-- clean data
SELECT call_id,
	call_datetime,
	call_date,
	first_name, 
	last_name, 
	CONCAT(first_name, ' ', last_name) AS full_name, 
	phone_number, 
	REPLACE(phone_number, '.', '-') AS clean_phone_number, 
	customer_id, 
	employee_id, 
	call_category, 
	call_length_minutes
FROM support_calls_2025;

-- final query (clean and deduplicated)
SELECT DISTINCT 
	call_id,
	call_datetime,
	call_date,
	first_name, 
	last_name, 
	CONCAT(first_name, ' ', last_name) AS full_name, 
	phone_number, 
	REPLACE(phone_number, '.', '-') AS clean_phone_number, 
	customer_id, 
	employee_id, 
	call_category, 
	call_length_minutes
FROM support_calls_2025;


-- PHASE 2 CREATING BASELINE / JOIN TABLES
SELECT call_date,
    COUNT(call_id) AS total_calls,
    AVG(call_length_minutes) AS avg_call_length,
    call_category
FROM support_calls_2025
WHERE call_date >= '2025-10-01' AND call_date < '2025-11-01'
GROUP BY call_date, call_category
ORDER BY call_date DESC;

-- joining table to events dataset
WITH october_calls AS (
SELECT call_date,
    COUNT(call_id) AS total_calls,
    AVG(call_length_minutes) AS avg_call_length,
    call_category
FROM support_calls_2025
WHERE call_date >= '2025-10-01' AND call_date < '2025-11-01'
GROUP BY call_date, call_category
)

SELECT *
FROM october_calls AS o
LEFT JOIN product_events_2025 AS p
ON o.call_date = p.event_date
ORDER BY call_date DESC;


-- PHASE 3 ANALYSIS

-- Billing event
SELECT CASE WHEN call_date < '2025-10-15' THEN 'pre_event'
	ELSE 'post_event'
	END AS period,
	COUNT(call_id) AS total_calls,
	AVG(call_length_minutes) AS avg_call_length,
    SUM(CASE WHEN lower(call_category) = 'billing' THEN 1
    ELSE 0
    END)/COUNT(DISTINCT call_date) AS billing_calls_per_day
FROM support_calls_2025
WHERE call_date >= '2025-10-01' 
AND call_date < '2025-11-01'
GROUP BY period;

-- Login MFA event
SELECT CASE WHEN call_date < '2025-10-25' THEN 'pre_event'
	ELSE 'post_event'
	END AS period,
	COUNT(call_id) AS total_calls,
	AVG(call_length_minutes) AS avg_call_length,
    SUM(CASE WHEN lower(call_category) = 'login' THEN 1
    ELSE 0
    END)/COUNT(DISTINCT call_date) AS login_calls_per_day
FROM support_calls_2025
WHERE call_date >= '2025-10-01' 
AND call_date < '2025-11-01'
GROUP BY period;
