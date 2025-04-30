CREATE TABLE customer_usa (
    CustomerID INT PRIMARY KEY,  -- Unique identifier for each customer
    CustomerName VARCHAR(100),   -- Name of the customer
    Email VARCHAR(100),          -- Email address
    PhoneNumber VARCHAR(50),     -- Contact number
    Address VARCHAR(255),        -- Full address
    City VARCHAR(100),           -- City name
    State VARCHAR(100),          -- State
    PostalCode VARCHAR(20),      -- Postal/Zip code
    Country VARCHAR(100)         -- Country of residence
);

-- Create product table
CREATE TABLE product_usa (
    ProductID INT PRIMARY KEY,       -- Unique product identifier
    ProductName VARCHAR(100),        -- Name of the product
    Category VARCHAR(100),           -- Product category
    Brand VARCHAR(100),              -- Brand of the product
    UnitPrice DECIMAL(10,2),         -- Selling price per unit
    UnitCost DECIMAL(10,2)           -- Cost to company per unit
);

-- Create region table
CREATE TABLE region_usa (
    StateCode VARCHAR(10) PRIMARY KEY,  -- Short state code
    State VARCHAR(100),                 -- Full state name
    Region VARCHAR(100)                 -- Region classification
);

-- Create sales order table
CREATE TABLE sales_order_usa (
    OrderNumber INT PRIMARY KEY,           -- Unique order ID
    SalesChannel VARCHAR(50),              -- Online, in-store, etc.
    WarehouseCode VARCHAR(50),             -- ID of warehouse
    ProcuredDate DATE,                     -- When items were procured
    OrderDate DATE,                        -- When order was placed
    ShipDate DATE,                         -- Shipping date
    DeliveryDate DATE,                     -- Final delivery date
    CurrencyCode VARCHAR(10),              -- Currency used
    SalesTeamID INT,                       -- FK to sales_team_usa
    CustomerID INT,                        -- FK to customer_usa
    StoreID INT,                           -- FK to store_sales_usa
    ProductID INT,                         -- FK to product_usa
    OrderQuantity INT,                     -- Number of units ordered
    DiscountApplied DECIMAL(10,2),         -- Discount on the order
    UnitedPrice DECIMAL(10,2),             -- Price per unit sold
    UnitCost DECIMAL(10,2)                 -- Cost per unit
);

-- Create sales team table
CREATE TABLE sales_team_usa (
    SalesTeamID INT PRIMARY KEY,       -- Unique team ID
    TeamName VARCHAR(100),             -- Name of the sales team
    Manager VARCHAR(100),              -- Team manager
    Region VARCHAR(100)                -- Region assigned to team
);

-- Create store table
CREATE TABLE store_sales_usa (
    StoreID INT PRIMARY KEY,       -- Unique store ID
    StoreName VARCHAR(100),        -- Name of the store
    Location VARCHAR(100),         -- Store location
    State VARCHAR(100)             -- State of store
);

-- 1. Calculate Total Profit
SELECT 
    SUM((`Order Quantity` * `Unit Price`) - (`Order Quantity` * `Unit Cost`) - `Discount Applied`) AS Total_Profit
FROM sales_order_usa;

-- 2. Total Quantity Sold
SELECT 
    SUM(`Order Quantity`) AS Total_Quantity_Sold
FROM sales_order_usa;

-- 3. Count of Unique Customers
SELECT 
    COUNT(DISTINCT _CustomerID) AS Total_Customers
FROM sales_order_usa;

-- 4. Total Profit by Region
SELECT 
    st.Region, 
    SUM((so.`Order Quantity` * so.`Unit Price`) - (so.`Order Quantity` * so.`Unit Cost`) - so.`Discount Applied`) AS Total_Profit
FROM sales_order_usa so
JOIN sales_team_usa st ON so._SalesTeamID = st._SalesTeamID
GROUP BY st.Region
ORDER BY Total_Profit DESC;

-- 5. Top Products by Profit per Region
SELECT 
    st.Region,
    p.`Product Name`,
    SUM((so.`Order Quantity` * so.`Unit Price`) - (so.`Order Quantity` * so.`Unit Cost`) - so.`Discount Applied`) AS Product_Profit
FROM sales_order_usa so
JOIN product_usa p ON so._ProductID = p._ProductID
JOIN sales_team_usa st ON so._SalesTeamID = st._SalesTeamID
GROUP BY st.Region, p.`Product Name`
ORDER BY st.Region, Product_Profit DESC;

-- 6. Profit by Sales Channel
SELECT 
    `Sales Channel`,
    SUM((`Order Quantity` * `Unit Price`) - (`Order Quantity` * `Unit Cost`) - `Discount Applied`) AS Total_Profit
FROM sales_order_usa
GROUP BY `Sales Channel`
ORDER BY Total_Profit DESC;

-- 7. Average Profit Across Regions
SELECT 
    st.Region,
    AVG((so.`Order Quantity` * so.`Unit Price`) - (so.`Order Quantity` * so.`Unit Cost`) - so.`Discount Applied`) AS Average_Profit
FROM sales_order_usa so
JOIN sales_team_usa st ON so._SalesTeamID = st._SalesTeamID
GROUP BY st.Region
ORDER BY Average_Profit DESC;

-- 8. Top 10 Customers by Revenue
SELECT 
    c.`Customer Names`,
    SUM(so.`Order Quantity` * so.`Unit Price`) AS Total_Revenue
FROM sales_order_usa so
JOIN customer_usa c ON so._CustomerID = c._CustomerID
GROUP BY c.`Customer Names`
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 9. Customer Distribution by Region
SELECT 
    st.Region,
    COUNT(DISTINCT so._CustomerID) AS Customer_Count
FROM sales_order_usa so
JOIN sales_team_usa st ON so._SalesTeamID = st._SalesTeamID
GROUP BY st.Region
ORDER BY Customer_Count DESC;

-- 10. Revenue by Sales Team
SELECT 
    st.`Sales Team`,
    SUM(so.`Order Quantity` * so.`Unit Price`) AS Total_Revenue
FROM sales_order_usa so
JOIN sales_team_usa st ON so._SalesTeamID = st._SalesTeamID
GROUP BY st.`Sales Team`
ORDER BY Total_Revenue DESC;
