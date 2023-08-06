% -----------------------------------QUERY 2---------------------------------------------
% ---------------------------------------------------------------------------------------

SELECT Artist.ArtistId, 
       Artist.Name, 
       Genre.Name, 
       COUNT(Track.TrackId)
FROM Artist
JOIN Album
ON Artist.ArtistId = Album.ArtistId
JOIN Track
ON Track.AlbumId = Album.AlbumId
JOIN Genre
ON Track.GenreId=Genre.GenreId
WHERE Genre.Name = 'Rock'
GROUP BY 1,2
ORDER BY 4 DESC
LIMIT 10
