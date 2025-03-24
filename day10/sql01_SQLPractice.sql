/*
 * 기본 SELECT문
 * */

-- 문1. EMPLOYEES의 테이블에서 사원번호, 이름(이름 성 합쳐서 표시), 급여, 업무, 입사일, 상사의 사원번호로 출력하시오(107행)
SELECT employee_id
     , (first_name ||' ' || last_name) AS name
	 , salary
	 , job_id
	 , to_char(hire_date, 'yyyy-mm-dd') AS hire_date
	 , manager_id
 FROM employees;

SELECT * FROM employees;

-- 문2. Employee 테이블에서 모든 사원의 이름(last_name)과 연봉을 '이름: 1year salary = $연봉' 형식으로 출력하고, 컬럼명을 1 Year Salary로 변경하시오(107행)
SELECT (last_name || ': 1year salary = ' || to_char(salary * 12, '$999,999.99')) AS "1Year Salary" 
  FROM employees;



-- 문3. 부서별로 담당하는 업무를 한번씩만 출력하시오. (20행)
SELECT department_id, job_id
  FROM EMPLOYEES 
 GROUP BY job_id, department_id;

SELECT DISTINCT department_id, job_id
  FROM employees;

/*
 * WHERE절, ORDER BY절
 * */
-- 문4. Employees에서 급여가 7000~10000달러 범위이외 사람의 이름과 성을 full_name, 급여를 오름차순으로 출력하시오(75행)

SELECT (first_name ||' '||last_name) AS full_name, salary
  FROM employees
 WHERE 7000 > salary or 10000 < SALARY 
 ORDER BY salary;

SELECT (first_name ||' '||last_name) AS full_name, salary
  FROM employees
 WHERE salary NOT BETWEEN 7000 AND 10000
 ORDER BY salary ;

-- 문5. 현재 날짜 타입을 날짜 함수를 통해서 확인하고, 
-- 입사일자가 2003년 5월 20일부터 2004년 5월 20일 사이에 입사한 사원의 이름(full_name), 사원번호, 고용일자를 출력하시오.
-- 단 입사일을 빠른순으로 정렬하시오.(10행)

SELECT (first_name||' '||last_name) AS "FULL_name", employee_id, to_char(hire_date, 'yyyy-mm-dd') AS "hire_date"
  FROM employees
 WHERE hire_date BETWEEN '2003-05-20' AND '2004-05-20'
 ORDER BY hire_date ASC;
 
/*
 * 단일행 함수와 변환 함수
 * */

-- 문6. 이번분기, 60번 IT부서가 지대한 공헌을 했음.
-- IT부서 사원 급여를 15.3% 인상하기로 했다. 정수만 반올림.
-- 출력형식은 사번, full_name, 급여, 인상된 급여(Increased Salary) 출력(5행)

SELECT employee_id, (first_name||' '||last_name) AS "FULL_name", salary, (salary *1.153 ) AS "Increased Salary(참조)"
	 , round(salary*1.153) AS "increased Salary"
  FROM EMPLOYEES
 WHERE job_id = 'IT_PROG';

-- 문7. 모든 사원의 연봉을 표시하는 보고서 작성.
-- 사원 full_name, 급여, 수당여부에 따라 연봉을 표시하시오.
-- 수당이 있으면 salary + commission, 없으면 salary only라고 표시. 연봉이 높은 순으로 정렬할것(107행)
SELECT (first_name||' '||last_name) AS "FULL_name"
	 , salary
	 , (salary*12) + (salary*nvl(commission_pct,0)) AS "Annual Salary"z
	 , CASE WHEN commission_pct IS NULL THEN 'salary only'
	 		WHEN commission_pct IS NOT NULL THEN 'salary + commission'
	 		END AS "Commission?"
  FROM employees
 ORDER BY "Annual Salary" DESC;  -- "Annual Salary" 보다 컬럼순서인 3을 적는게 훨씬 효율적

/*
 * 집계함수, min, max, sum, avg, count....
 * */
 --문8. employees에서 각 사원이 소속된 부서별 급여합계, 급여평균, 급여최대값, 급여최소값 집계
 -- 출력형식은 여섯자리와 세자리 구분기호, $를 앞에 표시. 부서번호의 오름차순으로 정렬.
 -- 단 부서에 소속되지 않은 사원은 제외(11행)
 
SELECT department_id, TO_char(sum(salary),'$999,999') AS "급여합계"
	 , TO_char(avg(salary),'$99,999.99') AS "급여평균"
	 , TO_char(max(salary),'$99,999') AS "급여최대값"
	 , TO_char(min(salary),'$99,999') AS "급여최소값" 
  FROM employees
 WHERE department_id IS NOT NULL 
 GROUP BY department_id
 ORDER BY department_id;
 
 
/*
 * JOIN,
 * */
-- 문9. employees, departments, locations 테이블 구조파악
-- Oxford에 근무하는 사원 full_name, 업무, 부서명, 도시명을 출력하시오(34행)

SELECT (e.first_name||' '||e.last_name) AS "FULL_name", e.job_id, d.DEPARTMENT_NAME, l.CITY
  FROM employees e, departments d, locations l
 WHERE d.department_id = e.department_id
   AND d.location_id = l.location_id
   AND l.city = 'Oxford';

COMMIT;
-- 문10. 
SELECT * 
  FROM EMPLOYEES;

SELECT (e.first_name||' '||e.last_name) AS "FULL_name"
	 , e.job_id
	 , d.DEPARTMENT_NAME
  FROM employees e, departments d
 WHERE d.department_id(+) = e.department_id;

/*
 * 서브쿼리
 */

-- 문11. Tucker 사원보다 급여를 많이 받는 사원의 full_name, 업무, 급여를 출력(15행)
SELECT salary
  FROM employees
 WHERE last_name = 'Tucker';

-- 실쿼리
SELECT (first_name||' '||last_name) AS "FULL_name", job_id, salary
  FROM employees
 WHERE salary > (SELECT salary
  				  FROM employees
 				 WHERE last_name = 'Tucker');

-- 문12. 부서와 업무별 급여합계를 구하여서 급여수준 레벨을 지정하고자 함.
-- 부서별, 업무별 급여합계 및 각 부서별 총합, 각 부서별, 업무별 직원수를 출력하시오.(20행)
SELECT department_id, job_id
	 , to_char(sum(salary),'$99,999') AS "SUM_salary"
	 , count(*) AS "Employees Cnt"
  FROM employees
 GROUP BY ROLLUP(department_id, job_id);
COMMIT;






















