-- Initial SQLite setup
.open fittrackpro.sqlite  -- Open the SQLite database file named fittrackpro.sqlite
.mode column  -- Set the output mode to column format

-- Enable foreign key support

PRAGMA foreign_key = ON;  -- Enable foreign key constraints in the SQLite database

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role

SELECT staff_id, first_name, last_name, position AS role  -- Select staff ID, first name, last name, and position (renamed to role)
FROM staff;  -- From the staff table

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days

SELECT s.staff_id, s.first_name || ' ' || s.last_name AS trainer_name, COUNT(*) AS num_sessions  -- Select staff ID, concatenated first and last name as trainer name, and count of sessions
FROM staff s  -- From the staff table with alias s
JOIN personal_training_sessions pt  -- Join with the personal_training_sessions table with alias pt
ON s.staff_id = pt.staff_id  -- On matching staff ID between staff and personal_training_sessions tables
WHERE pt.session_date BETWEEN date('now') AND date('now', '+30 days')  -- Where session date is between today and the next 30 days
GROUP BY s.staff_id;  -- Group the results by staff ID
