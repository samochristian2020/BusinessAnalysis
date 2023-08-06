% -----------------------------------QUERY 1---------------------------------------------
% ---------------------------------------------------------------------------------------
SELECT Customer.CustomerId, 
       Customer.FirstName, 
       Customer.LastName, 
       Artist.Name Artist_name, 
       InvoiceLine.UnitPrice * SUM(InvoiceLine.Quantity)
FROM Artist
JOIN Album
ON Artist.ArtistId = Album.ArtistId
JOIN Track
ON Track.AlbumId = Album.AlbumId
JOIN InvoiceLine
ON Track.TrackId=InvoiceLine.TrackId
JOIN Invoice
ON Invoice.InvoiceId =InvoiceLine.InvoiceId
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
WHERE Artist.Name IN(SELECT A_name 
                     FROM (SELECT Artist.ArtistId, 
			          Artist.Name A_name, 
				  InvoiceLine.UnitPrice * SUM(InvoiceLine.Quantity) as earned
                           FROM Artist
                           JOIN Album
                           ON Artist.ArtistId = Album.ArtistId
                           JOIN Track
                           ON Track.AlbumId = Album.AlbumId
                           JOIN InvoiceLine
                           ON Track.TrackId=InvoiceLine.TrackId
                           JOIN Invoice
                           ON Invoice.InvoiceId =InvoiceLine.InvoiceId
                           GROUP BY 1,2
                           ORDER BY 3 DESC
                           LIMIT 1) sub1
					  )
GROUP BY 1
ORDER BY 5 DESC

