-- CONNECTION: url=jdbc:oracle:thin:@//localhost:1521/XE
-- New script in localhost 4.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : C:\workspace\multi\03_db
-- Date: 2024. 5. 3.
-- Time: 오후 2:46:46


SELECT * FROM HR.EMPLOYEES;


--테이블 만들기 
--[표현식] :
--CREATE TABLE 테이블명(컬럼명 자료형(크기) , 컬럼명 자료형(크기)....);

CREATE TABLE member(
	ID VARCHAR2(100),
	PW VARCHAR2(100),
	NAME VARCHAR2(100),
	TEL VARCHAR2(100)
);


-- 컬럼에 주석달기 
--[표현식]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용'

COMMENT ON COLUMN MEMBER.ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.PW IS '비밀번호';
COMMENT ON COLUMN MEMBER.NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.TEL IS '전화번호';


-------DML 연습

SELECT * 
FROM SYS.USER_TABLES
WHERE TABLE_NAME = 'TEST';



INSERT INTO MEMBER VALUES ('100','1234','PARK','011');

INSERT INTO MEMBER VALUES ('200','1234','PARK','011');

INSERT INTO MEMBER VALUES ('300','1111','APPLE','011');





COMMIT;


SELECT * FROM MEMBER; -- 모든 컬럼 조회

SELECT ID FROM MEMBER; -- 특정 컬럼 하나만 조회


SELECT ID, PW 
FROM "MEMBER" 
WHERE ID = '300'; -- 조건이 있고 특정 컬럼만 조회할때 


--SELECT A.*, B.*
--FROM "MEMBER"  A , EMP B 
--WHERE A.ID = '300';


UPDATE MEMBER 
SET TEL = '900'
WHERE ID = '100';

COMMIT;


SELECT * FROM MEMBER; -- 모든 컬럼 조회


DELETE  FROM MEMBER WHERE ID = '300'; -- 300 삭제 







-- TCL (Transaction Controll Language)
-- 트랜젝션 제어 언어
-- COMMIT과 ROLLBACK이 있다.

-- 트랜젝션이란?
-- 한꺼번에 수행되어야 할 최소의 작업 단위를 말한다.
-- 논리적 작업 단위(Logical Unit of Work : LUW)
-- 하나의 트랜젝션으로 이루어진 작업은 반드시 한꺼번에 완료(COMMIT)
-- 되어야 하며, 그렇지 않은 경우에는 한꺼번에 취소(ROLLBACK)되어야 함

-- EX) ATM기기 인출을 함
-- 1. 카드 삽입
-- 2. 메뉴 선택(인출)
-- 3. 금액 확인, 비밀번호 인증
-- 4. 금액 입력(만약 3번에서 에러가 발생했다면 3번 수행하기 이전으로 되돌려야되고 ,3번까지 정상적으로 진행되면 진행된 작업모두 반영처리해야함 )

-- 5. 인출구에서 현금 수령
-- 6. 카드 받기
-- 7. 명세표 받기

-- COMMIT : 트랜젝션 작업이 정상 완료되면 변경 내용을 영구히 저장
-- ROLLBACK : 트랜젝션 작업을 취소하고 최근 COMMIT한 시점으로 이동
-- SAVEPOINT 세이브포인트명 : 현재 트랜젝션 작업 시점에 이름을 정해줌
--                          하나의 트랜젝션 안에 구역을 나눔 
-- ROLLBACK TO 세이브포인트명 : 트랜젝션 작업을 취소하고 
--                            SAVEPOINT 시점으로 이동

DELETE FROM MEMBER; -- 모든 데이터 삭제 

COMMIT;



INSERT INTO MEMBER VALUES ('100','1234','PARK','011');

INSERT INTO MEMBER VALUES ('200','1234','PARK','011');

INSERT INTO MEMBER VALUES ('300','1111','APPLE','011');





COMMIT; -- 3개 

INSERT INTO MEMBER VALUES ('300','1111','APPLE','011');

SELECT * FROM MEMBER; -- 4개

ROLLBACK; -- 최근 실행한 커밋 시점으로 롤백 

SELECT * FROM MEMBER; -- 3개


INSERT INTO MEMBER VALUES ('300','1111','APPLE','011');
SELECT * FROM MEMBER; -- 4개

SAVEPOINT SP2;

INSERT INTO MEMBER VALUES ('300','1111','APPLE','011');

SELECT * FROM MEMBER; -- 5개

ROLLBACK TO SP2; 

SELECT * FROM MEMBER; -- 4개


ROLLBACK; -- 최근 실행한 커밋 시점으로 롤백 3개










