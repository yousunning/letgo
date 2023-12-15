--9장 서브쿼리(쿼리 안 쿼리)
--서브쿼리로 JONES의 급여보다 높은 급여를 받는 사원 출력하기
SELECT *
FROM EMP
WHERE SAL>(SELECT SAL
            FROM EMP
                WHERE ENAME ='JONES');
--서브쿼리 특징
--1. 연산자와 같은 비교 또는 조회 대상의 오른쪽에 놓이며 괄호()로 묶어사용
--2. ORDER BY 딱히 ? 굳이? 잘안씀
--3. 비교대상 데이터가 하나라면 서브쿼리의 SELECT절 역시 같은 자료형인 열을 지정
--4. 단일행 연산자 경우 서브쿼리의 출력결과가 단일행이어야 한다.
SELECT *
FROM EMP
WHERE COMM >(SELECT COMM
            FROM EMP
                WHERE ENAME ='ALLEN');

--09-2절 부터 실행 결과가 하나인 단일행 서브쿼리
--단일행 서브쿼리와 날짜형 데이터
--서브쿼리 결과 값이 날짜인 경우
--SCOTT직원보다 먼저 입사한 직원출력
SELECT *
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
                    FROM EMP
                        WHERE ENAME = 'SCOTT');
--단일형 서브쿼리와 함수
--서브쿼리 안에서 함수를 사용한 경우
--20번 부서에서 전직원 평균 월급보다 많이 받는 직원출력
SELECT E.ENAME, E.EMPNO, E.JOB, E.SAL, D.DEPTNO, D.DNAME
    FROM  EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND   E.DEPTNO = 20 --AND 조건
    AND   E.SAL > ( SELECT AVG(SAL) FROM EMP);

SELECT AVG(SAL)
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 20 
AND E.SAL >= (SELECT AVG(SAL)FROM EMP);

--09-3 실행결과가 여러개인 다중행 서브쿼리
--다중행 연산자 : 
--IN : 결과중 하나라도 일치하는 데이터가 있으면 TRUE
--ANY,SUM : 하나 이상이면 TRUE
--ALL : 서브쿼리에 결과가 모두 만족하면                        
--EXISTS : 결과값이 존재하면 (행이 하나라도 있으면) TRUE                        

--IN연산자
--부서번호가 20번 이서나 30인 사우너정보 출력
SELECT * FROM EMP WHERE DEPTNO IN (20,30);
--각 부서별 최고급여와 동일한 급여를 받는 사원정보 출력하기
SELECT * FROM EMP WHERE SAL IN -- 단일행 연산자 쓰지 않도록 주의
    (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

SELECT MAX(SAL) --2850. 3000. 5000
FROM EMP
GROUP BY DEPTNO;

--9-11
SELECT * FROM EMP
WHERE SAL = ANY(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

SELECT * FROM EMP
WHERE SAL = ANY(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

--30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보를 촐력
--************단 MAX 함수 사용금지
SELECT * FROM EMP--ANY 
WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO=30);

--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보를 촐력
--**************단 MIN 함수 사용금지
SELECT * FROM EMP--ANY -2850 보다 적은 사원정보 출력하기
WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO=30);

--SOME 연산자 
SELECT * FROM EMP
WHERE SAL = SOME(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--30번 부서 사원들 최소급여보다 적은 급여를 받은 사원출력
SELECT * FROM EMP--*********  ALL 모든 조건 만족함수
WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

--부서번호가 30번인 사원들 최대급여보다 더 많이 급여를 받는 사원출력
-- 단 MAX 함수 사용금지
SELECT * FROM EMP--*********  ALL ()괄호 안 모든 조건 만족함수
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

--EXISTS연산자
--서브쿼리 결과값이 존재하는 경우
SELECT *
FROM EMP    --      (1)하나라도 있음 출력
WHERE EXISTS (SELECT 1 FROM DEPT WHERE DEPTNO =40);
--서브쿼리 결과값이 존재하지않는 경우                 
     SELECT *
FROM EMP    --      하나라도 있음 출력
WHERE EXISTS (SELECT 1 FROM DEPT WHERE DEPTNO =50);                   

--EMP 사원중 10번 부서 사원들 보다 먼저 입사한 직원정보
--해석 : DEPTNO 10보다 빠른 HITEDATE인 EMP정보
SELECT * FROM EMP WHERE HIREDATE < 
ALL (SELECT HIREDATE FROM EMP WHERE DEPTNO =10);

--상관서브쿼리 - 인덱스를 타고오기 때문에 데이터 조회 빠름
--각 부서의 최대급여를 받는 사원의 부서코드, 이름, 급여를 출력해라
--단 상관서브쿼리 사용

SELECT DEPTNO , ENAME, SAL 
FROM EMP E1--애일리언스 
WHERE E1.SAL = (SELECT MAX(SAL) FROM EMP E2 WHERE E2.DEPTNO = E1.DEPTNO);

--부서테이블에서 사원을 한명이라도 가지고 있는 부서를 출력하시오

SELECT D.DNAME AS 부서명, D.DEPTNO AS 부서번호
FROM DEPT D
WHERE EXISTS (SELECT 8 FROM EMP WHERE DEPTNO = D.DEPTNO);

--해당부서 중 한명도 없는 부서 출력
SELECT D.DNAME AS 부서명, D.DEPTNO AS 부서번호
FROM DEPT D
WHERE NOT EXISTS (SELECT 8 FROM EMP WHERE DEPTNO = D.DEPTNO);

--고객중 주문을 한번이라도 한 고객 조회EXISTS / 한번도 하지 않은 고객들을 조회 NOT EXISTS
--제품중 한번 이상 주문된 제품정보 조회
--제품 중 한번도 주문 안된 제품정보 조회
--09-4 비교할 열이 여러개인 다중열 서브쿼리
SELECT *
FROM  EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO,MAX(SAL) 
                                        FROM EMP    
                                            GROUP BY DEPTNO);
                                            
--09-5 FROM절에 사용하는 서브쿼리와[인라인뷰] WITH절
--9-19예제
SELECT E10.EMPNO, E10.ENAME, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO =10)E10
    ,(SELECT * FROM DEPT) D
    WHERE E10.DEPTNO = D.DEPTNO;
    
