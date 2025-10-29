create database sale;
use sale;
select * from `retail sales`;
select database();
show tables;
Describe `retail sales`;
select sale_date from `retail sales`limit 10;
select sale_date,
     str_to_date(sale_date,'%d/%m/%Y') as sales_date
     from `retail sales`
       limit 10;
       alter table `retail sales`
        add column Sales_date DATE;
        update `retail sales`
        set Sales_date=str_to_date(sale_date,'%d/%m/%Y');
        set sql_safe_updates=0;
        alter table `retail sales`
          drop column sale_date;
          alter table `retail sales`
           change Sales_date sale_date DATE;
           alter table `retail sales`
           modify column sale_date DATE after transactions_id;
           select * from `retail sales`;
select str_to_date(sale_time,'%H:%i:%s') as new_time
 from `retail sales`;
   alter table `retail sales`
   add column new_time TIME;
   update `retail sales`
   set new_time=str_to_date(sale_time,'%H:%i:%s');
   describe `retail sales`;
   alter table `retail sales`
   drop column sale_time;
   alter table `retail sales`
   change new_time sale_time Time;
   alter table `retail sales`
   modify column sale_time time after sale_date;
   select * from `retail sales`;
   describe `retail sales` ;
select count(*) as total_rows,
  count(transactions_id) as transactions_id_non_null,
  count(sale_date) as sale_date_non_null,
  count(sale_time) as sale_time_non_null,
  count(customer_id) as customer_id_non_null,
  count(gender) as gender_non_null,
  count(age) as age_non_null,
  count(category) as category_non_null,
  count(quantiy) as quantity_non_null,
  count(price_per_unit) as price_per_unit_non_null,
  count(cogs) as cogs_non_null,
  count(price_per_unit) as price_per_unit_non_null
  from `retail sales`;
  alter table `retail sales`
  rename column quantiy to quantity;
  describe `retail sales`;
  select
     sum(case when gender=''then 1 else 0 end ) as gender_empty
     from `retail sales`;
     select * from `retail sales`
      where sale_date is null;
      select sale_date
      from `retail sales`where sale_date not between '1900-01-01'and '2100-12-31';
      SELECT *
FROM `retail sales`
WHERE sale_date = '2022-11-05'; -- to retreive sales made on 2022-11-05
/* retrieve all transactions where the category
is 'Clothing' and the quantity sold is more than 4 in the month of
Nov-2022*/
select * from `retail sales`
where category = 'clothing' and quantity > 4 
and sale_date between '2022-11-01' AND '2022-11-30';

SELECT *
FROM `retail sales`
WHERE sale_date BETWEEN '2022-11-01' AND '2022-11-30';
select * from `retail sales`
where quantity>4;
/* to calculate the total sales (total_sale) for
each category*/

SELECT category,
       SUM(total_sale) AS total
FROM `retail sales`
GROUP BY category;
/* to find the average age of customers who
purchased items from the 'Beauty' category */
select avg(age) from `retail sales`
where category='Beauty';
/*to find all transactions where the total_sale is
greater than 1000*/
select * from `retail sales`
where total_sale >1000;
/* Write a SQL query to find the total number of transactions
(transaction_id) made by each gender in each category*/
select 
    gender,category,count(transactions_id) as gender_count
    from `retail sales`
    group by gender,category
    order by gender,category;
  -- to calculate the average sale for each month
  
    SELECT 
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(total_sale) AS average_sale
FROM `retail sales`
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sale_year, sale_month;
/* to calculate the average sale for each month and 
Find out best-selling month in each year*/
SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    COUNT(transactions_id) AS total_sales
FROM `retail sales`
GROUP BY YEAR(sale_date), MONTH(sale_date);

SELECT 
    year,
    month,
    total_sales,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY total_sales DESC) AS rn
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        COUNT(transactions_id) AS total_sales
    FROM `retail sales`
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) t;
SELECT year, month, total_sales
FROM (
    SELECT 
        year,
        month,
        total_sales,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY total_sales DESC) AS rn
    FROM (
        SELECT
            YEAR(sale_date) AS year,
            MONTH(sale_date) AS month,
            COUNT(transactions_id) AS total_sales
        FROM `retail sales`
        GROUP BY YEAR(sale_date), MONTH(sale_date)
    ) t
) ranked
WHERE rn = 1
ORDER BY year;
-- To extract month name from sale date
ALTER TABLE `retail sales`
ADD COLUMN month_name VARCHAR(20);

UPDATE `retail sales`
SET month_name = MONTHNAME(sale_date);
      select * from `retail sales`;
      alter table `retail sales`
      modify column month_name Varchar(20) after sale_date;
      select Year(sale_date) as year
      from `retail sales`;
      alter table `retail sales`
add column year int
after month_name;

update `retail sales`
set year=year(sale_date);
      
      -- to find the top 5 customers based on the highest total sales.
      
      select customer_id,
       sum(total_sale) as Total
       from `retail sales`
       group by customer_id
       order by Total desc
       limit 5;

/* to find the number of unique customers who purchased
items from each category*/
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM `retail sales`
GROUP BY category
-- to create each shift and number of orders 
SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS number_of_orders
FROM `retail sales`
GROUP BY shift
ORDER BY number_of_orders DESC;

select * from `retail sales`;

