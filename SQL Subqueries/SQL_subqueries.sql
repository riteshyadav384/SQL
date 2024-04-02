# Setup
CREATE DATABASE thinkuponai;
USE thinkuponai;

# SQL Sub-queries
# Definition: Queries nested inside another SQL query
/*
Subqueries can be used with 
- SQL Query (SELECT, WHERE, FROM...)
- INSERT 
- UPDATE
- DELETE
*/

SELECT * FROM youtube_videos;
SELECT * FROM video_detail;

# Types: 5 
# a) Single-row subqueries (returns single row as output)
SELECT ID, Title, (SELECT AVG(Likes) FROM youtube_videos) AS avg_likes
FROM youtube_videos;

SELECT ID, Title, Likes
FROM youtube_videos
WHERE Likes > (SELECT AVG(Likes) FROM youtube_videos);

# Exercise 1: Find the videos that got likes higher than the average likes of the videos published by channel "Pursuit of Wonder"
SELECT ID, Title, Likes, (SELECT AVG(Likes) FROM youtube_videos WHERE Channel_name LIKE 'Pursuit%') AS avg_likes_pow
FROM youtube_videos
WHERE Likes > (SELECT AVG(Likes) FROM youtube_videos WHERE Channel_name LIKE 'Pursuit%');

# Exercise 2: Find the youtubers who got likes higher than the average likes of all the videos
SELECT Channel_name, SUM(Likes) AS total_likes
FROM youtube_videos
GROUP BY Channel_name
HAVING total_likes > (SELECT AVG(Likes) FROM youtube_videos);

# b) Multiple-row subqueries (returns multiple rows as output)

SELECT * FROM video_detail
WHERE Video_ID IN (SELECT ID FROM youtube_videos);

# Same can be done with JOIN operation
# JOIN Command
SELECT Video_ID, Category, No_of_comments
FROM video_detail v
JOIN youtube_videos y
 ON v.Video_ID=y.ID;

# Exercise 3: Find the videos(Title, Channel_name,..) that got less than 1500 comments on youtube, given the video is classified into a category

SELECT ID, Title, Channel_name
FROM youtube_videos
WHERE ID IN (SELECT Video_ID FROM video_detail WHERE No_of_comments < 1500);


# c) Multiple-column subqueries (returns multiple columns as output)
SELECT * 
FROM youtube_videos
WHERE (ID, Likes) IN (SELECT ID, Likes FROM youtube_videos WHERE Likes>1500);

SELECT * 
FROM youtube_videos
WHERE Likes>1500;

# Exercise 4: Show 'Title', 'Channel_name', and 'Likes' of the videos with least number of likes for each youtuber

SELECT Title, Channel_name, Likes
FROM youtube_videos
WHERE (Channel_name, Likes) IN (SELECT Channel_name, MIN(Likes) FROM youtube_videos GROUP BY Channel_name);


# Try without using subquery (if possible)
SELECT Title, Channel_name, MIN(Likes)
FROM youtube_videos
GROUP BY Channel_name;


# d) Correlated subqueries (returns values based on information from parent query)

SELECT Title, Channel_name, (SELECT "Yes" FROM video_detail v WHERE v.Video_ID = y.ID) AS Categorized
FROM youtube_videos y;

SELECT Title, Channel_name
FROM youtube_videos y
WHERE EXISTS (SELECT 1 FROM video_detail v WHERE v.Video_ID = y.ID);

# Exercise 5: Find the number of likes of the uncategorized video
SELECT * FROM youtube_videos;
SELECT * FROM video_detail;

/* If using original table (not needed for updated table)
DELETE FROM video_detail
WHERE Video_ID=1;
*/

SELECT Title, Channel_name, Likes
FROM youtube_videos y
WHERE NOT EXISTS (SELECT 1 FROM video_detail v WHERE v.Video_ID = y.ID);

# e) Nested subqueries (subqueries inside another subqueries)

# Exercise 6: Find the videos with higher likes than the average likes for videos with more than 1500 likes 

SELECT ID, Title, Channel_name FROM youtube_videos 
WHERE Likes > (SELECT AVG(Likes) FROM youtube_videos 
WHERE ID IN (SELECT ID FROM youtube_videos WHERE Likes>1500));


# Exercise 7: Find the second highest liked video for each youtuber.
SELECT Channel_name, (SELECT Title FROM youtube_videos t_in WHERE t_in.Channel_name = t_out.Channel_name
ORDER BY Likes DESC 
LIMIT 1 OFFSET 1) AS second_highest_liked_video
FROM (SELECT DISTINCT Channel_name FROM youtube_videos) AS t_out;

SELECT Channel_name FROM youtube_videos;