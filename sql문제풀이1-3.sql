 --문제풀이
 --COUNRIES 테이블 조회
SELECT *
FROM COUNTRIES;
--COUNTRIES 테이블에서 COUNTRY_ID와 COUNTRY_NAME컬럼만 조회
SELECT country_name, country_id
FROM COUNTRIES;

--COUNTRIES 테이블에서 컬럼명 COUNTRY_ID 를 국가ID, COUNTRY_NAME를 국가명으로 조회
SELECT COUNTRY_ID AS 국가ID , COUNTRY_NAME AS 국가명
FROM COUNTRIES;

--COUNTRUIES  테이블에서 REGION_ID를 중복제외하고 조회
SELECT DISTINCT REGION_ID
FROM COUNTRIES;

--COUNTRIES테이블에서  COUNTRY_NAME과 COUNTRY_ID를 연결하여 조회
SELECT COUNTRY_NAME || ' ' ||  COUNTRY_ID AS 이름
FROM countries;

--문제풀이 Q2
--EMPLOYEES  테이블에서 FIRST_NAME이 'DAVID'인 직원조회
SELECT *
FROM employees
WHERE first_name = 'David'; --입력값은 대소문자 구분

--jobs테이블에서 최소 월급이 4000달러인 직업 조회
SELECT job_title
FROM JOBS
WHERE min_salary < 4000;

--jobs테이블에서 최소 월급이 8000 초과인 직업 조회
SELECT job_title
FROM JOBS
WHERE min_salary > 8000;

--jobs테이블에서 최대 월급이 10000이하인 직업 조회
SELECT job_title
FROM JOBS
WHERE max_salary <= 10000;

--JOBS테이블에서 최소 월급이 4000이상이고 최대 월급이 10000이하는 직업 조회
SELECT *
FROM JOBS
WHERE min_salary <= 4000 AND max_salary >= 10000;

--EMPLOYEES 테이블에서 JOB_ID가 'IT_PROG'이면서 SASLARY 가 5000 초과인 직원조회
SELECT *
FROM employees
WHERE JOB_ID = 'IT_PROG' AND salary > 5000;

--문제풀이 Q3
--LOCATIONS 테이블에서 STREET_ADDRESS와 CITY 칼럼만 조회
SELECT STREET_ADDRESS, CITY
FROM LOCATIONS;

--JOBS 테이블에서 JOB_ID와 JOB_TITLE 컬럼만 조회
SELECT JOB_ID, JOB_TITLE
FROM JOBS;

--JOBS 테이블에서 JOB_TITLE,MIN_SALARY, MAX_SALARY 컬럼을
--최소연봉과 최대연봉을 10% 인상된 상태로 조회
SELECT JOB_TITLE,MIN_SALARY*1.1 AS 최소연봉, MAX_SALARY*1.1 AS 최대연봉
FROM JOBS;

--EMPLOYEES 테이블에서 FIRST_NAME과 LAST_NAME을 연결하고 컬럼명을 이름으로 조회
SELECT CONCAT(FIRST_NAME , LAST_NAME) AS 이름
FROM employees;

SELECT FIRST_NAME ||' '|| LAST_NAME AS 이름
FROM employees; 


--EMPLOYEES테이블에서 JOB_ID를 중복제회하고 조회
SELECT DISTINCT JOB_ID
FROM employees;


