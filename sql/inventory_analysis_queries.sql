-- ======================================================
-- Inventory Analysis SQL Queries
-- Database: inventory_analysis
-- Table: inventory_transactions
-- ======================================================

-- 1. Total number of transactions
SELECT COUNT(*) AS total_transactions
FROM inventory_transactions;

-- 2. Total Stock Value
SELECT ROUND(SUM(Stock_Value), 2) AS total_stock_value
FROM inventory_transactions;

-- 3. Stock summary by Warehouse
SELECT 
    Warehouse,
    SUM(Closing_Stock) AS total_closing_stock,
    ROUND(SUM(Stock_Value), 2) AS total_stock_value
FROM inventory_transactions
GROUP BY Warehouse
ORDER BY total_stock_value DESC;

-- 4. Stock summary by Category
SELECT 
    Category,
    SUM(Closing_Stock) AS total_closing_stock,
    ROUND(SUM(Stock_Value), 2) AS total_stock_value
FROM inventory_transactions
GROUP BY Category
ORDER BY total_stock_value DESC;

-- 5. Top 10 Products by Stock Value
SELECT 
    Product,
    Category,
    SUM(Closing_Stock) AS total_closing_stock,
    ROUND(SUM(Stock_Value), 2) AS total_stock_value
FROM inventory_transactions
GROUP BY Product, Category
ORDER BY total_stock_value DESC
LIMIT 10;

-- 6. Low Stock Items (Closing Stock < 150)
SELECT 
    Product,
    Warehouse,
    Category,
    Closing_Stock,
    ROUND(Stock_Value, 2) AS Stock_Value
FROM inventory_transactions
WHERE Closing_Stock < 150
ORDER BY Closing_Stock ASC;

-- 7. Monthly Stock Movement
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Qty_Received) AS total_received,
    SUM(Qty_Issued) AS total_issued,
    ROUND(SUM(Stock_Value), 2) AS total_stock_value
FROM inventory_transactions
GROUP BY DATE_FORMAT(Date, '%Y-%m')
ORDER BY Month;

-- 8. Average Unit Cost by Category
SELECT 
    Category,
    ROUND(AVG(Unit_Cost), 2) AS average_unit_cost
FROM inventory_transactions
GROUP BY Category
ORDER BY average_unit_cost DESC;
