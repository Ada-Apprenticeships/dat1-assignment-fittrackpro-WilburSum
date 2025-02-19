-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON; 

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance

SELECT 
    equipment_id, 
    name, 
    next_maintenance_date  -- Select equipment ID, name, and next maintenance date
FROM 
    equipment  -- From the equipment table
WHERE 
    next_maintenance_date BETWEEN datetime('now') 
    AND date('now', '+30 days');  -- Where the next maintenance date is within the next 30 days

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock

SELECT 
    type, 
    COUNT(*) AS count  -- Select equipment type and count the number of each type
FROM 
    equipment  -- From the equipment table
GROUP BY 
    type;  -- Group the results by equipment type

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)

SELECT 
    type, 
    AVG(julianday(date('now')) - julianday(purchase_date)) AS avg_age_days  -- Select equipment type and calculate the average age in days
FROM 
    equipment  -- From the equipment table
GROUP BY 
    type;  -- Group the results by equipment type
