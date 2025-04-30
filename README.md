# Sales-Analysis-My-SQL

## Problem Statement

This project analyzes the sales performance of a retail company across regions, products, sales teams, and customer segments. The aim is to help the company identify its top-performing areas and improvement opportunities using structured SQL analysis.

The primary goal is to extract business insights such as total profit, top-performing regions, key product contributions, and customer distribution using MySQL queries written from scratch.

### Software Used

MySQL Workbench – to write and run SQL queries

Microsoft Excel – to explore and review datasets

### Steps Followed

#### Step 1: Received and Reviewed Datasets

_Six datasets were provided in CSV format_

customer_usa

product_usa

region_usa

sales_order_usa

sales_team_usa

store_sales_usa


#### Step 2: Planned Table Structures

Analyzed the columns and decided which would be primary and foreign keys.

Mapped relationships between tables like CustomerID, ProductID, SalesTeamID, StoreID.


#### Step 3: Manually Created Tables

Each table was created manually using SQL CREATE TABLE statements with appropriate data types like INT, VARCHAR, DECIMAL, and DATE.

#### Step 4: Imported Data into Tables

Used MySQL Workbench's Table Data Import Wizard.

Choose "Use existing table and truncate" to preserve table structure.

Verified data import with SELECT * FROM table_name LIMIT 5;.


#### Step 5: Encountered and Resolved Errors

Error: Unknown column 'c.State'

Tried joining customer_usa with region_usa using a missing column.

Fix: Used sales_order_usa → sales_team_usa → region to count customers by region.


Error: Unknown column 'st.TeamName'

Mistook Sales Team (with space) for TeamName.

Fix: Used backticks for space: st.\Sales Team``.


Error: No data appearing after import

Table appeared in schema, but the data was missing.

Fix: Verified data presence using SELECT queries after each import.


#### Step 6: Wrote SQL Queries

Developed 10+ queries to analyze business performance:

Total profit calculation

Total quantity sold

Customer count

Profit by region

Product contribution per region

Profit per sales channel

Average regional profit

Top customers by revenue

Customer distribution

Sales team performance

### Insights from SQL Queries

#### Total Profit:

Profit = (Order Quantity × Unit Price) − (Order Quantity × UnitCost) − Discount Applied

#### Total Quantity Sold:

All quantities summed from sales_order_usa.

#### Customer Count:

Unique customer IDs identified from sales orders.

#### Profit by Region:

Joined sales_team_usa to extract regional profitability.

#### Top Products by Profit in Each Region:

Multi-table joins with product_usa, sales_order_usa, and sales_team_usa.

#### Sales Channel Profit Analysis:

Grouped by SalesChannel in sales_order_usa.

#### Average Profit by Region:

Used AVG() on profit formula grouped by region.

#### Top 10 Customers by Revenue:

Grouped by customer name and ordered by SUM(Order Quantity × Unit Price).

#### Customer Distribution:

Linked customer sales to team region.

#### Sales Team Performance:

Ranked sales teams based on total revenue contributed.

## File Included
- [`sales_analysis_project.sql`](./sales_analysis_project.sql) – Final SQL script used for all analysis
