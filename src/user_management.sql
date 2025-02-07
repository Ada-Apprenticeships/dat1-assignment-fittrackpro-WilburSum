-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members

SELECT *
FROM members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information

UPDATE members
SET phone_number = '555-9876',
    email = 'emily.jones.updated@email.com'
WHERE member_id = 5;

SELECT *
FROM members
WHERE member_id = 5;

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members

SELECT COUNT(*) AS number_members
FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations

WITH RegistrationCounts AS (
    SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.schedule_id) AS registration_count
    FROM members m
    JOIN class_attendance ca ON m.member_id = ca.member_id
    GROUP BY m.member_id
)
SELECT member_id, first_name, last_name, registration_count
FROM RegistrationCounts
WHERE registration_count = (SELECT MAX(registration_count) FROM RegistrationCounts);

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

WITH RegistrationCounts AS (
    SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.schedule_id) AS registration_count
    FROM members m
    JOIN class_attendance ca ON m.member_id = ca.member_id
    GROUP BY m.member_id
)
SELECT member_id, first_name, last_name, registration_count
FROM RegistrationCounts
WHERE registration_count = (SELECT MIN(registration_count) FROM RegistrationCounts);

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class

SELECT (COUNT(DISTINCT ca.member_id) * 100 / (SELECT COUNT(*) FROM members)) AS percentage_of_members
FROM class_attendance ca
WHERE attendance_status = 'Attended';