-- Carter Mooring
-- CPSC321 Databases
-- HW4
-- Description:

-- Start using emacs: emacs -nw hw4.sql  
-- TO Save: hold 'control' and type 'xs'
-- TO SEARCH: 'control s' to 'control g' to quit
-- end of line: 'control e'
-- recenter: 'conrtol l'

-- default engine is innodb
SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE IF EXISTS consistsOf;
DROP TABLE IF EXISTS producers;
DROP TABLE IF EXISTS writtenBy;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS influenced;
DROP TABLE IF EXISTS associated;
DROP TABLE IF EXISTS musicGroup;
DROP TABLE IF EXISTS musicArtist;
DROP TABLE IF EXISTS musicTrack;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS recordLabel;

CREATE TABLE recordLabel(
	label_name VARCHAR (40),
	year_founded YEAR,
	music_type VARCHAR (20),
	PRIMARY KEY (label_name)
);

CREATE TABLE album(
	title VARCHAR (30),
	group_name VARCHAR (30),
	year_founded YEAR,
	label_name VARCHAR (40),
	PRIMARY KEY (title, group_name),
	FOREIGN KEY (label_name) REFERENCES recordLabel (label_name)
);

CREATE TABLE song(
	title VARCHAR (20),
	year_written YEAR,
	PRIMARY KEY (title)
);

CREATE TABLE musicTrack(
	date_recorded DATE,
	track_name VARCHAR (30),
	PRIMARY KEY (track_name),
	FOREIGN KEY (track_name) REFERENCES song (title)
);

CREATE TABLE musicArtist(
	artist_name VARCHAR (40),
	birth_year YEAR,
	PRIMARY KEY (artist_name)
);

CREATE TABLE musicGroup(
	group_name VARCHAR (30),
	year_formed YEAR,
	PRIMARY KEY (group_name)
);

CREATE TABLE associated(
	genre_type VARCHAR (20),
	music_group VARCHAR (30),
	PRIMARY KEY (genre_type, music_group),
	FOREIGN KEY (music_group) REFERENCES musicGroup (group_name)
);

CREATE TABLE influenced(
	group_influencing VARCHAR (30),
	group_influenced_by VARCHAR (30),
	PRIMARY KEY (group_influencing, group_influenced_by),
	FOREIGN KEY (group_influencing) REFERENCES musicGroup (group_name),
	FOREIGN KEY (group_influenced_by) REFERENCES musicGroup (group_name)
);

CREATE TABLE members(
	member_name VARCHAR (40),
	group_name VARCHAR (30),
	range_start YEAR,
	range_end YEAR,
	PRIMARY KEY (member_name, group_name),
	FOREIGN KEY (member_name) REFERENCES musicArtist (artist_name),
	FOREIGN KEY (group_name) REFERENCES musicGroup (group_name)
);

CREATE TABLE writtenBy(
	song_name VARCHAR (20),
	artist_name VARCHAR (40),
	PRIMARY KEY (song_name, artist_name),
	FOREIGN KEY (song_name) REFERENCES song (title),
	FOREIGN KEY (artist_name) REFERENCES musicArtist (artist_name)
);

CREATE TABLE producers(
	artist_name VARCHAR (40),
	track_name VARCHAR (30),
	PRIMARY KEY (artist_name, track_name),
	FOREIGN KEY (artist_name) REFERENCES musicArtist (artist_name),
	FOREIGN KEY (track_name) REFERENCES musicTrack (track_name)
);

CREATE TABLE consistsOf(
	album_name VARCHAR (30),
	track_name VARCHAR (30),
	PRIMARY KEY (album_name, track_name),
	FOREIGN KEY (album_name) REFERENCES album (title),
	FOREIGN KEY (track_name) REFERENCES musicTrack (track_name)
);

-- To View Tables: select * from recordLabel;
INSERT INTO recordLabel VALUES
       ("Sony Music Entertainment", 1987, "Rock"),
       ("Universal Music Publishing Group", 1983, "R&B"),
       ("Awesome People", 1980, "Rock"),
       ("Warner Music Group", 1958, "Pop"),
       ("Island Records", 1958, "Pop"),
       ("BMG Rights Management", 1958, "Pop");

