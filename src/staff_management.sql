-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

PRAGMA foreign_key = ON;


-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role

SELECT staff_id, first_name, last_name, position AS role
FROM staff;

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days