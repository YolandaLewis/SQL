--Program created using SQL Developer
SET SERVEROUTPUT ON;

--CREATE PROCEDURE THAT WILL CREATE THE USER DATABASE--------------
CREATE OR REPLACE PROCEDURE Users_Table IS
UserString varChar2(300);
Table_Checker INTEGER;
BEGIN 
SELECT COUNT (*) 
INTO TABLE_CHECKER 
FROM SYS.user_tables 
WHERE TABLE_NAME = 'MOVIE_USER';
    IF (table_checker) = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE MOVIE_USER CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE 'CREATE TABLE Movie_USER ( 
        USERID INTEGER, 
        GENDER VARCHAR2(3),
        AGE INTEGER, 
        OCCUPATION INTEGER, 
        ZIPCODE VARCHAR2(10),
        PRIMARY KEY (USERID)
        )';
        DBMS_OUTPUT.PUT_LINE('TABLE WAS DROPPED AND RE-CREATED IN THE PROCEDURE');
ELSIF TABLE_CHECKER = 0 THEN
EXECUTE IMMEDIATE 'CREATE TABLE Movie_USER ( 
        USERID INTEGER, 
        GENDER CHAR,
        AGE INTEGER, 
        OCCUPATION INTEGER, 
        ZIPCODE VARCHAR2(10),
        PRIMARY KEY (USERID)
        )';
DBMS_OUTPUT.PUT_LINE(' MOVIE USER TABLE CREATED SUCCESSFULLY!');
END IF;
END Users_table;
/
--EXECUTE Users_table;



--CREATE A PRODECURE THAT WILL CREATE THE MOVIES DATABASE--------------------
CREATE OR REPLACE PROCEDURE MOVIES_TABLE IS
UserString varChar2(300);
Table_Checker INTEGER;
BEGIN
SELECT COUNT (*) 
INTO TABLE_CHECKER 
FROM SYS.user_tables 
WHERE TABLE_NAME = 'MOVIES';
    IF (table_checker) = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE MOVIES CASCADE CONSTRAINTS'; 
        EXECUTE IMMEDIATE 'CREATE TABLE MOVIES ( 
        MOVIEID INTEGER, 
        TITLE VARCHAR2(100),
        GENRE VARCHAR2(100),  
        PRIMARY KEY (MOVIEID)
        )';
        DBMS_OUTPUT.PUT_LINE(' MOVIES TABLE WAS DROPPED AND RE-CREATED IN THE PROCEDURE');
ELSIF TABLE_CHECKER = 0 THEN
EXECUTE IMMEDIATE 'CREATE TABLE MOVIES ( 
        MOVIEID INTEGER, 
        TITLE VARCHAR2(100),
        GENRE VARCHAR2(100),  
        PRIMARY KEY (MOVIEID)
        )';
DBMS_OUTPUT.PUT_LINE(' MOVIES TABLE CREATED SUCCESSFULLY!');
END IF;
END MOVIES_TABLE;
/
--EXECUTE MOVIES_TABLE;




-- CREATE A PROCEDURE TO CREATE THE RATINGS DATABASE-----------------
CREATE OR REPLACE PROCEDURE Ratings_table IS
UserString varChar2(300);
Table_Checker INTEGER;
BEGIN
SELECT COUNT (*) 
INTO TABLE_CHECKER 
FROM SYS.user_tables 
WHERE TABLE_NAME = 'RATING';
    IF (table_checker) = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE RATING'; 
        EXECUTE IMMEDIATE 'CREATE TABLE RATING ( 
        USERID INTEGER, 
        MOVIEID INTEGER,
        RATING INTEGER, 
        TIMESTAMP INTEGER,
        primary key(userid,movieid)
        )';
        DBMS_OUTPUT.PUT_LINE(' RATINGS TABLE WAS DROPPED AND RE-CREATED IN THE PROCEDURE');
ELSIF TABLE_CHECKER = 0 THEN
EXECUTE IMMEDIATE 'CREATE TABLE RATING ( 
        USERID INTEGER, 
        MOVIEID INTEGER,
        RATING INTEGER, 
        TIMESTAMP INTEGER, 
        primary key(userid,movieiD)
        )';
DBMS_OUTPUT.PUT_LINE(' RATINGS TABLE CREATED SUCCESSFULLY!');
END IF;
END Ratings_table;
/
--execute ratings_table;

