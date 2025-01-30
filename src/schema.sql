-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

-- TODO: Create the following tables:
-- Create your tables here

-- Locations Table
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(255),
    opening_hours VARCHAR(255)
);

-- Members Table
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(15),
    date_of_birth DATE,
    join_date DATE,
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone VARCHAR(15)
);

-- Staff Table
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(15),
    position,
    hire_date DATE,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Equipment Table
CREATE TABLE equipment (
    equipment_id INT PRIMARY KEY,
    name VARCHAR(255),
    type ENUM('Cardio', 'Strength'),
    purchase_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Classes Table
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    capacity INT,
    duration TIME,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Class Schedule Table
CREATE TABLE class_schedule (
    schedule_id INT PRIMARY KEY,
    class_id INT,
    staff_id INT,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Memberships Table
CREATE TABLE memberships (
    membership_id INT PRIMARY KEY,
    member_id INT,
    type VARCHAR(255),
    start_date DATE,
    end_date DATE,
    status ENUM('Active', 'Inactive'),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Attendance Table
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    member_id INT,
    location_id INT,
    check_in_time DATETIME,
    check_out_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Class Attendance Table
CREATE TABLE class_attendance (
    class_attendance_id INT PRIMARY KEY,
    schedule_id INT,
    member_id INT,
    attendance_status ENUM('Registered', 'Attended', 'Unattended'),
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    member_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    payment_method ENUM('Credit Card', 'Bank Transfer', 'PayPal'),
    payment_type ENUM('Monthly membership fee', 'Day pass'),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Personal Training Sessions Table
CREATE TABLE personal_training_sessions (
    session_id INT PRIMARY KEY,
    member_id INT,
    staff_id INT,
    session_date DATE,
    start_time TIME,
    end_time TIME,
    notes TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Member Health Metrics Table
CREATE TABLE member_health_metrics (
    metric_id INT PRIMARY KEY,
    member_id INT,
    measurement_date DATE,
    weight DECIMAL(5, 2),
    body_fat_percentage DECIMAL(5, 2),
    muscle_mass DECIMAL(5, 2),
    bmi DECIMAL(5, 2),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Equipment Maintenance Log Table
CREATE TABLE equipment_maintenance_log (
    log_id INT PRIMARY KEY,
    equipment_id INT,
    maintenance_date DATE,
    description TEXT,
    staff_id INT,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);


-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal