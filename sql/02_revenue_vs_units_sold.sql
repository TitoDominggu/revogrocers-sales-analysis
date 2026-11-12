-- =====================================================================
-- 02. Total Revenue vs Total Units Sold per Category
-- Question : Do categories with higher revenue also sell more units?
-- Insight  : Confections leads in both revenue and units sold, but the
--            relationship is not always linear. Grain has the
--            2nd-lowest revenue yet the lowest units sold.
-- =====================================================================

SELECT
  cat.categoryname,
  ROUND(SUM(s.Quantity * p.price * (1 - s.Discount)), 2) AS total_revenue,
  SUM(s.Quantity) AS total_unit_sold
FROM `fsda-sql-01.grocery_dataset.sales` AS s
JOIN `fsda-sql-01.grocery_dataset.products` AS p
  ON s.ProductID = p.productid
JOIN `fsda-sql-01.grocery_dataset.categories` AS cat
  ON p.categoryid = cat.categoryid
GROUP BY cat.categoryname
ORDER BY total_revenue, total_unit_sold DESC;
