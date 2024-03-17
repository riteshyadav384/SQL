# Create -> Import -> activate database
CREATE DATABASE thinkuponai;
USE thinkuponai;


# Start with basic queries
SELECT Title, Channel_name FROM youtube_videos;
SELECT * FROM video_detail;
SELECT Video_ID, No_of_comments FROM video_detail;

# WHERE Condition (<,>,>=,<=,=,!=)
SELECT * FROM youtube_videos
WHERE Year>=2023 AND Year<=2024;


# WHERE Condition (BETWEEN & NOT BETWEEN)
SELECT * FROM youtube_videos
WHERE Channel_name BETWEEN 'A' AND 'P';

SELECT * FROM youtube_videos
WHERE Year NOT BETWEEN 2023 AND 2024;

# WHERE Condition (IN & NOT IN)
SELECT * FROM youtube_videos
WHERE Channel_name IN('Jay Clouse', 'MrBeast');

SELECT * FROM youtube_videos
WHERE Channel_name NOT IN('Jay Clouse', 'MrBeast');

# WHERE Condition (LIKE & NOT LIKE [%,_])
SELECT * FROM video_detail
WHERE Category LIKE 'Advic_';

SELECT * FROM video_detail
WHERE Category NOT LIKE 'psychology';


# DISTINCT
SELECT DISTINCT Category FROM video_detail;


# ORDER BY (DESC/ ASC)
SELECT * FROM video_detail
ORDER BY No_of_comments ASC;


# LIMIT
SELECT * FROM video_detail
ORDER BY No_of_comments DESC
LIMIT 3;


# LIMIT with OFFSET	
SELECT * FROM video_detail
ORDER BY No_of_comments DESC
LIMIT 3 OFFSET 1;



# AGG function (COUNT/ MIN/ MAX/ AVG/ SUM) with GROUP BY
SELECT Channel_name, COUNT(Title) FROM youtube_videos
GROUP BY Channel_name;


# HAVING (used with GROUP BY clause)
SELECT Channel_name, COUNT(Title) FROM youtube_videos
GROUP BY Channel_name
HAVING Channel_name='Jay Clouse';


######=========== TASKS ===========######

# Task 1: List all the videos from the channel 'Jay Clouse' in the order of year they were published
SELECT * FROM youtube_videos
WHERE Channel_name LIKE 'Jay Clouse'
ORDER BY Year;


# Task 2: List two most liked videos from channel 'Pursuit of Wonder'
SELECT * FROM youtube_videos
WHERE Channel_name LIKE 'Pursuit%'
ORDER BY LIKES DESC
LIMIT 2;

# Task 3: List third most liked video
SELECT * FROM youtube_videos
WHERE Channel_name LIKE 'Pursuit%'
ORDER BY LIKES DESC
LIMIT 1 OFFSET 2;


# Task 4: List the Channel_names along with highest liked videos for each channel
SELECT Channel_name, MAX(Likes) FROM youtube_videos
GROUP BY Channel_name;



#----------------x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-----------------#

# JOINs
SELECT * FROM youtube_videos;
SELECT * FROM video_detail;


# INNER JOIN
SELECT * FROM youtube_videos
INNER JOIN video_detail
 ON youtube_videos.ID=video_detail.Video_ID;


# Task 5: Top 3 most commented videos (using INNER JOIN)
SELECT youtube_videos.Title, No_of_comments FROM youtube_videos
INNER JOIN video_detail
 ON youtube_videos.ID=video_detail.Video_ID
ORDER BY No_of_comments DESC
LIMIT 3;

SELECT * FROM youtube_videos
RIGHT JOIN video_detail
 ON youtube_videos.ID=video_detail.Video_ID;



# LEFT JOIN (Task 6: Find the youtube videos that are not assigned to any of the categories.)
DELETE FROM video_detail
WHERE Video_ID=1;

SELECT * FROM youtube_videos
LEFT JOIN video_detail
 ON youtube_videos.ID=video_detail.Video_ID
WHERE Category IS NULL;

# RIGHT JOIN
SELECT * FROM video_detail
RIGHT JOIN youtube_videos
  ON youtube_videos.ID=video_detail.Video_ID
WHERE Category IS NULL;

# Simulating FULL JOIN
SELECT * FROM youtube_videos
LEFT JOIN video_detail
  ON youtube_videos.ID=video_detail.Video_ID
UNION
SELECT * FROM youtube_videos
RIGHT JOIN video_detail
  ON youtube_videos.ID=video_detail.Video_ID;

# Expressions
SELECT Title, (Likes/1000) AS 'Likes (in K)' FROM youtube_videos;

# ALIAS
SELECT * FROM youtube_videos AS t1
RIGHT JOIN video_detail AS t2
  ON t1.ID=t2.Video_ID;  


# - x - x - x - x - x - x - x - x - x - x - x - x - x - x - x - x - x - x - x - x - # 
    