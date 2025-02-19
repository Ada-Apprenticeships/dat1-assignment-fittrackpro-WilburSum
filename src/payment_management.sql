-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership
INSERT INTO payments (
    member_id, 
    amount, 
    payment_date, 
    payment_method, 
    payment_type
    )
  -- Insert a new payment record into the payments table
VALUES (
    11, 
    50.00, 
    CURRENT_TIMESTAMP, 
    'Credit Card', 'Monthly membership fee'
    );  -- Values for the new payment record

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the current year
SELECT 
    strftime('%Y-%m', payment_date) AS month, 
    SUM(amount) AS total_revenue  -- Select the year-month and sum of amounts as total revenue
FROM 
    payments  -- From the payments table
GROUP BY 
    month;  -- Group by the year-month

-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases
SELECT 
    payment_id, 
    amount, 
    payment_date, 
    payment_method  -- Select payment ID, amount, payment date, and payment method
FROM 
    payments  -- From the payments table
WHERE 
    payment_type = 'Day pass';  -- Where the payment type is 'Day pass'
