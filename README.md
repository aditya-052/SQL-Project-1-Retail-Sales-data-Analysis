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
        sale_date date,
        sale_time time,
        customer_id int,
        gender varchar(15),
        age int,
        category varchar(15),
        quantiy	int,
        price_per_unit float,
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
    transactions_id is null
    or
    sale_time is null
    or
    customer_id	is null
    or
    gender is null 
    or 
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null 
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

### 3. Data analysis and Findings

1. **Write a sql query to retrieve all columns for sales made on particular date
```sql
select * from Retail_Sales_Analysis
where sale_date='2022-11-05';
```

2. **Write a SQL Query to retrieve all transactions where the category is 'Clothing ' and the quantity sold is more than 4 in the month of Nov-2022
```sql
select * from Retail_Sales_Analysis
where 
category="Clothing"
and
quantiy>=3
and 
date_format(Sale_date,'%Y-%m')='2022-11'
order by transactions_id asc;
```

3.** Write a SQL Query to calculate the total sales for each category
```sql
select category ,sum(total_sale) as total_sale,count(customer_id) as total_orders
from Retail_Sales_Analysis
group by category;
```

4. ** Write a SQL Query to find the average age of customers who purchased items from the 'Beauty' Categoryselect 
```sql
Select Round(avg(age), 2) as Average_age from Retail_Sales_Analysis
where category='Beauty';
```

5. **Write a SQL query to find all the transactions where the total_sale is greater than 1000
```sql
select * from Retail_Sales_Analysis
where total_sale >1000;
```

6. **write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category
```sql
select category, gender,count(transactions_id) as no_of_transaction from Retail_Sales_Analysis
group by
	category,gender
order by 1;
```

7.** Write a query to calculate the average sale for each month.find out best selling month for each year
```sql
select 
	Year(Sale_date),
    Month(sale_date),
    round(avg(total_sale),2) as average_sale,
    rank() over(partition by year(sale_date) order by avg(total_sale) desc) 
from Retail_Sales_Analysis
group by 1,2;
```

 8.** Write a SQL Query to find out the top 5 customers based on the highest total sale;
```sql
Select customer_id,sum(total_sale) as Total_purchase
from Retail_Sales_Analysis
group by customer_id
order by Total_purchase desc
limit 5;
```

9.** Write a SQL Query to find the number of unique customers who purchased the items from each category
```sql
Select category,count(distinct customer_id)
from Retail_Sales_Analysis
group by category;
```

10. **Write the SQL Query to find the customers who have purchased items from each category
```sql
select customer_id from Retail_Sales_Analysis
group by customer_id
having count(distinct category)=(
	select count(distinct category) from Retail_Sales_Analysis
);
```

11. **write a SQL Query to create each shift and number of orders(Example Morning <=12,Afternoon between 12 and 17,Evening >17
```sql
with Shift_wise_sale
as (
		Select *,
		CASE 	
			when hour(sale_time) <12 then 'Morning'
			when hour(sale_time) between 12 and 17 then 'AfterNoon'
			else 'Evening'
			end
			as Shift
			from Retail_Sales_Analysis
    )
Select shift, count(*) as total_orders
    from Shift_wise_sale
    group by shift;
  ```

