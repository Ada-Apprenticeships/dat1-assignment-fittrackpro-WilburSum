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

-- SELECT classes.capacity
--     FROM classes
--     JOIN class_schedule ON classes.class_id = class_schedule.class_id
--     WHERE (strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01')
--     GROUP BY classes.class_id;

-- SELECT COUNT(*) 
--     FROM class_attendance 
--     JOIN class_schedule ON class_attendance.schedule_id = class_schedule.schedule_id
--     WHERE (strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01') 
--         AND (class_attendance.attendance_status = 'Registered')
--     GROUP BY class_schedule.class_id;

-- SELECT classes.capacity
-- FROM classes
-- JOIN class_schedule ON classes.class_id = class_schedule.class_id
-- WHERE (strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01')
-- GROUP BY classes.class_id;
    
-- SELECT COUNT(*) 
-- FROM class_attendance 
-- JOIN class_schedule ON class_attendance.schedule_id = class_schedule.schedule_id
-- WHERE (strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01') 
--     AND (class_attendance.attendance_status = 'Registered')
-- GROUP BY class_schedule.class_id

SELECT classes.class_id, classes.name, class_schedule.start_time, class_schedule.end_time,
    ((SELECT classes.capacity
    FROM classes
    JOIN class_schedule ON classes.class_id = class_schedule.class_id
    WHERE (strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01')
    GROUP BY classes.class_id) -
    (SELECT COUNT(*) 
    FROM class_attendance 
    JOIN class_schedule ON class_attendance.schedule_id = class_schedule.schedule_id
    WHERE (strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01') 
        AND (class_attendance.attendance_status = 'Registered')
    GROUP BY class_schedule.class_id)) AS available_spots
FROM classes
JOIN class_schedule ON classes.class_id = class_schedule.class_id
WHERE (strftime('%Y-%m-%d', class_schedule.start_time) = '2025-02-01')

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member