--Procedure to insert values in the user table----------------
CREATE OR REPLACE PROCEDURE INSERT_INTO_USER_TABLE IS
UserString Varchar2(200);
BEGIN
EXECUTE IMMEDIATE 'INSERT INTO MOVIE_USER (SELECT * FROM TEMP_USERS)';
DBMS_OUTPUT.PUT_LINE('VALUES INSERTED INTO MOVIE_USER TABLE');
END INSERT_INTO_USER_TABLE;
/
--execute INSERT_INTO_USER_TABLE;


---Procedure to insert values into ratings table--------------------
CREATE OR REPLACE PROCEDURE INSERT_INTO_RATINGS_TABLE IS
BEGIN
EXECUTE IMMEDIATE 'INSERT INTO RATING (SELECT * FROM TEMP_MOVIE_RATINGS)';
DBMS_OUTPUT.PUT_LINE('VALUES INSERTED INTO RATINGS TABLE');

END INSERT_INTO_RATINGS_TABLE;
/
--execute INSERT_INTO_RATINGS_TABLE;

--Procedure to alter the movies table to add a Year column---
CREATE OR REPLACE PROCEDURE add_YearColumn is
UserString varChar2(300);
Table_Checker INTEGER;
BEGIN
SELECT COUNT (*) 
INTO TABLE_CHECKER 
FROM SYS.ALL_TAB_COLUMNS 
WHERE TABLE_NAME = 'MOVIES' and COLUMN_NAME  = 'YEAR';
    IF (table_checker) = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE MOVIES ADD (YEAR VARCHAR2(200))';
        
    ELSif(table_checker) = 1 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE MOVIES MODIFY (YEAR VARCHAR2(200))';
    END IF;
dbms_output.put_line('the Column Year was added to the movies table.');
END add_YearColumn;
/
--EXECUTE Add_YearColumn;




--Procedure to seperate the YEAR from the Movie title AND INSERT VALUES in the movies table-------
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE EXTRACT_MOVIE_YEAR_FROM_TITLE IS
v_MOVIEID temp_movies.movieid%TYPE;
v_MOVIETITLE temp_movies.TITLE%TYPE;
v_Movie_YEAR varchar2(20);
v_GENRE varchar2(300);

Cursor extract_qry IS
 select DISTINCT MOVIEID, rtrim(SUBSTR(Temp_movies.title,1,INSTR(Temp_MOVIES.TITLE,' (1' ))) AS MOVIETITLE,
        Ltrim(SUBSTR(Temp_movies.title,-6,INSTR(Temp_MOVIES.TITLE, '('))) AS Movie_YEAR,genres
        FROM temp_movies
        ORDER BY MOVIEID;
   
BEGIN
OPEN extract_qry;
FETCH extract_qry INTO v_movieID, v_movieTitle, v_movie_year, v_genre;
    WHILE TRUE LOOP
    IF extract_qry%found THEN
        --DBMS_OUTPUT.PUT_LINE('The Following Lines were Found: ' || v_movieID); --|| v_movieTitle || v_Movie_year || v_genre);
FETCH extract_qry INTO v_movieID, v_movieTitle, v_movie_year, v_genre;
    EXECUTE IMMEDIATE 'INSERT INTO MOVIES VALUES ( :a, :b, :c, :d)'
                        using v_movieid, v_movietitle, v_genre, v_movie_year;
    EXIT WHEN extract_qry%notfound;
    END IF;
   
END LOOP;
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('DUPLICATE KEY');
DBMS_OUTPUT.PUT_LINE('RECORDS INSERTED IN MOVIES TABLE WITH YEAR SEPERATED FROM TITLE');
DBMS_OUTPUT.PUT_LINE('The Amount of Rows fetched is: ' || extract_qry%rowcount);
CLOSE extract_qry;
END EXTRACT_MOVIE_YEAR_FROM_TITLE;
/
execute EXTRACT_MOVIE_YEAR_FROM_TITLE;
commit;       



---Procedure to Create a table for Movie-Category relationship-----
CREATE OR REPLACE PROCEDURE MOVIES_CATEGORIES_TABLE IS
UserString varChar2(300);
Table_Checker INTEGER;
BEGIN
SELECT COUNT (*) 
INTO TABLE_CHECKER 
FROM SYS.user_tables 
WHERE TABLE_NAME = 'MOVIE_CATEGORY';
    IF (table_checker) = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE MOVIE_CATEGORY CASCADE CONSTRAINTS'; 
        EXECUTE IMMEDIATE 'CREATE TABLE MOVIE_CATEGORY ( 
        CATEGORY_MOVIEID INTEGER, 
        CATEGORY VARCHAR2(100),  
        Foreign Key (CATEGORY_MOVIEID) references MOVIES (MOVIEID)
        )';
        DBMS_OUTPUT.PUT_LINE(' MOVIE_CATEGORY TABLE WAS DROPPED AND RE-CREATED IN THE PROCEDURE');
