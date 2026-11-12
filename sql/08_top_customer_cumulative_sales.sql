-- =====================================================================
-- 08. Cumulative Sales Amount of the Top Customer
-- Question : Who is the highest-spending customer, and how does their
--            spending accumulate across transactions?
-- Insight  : Customer ID 94800 is the top spender. Their cumulative
--            amount reaches 134,409.83 at Sales ID 6682304.
--
-- Note     : This query uses price * Quantity WITHOUT the discount,
--            unlike queries 01-03 and 06, which use revenue after
--            discount. A possible improvement is to use
--            price * Quantity * (1 - Discount) for consistency.
-- =====================================================================

WITH customer_totals AS (
  SELECT
    CustomerID,
    ROUND(SUM(price * Quantity)) AS total_spent
  FROM `fsda-sql-01.grocery_dataset.sales` AS s
  JOIN `fsda-sql-01.grocery_dataset.products` AS p
    ON s.ProductID = p.productid
  WHERE CustomerID IS NOT NULL
  GROUP BY CustomerID
  ORDER BY total_spent DESC
  LIMIT 1
)

SELECT
  s.CustomerID,
  s.SalesID,
  total_spent,
  SUM(price * Quantity) OVER (PARTITION BY s.CustomerID ORDER BY s.SalesID ASC) AS cumulative_sales_amount
FROM `fsda-sql-01.grocery_dataset.sales` AS s
JOIN customer_totals AS ct
  ON s.CustomerID = ct.CustomerID
JOIN `fsda-sql-01.grocery_dataset.products` AS p
  ON p.productid = s.ProductID
ORDER BY cumulative_sales_amount DESC;
