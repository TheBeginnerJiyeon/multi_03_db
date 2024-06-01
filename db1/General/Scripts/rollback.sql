-- CONNECTION: url=jdbc:oracle:thin:@//DESKTOP-MD0C8U4:1521/STR
-- New script in STR 3.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//DESKTOP-MD0C8U4:1521/STR
-- workspace : C:\Users\dkswl\OneDrive\Documents\code_upload\Auto_window\multi_it\backend\db\db1
-- Date: 2024. 5. 3.
-- Time: 오후 4:17:33




SELECT * FROM hr.EMPLOYEES ;

CREATE TABLE member(
	id varchar2(100),
	pw varchar2(100),
	name varchar2(100),
	tel varchar2(100)

);

--테이블 만들기 
--[표현식] :
--CREATE TABLE 테이블명(컬럼명 자료형(크기) , 컬럼명 자료형(크기)....);

-- 컬럼에 주석달기 
--[표현식]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용'

COMMENT ON COLUMN MEMBER.ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.PW IS '비밀번호';
COMMENT ON COLUMN MEMBER.NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.tel IS '전화번호';


SELECT * 
FROM SYS.USER_TABLES
WHERE TABLE_NAME ='TEST';

INSERT INTO MEMBER VALUES ('100','1234','PARK','011');

INSERT INTO MEMBER VALUES ('200','1234','PARK','011');

INSERT INTO MEMBER VALUES ('300','1111','APPLE','011');


COMMIT;

SELECT * FROM MEMBER; -- 모든 컬럼 조회
SELECT ID FROM MEMBER; -- 특정 컬럼 하나 조회

SELECT ID, PW
FROM "MEMBER"
WHERE ID='300'; -- 조건이 있고 특정 컬럼만 조회할 때

SELECT *
FROM "MEMBER";

UPDATE MEMBER SET
TEL='900'
WHERE ID='100';


SAVEPOINT SP1;
DELETE FROM MEMBER WHERE ID='200';


SAVEPOINT SP2;
DELETE FROM MEMBER WHERE ID='100';

DELETE FROM MEMBER WHERE ID='100';

DELETE FROM MEMBER WHERE ID='300';

ROLLBACK TO SP2;