ELSIF TABLE_CHECKER = 0 THEN
EXECUTE IMMEDIATE 'CREATE TABLE MOVIE_CATEGORY ( 
        CATEGORY_MOVIEID INTEGER, 
        CATEGORY VARCHAR2(100),  
        Foreign Key (CATEGORY_MOVIEID) references MOVIES (MOVIEID)
        )';
DBMS_OUTPUT.PUT_LINE(' MOVIE_CATEGORY TABLE CREATED SUCCESSFULLY!');
END IF;
END MOVIES_CATEGORIES_TABLE;
/
EXECUTE MOVIES_CATEGORIES_TABLE;


--- Procedure to seperate pipe seperated category and insert values into a separate table with movie category relationships---------

CREATE OR REPLACE PROCEDURE remove_pipe_character IS
v_movieIDString varchar2(10);
v_movieGenreString varchar2(300);

cursor remove_pipe IS
select MOVIEID,
       regexp_substr(MOVIES.GENRE,'[^|]+',1,column_value) as MOVIE_GENRE
    from movies,
       TABLE(cast(multiset(select level
       from dual
    connect by level <= length(MOVIES.GENRE) - length(replace(MOVIES.GENRE,'|'))+1) as sys.odcinumberlist))
    ORDER BY MOVIEID;
   
BEGIN
OPEN remove_pipe;
FETCH remove_pipe INTO v_movieIDString, v_movieGenreString;
WHILE TRUE LOOP
    IF remove_pipe%found THEN
        --DBMS_OUTPUT.PUT_LINE('The Following Lines were Found: ' || v_movieIDString); --|| v_movieTitle || v_Movie_year || v_genre);
FETCH remove_pipe INTO v_movieIDString, v_movieGenreString; 
EXECUTE IMMEDIATE 'INSERT INTO MOVIE_Category VALUES ( :a, :b)'
                        using v_movieIDString, v_movieGenreString;
EXIT WHEN remove_pipe%notfound;
end if;
end loop;
DBMS_OUTPUT.PUT_LINE('RECORDS INSERTED IN MOVIE_Genre TABLE WITH REPEATING GROUPS IN GENRE SEPERATED.');
DBMS_OUTPUT.PUT_LINE('The Amount of Rows fetched is: ' || remove_pipe%rowcount);
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('DUPLICATE KEY');
close remove_pipe;
END remove_pipe_character;  
/  
--EXECUTE remove_pipe_character;
commit;


--procedure to create a table to decode age in the movie_user table---
CREATE OR REPLACE PROCEDURE AGE_DESCRIPTION_TABLE IS
UserString varChar2(300);
Table_Checker INTEGER;
BEGIN
SELECT COUNT (*) 
INTO TABLE_CHECKER 
FROM SYS.user_tables 
WHERE TABLE_NAME = 'AGE_DESCRIPTION';
    IF (table_checker) = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE AGE_DESCRIPTION CASCADE CONSTRAINTS'; 
        EXECUTE IMMEDIATE 'CREATE TABLE AGE_DESCRIPTION ( 
        AGE INTEGER, 
        DESCRIPTION VARCHAR2(20)  
        )';
        DBMS_OUTPUT.PUT_LINE(' AGE_DESCRIPTION TABLE WAS DROPPED AND RE-CREATED IN THE PROCEDURE');
ELSIF TABLE_CHECKER = 0 THEN
EXECUTE IMMEDIATE 'CREATE TABLE AGE_DESCRIPTION ( 
        AGE INTEGER, 
        DESCRIPTION VARCHAR2(20)
        )';

DBMS_OUTPUT.PUT_LINE(' AGE_DESCRIPTION TABLE CREATED SUCCESSFULLY!');
END IF;
END AGE_DESCRIPTION_TABLE;
/
--EXECUTE AGE_DESCRIPTION_TABLE;


--Procedure To Insert values into age_category taBLE

create or replace PROCEDURE AGE_DESCRIPTION_TABLE_INSERT IS
sqlString VARCHAR2(1000);
BEGIN
sqlString := 'INSERT INTO AGE_DESCRIPTION VALUES (:a, :b)';
execute immediate sqlString using 1,'Under 18';
execute immediate sqlString using 18,'18-24';
execute immediate sqlString using 25,'25-34';
execute immediate sqlString using 35,'35-44';
execute immediate sqlString using 45,'45-49';
execute immediate sqlString using 50,'50-55';
execute immediate sqlString using 56,'56+';
DBMS_OUTPUT.PUT_LINE('VALUES INSERTED INTO MOVIE_USER TABLE');
END AGE_DESCRIPTION_TABLE_INSERT;
/
EXECUTE age_description_table_insert;