----------TIGER.SQL 내용 ----------------




 DROP TABLE BONUS CASCADE CONSTRAINT;
 DROP TABLE EMP CASCADE CONSTRAINT;
 DROP TABLE DEPT CASCADE CONSTRAINT;
 DROP TABLE SALGRADE CASCADE CONSTRAINT;


CREATE TABLE BONUS
(
  ENAME  VARCHAR2(10 BYTE),
  JOB    VARCHAR2(9 BYTE),
  SAL    NUMBER,
  COMM   NUMBER
);


CREATE TABLE DEPT
(
  DEPTNO  NUMBER(2),
  DNAME   VARCHAR2(14 BYTE),
  LOC     VARCHAR2(13 BYTE)
);


CREATE TABLE EMP
(
  EMPNO     NUMBER(4),
  ENAME     VARCHAR2(10 BYTE),
  JOB       VARCHAR2(9 BYTE),
  MGR       NUMBER(4),
  HIREDATE  DATE,
  SAL       NUMBER(7,2),
  COMM      NUMBER(7,2),
  DEPTNO    NUMBER(2)
);


CREATE TABLE SALGRADE
(
  GRADE  NUMBER,
  LOSAL  NUMBER,
  HISAL  NUMBER
);



ALTER TABLE DEPT ADD (
  CONSTRAINT PK_DEPT
 PRIMARY KEY
 (DEPTNO));

ALTER TABLE EMP ADD (
  CONSTRAINT PK_EMP
 PRIMARY KEY
 (EMPNO));

ALTER TABLE EMP ADD (
  CONSTRAINT FK_DEPTNO 
 FOREIGN KEY (DEPTNO) 
 REFERENCES DEPT (DEPTNO));


--
--
--Insert into DEPT
--   (DEPTNO, DNAME, LOC)
-- Values
--   (NULL, 'ACCOUNTING', 'NEW YORK');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (10, 'ACCOUNTING', 'NEW YORK');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (20, 'RESEARCH', 'DALLAS');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (30, 'SALES', 'CHICAGO');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (40, 'OPERATIONS', 'BOSTON');
COMMIT;




Insert into SCOTT.SALGRADE
   (GRADE, LOSAL, HISAL)
 Values
   (1, 700, 1200);
Insert into SCOTT.SALGRADE
   (GRADE, LOSAL, HISAL)
 Values
   (2, 1201, 1400);
Insert into SCOTT.SALGRADE
   (GRADE, LOSAL, HISAL)
 Values
   (3, 1401, 2000);
Insert into SCOTT.SALGRADE
   (GRADE, LOSAL, HISAL)
 Values
   (4, 2001, 3000);
Insert into SCOTT.SALGRADE
   (GRADE, LOSAL, HISAL)
 Values
   (5, 3001, 9999);
COMMIT;
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7369, 'SMITH', 'CLERK', 7902, 
    TO_DATE('12/17/1980 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 800, 20);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 Values
   (7499, 'ALLEN', 'SALESMAN', 7698, 
    TO_DATE('02/20/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1600, 300, 30);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 Values
   (7521, 'WARD', 'SALESMAN', 7698, 
    TO_DATE('02/22/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1250, 500, 30);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7566, 'JONES', 'MANAGER', 7839, 
    TO_DATE('04/02/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 2975, 20);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 Values
   (7654, 'MARTIN', 'SALESMAN', 7698, 
    TO_DATE('09/28/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1250, 1400, 30);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7698, 'BLAKE', 'MANAGER', 7839, 
    TO_DATE('05/01/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 2850, 30);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7782, 'CLARK', 'MANAGER', 7839, 
    TO_DATE('06/09/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 2450, 10);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7788, 'SCOTT', 'ANALYST', 7566, 
    TO_DATE('04/19/1987 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 3000, 20);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO)
 Values
   (7839, 'KING', 'PRESIDENT', 
    TO_DATE('11/17/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 5000, 10);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 Values
   (7844, 'TURNER', 'SALESMAN', 7698, 
    TO_DATE('09/08/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1500, 0, 30);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7876, 'ADAMS', 'CLERK', 7788, 
    TO_DATE('05/23/1987 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1100, 20);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7900, 'JAMES', 'CLERK', 7698, 
    TO_DATE('12/03/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 950, 30);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7902, 'FORD', 'ANALYST', 7566, 
    TO_DATE('12/03/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 3000, 20);
Insert into SCOTT.EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
 Values
   (7934, 'MILLER', 'CLERK', 7782, 
    TO_DATE('01/23/1982 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1300, 10);
COMMIT;