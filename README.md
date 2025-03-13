# Spotify-Dataset-Analysis-using-MySQL

![image](https://github.com/user-attachments/assets/516fe2b8-2bc8-492e-8cd4-72d7d1b1e70b)


## Overview
This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using **SQL**. It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity (easy, medium, and advanced), and optimizing query performance. The primary goals of the project are to practice advanced SQL skills and generate valuable insights from the dataset.

```sql
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
```
## Project Steps

### 1. Data Exploration
Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:
- `Artist`: The performer of the track.
- `Track`: The name of the song.
- `Album`: The album to which the track belongs.
- `Album_type`: The type of album (e.g., single or album).
- Various metrics such as `danceability`, `energy`, `loudness`, `tempo`, and more.
### 2. EDA
After learning about dataset's fields it is neccessary to perform EDA.
- Dataset is checked for duplicate enteries.
- When no duplicates are found dataset is imported for analysis.
- Number of Columns of dataset, number of distinct albums, album types, and duration of tracks.
- Min duration of track was found to be zero and the corresponding enteries were removed.

```sql
SELECT COUNT (*) FROM spotify;

SELECT DISTINCT album_type FROM spotify;

SELECT COUNT(DISTINCT artist) FROM spotify;

SELECT MAX(duration_min) FROM spotify;

SELECT MIN(duration_min) FROM spotify;

SELECT * FROM spotify
WHERE duration_min=0;

DELETE  FROM spotify
WHERE duration_min=0;

SELECT * FROM spotify
WHERE duration_min=0;
```
### 4. Querying the Data
After the data is inserted, various SQL queries can be written to explore and analyze the data. Queries are categorized into **easy**, **medium**, and **advanced** levels to help progressively develop SQL proficiency.

#### Easy Queries
- Simple data retrieval, filtering, and basic aggregations.
  
#### Medium Queries
- More complex queries involving grouping, aggregation functions, and joins.
  
#### Advanced Queries
- Nested subqueries, window functions, CTEs, and performance optimization.

### 5. Query Optimization
In advanced stages, the focus shifts to improving query performance. Some optimization strategies include:
- **Indexing**: Adding indexes on frequently queried columns.
- **Query Execution Plan**: Using `EXPLAIN ANALYZE` to review and refine query performance.
  
---
## Analysis Questions
### Easy Level
1. Retrieve the names of all tracks that have more than 1 billion streams.

Query:
```sql
SELECT * FROM spotify
WHERE stream > 1000000000;
```
![image](https://github.com/user-attachments/assets/9b18e037-dbc3-4747-9bfb-f4ed617e0af5)

2. List all albums along with their respective artists.

Query:
```sql
SELECT DISTINCT album,artist
FROM spotify;

```
![image](https://github.com/user-attachments/assets/e9a29518-b25e-4350-8be0-e7546ad6b93b)

3. Get the total number of comments for tracks where `licensed = TRUE`.

Query:
```sql
SELECT SUM (comments) as total_comments
FROM spotify
WHERE licensed = 'true';
```
![image](https://github.com/user-attachments/assets/d9d17235-7a42-454a-a8bb-31eb39320cd5)

4. For each album, calculate the total views of all associated tracks.

Query:
```sql
SELECT * FROM spotify
WHERE album_type = 'single';
```
![image](https://github.com/user-attachments/assets/9ff1bed5-68f7-44a5-8ffa-42e49d6bdd74)

5. Retrieve the track names that have been streamed on Spotify more than YouTube.

Query:
```sql
SELECT artist, COUNT(*) as total_no_songs
FROM spotify
GROUP BY artist
ORDER BY 2
```
![image](https://github.com/user-attachments/assets/046b1f57-07b8-4002-a448-99cf30dc14eb)

### Medium Level
