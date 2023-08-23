  -- Katherine Cinnamon
  -- Dataset: Top Spotify songs from 2010-2019 - BY YEAR
  -- Source: https://www.kaggle.com/datasets/leonardopena/top-spotify-songs-from-20102019-by-year
  -- *some column names were renamed for clarity

  /*
   Column Details (from kaggle)
   bpm: Beats per Minute
   energy: The energy of a song - the higher the value, the more energtic.
   danceability: The higher the value, the easier it is to dance to this song.
   loudness: The higher the value, the louder the song.
   liveness: The higher the value, the more likely the song is a live recording.
   valence: The higher the value, the more positive mood for the song.
   duration: The duration of the song in seconds. 
   acousticness: The higher the value the more acoustic the song is.
   speechiness: The higher the value the more spoken word the song contains.
   popularity: The higher the value the more popular the song is.
  */


  -- Average Energy by Artist

	SELECT 
		artist, 
		avg(energy) as avg_energy
	FROM dbo.top_songs_data
	GROUP BY artist
	ORDER BY avg_energy DESC

  -- Years ordered by average duration for their top 10 most popular songs 

	SELECT
		year,
		AVG(duration) as avg_duration
	FROM(
		SELECT 
			year, 
			duration,
			ROW_NUMBER() OVER (PARTITION BY year ORDER BY popularity DESC) AS rank
		FROM dbo.top_songs_data
		) ranked_songs
	WHERE rank <= 10
	GROUP BY year
	ORDER BY avg_duration DESC

  -- Top 10 most popular artists

	SELECT TOP 10 
		artist, 
		AVG(popularity) as avg_pop
	FROM dbo.top_songs_data
	GROUP BY artist
	ORDER BY avg_pop DESC
  
-- Average Danceability by year

	SELECT 
		year,
		AVG(danceability) as avg_dance
	FROM dbo.top_songs_data
	GROUP BY year
	ORDER BY avg_dance DESC

-- Which 20 artists have the most top songs and what is their songs average bpm and duration
 
	SELECT TOP 20 
		artist, 
		COUNT(*) AS num_songs, 
		AVG(bpm) AS avg_bpm, 
		AVG(duration) as avg_duration
	FROM dbo.top_songs_data
	GROUP BY artist
	ORDER BY num_songs DESC

-- What are the 25 longest songs and what is their valence 
	SELECT TOP 25
		artist,
		title,
		duration,
		valence
	FROM dbo.top_songs_data
	ORDER BY duration DESC 

-- What were the 5 lowest energy songs in 2018

	SELECT TOP 5
		title,
		artist,
		energy
	FROM dbo.top_songs_data
	WHERE year = '2018'
	ORDER BY energy ASC

-- Total number of songs by genre for genres with at least 5 songs in order of amount

	SELECT
		top_genre,
		COUNT(*) as num_songs
	FROM dbo.top_songs_data
	GROUP BY top_genre
	HAVING COUNT(*) >= 5
	ORDER BY num_songs DESC
	