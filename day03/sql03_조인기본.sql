/*
 * JOIN
 * */
-- 개념
-- 정규화되어 나누어진 테이블의 데이터를 한꺼번에 모아서 쉽게 출력하기 위한 기법
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;

SELECT d.*
  FROM departments d
 WHERE d.department_id = 100;

-- 총 데이터수가 2889개 출력
-- 카테시안 곱
SELECT *
  FROM employees e, departments d

-- 오라클 방식. 표준방식 아님. 편하게 쿼리를 작성하라고 만든 편법.
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;

-- ANSI 표준 문법
SELECT *
  FROM employees e
 INNER JOIN departments d
 	ON e.department_id = d.department_id;

-- 필요컬럼만 명세
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "full_name"
	 , e.email, e.PHONE_NUMBER
	 , e.hire_date, e.JOB_ID
	 , d.department_name
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;

-- 내부조인(INNER JOIN)
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "full_name"
	 , e.email, e.PHONE_NUMBER
	 , e.hire_date, e.JOB_ID
	 , d.DEPARTMENT_ID
	 , d.department_name
	 , l.city, l.STATE_PROVINCE, l.STREET_ADDRESS
  FROM employees e, departments d, locations l
 WHERE e.department_id = d.department_id
   AND l.location_id = d.location_id
   AND d.department_id = 60;

-- 외부조인
-- 보통 PK와 FK간의 일치하는 조건의 데이터를 찾는것 - 내부조인
-- PK와 FK간의 일치하지 않는 조건의 데이터도 찾는것 - 외부조인
-- 테이블1 OUTER JOIN 테이블2
-- 테이블1번을 기준으로 외부조인 LEFT OUTER JOIN
-- 테이블2번을 기준으로 외부조인 RIGHT OUTER JOIN

SELECT *
  FROM employees e
 INNER JOIN departments d
    ON e.department_id = d.department_id;

-- ANSI 표준 문법
-- employees테이블에는 있는데 departments테이블에는 없는 데이터를 출력해줘
SELECT *
  FROM employees e
  LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
 WHERE e.department_id IS null;

-- departments테이블에는 있는데 employees테이블에는 없는 데이터를 출력해줘
SELECT *
  FROM employees e
 RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;

-- Oracle 문법
-- (+)만족하지 않는 조건도 더 나오게 한다는 뜻
-- LEFT OUTER JOIN
SELECT *
  FROM employees e, departments d
 WHERE e.department_id = d.department_id(+)

 -- RIGHT OUTER JOIN
 SELECT *
  FROM employees e, departments d
 WHERE e.department_id(+) = d.department_id

 -- INNER JOIN은 INNER를 생략가능
 -- OUTER JOIN에만 LEFT,RIGHT존재하므로, OUTER 생략가능
 
 -- 셀프조인: 자기자신을 두번 사용하는 조인
SELECT e1.employee_id
	 , e1.FIRST_NAME || ' ' || e1.LAST_NAME AS "full_emp_name"
	 , e1.job_id
	 , e1.manager_id
	 , e2.first_name || ' ' || e2.last_name AS "full_mng_name"
	 , e2.job_id
	 , e1.manager_id
  FROM employees e1, employees e2
 WHERE e1.manager_id = e2.EMPLOYEE_ID(+)
 ORDER BY e1.employee_id;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 