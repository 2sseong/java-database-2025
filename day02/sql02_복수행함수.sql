/*
 * 복수행, GROUP BY와 가장 많이 사용
 * COUNT(), SUM(), AVG(), MIN/MAX(), STDDEV(), ...
 * ROLLUP, CUBE, RANK, DENSE_RANK....
 * */
-- COUNT() -- 무지무지무지 많이 씀
SELECT count(*) -- scalar value
  FROM employees;

SELECT count(employee_id) -- scalar value
  FROM employees;

-- SUM(숫자형컬럼) 합계(컬럼값) 합계. 컬럼은 숫자형만
-- employees 206 salary 8300 삭제
SELECT sum(salary)
  FROM employees;

-- AVG(숫자형컬럼) 평균
-- 컬럼에 NULL값이 있으면 제외하고 계산하기 때문에 잘못된 값이 도출
-- 금액이나 수량을 계산하는 컬럼의 NULL값은 항상 전처리 해줘야 함. 
SELECT avg(salary)
  FROM employees;

SELECT count(salary)
  FROM employees;

-- MIN(숫자형컬럼|문자형), MAX()
SELECT min(salary), max(salary), max(first_name)
  FROM employees;

/*
 * GROUP BY 연계, 데이터 그룹화 
 * GROUP BY를 사용하면 SELECT절에는 GROUP BY 사용한 컬럼과 집계함수 및 일반함수만 사용할 수 있음
 */
-- 아래의 경우 department_id 이외의 컬럼은 사용불가
SELECT department_id
	 , avg(salary) AS 부서별평균급여
     , to_char(round(avg(salary),1), '99,999.9') AS 부서별평균급여
     , sum(salary) AS 부서별급여총액
  FROM employees
GROUP BY department_id
ORDER BY avg(salary) DESC;

-- employees에서 부서와 직군별 급여총액과 직원수를 출력
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
	 , count(*)
 FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

-- employees에서 부서와 직군별 급여총액과 직원수를 출력하는데
-- department_id가 30에서 90사이이고, 부서직군별급여총액이 20000달러 이상인 데이터만 보일것
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
	 , count(*)
 FROM employees
WHERE department_id BETWEEN 30 AND 90
--  AND sum(salary) >= 20000 --집계함수는 WHERE에 사용불가
HAVING sum(salary) >= 20000
GROUP BY department_id, job_id
ORDER BY department_id;

-- ORDER BY에는 컬럼의 순번(1부터 시작)으로 컬럼명을 대체가능
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
	 , count(*)
 FROM employees
WHERE department_id BETWEEN 30 AND 90
--  AND sum(salary) >= 20000 --집계함수는 WHERE에 사용불가
HAVING sum(salary) >= 20000
GROUP BY department_id, job_id
ORDER BY 3 DESC;

-- ROLLUP 그룹별 소계와 총계를 표시해주는 기능
-- ORDER BY 사용안함 HAVING절 사용 가능
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
	 , count(*)
 FROM employees
WHERE department_id BETWEEN 30 AND 90
GROUP BY ROLLUP(department_id, job_id);

-- PIVOT() 엑셀에 동일한 기능
-- PIVOT 안쓰고 각 달별로 입사한 사원의 수를 표시
-- 각 입사일자에서 달만 추출
SELECT TO_char(hire_date,'MM')
  FROM employees;

-- 입사 달별로 그룹핑
SELECT TO_char(hire_date,'MM'), count(*)
  FROM employees
GROUP BY to_char(hire_date,'MM')
ORDER BY to_char(hire_date,'MM');


-- 1월달에 입사한 사람 카운팅
SELECT CASE TO_char(hire_date,'MM') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
  FROM employees
GROUP BY to_char(hire_date,'MM');

-- 옆으로 각 달별로 스프레드
SELECT CASE TO_char(hire_date,'MM') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
	 , CASE TO_char(hire_date,'MM') WHEN '02' THEN count(*) ELSE 0 END AS "2월"
	 , CASE TO_char(hire_date,'MM') WHEN '03' THEN count(*) ELSE 0 END AS "3월"
	 , CASE TO_char(hire_date,'MM') WHEN '04' THEN count(*) ELSE 0 END AS "4월"
	 , CASE TO_char(hire_date,'MM') WHEN '05' THEN count(*) ELSE 0 END AS "5월"
	 , CASE TO_char(hire_date,'MM') WHEN '06' THEN count(*) ELSE 0 END AS "6월"
	 , CASE TO_char(hire_date,'MM') WHEN '07' THEN count(*) ELSE 0 END AS "7월"
	 , CASE TO_char(hire_date,'MM') WHEN '08' THEN count(*) ELSE 0 END AS "8월"
	 , CASE TO_char(hire_date,'MM') WHEN '09' THEN count(*) ELSE 0 END AS "9월"
	 , CASE TO_char(hire_date,'MM') WHEN '10' THEN count(*) ELSE 0 END AS "10월"
	 , CASE TO_char(hire_date,'MM') WHEN '11' THEN count(*) ELSE 0 END AS "11월"
	 , CASE TO_char(hire_date,'MM') WHEN '12' THEN count(*) ELSE 0 END AS "12월"
  FROM employees
GROUP BY to_char(hire_date,'MM')
ORDER BY to_char(hire_date,'MM');

-- decode
SELECT decode(TO_char(hire_date,'MM'),'01', count(*),0) AS "1월"
	 , decode(TO_char(hire_date,'MM'),'02', count(*),0) AS "2월"
	 , decode(TO_char(hire_date,'MM'),'03', count(*),0) AS "3월"
	 , decode(TO_char(hire_date,'MM'),'04', count(*),0) AS "4월"
	 , decode(TO_char(hire_date,'MM'),'05', count(*),0) AS "5월"
	 , decode(TO_char(hire_date,'MM'),'06', count(*),0) AS "6월"
	 , decode(TO_char(hire_date,'MM'),'07', count(*),0) AS "7월"
	 , decode(TO_char(hire_date,'MM'),'08', count(*),0) AS "8월"
	 , decode(TO_char(hire_date,'MM'),'09', count(*),0) AS "9월"
	 , decode(TO_char(hire_date,'MM'),'10', count(*),0) AS "10월"
	 , decode(TO_char(hire_date,'MM'),'11', count(*),0) AS "11월"
	 , decode(TO_char(hire_date,'MM'),'12', count(*),0) AS "12월"
  FROM employees
GROUP BY to_char(hire_date,'MM')
ORDER BY to_char(hire_date,'MM');

				
-- RANK() 등수 공동등수 번호가 띄우기, DENSE_RANK() 등수번호가 순차적으로 올라감
-- ROW_NUMBER() 현재 데이터 행번호 출력
SELECT employee_id, last_name, salary
	 , rank() OVER (ORDER BY salary desc) AS "랭크" -- 잘안씀
	 , dense_rank() OVER (ORDER BY salary desc) AS "덴스랭크" -- 일반적으로 많이 사용
	 , row_number() OVER (ORDER BY salary desc) AS "행번호"
  FROM employees;




