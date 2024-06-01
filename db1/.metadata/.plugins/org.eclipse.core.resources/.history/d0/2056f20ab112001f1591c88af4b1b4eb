-- CONNECTION: url=jdbc:oracle:thin:@//localhost:1521/XE





-- localhost                - target database host
-- localhost         - tunnel host name
-- 1521                - target database port
-- ${server}              - target server name
-- XE            - target database name
-- dkswl                - database user name
-- jdbc:oracle:thin:@//localhost:1521/XE                 - connection URL
-- dev     - connection type
-- SCOTT          - datasource
-- C:\Users\dkswl\AppData\Roaming\DBeaverData\workspace6\General        - project path
-- General        - project name
-- 2024. 5. 10.                - current date
-- C:\Users\dkswl\AppData\Roaming\DBeaverData\workspace6           - workspace path
-- C:\Users\dkswl                - OS user home path
-- C:\Users\dkswl\AppData\Local\DBeaver        - application install path
-- C:\Users\dkswl\AppData\Local\DBeaver    - application install path
-- DBeaver    - application name
-- 24.0.3.202404211624 - application version
-- 222.99.55.135            - local IP address
-- 2024. 5. 10.                - current date
-- 오후 9:49:03                - current time
-- dkswl                - OS user name

drop table users cascade constraints;

CREATE TABLE USERS (
    USER_ID VARCHAR2(30) PRIMARY KEY,
    PW VARCHAR2(30) NOT NULL,
    COIN_COUNT NUMBER(10),
    NAME VARCHAR2(30),
    AGE NUMBER(3),
    TEL VARCHAR2(50),
    EMAIL VARCHAR2(50),
    SIGNUP_DATE DATE,
    DEL_ACC CHAR(1) DEFAULT 'N',
    DELETE_ACC_DATE DATE,
    CONSTRAINT CHK_DEL_ACC CHECK (DEL_ACC IN ('Y', 'N'))
);


INSERT INTO USERS VALUES('ID','PW',200,'JY',30,'010','JYU35467@GMAIL.COM','2024/01/01','N',NULL);
INSERT INTO USERS VALUES('ID2','PW2',300,'JY2',302,'0102','JYU35467@GMAIL.COM2','2024/01/02','N',NULL);
COMMIT;

CREATE SEQUENCE NO_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999
    NOCYCLE
    NOCACHE;


DROP TABLE BOARD;

CREATE TABLE BOARD (
    NO INT PRIMARY KEY,
    USER_ID VARCHAR2(30) NOT NULL,
    WRITE_DATE DATE,
    TITLE VARCHAR2(30),
    CONTENT VARCHAR2(400),
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER TRIGGER1
BEFORE INSERT ON BOARD
FOR EACH ROW
  WHEN (new.NO IS NULL)
BEGIN
  :new.NO := NO_SEQ.NEXTVAL;
END;

-- 왜래키 지정되어 있으므로 있는 ID값 대입하는 것 잊지 말기
INSERT INTO BOARD(USER_ID, WRITE_DATE, TITLE, CONTENT)
values('ID','2024/01/01','TITLE','CONTENT');
INSERT INTO BOARD(USER_ID, WRITE_DATE, TITLE, CONTENT)
values('ID2','2024/02/02','TITLE','CONTENT');

COMMIT;


DROP TABLE LEVELS cascade constraints;

CREATE TABLE LEVELS (
    LEVEL_NO NUMBER(10) PRIMARY KEY,
    SCORE NUMBER(20)
);

INSERT INTO LEVELS
VALUES (1,100);
INSERT INTO LEVELS
VALUES (2,200);
INSERT INTO LEVELS
VALUES (3,300);
COMMIT;




DROP TABLE RECORD;

CREATE TABLE RECORD(
    USER_ID VARCHAR2(30) PRIMARY KEY,
    HIGH_SCORE NUMBER(30),
    LEVEL_NO NUMBER(30) NOT NULL, --  invalid identifier : 레벨이 예약어로 보임
    TOTAL_SCORE NUMBER(30),
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE,
    FOREIGN KEY (LEVEL_NO) REFERENCES LEVELS(LEVEL_NO) ON DELETE CASCADE
);

INSERT INTO RECORD VALUES('ID',200,1,500);
COMMIT;


DROP TABLE ITEMS cascade constraints;

CREATE TABLE ITEMS (
    ITEM_NO NUMBER(10) PRIMARY KEY,
    ITEM_NAME VARCHAR2(30),
    ITEM_PRICE NUMBER(30)
);

INSERT INTO ITEMS VALUES(1,'물약',1000);
COMMIT;

DROP TABLE ITEM_INVT;

CREATE TABLE ITEM_INVT (
    USER_ID VARCHAR2(30),
    ITEM_NO NUMBER(10),
    ITEM_COUNT NUMBER(10),
    CONSTRAINT pk_item_invt PRIMARY KEY (USER_ID, ITEM_NO),
    CONSTRAINT fk_user_id FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE,
    CONSTRAINT fk_item_no FOREIGN KEY (ITEM_NO) REFERENCES ITEMS(ITEM_NO) ON DELETE CASCADE
);


INSERT INTO ITEM_INVT VALUES('ID',1,2);
COMMIT;

DROP TABLE COIN_INVT;




CREATE OR REPLACE TRIGGER TRG_USERID
AFTER UPDATE ON USERS FOR EACH ROW
BEGIN
	UPDATE ITEM_INVT SET USER_ID=:NEW.USER_ID WHERE USER_ID=:OLD.USER_ID;
	UPDATE RECORD SET USER_ID=:NEW.USER_ID WHERE USER_ID=:OLD.USER_ID;
	UPDATE BOARD SET USER_ID=:NEW.USER_ID WHERE USER_ID=:OLD.USER_ID;
END;































