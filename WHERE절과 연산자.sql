--5장 교재 문제
--EMP테이블을 사용하여 다음과 같이 사원이름(ENAME)이 S로 끝나는 사원의 데이터를 모두 출력
SELECT *
FROM EMP
WHERE ename LIKE '%S';
--EMP 테이블을 사용하여 30번 부서에서 근무하고 있는 사원 중에 직책 
--JOB이 SALESMAN인 사원의 사원번호 , 이름 직책 급여 부서 번호를 출력하는 SQL 문을 완성하세요
SELECT EMPNO 사원번호, ENAME 사원이름 , JOB 직책, DEPTNO 부서번호
FROM EMP
WHERE JOB = 'SALESMAN'
AND DEPTNO =30;

--EMP 테이블을 사용하여 20번 30번 부서에 근무하고 있는 사원 중 급여가 2000초과인
--사원을 다음 두가지 방식의 SELECT문을 사용하여 사원번호, 이름, 급여, 부서번호 출력
--1. 집합연산자를 사용하지 않은 방식
--2. 집합연산자를 사용한 방식

SELECT EMPNO 사원번호, ENAME 사원이름, SAL 급여, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO = 20 and DEPTNO = 30 AND SAL > 2000;
