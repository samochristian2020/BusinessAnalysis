% -----------------------------------QUERY 3---------------------------------------------
% ---------------------------------------------------------------------------------------

WITH t1 AS (SELECT country, genre_name, 
            MAX(purchases) OVER(PARTITION BY country) - purchases test, 
			MAX(purchases) OVER(PARTITION BY country) maxx
            FROM  (SELECT Invoice.BillingCountry country, 
			              Genre.Name genre_name, 
						  SUM(InvoiceLine.Quantity) purchases
                   FROM Invoice
                   JOIN InvoiceLine
                   ON Invoice.InvoiceId = InvoiceLine.InvoiceId
                   JOIN Track
                   ON InvoiceLine.TrackId = Track.TrackId
                   JOIN Genre
                   ON Track.GenreId = Genre.GenreId
                   GROUP BY 1,2 ) sub1
		  )
SELECT country, 
       genre_name, 
	   maxx
FROM t1
WHERE t1.test=0	  
