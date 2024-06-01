-- CONNECTION: url=jdbc:oracle:thin:@//DESKTOP-MD0C8U4:1521/STR
/*
-- CONNECTION: url=jdbc:oracle:thin:@//DESKTOP-MD0C8U4:1521/STR
-- New script in SCOTT.
-- Connection Type: dev 
-- Url: jdbc:oracle:thin:@//DESKTOP-MD0C8U4:1521/STR
-- workspace : C:\Users\dkswl\OneDrive\Documents\code_upload\Auto_window\multi_it\backend\db\db1
-- Date: 2024. 5. 6.
-- Time: 오후 10:29:24


SELECT SUM(SAL) FROM EMP;

SELECT SUM(COMM) FROM EMP;

SELECT SUM(DISTINCT SAL),
		SUM(ALL SAL),
		SUM(SAL)
		FROM EMP;
		
SELECT COUNT(*) FROM EMP; 

SELECT COUNT(*) FROM EMP WHERE DEPTNO=30;

SELECT COUNT(DISTINCT SAL),
		COUNT(ALL SAL),
		COUNT(SAL)
		FROM EMP;
		
	
SELECT COUNT(COMM) FROM EMP;	

SELECT COUNT(COMM) FROM EMP WHERE COMM IS NOT NULL;
	

SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10;
	
 	
SELECT MIN(SAL) FROM EMP WHERE DEPTNO=10;


SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO=20;


SELECT MIN(HIREDATE)
FROM EMP
WHERE DEPTNO=20;


SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO=30;


SELECT AVG(DISTINCT SAL)
	FROM EMP 
	WHERE DEPTNO= 30;


SELECT AVG(SAL), '10' AS DEPTNO FROM EMP WHERE DEPTNO =10
UNION  ALL 
SELECT AVG(SAL), '20' AS DEPTNO FROM EMP WHERE DEPTNO =20
UNION  ALL 
SELECT AVG(SAL), '30' AS DEPTNO FROM EMP WHERE DEPTNO =30;


SELECT AVG(SAL), DEPTNO
FROM EMP 
GROUP BY DEPTNO;


SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP GROUP BY DEPTNO, JOB ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL)>=2000
ORDER BY DEPTNO, JOB;



SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB 
HAVING AVG(SAL)>=2000
ORDER BY DEPTNO, JOB;

*/


SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL<=3000
GROUP BY DEPTNO, JOB 
HAVING AVG(SAL)>=2000
ORDER BY DEPTNO, JOB;


SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;


SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP GROUP BY ROLLUP(DEPTNO, JOB);


SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;



SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY DEPTNO, ROLLUP(JOB);


SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY JOB, ROLLUP(DEPTNO);


SELECT DEPTNO, JOB, COUNT(*)
FROM EMP 
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
GROUPING(DEPTNO),
GROUPING(JOB)
FROM EMP 
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DECODE(GROUPING(DEPTNO),1,'ALL_DEPT',DEPTNO) AS DEPTNO,
DECODE(GROUPING(JOB), 1, 'ALL_JOB',JOB) AS JOB,
COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;



SELECT DEPTNO, JOB, COUNT(*), SUM(SAL),
GROUPING(DEPTNO),
GROUPING(JOB),
GROUPING_ID(DEPTNO, JOB)
FROM EMP GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;


SELECT DEPTNO,ENAME
FROM EMP GROUP BY DEPTNO, ENAME;


SELECT deptno,
LISTAGG(ename, ', ')
WITHIN group(ORDER BY sal desc) AS enames
FROM EMP GROUP BY deptno;


SELECT deptno, job, max(sal)
FROM EMP 
GROUP BY deptno, JOB ORDER BY deptno, job;


SELECT *
FROM (SELECT deptno, job, sal FROM emp)
pivot(max(sal) FOR deptno IN (10,20,30))
ORDER BY job;


SELECT *
FROM (SELECT job, deptno, sal FROM emp)
pivot(max(sal)
FOR job IN ('CLERK' AS CLERK,
'SALESMAN' AS SALESMAN,
'PRESIDENT' AS PRESIDENT,
'MANAGER' AS MANAGER,
'ANALYST' AS ANALYST))
ORDER BY DEPTNO;



SELECT DEPTNO,
		MAX(DECODE(JOB, 'CLERK',SAL)) AS "CLERK",
		MAX(DECODE(JOB, 'SALESMAN',SAL)) AS "SALESMAN",
		MAX(DECODE(JOB, 'PRESIDENT',SAL)) AS "PRESIDENT",
		MAX(DECODE(JOB, 'MAANGER',SAL)) AS "MANAGER",
		MAX(DECODE(JOB, 'ANALYST',SAL)) AS "ANALYST"
		FROM EMP
	GROUP BY DEPTNO ORDER BY DEPTNO;


SELECT * FROM 
(SELECT DEPTNO,
		MAX(DECODE(JOB, 'CLERK',SAL)) AS "CLERK",
		MAX(DECODE(JOB, 'SALESMAN',SAL)) AS "SALESMAN",
		MAX(DECODE(JOB, 'PRESIDENT',SAL)) AS "PRESIDENT",
		MAX(DECODE(JOB, 'MAANGER',SAL)) AS "MANAGER",
		MAX(DECODE(JOB, 'ANALYST',SAL)) AS "ANALYST"
		FROM EMP
	GROUP BY DEPTNO 
	ORDER BY DEPTNO)

	UNPIVOT(SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST))
	ORDER BY DEPTNO, JOB
	
	;








