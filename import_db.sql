PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS questions_follows
DROP TABLE IF EXISTS replies ;
DROP TABLE IF EXISTS question_likes;


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
 );

 CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body VARCHAR(255) NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id)
 );

 CREATE TABLE questions_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER
    questions_id INTEGER
 );

 CREATE TABLE replies (
   id INTEGER PRIMARY KEY,
   body VARCHAR(255) NOT NULL,
   question_id INTEGER NOT NULL, 
   user_id INTEGER NOT NULL,
   parent_reply_id INTEGER,

   FOREIGN KEY (question_id) REFERENCES questions(id)

   FOREIGN KEY (user_id) REFERENCES users(id)

   FOREIGN KEY (parent_reply_id) REFERENCES replies(id)

 )

 CREATE TABLE question_likes (
   id INTEGER PRIMARY KEY, 
   user_id INTEGER NOT NULL,
   question_id INTEGER NOT NULL, 
   number_of_likes INTEGER NOT NULL,

   FOREIGN KEY (question_id) REFERENCES questions(id)

   FOREIGN KEY (user_id) REFERENCES users(id)
 )


INSERT INTO 
   users (fname, lname)
VALUES
   ('Arthur', 'Miller'), 
   ('Eugene', 'Neil')

INSERT INTO 
   questions 
VALUES   
 ('Q1', 'What is your first name?', author_id)