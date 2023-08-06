% -----------------------------------QUERY 4---------------------------------------------
% ---------------------------------------------------------------------------------------

WITH sub2 AS (SELECT customer_id, 
                     f_name, 
	             l_name, 
	             country, 
	             MAX(amt_spent) OVER (PARTITION BY country) - amt_spent test,
		     amt_spent
            FROM (SELECT Customer.CustomerId customer_id, 
                         Customer.FirstName f_name, 
		         Customer.LastName l_name, 
		         Invoice.BillingCountry country, 
		         SUM(Invoice.Total) amt_spent
                  FROM Customer
                  JOIN Invoice
                  ON Customer.CustomerId=  Invoice.CustomerId
                  GROUP BY 1,4) sub1
				  )
SELECT customer_id, 
       f_name, 
       l_name, 
       country,
       amt_spent
FROM sub2
WHERE sub2.test<0.00000000001
