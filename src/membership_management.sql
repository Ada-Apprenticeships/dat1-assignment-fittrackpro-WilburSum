-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

PRAGMA foreign_key = ON;

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

SELECT m.member_id, m.first_name, m.last_name, ms.type AS membership_type, ms.start_date
FROM members AS m
JOIN memberships AS ms
ON m.member_id = ms.member_id
WHERE ms.status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

SELECT 
    m.type AS membership_type,
    ROUND(AVG((JULIANDAY(a.check_out_time) - JULIANDAY(a.check_in_time)) * 24 * 60), 2) AS avg_visit_duration_minutes
    FROM
    attendance a
JOIN 
    memberships m ON a.member_id = m.member_id
GROUP BY 
    m.type;

-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year

SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    m.email, 
    ms.end_date
FROM 
    members m
JOIN 
    memberships ms ON m.member_id = ms.member_id
WHERE 
    ms.end_date BETWEEN DATE('now') AND DATE('now', '+1 year');