INSERT INTO album VALUES
       ("Error in the System", "Peter Schilling", 2016, "Warner Music Group"),
       ("California", "Blink-182", 2016, "BMG Rights Management"),
       ("Hey", "Blink-182", 1987, "BMG Rights Management"),
       ("Unbreakable", "Janet Jackson", 2016, "BMG Rights Management"),
       ("Burnin", "The Wailers", 1973, "Island Records"),
       ("Legends Never Die", "Juice WRLD", 2020, "Universal Music Publishing Group"),
       ("Yeah They Do", "Juice WRLD", 1960, "Universal Music Publishing Group"),
       ("As I Am", "Alicia Keys", 2007, "Sony Music Entertainment"),
       ("Stankonia", "OutKast", 2000, "Sony Music Entertainment"),
       ("Backbenders", "TCZ", 2020, "BMG Rights Management");

INSERT INTO song VALUES
       ("Hello World", 1983),
       ("No More", 2000),
       ("Research", 2005),
       ("Took 2 Long", 1996),
       ("Sorry Mrs Jackson", 2000),
       ("Intro", 2000),
       ("Gasoline Dreams", 1999),
       ("Im Cool", 2000),
       ("So Fresh", 2000),
       ("D.F.", 1998),
       ("Xplosion", 2000);

INSERT INTO musicTrack VALUES
       ('1983-9-3', "Hello World"),
       ('2000-10-13', "No More"),
       ('2005-7-24', "Research"),
       ('1996-4-9', "Took 2 Long"),
       ('2000-5-7', "Sorry Mrs Jackson"),
       ('2000-6-3', "Intro"),
       ('1999-8-15', "Gasoline Dreams"),
       ('2000-9-6', "Im Cool"),
       ('2000-10-28', "So Fresh"),
       ('1998-7-13', "D.F."),
       ('2000-9-4', "Xplosion");

INSERT INTO musicArtist VALUES
       ("Kanye West", 1977),
       ("Janet Jackson", 1966),
       ("Andre 3000", 1975),
       ("Big Boi", 1975),
       ("Barter", 2020),
       ("Bakito", 1999);

INSERT INTO musicGroup VALUES
       ("OutKast", 1991),
       ("The Wailers", 1963),
       ("Blink-182", 1992),
       ("Dungeon Family", 2000),
       ("TCZ", 2020),
       ("Janet Jackson", 2005),
       ("Alicia Keys", 2004),
       ("Juice WRLD", 2018),
       ("Peter Schilling", 2014);

INSERT INTO associated VALUES
       ("Hip-Hop", "OutKast"),
       ("Rap", "OutKast"),
       ("Alternative", "OutKast"),
       ("Punk Rock", "Blink-182"),
       ("Pop-Punk", "Blink-182"),
       ("Metal", "Blink-182"),
       ("Reggae", "The Wailers"),
       ("Rocksteady", "The Wailers"),
       ("Ska", "The Wailers"),
       ("Rap", "Dungeon Family"),
       ("Hip-Hop", "TCZ"),
       ("Hip-Hop", "Janet Jackson");

INSERT INTO influenced VALUES
       ("The Wailers", "OutKast"),
       ("The Wailers", "Blink-182"),
       ("The Wailers", "TCZ"),
       ("Dungeon Family", "The Wailers"),
       ("OutKast", "Peter Schilling"),
       ("Peter Schilling", "Blink-182"),
       ("Juice WRLD", "The Wailers"),
       ("Alicia Keys", "TCZ");

INSERT INTO members VALUES
       ("Andre 3000", "OutKast", '1991', '2006'),
       ("Big Boi", "OutKast", '1991', '2006'),
       ("Bakito", "OutKast", '1991', '2005'),
       ("Barter", "TCZ", '2020', '2050'),
       ("Andre 3000", "Dungeon Family", '2006', '2009'),
       ("Big Boi", "The Wailers", '2006', '2009'),
       ("Janet Jackson", "Janet Jackson", '1986', '2017');
       
INSERT INTO writtenBy VALUES
       ("Sorry Mrs Jackson", "Andre 3000"),
       ("Sorry Mrs Jackson", "Big Boi");

INSERT INTO producers VALUES
       ("Andre 3000", "Sorry Mrs Jackson");

INSERT INTO consistsOf VALUES
       ("Stankonia", "Sorry Mrs Jackson"),
       ("Error in the System", "Hello World"),
       ("California", "Hello World"),
       ("Burnin", "No More"),
       ("Legends Never Die", "No More"),
       ("As I Am", "Research"),
       ("Backbenders", "Research"),
       ("Stankonia", "Intro"),
       ("Stankonia", "Gasoline Dreams"),
       ("Stankonia", "Im Cool"),
       ("Stankonia", "So Fresh"),
       ("Stankonia", "D.F."),
       ("Stankonia", "Xplosion");
