-- =====================================================================
-- 01. Total Revenue per Category
-- Question : Which product category generates the most revenue
--            (after discount)?
-- Insight  : Confections has the highest total revenue,
--            Shell fish has the lowest.
-- =====================================================================

SELECT
  cat.categoryname,
  ROUND(SUM(s.Quantity * p.price * (1 - s.Discount)), 2) AS total_revenue
FROM `fsda-sql-01.grocery_dataset.sales` AS s
JOIN `fsda-sql-01.grocery_dataset.products` AS p
  ON s.ProductID = p.productid
JOIN `fsda-sql-01.grocery_dataset.categories` AS cat
  ON p.categoryid = cat.categoryid
GROUP BY cat.categoryname
ORDER BY 2 DESC;
