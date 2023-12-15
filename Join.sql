--8장 교재풀이
     --Q1
       SELECT D.deptno,D.dname, E.ename , E.sal
        FROM emp E RIGHT OUTER JOIN dept D ON (E.deptno=D.deptno)
        WHERE sal > 2000
        ORDER BY D.deptno, E.empno;

        SELECT deptno, dname , empno , ename , sal
        FROM emp E NATURAL JOIN dept D
        WHERE E.sal >2000;
        
        SELECT deptno, dname , empno , ename , sal
        FROM emp E NATURAL JOIN dept D
        WHERE sal >2000;
        
-- 8-2
--SQL-99 이전 방식
SELECT D.deptno,
       D.dname,
       TRUNC(AVG(sal)) AS avg_sal,
       MAX(sal) AS max_sal,
       MIN(sal) AS min_sal,
       COUNT(*) AS cnt
  FROM emp E, dept D
 WHERE E.deptno = D.deptno
GROUP BY D.deptno, D.dname;

--SQL-99 방식
SELECT deptno,
       D.dname,
       TRUNC(AVG(sal)) AS avg_sal,
       MAX(sal) AS max_sal,
       MIN(sal) AS min_sal,
       COUNT(*) AS cnt
  FROM emp E JOIN dept D USING (deptno)
GROUP BY deptno, D.dname;

-- 8-3
--SQL-99 이전 방식
SELECT D.deptno, D.dname, E.empno, E.ename, E.JOB, E.sal
  FROM emp E, dept D
 WHERE E.deptno(+) = D.deptno
ORDER BY D.deptno, E.ename;

--SQL-99 방식
SELECT D.deptno, D.dname, E.empno, E.ename, E.JOB, E.sal
  FROM emp E RIGHT OUTER JOIN dept D ON (E.deptno = D.deptno)
ORDER BY D.deptno, E.ename;

-- 8-4
--SQL-99 이전 방식
SELECT D.deptno, D.dname,
       E.empno, E.ename, E.mgr, E.sal, E.deptno,
       S.losal, S.hisal, S.grade,
       e2.empno AS mgr_empno, e2.ename AS mgr_ename
  FROM emp E, dept D, salgrade S, emp e2
 WHERE E.deptno(+) = D.deptno
   AND E.sal BETWEEN S.losal(+) AND S.hisal(+)
   AND E.mgr = e2.empno(+)
ORDER BY D.deptno, E.empno; 

--SQL-99방식
SELECT D.deptno, D.dname,
       E.empno, E.ename, E.mgr, E.sal, E.deptno,
       S.losal, S.hisal, S.grade,
       e2.empno AS mgr_empno, e2.ename AS mgr_ename
  FROM emp E RIGHT OUTER JOIN dept D ON (E.deptno = D.deptno)-- 조인 조건식
              LEFT OUTER JOIN salgrade S ON (E.sal BETWEEN S.losal AND S.hisal)-- 조인 조건식
              LEFT OUTER JOIN emp e2 ON (E.mgr = e2.empno)-- 조인 조건식
ORDER BY D.deptno, E.empno; 
        
        
SELECT D.deptno, D.dname,
       E.empno, E.ename, E.mgr, E.sal, E.deptno,
       S.losal, S.hisal, S.grade,
       e2.empno AS mgr_empno, e2.ename AS mgr_ename
  FROM emp E RIGHT OUTER JOIN dept D ON (E.deptno = D.deptno)
              LEFT OUTER JOIN salgrade S ON (E.sal BETWEEN S.losal AND S.hisal)
              LEFT OUTER JOIN emp e2 ON (E.mgr = e2.empno)
ORDER BY D.deptno, E.empno;


----------강사님 문제-------------------------------------------------
    
SELECT C.country_name, L.state_province, L.street_address
FROM countries C, locations L
ORDER BY C.country_id;
        
 SELECT j.job_id, j.job_title, H.start_date, H.end_date
 FROM jobs j , job_history H
 ORDER BY j.job_id;
 
 SELECT E.first_name, E.last_name, D.department_name, j.job_title 
 FROM employees E,departments D , jobs j
 --WHERE D.DEPERTMENET_ID(+) = e.employee_id
 ORDER BY j.job_title;

 --외부조인!!!!!!!!!!!!
SELECT C.country_id, C.country_name , L.city
FROM countries C LEFT OUTER JOIN locations L ON (C.country_id=L.country_id) 
ORDER BY C.country_id;

--외부조인
SELECT E.first_name, E.last_name, D.department_name
FROM employees E RIGHT OUTER JOIN departments D ON (E.department_id=D.department_id)
ORDER BY employee_id;

--자체조인한 뒤에 결합하고 기준으로 정렬하여 조회
SELECT E.manager_id, E.employee_id, E.first_name, E.last_name
FROM employees E , employees M
WHERE M.employee_id = E.employee_id;


--1. 사원번호, 사원이름, 부서이름, 부서번호를 출력하시오. 
--( Natural 조인 ,  Join On  , Join Using )

SELECT E.empno, E.ename, D.deptno, D.dname 
FROM emp E , dept D
WHERE D.deptno = E.empno;

SELECT E.empno, E.ename, D.dname, D.deptno
FROM emp E LEFT OUTER JOIN dept D ON (E.deptno= D.deptno)
ORDER BY E.empno;

SELECT E.empno, E.ename, D.dname ,deptno
FROM emp E NATURAL JOIN dept D;

--2. 부서가 30이고, 급여가 1500이상인 
--사원의 이름, 급여, 부서명, 부서번호를 출력하시오. ( Join on )
SELECT E.ename, E.sal, D.dname, D.deptno
FROM emp E JOIN dept D ON (E.deptno= D.deptno)
WHERE E.deptno = 30 AND sal >=1500
ORDER BY E.ename;
--3. 사원수가 5명이 넘는 부서의 부서명과 사원수를 출력하시오. GROUP BY / =
SELECT D.dname,COUNT(*)
FROM emp E, dept D
WHERE E.deptno = D.deptno
GROUP BY D.dname
HAVING COUNT(*) > 5;
--4. ADAMS 사원이 근무하는 부서이름과 지역이름을 출력하시오.
SELECT D.dname , D.loc
FROM emp E , dept D
WHERE E.ename = 'ADAMS';
--5. NEW YORK 이나 DALLAS 지역에 근무하는 사원들의 
--사원번호, 사원이름을 사원번호 순으로  출력하시오.

SELECT E.empno , E.ename
FROM emp E , dept D
GROUP BY 'NEW YORK', 'DALLAS', E.empno, E.ename
ORDER BY e.empno ASC;

SELECT E.empno , E.ename
FROM emp E , dept D
WHERE d.loc IN ('NEW YORK', 'DALLAS')
ORDER BY e.empno ASC;
