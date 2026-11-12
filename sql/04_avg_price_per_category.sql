-- =====================================================================
-- 04. Average Price per Category
-- Question : Which category has the highest average product price?
-- Insight  : Grain has the highest average price,
--            Shell fish has the lowest.
-- =====================================================================

SELECT
  cat.categoryname,
  AVG(p.price) AS avg_price
FROM `fsda-sql-01.grocery_dataset.sales` AS s
JOIN `fsda-sql-01.grocery_dataset.products` AS p
  ON s.ProductID = p.productid
JOIN `fsda-sql-01.grocery_dataset.categories` AS cat
  ON p.categoryid = cat.categoryid
GROUP BY cat.categoryname
ORDER BY avg_price DESC;
