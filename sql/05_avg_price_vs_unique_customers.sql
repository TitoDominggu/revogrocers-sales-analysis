-- =====================================================================
-- 05. Average Price vs Unique Customers per Category
-- Question : Does a higher average price attract fewer (or more)
--            customers?
-- Insight  : A high average price does not guarantee many customers.
--            Grain has the highest average price, but its unique
--            customers are lower than several other categories.
-- =====================================================================

SELECT
  cat.categoryname AS CategoryName,
  AVG(p.price) AS avg_unit_categories,
  COUNT(DISTINCT s.CustomerID) AS total_unique_customers
FROM `fsda-sql-01.grocery_dataset.sales` AS s
JOIN `fsda-sql-01.grocery_dataset.products` AS p
  ON s.ProductID = p.productid
JOIN `fsda-sql-01.grocery_dataset.categories` AS cat
  ON cat.categoryid = p.categoryid
GROUP BY CategoryName;
