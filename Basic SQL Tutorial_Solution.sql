#-------------------------------DATABASES------------------------------------#
#1) CREATE
CREATE DATABASE IF NOT EXISTS thinkuponai;

#2) DROP
DROP DATABASE IF EXISTS thinkuponai;

#3) USE
USE thinkuponai;

#--------------------------------TABLES-------------------------------------#
# CRUD Operations [Create, Read, Update, Delete]

#1) CREATE/ INSERT
CREATE TABLE my_content(
ID INT PRIMARY KEY, #Should be unique and not NULL
Title VARCHAR(60) NOT NULL,
Published_date DATE,
Views INT
);

#----Exercise question----#
/* Create a table named "subscribers" with columns- Video_ID, Name, Location.
You are free to choose the variable TYPE, CONSTRAINTS or DEFAULT_VALUE */
/* Solution - 
CREATE TABLE subscribers(
Video_ID INT,
Name VARCHAR(50),
Location VARCHAR(50)
);*/

# INSERT (all columns)
INSERT INTO my_content 
VALUES('1','Principal_Component_Analysis','2023-12-17', '526'),
	  ('2','Attention is all you need(LLMs)','2024-01-02', '568');

# INSERT (selected columns)      
INSERT INTO my_content (ID, Title)
VALUES('3','RLHF');

# INSERT (selected columns/ with expressions)
INSERT INTO my_content (ID, Title, Views)
VALUES('4','SQL Tutorial',10*30);

#----Exercise question----#
/* Insert 2 row values(for all the columns) in the table "subscribers" that you have created in the last exercise.
Use Video_ID = 1 and 3 for the two rows that you will insert.
Note: Look for any constraints that you have used while creating the table */
/* Solution:
INSERT INTO subscribers
VALUES('1','Rohan','India'),('3','Andrew','Germany');*/


# DROP
DROP TABLE IF EXISTS my_content;

#2) READ 
SELECT * FROM my_content;
SELECT * FROM subscribers;

#3) UPDATE
UPDATE my_content
SET Views=130, Published_date='2024-01-14'
WHERE Title='RLHF'; #note that you have not skipped the condition

#----Exercise question----#
/* One of the subscribers for Video_ID = 3 has updated location to USA.
Please update the same in your table in column 'Location'*/
/* Solution:
UPDATE subscribers
SET Location='USA'
WHERE Video_ID='3';*/

#4) DELETE
DELETE FROM my_content
WHERE ID=4; #note that you have not skipped the condition

#5) ALTER

#-- ADD
ALTER TABLE my_content
ADD avg_duration float DEFAULT 0;

ALTER TABLE my_content
ADD temp float DEFAULT 10;

#-- DROP
ALTER TABLE my_content
DROP temp;

#-- RENAME
ALTER TABLE my_content
RENAME my_videos;

#----Exercise question----#
/* You thought that it is good to know about the age of your subscriber as well, for your future content.
Add the column 'Age' with the constraint NOT NULL and default value '24' */
/* Solution:
ALTER TABLE subscribers
ADD Age INT NOT NULL DEFAULT 24; */

#------Primary Key/Foreign Key------#

#----Exercise question----#
/*Rename the 'subscribers' table that you created to 'subscribers_temp'*/
/*Solution:
ALTER TABLE subscribers
RENAME subscribers_temp;*/

CREATE TABLE subscribers(
Name VARCHAR(50),
Video_ID INT,
Location VARCHAR(50),
FOREIGN KEY(Video_ID) REFERENCES my_videos(ID)
);
