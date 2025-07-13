# SQL-Project-1-Retail-Sales-data-Analysis
 
##Retail Sales data Analysis

Database:  sql_project_p1

##Objectives
1.**Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
2.**Data Cleaning: Identify and remove any records with missing or null values.
3.**Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4.**Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

##Project Structure
###1. Database Setup

** Database Creation: The project starts by creating a database named Database:  sql_project_p1.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database sql_project_1;
use sql_project_1;

truncate table  Retail_Sales_Analysis;

create table Retail_Sales_Analysis(
		transactions_id	int primary key,
        sale_date	date,
        sale_time	time,
        customer_id	int,
        gender	varchar(15),
        age	int,
        category varchar(15),
        quantiy	int,
        price_per_unit	float,
        cogs float,
        total_sale float
);

```

###2. Data Exploration & Cleaning
- **Record Count: Determine the total number of records in the dataset.
- **Customer Count: Find out how many unique customers are in the dataset.
- **Category Count: Identify all unique product categories in the dataset.
- **Null Value Check: Check for any null values in the dataset and delete records with missing data.

```sql
  select * from Retail_Sales_Analysis;

select * from Retail_Sales_Analysis
where
	transactions_id	is null
    or
	sale_time is null
    or
	customer_id	is null
    or
    gender	is null 
    or 
    age is null
    or
	category is null
    or
	quantiy	is null
    or
    price_per_unit	is null 
    or 
    cogs is null
    or
	total_sale is null;
    
    #Data Exploration
    
-- Total no of Sales or customers
select count(Transactions_id) as Total_Transactions, count(customer_id) as Total_customers  from Retail_Sales_Analysis;

-- Total no of unique customers
select count(distinct customer_id) as Total_Unique_Customers from Retail_Sales_Analysis;

-- How much categories
select Category,count(category) as No_of_Transaction from Retail_Sales_Analysis
group by Category;

-- Transactions By Gender
select gender,count(gender) from Retail_Sales_Analysis
group by gender;

  ```

