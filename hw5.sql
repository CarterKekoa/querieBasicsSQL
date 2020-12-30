/*----------------------------------------------------------------------
 * Name: Carter Mooring
 * File: hw5.sql
 * Date: Oct. 22nd, 2020
 * Class: CPSC321 Databases
 * Description: This is a collection of MySQL Queries whos parameters will output various tables filled with results.
 ----------------------------------------------------------------------*/

-- required in MariaDB to enforce constraints
SET sql_mode = STRICT_ALL_TABLES;

/*1. Find all album titles recorded in a specific year.*/
SELECT title
FROM album
WHERE year_founded = 2016;

/*2. Find the names of all record labels that were founded in a specific year with a specific label type.*/
SELECT label_name
FROM recordLabel
WHERE year_founded = 1958 AND music_type = "Pop";

/*3. Find the names of all record labels that have one of two specific types and that was founded in the 1980’s.*/
SELECT label_name
FROM recordLabel
WHERE year_founded > 1979 AND year_founded < 1990
      AND (music_type = "R&B" OR music_type = "Rock");


/*4. Find the names of all artists that have been members of a specific music group. */
SELECT member_name
FROM members
WHERE group_name = 'OutKast';

/*5. Find the names of all artists that have been members of at least two different music groups. */
SELECT DISTINCT mn.member_name
FROM members mn, members n
WHERE mn.member_name = n.member_name AND mn.group_name != n.group_name;

/*6. Find the name and year formed of each music group that plays at least three different genres of music. */
SELECT DISTINCT a1.music_group, mg.year_formed 
FROM musicGroup mg, associated a1, associated a2, associated a3 
WHERE a1.music_group = a2.music_group AND a2.music_group = a3.music_group
      AND a3.music_group = mg.group_name
      AND a1.genre_type != a2.genre_type AND a1.genre_type != a3.genre_type AND a2.genre_type != a3.genre_type;

/*7. Find the name of each music group that was influenced by a specific music group. */
SELECT group_influenced_by
FROM influenced
WHERE group_influencing = 'The Wailers';

/*8. Find all of the album titles recorded within a specific range of years and whose corresponding group contained
 a specific artist that was a member of the group during the same range of years. */
SELECT DISTINCT a.title
FROM album a, members mem
WHERE a.year_founded >= 2000 AND a.year_founded <= 2020
     AND mem.group_name = a.group_name
     AND ((mem.range_start >= 2000 AND mem.range_start <= 2020)
     OR (mem.range_end >= 2000 AND mem.range_end <= 2020));

/*9. Find all of the artists that were members of groups that played a specific genre of music and that were members 
of the group within a specific range of years (e.g., in the 2000s). Return the artist name and group name. */
SELECT DISTINCT mem.member_name, mem.group_name 
FROM members mem, associated a 
WHERE a.genre_type = 'Hip-Hop' 
      AND a.music_group = mem.group_name 
      AND mem.range_start > 1985;

/*10. Find all of the tracks that were on at least two albums, but where two of the albums were associated with 
different record labels and different music groups. */
SELECT DISTINCT c1.track_name
FROM consistsOf c1, consistsOf c2, album a1, album a2
WHERE c1.track_name = c2.track_name AND	c1.album_name != c2.album_name
      AND c1.album_name = a1.title AND c2.album_name = a2.title
      AND a1.label_name != a2.label_name AND a1.group_name != a2.group_name;

/*11. Find each music group that is influenced by another group such that both groups have albums that share a song 
 title. Return the name of each group and the song title they share.*/
SELECT DISTINCT i.group_influenced_by, i.group_influencing, mt1.track_name
FROM musicGroup mg, influenced i, album a1, album a2, consistsOf c1, consistsOf c2, musicTrack mt1, musicTrack mt2 
WHERE mg.group_name = i.group_influenced_by
      AND i.group_influencing = a1.group_name AND i.group_influenced_by = a2.group_name
      AND a1.title = c1.album_name AND a2.title = c2.album_name
      AND c1.track_name = mt1.track_name AND c2.track_name = mt2.track_name
      AND mt1.track_name = mt2.track_name;

/*12. Find the artists that are either in at least two groups or wrote at least two songs, but not necessarily both. 
 Note that you should have at least one artist in your database that didn’t do either of these. Return the unique 
 set of artist names. */
SELECT DISTINCT mem1.member_name
FROM members mem1, members mem2, producers p1, producers p2
WHERE mem1.member_name = mem2.member_name
      AND p1.track_name = p2.track_name;

/*13. Find the first and last year a specific group created albums. Although not part of the query itself, select 
 a group that is associated with more than two albums.*/
SELECT group_name, MIN(year_founded) AS first_album, MAX(year_founded) AS last_album
FROM album
WHERE group_name = 'Blink-182';

/*14. Find the total number of albums that were recorded by a group for a specific record label. */
SELECT DISTINCT label_name, group_name, COUNT(*)
FROM album
WHERE group_name = 'Juice WRLD'
      AND label_name = 'Universal Music Publishing Group';

/*15. Develop an “interesting” query involving joins and multiple WHERE conditions. Ex- plain in plain English what 
 your query returns and show the results of the query.
 Description: Find the and display the songs on a album that were written a certain year */
SELECT album_name, track_name, year_written
FROM song, consistsOf
WHERE title = track_name AND year_written = 2000;
