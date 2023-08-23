-- Katherine Cinnamon
-- Dataset: Spotify Top 10000 Streamed Songs
-- Source: https://www.kaggle.com/datasets/rakkesharv/spotify-top-10000-streamed-songs?resource=download
-- this data was last updated 11/12/22


-- Update the Spotify dataset to remove unwanted characters from a column 
-- changed Peak_Position_xTimes format from "(x20)" to "20" 
UPDATE dbo.Spotify_dataset
SET Peak_Position_xTimes = SUBSTRING(Peak_Position_xTimes, 3, LEN(Peak_Position_xTimes) - 3)
WHERE Peak_Position_xTimes LIKE '(x%)';

-- Updated columns from varchar to int for easier usability
ALTER TABLE dbo.Spotify_dataset ALTER COLUMN Total_Streams int;

ALTER TABLE dbo.Spotify_dataset ALTER COLUMN Peak_Position_xTimes int; 


--Top 20 most streamed artists only using songs in the top 2500

SELECT TOP 20 WITH TIES
	Artist_Name,
	SUM(CAST(Total_Streams AS bigint)) AS sum_streams
FROM (
	SELECT TOP 2500
			Artist_Name,
			Total_Streams
	FROM dbo.Spotify_dataset
	ORDER BY Total_Streams DESC
	) top_2500_songs
GROUP BY Artist_Name
ORDER BY sum_streams DESC

-- Which songs had a peak position of 1 over 50 times

SELECT 
	Song_Name,
	Peak_Position,
	Peak_Position_xTimes
FROM dbo.Spotify_dataset
WHERE Peak_Position_xTimes > 50
	AND Peak_Position = 1

-- What are the top 10 songs for most amount of times with a peak position of 1

SELECT TOP 10 WITH TIES
	Song_Name,
	Artist_Name,
	Peak_Position,
	Peak_Position_xTimes
FROM dbo.Spotify_dataset
WHERE Peak_Position = 1
ORDER BY Peak_Position_xTimes DESC

-- Which 5 artists had the highest total of 1st peak position times for all their songs

SELECT TOP 5 WITH TIES 
	Artist_Name,
	SUM(Peak_Position_xTimes) as peak_total
FROM dbo.Spotify_dataset
WHERE Peak_Position = 1
GROUP BY Artist_Name
ORDER BY peak_total DESC

-- Which 10 artists had the lowest average peak_position with more than 10 songs 

SELECT TOP 10 WITH TIES
	Artist_Name,
	AVG(Peak_Position) AS avg_peak
FROM dbo.Spotify_dataset
GROUP BY Artist_Name
HAVING COUNT(*) > 10
ORDER BY avg_peak ASC
