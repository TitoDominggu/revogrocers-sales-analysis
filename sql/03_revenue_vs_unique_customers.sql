-- =====================================================================
-- 03. Total Revenue vs Unique Customers per Category
-- Question : Do categories with higher revenue also have more
--            unique customers?
-- Insight  : Confections has the highest revenue and the most unique
--            customers. However, Shell fish (lowest revenue) has more
--            unique customers than Grain, which has higher revenue.
-- =====================================================================

SELECT
  cat.categoryname,
  ROUND(SUM(s.Quantity * p.price * (1 - s.Discount)), 2) AS total_revenue,
  COUNT(DISTINCT CustomerID) AS unique_customer
FROM `fsda-sql-01.grocery_dataset.sales` AS s
JOIN `fsda-sql-01.grocery_dataset.products` AS p
  ON s.ProductID = p.productid
JOIN `fsda-sql-01.grocery_dataset.categories` AS cat
  ON p.categoryid = cat.categoryid
GROUP BY cat.categoryname
ORDER BY total_revenue DESC;
