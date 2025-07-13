/*Sql Retail Sales Analysis*/

create database sql_project_1;
use sql_project_1;

truncate table  Retail_Sales_Analysis;

create table Retail_Sales_Analysis(
        transactions_id	int primary key,
        sale_date date,
        sale_time time,
        customer_id int,
        gender varchar(15),
        age	int,
        category varchar(15),
        quantiy int,
        price_per_unit	float,
        cogs float,
        total_sale float
);

drop table Retail_Sales_Analysis ;

select * from Retail_Sales_Analysis;

select * from Retail_Sales_Analysis
where
    transactions_id is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender	is null 
    or 
    age is null
    or
    category is null
    or
    quantiy	is null
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

-- Data analysis and Business key Problems

# 1.Write a sql query to retrieve all columns for sales made on '2022-11-05'

select * from Retail_Sales_Analysis
where sale_date='2022-11-05';

# 2.Write a SQL Query to retrieve all transactions where the category is 'Clothing ' and the quantity sold is more than 4 in the month of Nov-2022

select * from Retail_Sales_Analysis
where 
category="Clothing"
and
quantiy>=3
and 
date_format(Sale_date,'%Y-%m')='2022-11'
order by transactions_id asc;

#3. Write a SQL Query to calculate the total sales for each category

select category ,sum(total_sale) as total_sale,count(customer_id) as total_orders
from Retail_Sales_Analysis
group by category;


#4. Write a SQL Query to find the average age of customers who purchased items from the 'Beauty' Categoryselect 

Select Round(avg(age), 2) as Average_age from Retail_Sales_Analysis
where category='Beauty';

#5. Write a SQL query to find all the transactions where the total_sale is greater than 1000
select * from Retail_Sales_Analysis
where total_sale >1000;

#6. write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category
select category, gender,count(transactions_id) as no_of_transaction from Retail_Sales_Analysis
group by
	category,
	gender
order by 1;

#7. Write a query to calculate the average sale for each month.find out best selling month for each year

select 
    Year(Sale_date),
    Month(sale_date),
    round(avg(total_sale),2) as average_sale,
    rank() over(partition by year(sale_date) order by avg(total_sale) desc) 
from Retail_Sales_Analysis
group by 1,2;
;

# 8. Write a SQL Query to find out the top 5 customers based on the highest total sale;

Select customer_id,sum(total_sale) as Total_purchase
from Retail_Sales_Analysis
group by customer_id
order by Total_purchase desc
limit 5;

#9. Write a SQL Query to find the number of unique customers who purchased the items from each category

Select category,count(distinct customer_id)
from Retail_Sales_Analysis
group by category;


#10. Write the SQL Query to find the customers who have purchased items from each category

select customer_id from Retail_Sales_Analysis
group by customer_id
having count(distinct category)=(
	select count(distinct category) from Retail_Sales_Analysis
);

#11. write a SQL Query to create each shift and number of orders(Example Morning <=12,Afternoon between 12 and 17,Evening >17

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
    
Select * from Retail_sales_Analysis;

