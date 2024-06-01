-- CONNECTION: url=jdbc:oracle:thin:@//localhost:1521/XE
-- New script in SCOTT.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : C:\Users\dkswl\OneDrive\Documents\code_upload\Auto_window\multi_it\backend\db\db1
-- Date: 2024. 5. 9.
-- Time: 오후 10:51:09


CREATE TABLE MEMBER (
	ID NUMBER PRIMARY KEY,
	PW VARCHAR2(10), 
	NAME VARCHAR2(10),
	TEL VARCHAR2(10),
	CREAT_DATE DATE
	
);