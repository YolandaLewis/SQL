--drop table ratings;
--drop table movies;
--drop table users;

CREATE TABLE USERS (
UserID Integer Primary Key,
Gender char(2),
Age INT,
Occupation INT,
Zipcode varchar2(10)
);


CREATE TABLE MOVIES(
MovieID Integer Primary Key,
Title varchar2(100),
Genres varchar2(100)
);

CREATE TABLE MOVIE_RATINGS(
UserID integer,
MovieID integer,
Rating INT,
Time_Stamp varchar2(10), 

foreign key (UserID) references USERS(USERID),
foreign key (MovieID) references Movies(MovieID)
);


CREATE OR REPLACE PROCEDURE normalized_Movie_table(