--WITH 절 사용하기
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

--상호연관 서브쿼리
SELECT * FROM EMP E1 WHERE SAL > 
            (SELECT MIN(SAL) FROM EMP E2 WHERE E2.DEPTNO = E1.DEPTNO)
        ORDER BY DEPTNO, SAL;

--9-6 SELECT 절에 사용하는 서브쿼리
SELECT E.EMPNO, E.ENAME, E.JOB , E.SAL
,(SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) SGRADE
,E.DEPTNO
,(SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
FROM EMP E; 

--정체사원중 ALLEN과 같은 직책(JOB)인 사원들의 사원정보, 부서 정보를 다음과 같이 출력하는 
--SQL문을 작성하라.
SELECT EMPNO 사원번호, ENAME 사원이름 , SAL, DEPTNO 부서번호 , JOB 직업  
FROM EMP
WHERE JOB = ( SELECT JOB
                FROM EMP
             WHERE ENAME = 'ALLEN');
             
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND JOB = (SELECT JOB
                FROM EMP
               WHERE ENAME = 'ALLEN'); 
             
--전체 사원의 평균 급여 보다 높은 그별을 받는 사원들의 사원정보 부서정보 급여등급 정보를 출력
--단 출력할 때 급여나 많은 순으로 정렬, 급여가 같은 경우엔 사원번호 기준으로 오름차순
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC , E.SAL, S.GRADE
FROM EMP E , DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO --?????????????
AND E.SAL BETWEEN S.LOSAL AND S.HISAL 
AND SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO; 
  --오류
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIFRDATE, D.LOC , E.SAL, S.GRADE
FROM EMP E , DEPT D, SALGRADE S
WHERE AVG(SAL) > (SELECT S.GRADE
FROM EMP
ORDER BY S.GRADE, D.DEPTNO); 
--10번 부서에 근무하는 사원 중 (서브 쿼리 먼저 만들기 : 30번 부서에는 존재하지 않는 직책으르 가진 사원정보) , 부서 정보를 다음과 같이 출력
SELECT EMPNO, ENAME, JOB, DEPTNO, DNAME, LOC
FROM EMP , DEPT 
WHERE JOB =10 NOT IN (SELECT JOB
                    FROM EMP
                    WHERE DEPTNO = 30); --ME

SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE e.deptno = d.deptno
AND E.DEPTNO =10
AND JOB NOT IN (SELECT DISTINCT JOB
                    FROM EMP
                    WHERE DEPTNO = 30);
                    
 SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE e.deptno = d.deptno
AND E.DEPTNO =10
AND NOT EXISTS (SELECT JOB
                    FROM EMP
                    WHERE DEPTNO = 30 AND JOB = E.JOB);

--직책이SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보 , 급여 등급
--정보를 다음과 같이 출력하는 SQL문을 작성하세요
--단 서브쿼리를 활용할 대 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해서 사원번호를
--기준으로 오름차순 정렬해라.
-- 9-4
-- 다중행 함수 사용하지 않는 방법
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > (SELECT MAX(SAL)
                FROM EMP
               WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO; 

--다중행 함수 사용하는 방법
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > ALL (SELECT DISTINCT SAL
                    FROM EMP
                   WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO; 

--------------WITH
SELECT E.ENAME, EMPS1.EMP_CNT, M.ENAME AS MGR_NAME, EMPS2.EMP_CNT MGR_CNT
FROM EMP E
    , (SELECT DEPTNO, COUNT(*) AS EMP_CNT FROM EMP GROUP BY DEPTNO) EMPS1
    , EMP M
    , (SELECT DEPTNO, COUNT(*) AS EMP_CNT FROM EMP GROUP BY DEPTNO) EMPS2
WHERE E.DEPTNO = EMPS1.DEPTNO
  AND E.MGR = M.EMPNO
  AND M.DEPTNO = EMPS2.DEPTNO;
  -- - - - -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -- -
WITH EMP_CNT AS(
  SELECT DEPTNO, COUNT(*) AS DEPT_CNT FROM EMP GROUP BY DEPTNO
  )
  SELECT E.ENAME, EMPS1.DEPT_CNT, M.ENAME AS MGR_NAME, EMPS2.DEPT_CNT MGR_CNT
    FROM EMP E
    , EMP_CNT EMPS1
    , EMP M
    , EMP_CNT EMPS2
   WHERE E.DEPTNO = EMPS1.DEPTNO
       AND E.MGR = M.EMPNO
       AND M.DEPTNO = EMPS2.DEPTNO;
  
