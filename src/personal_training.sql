-- Initial SQLite setup
.open fittrackpro.sqlite  -- Open the SQLite database named fittrackpro.sqlite
.mode column  -- Set the output mode to column format

-- Enable foreign key support
PRAGMA foreign_key = ON;  -- Enable foreign key constraints

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer

SELECT 
    pt.session_id,  -- Select the session ID
    m.first_name || ' ' || m.last_name AS member_name,  -- Concatenate member's first and last name as member_name
    pt.session_date,  -- Select the session date
    pt.start_time,  -- Select the session start time
    pt.end_time  -- Select the session end time
FROM 
    personal_training_sessions AS pt  -- From the personal_training_sessions table
JOIN 
    members AS m  -- Join with the members table
ON
    pt.member_id = m.member_id  -- On matching member_id
JOIN 
    staff AS s  -- Join with the staff table
ON
    pt.staff_id = s.staff_id  -- On matching staff_id
WHERE
    s.first_name = 'Ivy'  -- Where the staff's first name is 'Ivy'
    AND
    s.last_name = 'Irwin';  -- And the staff's last name is 'Irwin'