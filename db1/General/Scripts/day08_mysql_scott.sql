/*USE scott;*/

DROP TABLE MEMBER;

CREATE TABLE member(
	no INT AUTO_INCREMENT PRIMARY KEY,
	id varchar(10) UNIQUE,
	pw varchar(10),
	name varchar(10),
	tel varchar(10),
	create_date timestamp DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO MEMBER
VALUES(NULL,'m01', '1', '리사', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'2', '2', '주혁', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'3', '3', '3', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'4', '4', '4', '010',NOW());
INSERT INTO MEMBER
VALUES(NULL,'5', '5', '5', '010',NOW());
COMMIT;

SELECT * FROM MEMBER;


DROP TABLE BOARD;



CREATE TABLE BOARD (
	no INT AUTO_INCREMENT PRIMARY KEY,
    CATEGORY_CODE INT,
    TITLE VARCHAR(100),
    CONTENT VARCHAR(100),
    WRITER VARCHAR(100)
);

create database jsp;

use jsp;

create database jsp;
use jsp;

create table member3 (
    id varchar(100) NULL,
    name varchar(256) NULL,
    email varchar(100) NULL,
    address varchar(500) NULL
);



SELECT * FROM MEMBER;



INSERT INTO BOARD
( CATEGORY_CODE, TITLE, CONTENT, WRITER)
VALUES( null, 10, '게시글 1 ', '게시글1 CONTENT 입니다 ', 'm01');

INSERT INTO BOARD
( CATEGORY_CODE, TITLE, CONTENT, WRITER)
VALUES( null, 10, '게시글 2 ', '게시글2 CONTENT 입니다 ', 'm01');
INSERT INTO BOARD
( CATEGORY_CODE, TITLE, CONTENT, WRITER)
VALUES( null, 10, '게시글 3 ', '게시글3 CONTENT 입니다 ', '2');
INSERT INTO BOARD
( CATEGORY_CODE, TITLE, CONTENT, WRITER)
VALUES( null, 10, '게시글 4 ', '게시글4 CONTENT 입니다 ', '2');
INSERT INTO BOARD
( CATEGORY_CODE, TITLE, CONTENT, WRITER)
VALUES( null, 10, '게시글 5 ', '게시글5 CONTENT 입니다 ', '3');
commit;

