-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members

SELECT *  -- Select all columns
FROM members;  -- From the members table

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information

UPDATE members  -- Update the members table
SET phone_number = '555-9876',  -- Set the phone number to '555-9876'
    email = 'emily.jones.updated@email.com'  -- Set the email to 'emily.jones.updated@email.com'
WHERE member_id = 5;  -- Where the member_id is 5

SELECT *  -- Select all columns
FROM members  -- From the members table
WHERE member_id = 5;  -- Where the member_id is 5

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members

SELECT COUNT(*) AS number_members  -- Count the total number of rows and alias it as number_members
FROM members;  -- From the members table

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations

WITH RegistrationCounts AS (  -- Common Table Expression (CTE) to calculate registration counts
    SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.schedule_id) AS registration_count  -- Select member_id, first_name, last_name, and count of schedule_id as registration_count
    FROM members m  -- From the members table aliased as m
    JOIN class_attendance ca ON m.member_id = ca.member_id  -- Join with class_attendance table on member_id
    GROUP BY m.member_id  -- Group by member_id
)
SELECT member_id, first_name, last_name, registration_count  -- Select member_id, first_name, last_name, and registration_count
FROM RegistrationCounts  -- From the CTE RegistrationCounts
WHERE registration_count = (SELECT MAX(registration_count) FROM RegistrationCounts);  -- Where registration_count is the maximum registration_count

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

WITH RegistrationCounts AS (  -- Common Table Expression (CTE) to calculate registration counts
    SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.schedule_id) AS registration_count  -- Select member_id, first_name, last_name, and count of schedule_id as registration_count
    FROM members m  -- From the members table aliased as m
    JOIN class_attendance ca ON m.member_id = ca.member_id  -- Join with class_attendance table on member_id
    GROUP BY m.member_id  -- Group by member_id
)
SELECT member_id, first_name, last_name, registration_count  -- Select member_id, first_name, last_name, and registration_count
FROM RegistrationCounts  -- From the CTE RegistrationCounts
WHERE registration_count = (SELECT MIN(registration_count) FROM RegistrationCounts);  -- Where registration_count is the minimum registration_count

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class

SELECT (COUNT(DISTINCT ca.member_id) * 100 / (SELECT COUNT(*) FROM members)) AS percentage_of_members  -- Calculate the percentage of members who have attended at least one class
FROM class_attendance ca  -- From the class_attendance table aliased as ca
WHERE attendance_status = 'Attended';  -- Where attendance_status is 'Attended'