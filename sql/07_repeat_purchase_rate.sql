-- =====================================================================
-- 07. Repeat Purchase Rate per Category
-- Question : Which category has the highest share of customers who
--            buy more than once?
-- Insight  : Confections has the highest repeat purchase rate (99.85%,
--            98,598 repeat customers). Grain has the lowest
--            (93.68%, 91,184 repeat customers).
-- =====================================================================

WITH customer_category_orders AS (
  SELECT
    s.CustomerID,
    cat.categoryname,
    COUNT(DISTINCT s.SalesID) AS order_count
  FROM `fsda-sql-01.grocery_dataset.sales` AS s
  JOIN `fsda-sql-01.grocery_dataset.products` AS p
    ON s.ProductID = p.productid
  JOIN `fsda-sql-01.grocery_dataset.categories` AS cat
    ON p.categoryid = cat.categoryid
  WHERE s.CustomerID IS NOT NULL
  GROUP BY s.CustomerID, cat.categoryname
)

SELECT
  categoryname,
  COUNT(DISTINCT CustomerID) AS total_customers,
  COUNT(DISTINCT CASE WHEN order_count > 1 THEN CustomerID END) AS repeat_customers,
  ROUND(
    COUNT(DISTINCT CASE WHEN order_count > 1 THEN CustomerID END) * 100.0 /
    COUNT(DISTINCT CustomerID),
    2
  ) AS repeat_purchase_rate
FROM customer_category_orders
GROUP BY categoryname
ORDER BY repeat_purchase_rate DESC;
