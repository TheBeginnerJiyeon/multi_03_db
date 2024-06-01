-- CONNECTION: url=jdbc:oracle:thin:@//DESKTOP-MD0C8U4:1521/STR
-- New script in HR.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//DESKTOP-MD0C8U4:1521/STR
-- workspace : C:\Users\dkswl\OneDrive\Documents\code_upload\Auto_window\multi_it\backend\db\db1
-- Date: 2024. 5. 9.
-- Time: 오전 11:42:54

-- 함수
   
-- 1. 직원의 이름과 이메일, 이메일 길이를 출력하시오
--		  직원명	    이메일		이메일길이
--	ex) 	홍길동 , hong  	  13

SELECT (FIRST_NAME || ' ' || LAST_NAME) AS NAME  ,
EMAIL, LENGTH(EMAIL) 
FROM EMPLOYEES;

-- 2. 2001 AND 2005년에 고용된  직원명과 입사년도, 보너스 값을 출력하시오 
--	그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오


SELECT (FIRST_NAME || ' ' || LAST_NAME) AS NAME,
		EXTRACT (YEAR FROM HIRE_DATE) AS YEAR,
		SALARY * NVL(COMMISSION_PCT,0) AS BONUS
FROM EMPLOYEES;

-- 3. '515' 핸드폰 번호를 사용하지 않는 사람의 수를 출력하시오(뒤에 단위는 명을 붙이시오)

SELECT COUNT(*) || '명' FROM EMPLOYEES 
WHERE SUBSTR(PHONE_NUMBER,1,3)!='515';



-- 4. 직원명과 입사년월을 2003년 6월 형태로 출력하시오
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    EMP_NAME		HIRE_YY
--	ex) 리사		       1997년 3월


SELECT FIRST_NAME AS EMP_NAME,
		TO_CHAR(HIRE_DATE,'RRRR"년" fmMM"월"') AS HIRE_YY		
FROM EMPLOYEES ;



--5 . 부서코드가 50,90인 직원들 중에서 2004년도에 입사한 직원 조회
-- 120(EMPNO)	Matthew Weiss(ENAME)	50(DEPTID)	2004-07-18(HIRE_DATE)  형식으로 출력 


SELECT EMPLOYEE_ID AS EMPNO,
(FIRST_NAME || ' ' || LAST_NAME) AS ENAME,
DEPARTMENT_ID AS DEPTID,
TO_CHAR(HIRE_DATE,'YYYY-MM-DD') AS HIRE_DATE 
FROM EMPLOYEES 
WHERE DEPARTMENT_ID  IN (50,90)
AND EXTRACT(YEAR FROM HIRE_DATE)=2004
;



--6 . 직원명, 입사일, 오늘까지의 근무일수 조회 * 주말도 포함 , 소수점 아래는 버림

SELECT (FIRST_NAME || ' ' || LAST_NAME) AS ENAME,
TO_CHAR(HIRE_DATE,'YYYY-MM-DD') AS HIRE_DATE,
TRUNC(SYSDATE - HIRE_DATE) AS WORKDAY
FROM EMPLOYEES ;


-- 7,8번 안 함

-- 7. 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수를 구하시오
--  아래의 년도에 입사한 인원수를 조회하시오. 마지막으로 전체직원수도 구하시오

--  => to_char, decode, sum 사용
--
--	-------------------------------------------------------------------------
--	 2001년   2002년   2003년   2004년   2005년   2006년   2007년 2008년 전체직원수
--	-------------------------------------------------------------------------


SELECT DISTINCT()  FROM EMPLOYEES ;

SELECT COUNT(*) FROM EMPLOYEES 
WHERE TO_CHAR(HIRE_DATE,'YYYY') IN ('2001', '2002','2003','2004','2005'); 



--8. 부서코드가 50이면 총무부, 60이면 기획부, 90이면 영업부로 처리하시오
--   단, 부서코드가 50, 60, 90 인 직원의 정보만 조회함
--  => case 사용
--   부서코드 기준 오름차순 정렬함.
SELECT * FROM EMPLOYEES;


SELECT * FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN (50,60,90)

JOIN

SELECT CASE 
			WHEN DEPARTMENT_ID =50 THEN '총무부'
			WHEN DEPARTMENT_ID =60 THEN '기획부'
			WHEN DEPARTMENT_ID =90 THEN '영업부'			
		END AS DEPT_NAME 
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50,60,90); 
		




















