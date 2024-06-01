-- CONNECTION: url=jdbc:oracle:thin:@//localhost:1521/XE
-- New script in SCOTT.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : C:\Users\dkswl\OneDrive\Documents\code_upload\Auto_window\multi_it\backend\db\db1
-- Date: 2024. 5. 10.
-- Time: 오후 10:57:25



CREATE TABLE USERS (
    USER_ID VARCHAR2(30) PRIMARY KEY,
    PW VARCHAR2(30) NOT NULL,
    NAME VARCHAR2(30),
    AGE NUMBER(3),
    TEL VARCHAR2(50),
    EMAIL VARCHAR2(50),
    SIGNUP_DATE DATE,
    DEL_ACC CHAR(1) DEFAULT 'N',
    DELETE_ACC_DATE DATE,
    CONSTRAINT CHK_DEL_ACC CHECK (DEL_ACC IN ('Y', 'N'))
);
