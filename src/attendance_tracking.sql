-- Initial SQLite setup
.open fittrackpro.sqlite -- Open the SQLite database file
.mode column -- Set the output mode to column

-- Enable foreign key support
PRAGMA foreign_key = ON; -- Enable foreign key constraints

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit

INSERT INTO attendance (member_id, location_id, check_in_time) -- Insert a new record into the attendance table
VALUES (7, 1, DATETIME('now')); -- Values for member_id, location_id, and current date-time for check_in_time

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history

SELECT 
    strftime('%Y-%m-%d', check_in_time) AS visit_date, -- Format check_in_time to only show the date
    strftime('%H:%M:%S', check_in_time) AS check_in_time, -- Format check_in_time to only show the time
    strftime('%H:%M:%S', check_out_time) AS check_out_time -- Format check_out_time to only show the time
FROM attendance -- From the attendance table
WHERE member_id = 7; -- Where the member_id is 7

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits

SELECT
    CASE strftime('%w', check_in_time) -- Get the day of the week as a number
        WHEN '1' THEN 'Monday' -- Map '1' to 'Monday'
        WHEN '2' THEN 'Tuesday' -- Map '2' to 'Tuesday'
        WHEN '3' THEN 'Wednesday' -- Map '3' to 'Wednesday'
        WHEN '4' THEN 'Thursday' -- Map '4' to 'Thursday'
        WHEN '5' THEN 'Friday' -- Map '5' to 'Friday'
        WHEN '6' THEN 'Saturday' -- Map '6' to 'Saturday'
        WHEN '7' THEN 'Sunday' -- Map '7' to 'Sunday'
    END AS day_of_week, -- Alias the result as day_of_week
    COUNT(*) AS visit_count -- Count the number of visits
FROM attendance -- From the attendance table
GROUP BY strftime('%w', check_in_time) -- Group by the day of the week
ORDER BY visit_count DESC -- Order by visit_count in descending order
LIMIT 1; -- Limit the result to 1 row

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location

SELECT
    l.name AS location_name, -- Select the location name
    ROUND(COUNT(DISTINCT a.member_id) / 7.0, 2) AS avg_daily_attendance -- Calculate the average daily attendance and round to 2 decimal places
FROM locations l -- From the locations table
JOIN attendance a ON l.location_id = a.location_id -- Join with the attendance table on location_id
GROUP BY l.name; -- Group by location name
