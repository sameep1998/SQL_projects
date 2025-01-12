/*create database*/
create database retail_sales;

/*create table*/
CREATE TABLE retail_sales (
  transaction_id int,
  sale_date date,
  sale_time time,
  customer_id int,
  gender varchar(15) ,
  age int,
  category varchar(15),
  quantity varchar(10),
  price_per_unit varchar(10),
  cogs varchar(10),
  total_sale varchar(10));




/*handling null values*/
select * from retail_sales
where 
transaction_id is null or sale_date is null
or sale_time is null or customer_id is null
or gender is null or age is null or 
category is null or quantity is null or 
price_per_unit is null or cogs is null or total_sale ='';



delete from retail_sales
where 
transaction_id is null or sale_date is null
or sale_time is null or customer_id is null
or gender is null or age is null or 
category is null or quantity is null or 
price_per_unit is null or cogs is null or total_sale =;


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales where category='Clothing' and quantity>=4 and sale_date like '2022-11%';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,sum(total_sale) as sales from retail_sales
group by 1 order by 1 desc;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2)as average_age from retail_sales where category='Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,count(transaction_id)as total_transaction_number from retail_sales
group by 1,2 order by 1,2;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

select year,month from(
select year(sale_date) as year,monthname(sale_date)as month,round(avg(total_sale),2)as average_sale,
rank() over(partition by year(sale_date) order by round(avg(total_sale),2) desc) as rn   from retail_sales
group by 1,2 )a
where a.rn=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,sum(total_sale)as sale from retail_sales
group by 1 order by 2 desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id) as unique_cust from retail_sales
group by 1 order by 2 desc;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select shift,count(transaction_id) as orders From(
select *,case when left(sale_time,2) <12 then 'Morning'
when left(sale_time,2) between 12 and 17 then 'Afternoon'
else 'Evening' end as shift from retail_sales)a
group by 1;

