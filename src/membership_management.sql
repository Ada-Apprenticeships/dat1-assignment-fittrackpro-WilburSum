-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    ms.type AS membership_type, 
    ms.start_date  -- Select member details and membership type
FROM 
    members AS m  -- From the members table
JOIN 
    memberships AS ms ON m.member_id = ms.member_id -- Join with the memberships table, On matching member_id
WHERE ms.status = 'Active';  -- Where the membership status is 'Active'

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

SELECT 
    m.type AS membership_type,  -- Select the membership type
    ROUND(AVG((JULIANDAY(a.check_out_time) - JULIANDAY(a.check_in_time)) * 24 * 60), 2) AS avg_visit_duration_minutes  -- Calculate the average visit duration in minutes
FROM
    attendance a  -- From the attendance table
JOIN 
    memberships m ON a.member_id = m.member_id  -- Join with the memberships table on matching member_id
GROUP BY 
    m.type;  -- Group by membership type

-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year

SELECT 
    m.member_id,  -- Select member ID
    m.first_name,  -- Select member first name
    m.last_name,  -- Select member last name
    m.email,  -- Select member email
    ms.end_date  -- Select membership end date
FROM 
    members m  -- From the members table
JOIN 
    memberships ms ON m.member_id = ms.member_id  -- Join with the memberships table on matching member_id
WHERE 
    ms.end_date BETWEEN DATE('now') 
    AND DATE('now', '+1 year');  -- Where the membership end date is within the next year
