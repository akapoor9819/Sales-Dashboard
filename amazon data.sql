SELECT * FROM amazon;

SELECT COUNT(*) FROM amazon;

-------------1 Total and Average Sles according to Discounted Price---------------------------
SELECT
	COUNT(DISTINCT product_id) AS total_products,
	SUM(discounted_price) AS total_sales,
	AVG(discounted_price) AS average_sale_price
FROM amazon;


-- -------------------------2 Category wise Sales Summary-------------------------------------
SELECT
	category,
	COUNT(DISTINCT product_id) AS products_count,
	SUM(discounted_price) AS category_sales,
	AVG(discount_percentage) AS average_sales_price
FROM amazon
GROUP BY category
ORDER BY category_sales DESC;


-- -------------------3 Product wise Average Rating and Rating Count--------------------------
SELECT
	product_id,
	product_name,
	AVG(rating) AS average_rating,
	SUM(rating_count) AS total_ratings
FROM amazon
GROUP BY product_id, product_name
ORDER BY average_rating DESC;


-- ------------------4 Top Rated and Top Selling Products(Discounted Price)-------------------
SELECT
	product_id,
	product_name,
	SUM(discounted_price) AS total_sales,
	AVG(rating) AS average_rating
FROM amazon
GROUP BY product_id, product_name
ORDER BY total_sales, average_rating DESC
LIMIT 10;


-- ---------------------5 Review Details (Review Count per Product)---------------------------
SELECT
	product_id,
	product_name,
	COUNT(review_id) AS total_reviews,
	AVG(rating) AS average_rating
FROM amazon
GROUP BY product_id, product_name
ORDER BY total_reviews DESC;


-- -------------------------------6 View for Dashborad---------------------------------------
CREATE OR REPLACE VIEW product_summary_view AS
SELECT
	product_id,
	product_name,
	category,
	SUM(discounted_price) AS total_sales,
	AVG(discount_percentage) AS average_discount,
	AVG(rating) AS average_rating,
	SUM(rating_count) AS total_rating,
	COUNT(review_id) AS total_reviews
FROM amazon
GROUP BY product_id, product_name, category;