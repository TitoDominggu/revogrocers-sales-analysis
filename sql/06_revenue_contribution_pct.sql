-- =====================================================================
-- 06. Revenue Contribution (%) per Category
-- Question : How much does each category contribute to total revenue?
-- Insight  : Confections contributes the most (12.87%),
--            Shell fish contributes the least (6.92%).
-- =====================================================================

WITH category_revenue AS (
  SELECT
    cat.categoryname,
    ROUND(SUM(s.Quantity * p.price * (1 - s.Discount)), 2) AS total_revenue
  FROM `fsda-sql-01.grocery_dataset.sales` AS s
  JOIN `fsda-sql-01.grocery_dataset.products` AS p
    ON s.ProductID = p.productid
  JOIN `fsda-sql-01.grocery_dataset.categories` AS cat
    ON p.categoryid = cat.categoryid
  GROUP BY cat.categoryname
)

SELECT
  categoryname,
  ROUND(total_revenue, 2) AS total_revenue,
  ROUND((total_revenue / SUM(total_revenue) OVER ()) * 100, 2) AS percentage
FROM category_revenue
ORDER BY percentage DESC;
