-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;
-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit

INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, DATETIME('now'));

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history

SELECT 
    strftime('%Y-%m-%d', check_in_time) AS visit_date,
    strftime('%H:%M:%S', check_in_time) AS check_in_time,
    strftime('%H:%M:%S', check_out_time) AS check_out_time
FROM attendance
WHERE member_id = 7;

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits

SELECT
    CASE strftime('%w', check_in_time)
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
        WHEN '7' THEN 'Sunday'
    END AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY strftime('%w', check_in_time)
ORDER BY visit_count DESC
LIMIT 1;

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location

SELECT
    l.name AS location_name,
    ROUND(COUNT(DISTINCT a.member_id) / 7.0, 2) AS avg_daily_attendance
FROM locations l
JOIN attendance a ON l.location_id = a.location_id
GROUP BY l.name;
