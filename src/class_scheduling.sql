-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

SELECT classes.class_id, classes.name AS class_name, (staff.first_name || ' ' || staff.last_name) as instructor_name
FROM classes
JOIN class_schedule on classes.class_id = class_schedule.class_id
JOIN staff on class_schedule.staff_id = staff.staff_id;

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date

SELECT
    classes.class_id,
    classes.name,
    class_schedule.start_time,
    class_schedule.end_time,
    classes.capacity - COUNT(class_attendance.attendance_status) AS available_spots
FROM 
    classes
JOIN 
    class_schedule ON classes.class_id = class_schedule.class_id
LEFT JOIN 
    class_attendance ON class_schedule.schedule_id = class_attendance.schedule_id
    AND class_attendance.attendance_status = 'Registered'
WHERE 
    strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01'
GROUP BY classes.class_id;

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
SELECT schedule_id, 11, 'Registered'
FROM class_schedule
WHERE class_id = 3 AND strftime('%Y-%m-%d', start_time) = '2025-02-01';

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

DELETE FROM class_attendance
WHERE member_id = 2 AND schedule_id = 7;

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

SELECT
    classes.class_id,
    classes.name AS class_name,
    COUNT(class_attendance.attendance_status) AS registation_count
FROM 
    classes
JOIN 
    class_schedule ON classes.class_id = class_schedule.class_id
LEFT JOIN 
    class_attendance ON class_schedule.schedule_id = class_attendance.schedule_id
WHERE 
    class_attendance.attendance_status = 'Registered'
GROUP BY
    classes.name, classes.class_id
ORDER BY
    registation_count DESC
LIMIT 3;

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT 
    ROUND((COUNT(*) * 1.0) / COUNT(DISTINCT member_id), 2) AS average_classes_per_member
FROM 
    class_attendance;
