-- Initial SQLite setup
.open fittrackpro.sqlite -- Open the SQLite database
.mode column -- Set the output mode to column

-- Enable foreign key support
PRAGMA foreign_key = ON; -- Enable foreign key constraints

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

SELECT classes.class_id, classes.name AS class_name, (staff.first_name || ' ' || staff.last_name) as instructor_name -- Select class ID, class name, and instructor name
FROM classes -- From the classes table
JOIN class_schedule on classes.class_id = class_schedule.class_id -- Join with class_schedule table on class_id
JOIN staff on class_schedule.staff_id = staff.staff_id; -- Join with staff table on staff_id

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date

SELECT
    classes.class_id, -- Select class ID
    classes.name, -- Select class name
    class_schedule.start_time, -- Select class start time
    class_schedule.end_time, -- Select class end time
    classes.capacity - COUNT(class_attendance.attendance_status) AS available_spots -- Calculate available spots
FROM 
    classes -- From the classes table
JOIN 
    class_schedule ON classes.class_id = class_schedule.class_id -- Join with class_schedule table on class_id
LEFT JOIN 
    class_attendance ON class_schedule.schedule_id = class_attendance.schedule_id -- Left join with class_attendance table on schedule_id
    AND class_attendance.attendance_status = 'Registered' -- Filter by attendance status 'Registered'
WHERE 
    strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01' -- Filter by specific date
GROUP BY classes.class_id; -- Group by class ID

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

INSERT INTO class_attendance (schedule_id, member_id, attendance_status) -- Insert into class_attendance table
SELECT schedule_id, 11, 'Registered' -- Select schedule_id, member_id, and attendance_status
FROM class_schedule -- From the class_schedule table
WHERE class_id = 3 AND strftime('%Y-%m-%d', start_time) = '2025-02-01'; -- Filter by class_id and specific date

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

DELETE FROM class_attendance -- Delete from class_attendance table
WHERE member_id = 2 AND schedule_id = 7; -- Filter by member_id and schedule_id

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

SELECT
    classes.class_id, -- Select class ID
    classes.name AS class_name, -- Select class name
    COUNT(class_attendance.attendance_status) AS registation_count -- Count the number of registrations
FROM 
    classes -- From the classes table
JOIN 
    class_schedule ON classes.class_id = class_schedule.class_id -- Join with class_schedule table on class_id
LEFT JOIN 
    class_attendance ON class_schedule.schedule_id = class_attendance.schedule_id -- Left join with class_attendance table on schedule_id
WHERE 
    class_attendance.attendance_status = 'Registered' -- Filter by attendance status 'Registered'
GROUP BY
    classes.name, classes.class_id -- Group by class name and class ID
ORDER BY
    registation_count DESC -- Order by registration count in descending order
LIMIT 3; -- Limit the result to top 3

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT 
    ROUND((COUNT(*) * 1.0) / COUNT(DISTINCT member_id), 2) AS average_classes_per_member -- Calculate average classes per member
FROM 
    class_attendance; -- From the class_attendance table
