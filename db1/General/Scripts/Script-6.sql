-- CONNECTION: url=jdbc:oracle:thin:@//localhost:1521/XE
-- New script in SCOTT.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//localhost:1521/XE
-- workspace : C:\Users\dkswl\OneDrive\Documents\code_upload\Auto_window\multi_it\backend\db\db1
-- Date: 2024. 5. 9.
-- Time: 오후 11:24:40


CREATE SEQUENCE emp_seq
		INCREMENT BY 1
		START WITH 1
		MINVALUE 1
		MAXVALUE 9999
		nocycle
		nocache
		noorder;
		
	
SELECT emp_seq.nextval FROM dual;
SELECT emp_seq.currval FROM dual;



CREATE table board(
	no number(20) PRIMARY key,
	title varchar2(30),
	content varchar2(400),
	writer number(20)
); 


CREATE SEQUENCE board_seq
		INCREMENT BY 1
		START WITH 1
		minvalue 1
		MAXVALUE 99999
		nocycle
		nocache
		noorder;

