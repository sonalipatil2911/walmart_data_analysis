-- Business Problems

-- Find different payment methods and number of transactions, number of quantity sold
SELECT 	payment_method,
		COUNT(*) AS total_transactions,
		SUM(quantity) AS total_items_sold
FROM walmart
GROUP BY 1;

-- Identify the highest-rated category in each branch, displaying branch, category, average rating
SELECT 	branch,
		category,
		avg_rating
FROM(
		SELECT 	branch,
				category,
				AVG(rating) AS avg_rating,
				RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank_n
		FROM walmart
		GROUP BY 1,2
)
WHERE rank_n = 1


-- Identify busiest day for each branch based on number of transactions.

SELECT 	branch,
		dayy,
		total_transactions
FROM(
		SELECT 	branch,
				TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') AS busiest_day,
				COUNT(*) AS total_transactions,
				RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank_n
		FROM walmart
		GROUP BY 1,2
)
WHERE rank_n = 1


-- Calculate the total quantity of items sold per payment method. List payment method and total quantity
SELECT 	payment_method,
		SUM(quantity) AS items_sold
FROM walmart
GROUP BY 1;


-- Determine the average, maximum, minimum rating of category for each city.
-- 

SELECT 	city,
		category,
		AVG(rating) AS avg_rating,
		MIN(rating) AS min_rating,
		MAX(rating) AS max_rating
FROM walmart
GROUP BY 1, 2;


-- Calculate the total profit for each category by considering total profit as
-- (unit_price * quantity * profit_margin).
-- List category and total_profit ordered from high to low profit
-- we have column total which is (unit_price * quantity)

SELECT 	category,
		SUM(total * profit_margin) AS total_profit
FROM walmart
GROUP BY 1
ORDER BY 2 DESC;


-- Determine the most common payment method for each Branch.
-- Display Branch and the preferred_payment_method
SELECT 	branch,
		payment_method as preferred_payment_method
FROM(
	SELECT 	branch,
			payment_method,
			COUNT(payment_method) AS preferred_payment_method,
			RANK() OVER(PARTITION BY branch ORDER BY COUNT(payment_method) DESC) AS rank_n
	FROM walmart
	GROUP BY 1, 2
)
WHERE rank_n = 1;


-- Categorize sales into 3 groups MORNING, AFTERNOON, EVENING
-- Find out which of the shift and number of invoices
SELECT branch,
		CASE
			WHEN extract(HOUR FROM time::TIME)<=12 THEN 'MORNING'
			WHEN extract(HOUR FROM time::TIME)<=17 THEN 'AFTERNOON'
		ELSE 'EVENING'
		END AS shifts,
		COUNT(invoice_id) AS total_invoices
FROM walmart
GROUP BY 1,2
ORDER BY 1, 3 DESC;



-- Identify 5 branches with highest decrease ratio in revenue compared to last year 
-- (current year 2023 and last year 2022)
-- rdr = last_rev - cur_rev/last_rev * 100

SELECT 	*,
		EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) AS formatted_date
FROM walmart

-- 2022 sales
WITH cte_revenue_2022 AS
(
	SELECT 	branch,
			SUM(total) AS revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
	GROUP BY 1
),
cte_revenue_2023 AS
(

	SELECT 	branch,
			SUM(total) AS revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	GROUP BY 1
)
SELECT 	ls.branch,
		ls.revenue AS last_year_revenue,
		cur.revenue AS current_year_revenue,
		ROUND(((ls.revenue - cur.revenue)::numeric/ls.revenue::numeric * 100), 2) AS revenue_ratio
FROM cte_revenue_2022 AS ls
JOIN
	cte_revenue_2023 AS cur
ON ls.branch = cur.branch
WHERE ls.revenue > cur.revenue
ORDER BY 4 DESC
LIMIT 5;
