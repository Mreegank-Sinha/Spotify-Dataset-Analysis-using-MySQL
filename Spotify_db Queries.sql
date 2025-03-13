-- Spotify Database analysis using MySQL
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EXploratory Data Analysis

SELECT COUNT (*) FROM spotify;

SELECT DISTINCT album_type FROM spotify;

SELECT COUNT(DISTINCT artist) FROM spotify;

SELECT MAX(duration_min) FROM spotify;

SELECT MIN(duration_min) FROM spotify;

-- Query to search for fields containing tracks with duration equal to Zero and removing the fields

SELECT * FROM spotify
WHERE duration_min=0;

DELETE  FROM spotify
WHERE duration_min=0;

SELECT * FROM spotify
WHERE duration_min=0;

-- Easy level questions

SELECT * FROM spotify
WHERE stream > 1000000000;

SELECT DISTINCT album,artist
FROM spotify;

SELECT SUM (comments) as total_comments
FROM spotify
WHERE licensed = 'true';

SELECT * FROM spotify
WHERE album_type = 'single';

SELECT artist, COUNT(*) as total_no_songs
FROM spotify
GROUP BY artist
ORDER BY 2

-- Medium level questions

SELECT 
	album, 
	avg(danceability) as avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC;

SELECT
	track,
	MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

SELECT 
	track,
	SUM(views) as total_views,
	SUM(likes) as total_likes
FROM Spotify
WHERE official_video = 'true'
GROUP BY 1
ORDER BY 2 DESC;

SELECT
	album,
	track,
	SUM(views)
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC;

SELECT * FROM
(SELECT
	track,
	COALESCE(SUM(CASE WHEN most_played_on='Youtube' THEN stream END),0)as streamed_on_youtube,
	COALESCE(SUM(CASE WHEN most_played_on='Spotify' THEN stream END),0)as streamed_on_spotify
FROM spotify
GROUP BY 1
) as t1
WHERE
	streamed_on_spotify > streamed_on_youtube
	AND
	streamed_on_youtube <>0;

-- Advanced level questions

WITH ranking_artist
AS
(SELECT
	artist,
	track,
	SUM(views) as total_view,
	DENSE_RANK()OVER(PARTITION BY artist ORDER BY SUM(views)DESC) as rank
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC
)
SELECT * FROM ranking_artist
WHERE rank <=3;

SELECT
	track,
	artist,
	liveness
From spotify
WHERE liveness > (SELECT AVG (liveness)FROM Spotify);

WITH cte
AS
(SELECT
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1
)
SELECT
	album,
	highest_energy - lowest_energy as energy_diff
FROM cte
ORDER BY 2 DESC;

SELECT 
    energy,
    liveness,
    (energy / liveness) AS energy_liveness_ratio
FROM spotify
WHERE (energy / liveness) > 1.2
GROUP BY 1,2
ORDER BY 3 DESC;

SELECT 
    artist, 
    track, 
    views, 
    likes, 
    SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify
ORDER BY views DESC;