--PROCEDURE TO CREATE OCCUPATION TABLE----
CREATE OR REPLACE PROCEDURE CREATE_OCCUPATION_TABLE IS
UserString varChar2(300);
Table_Checker INTEGER;
BEGIN
SELECT COUNT (*) 
INTO TABLE_CHECKER 
FROM SYS.user_tables 
WHERE TABLE_NAME = 'OCCUPATION_TABLE';
    IF (table_checker) = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE OCCUPATION_TABLE CASCADE CONSTRAINTS'; 
        EXECUTE IMMEDIATE 'CREATE TABLE OCCUPATION_TABLE ( 
        OCCUPATIONID INTEGER, 
        OCCUPATION_DESCRIPTION VARCHAR2(50))';  
DBMS_OUTPUT.PUT_LINE('OCCUPATION TABLE WAS CREATED SUCCESSFULLY!');
ELSIF TABLE_CHECKER = 0 THEN
EXECUTE IMMEDIATE 'CREATE TABLE OCCUPATION_TABLE ( 
        OCCUPATIONID INTEGER, 
        OCCUPATION_DESCRIPTION VARCHAR2(50)
        )';
DBMS_OUTPUT.PUT_LINE(' OCCUPATION TABLE WAS CREATED SUCCESSFULLY!');
END IF;
END CREATE_OCCUPATION_TABLE;
/
EXECUTE CREATE_OCCUPATION_TABLE;

create or replace PROCEDURE OCCUPATION_TABLE_INSERT IS
sqlString VARCHAR2(1000);
BEGIN
sqlString := 'INSERT INTO OCCUPATION_TABLE VALUES (:a, :b)';
execute immediate sqlString using 0,'''OTHER'' NOT SPECIFIED';
execute immediate sqlString using 1,'Academic/educator';
execute immediate sqlString using 2,'artist';
execute immediate sqlString using 3,'clerical/admin';
execute immediate sqlString using 4,'college/grad student';
execute immediate sqlString using 5,'customer service';
execute immediate sqlString using 6,'doctor/ healthcare';
execute immediate sqlString using 7,'executive/managerial';
execute immediate sqlString using 8,'farmer';
execute immediate sqlString using 9,'homemaker';
execute immediate sqlString using 10,'k-12 student';
execute immediate sqlString using 11,'lawyer';
execute immediate sqlString using 12,'programmer';
execute immediate sqlString using 13,'retired';
execute immediate sqlString using 14,'sales/marketing';
execute immediate sqlString using 15,'scientist';
execute immediate sqlString using 16,'self-employeed';
execute immediate sqlString using 17,'technician/engineer';
execute immediate sqlString using 18,'tradesman/craftsman';
execute immediate sqlString using 19,'unemployed';
execute immediate sqlString using 20,'writer';
DBMS_OUTPUT.PUT_LINE('VALUES INSERTED INTO OCCUPATION TABLE');
DBMS_OUTPUT.PUT_LINE('The program is complete with all tables loaded. An Interesting query will follow :-)');
END OCCUPATION_TABLE_INSERT;
/
EXECUTE Users_table;
EXECUTE MOVIES_TABLE;
execute ratings_table;
execute INSERT_INTO_USER_TABLE;
execute INSERT_INTO_RATINGS_TABLE;
EXECUTE Add_YearColumn;
execute EXTRACT_MOVIE_YEAR_FROM_TITLE;
EXECUTE MOVIES_CATEGORIES_TABLE;
EXECUTE AGE_DESCRIPTION_TABLE;
EXECUTE age_description_table_insert;
EXECUTE CREATE_OCCUPATION_TABLE;
EXECUTE OCCUPATION_TABLE_INSERT;
EXECUTE remove_pipe_character;


---AN INTERESTING QUERY----

---Find MOVIES that received a rating of 4 or 5, sort them in increasing order. 

    SELECT MOVIES.MOVIEID, MOVIES.TITLE, MOVIES_RATINGS.MOVIE_RATING From (MOVIES Join MOVIES_RATINGS ON MOVIES.MOVIEID = MOVIES_RATINGS.RATING_MOVIEID)  
    where MOVIE_RATING = 4 OR MOVIE_RATING = 5
    ORDER BY MOVIES_RATINGS.MOVIE_RATING ASC;

/*The following query joins the movies table and the rating table and returns movies that have received  rating of 4 or 5.
The results returned are in ascending order according to the rating received.




