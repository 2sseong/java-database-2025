/*
 * 서브쿼리
 */
SELECT * FROM student;
SELECT * FROM department;

-- 단일행 서브쿼리 = <> > >= < <= 비교연산자로 비교
-- join으로 두 테이블을 검색
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = 103;

-- Anthony Hopkins 학생과 같은 학과에 다니는 학생을 모두 조회
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = (SELECT deptno1
					 FROM student
					WHERE name = 'Anthony Hopkins'); --학생 이름따라 학과 번호가 변경 가능

-- WHERE절 서브쿼리에서 =로 비교할때 주의점
-- WHERE절 서브쿼리는 다중행이 되면 안됨
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = (SELECT deptno1
					 FROM student);					


-- 특정교수의 입사일보다 뒤에 입사한 교수의 정보 출력
SELECT * FROM professor;
SELECT * FROM department;


-- 조인되는 쿼리부터 생성
-- 맥 라이언 교수 입사일자로 비교 
SELECT p. name AS "PROF_NAME"
	 , p.hiredate
	 , d.dname AS "DEPT_NAME"
  FROM PROFESSOR p, department d
 WHERE p.deptno = d.deptno
   AND p.hiredate > '1985-09-18';

SELECT p. name AS "PROF_NAME"
	 , p.hiredate
	 , d.dname AS "DEPT_NAME"
  FROM PROFESSOR p, department d
 WHERE p.deptno = d.deptno
   AND p.hiredate > (SELECT hiredate
   					   FROM PROFESSOR
   					  WHERE name = 'Meg Ryan');
 COMMIT;

-- 다중행 서브쿼리
-- IN 서브쿼리 결과와 같은값. 여러개(OR와 동일)
-- EXISTS 서브쿼리의 값이 있는 경우 메인쿼리를 수행
-- >ANY 서브쿼리 최소값보다 메인쿼리의 큰값을 조회
-- <ANY 서브쿼리 최대값보다 메인쿼리의 작은값을 조회
-- <ALL 서브쿼리 최대값보다 메인쿼리의 큰값을 조회
-- >ALL 서브쿼리 최소값보다 메인쿼리의 작은값을 조회

-- 지역이 Pohang Main Office인 부서코드에 해당하는 직원들의 사번, 이름, 부서번호를 출력하시오.

SELECT dcode
  FROM DEPT2 
 WHERE area = 'Pohang Main Office';

SELECT empno, name, deptno
  FROM emp2
 WHERE deptno IN(SELECT dcode
 				   FROM DEPT2 
				  WHERE area = 'Pohang Main Office');

--p.434 연습문제
-- emp2 테이블에서 'Section head' 직급의 최소 연봉보다 연봉이 높은 사람의 이름, 직급, 연봉을 출력하시오.
-- 단, 연봉은 $75,000,000식으로 출력할 것
DELETE FROM EMp2
 WHERE empno = '20000219';
COMMIT;

-- 서브쿼리 Min 함수 최소값 스칼라에서 비교연산으로
SELECT name, POSITION, to_char(pay, '$999,999,999') AS SALARY 
  FROM emp2
 WHERE pay > (SELECT min(pay)
				 FROM emp2
				WHERE POSITION = 'Section head');

-- >ANY로 서브쿼리 다중행에서 최소값
SELECT name, POSITION, to_char(pay, '$999,999,999') AS SALARY 
  FROM emp2
 WHERE pay > ANY (SELECT pay
				    FROM emp2
			   	   WHERE POSITION = 'Section head');

-- 다중 컬럼 서브쿼리, 파이썬 튜플과 동일
-- 1~4학년중 몸무게가 가장 많이 나가는 학생의 정보를 출력하라(4행) 
SELECT grade, name, height, weight
  FROM student
 WHERE (grade, weight) IN (SELECT grade, max(weight)
							  FROM student
							 GROUP BY grade);

SELECT grade, max(weight)
  FROM student
 GROUP BY grade;

-- 교수테이블과 학과department 테이블 조회하여 학과별로 입사일이 가장 오래된 교수의 
-- 교수번호, 이름, 학과명을 출력하시오. 입사일 순으로 오름차순
SELECT p.profno AS "교수번호"
	 , p.name AS "이름"
	 , d.dname AS "학과명"
	 , to_char(p.hiredate, 'yyyy-mm-dd') AS "입사일"
  FROM professor p, department d
 WHERE d.deptno = p.deptno
   AND (p.DEPTNO, p.HIREDATE) IN (SELECT deptno, min(hiredate)
							   	    FROM professor
							       WHERE deptno IS NOT NULL 
							   	   GROUP BY deptno)
ORDER BY hiredate;



SELECT p.profno, p.name, d.dname 
  FROM professor p, department d
 WHERE p.deptno = d.deptno
   AND (p.deptno, p.hiredate) IN (SELECT deptno, min(hiredate)
							   	    FROM professor
							       WHERE deptno IS NOT NULL 
							   	   GROUP BY deptno);

SELECT deptno, min(hiredate)
  FROM professor
 WHERE deptno IS NOT NULL 
 GROUP BY deptno;

-- 상호연관 쿼리. 메인쿼리의 컬럼이 서브쿼리의 조건에 들어가는 경우
-- 전체 20명의 평균연봉
SELECT AVG(b.pay)
  FROM emp2 b
 GROUP BY b.POSITION;

SELECT AVG(b.pay)
  FROM emp2 b

--상호연관쿼리로 작성
SELECT a.name, a.POSITION, a.pay
  FROM emp2 a
 WHERE a.pay >= (SELECT avg(b.pay)
 				   FROM emp2 b
 				  WHERE b.POSITION = a.POSITION);

SELECT a.name, a.POSITION, a.pay
  FROM emp2 a
 WHERE (POSITION, pay) >ANY (SELECT b.POSITION, avg(b.pay)
 							   FROM emp2 b
							  WHERE b.POSITION IS NOT NULL
							  GROUP BY b.position);

COMMIT;

-- 여기까지, WHERE절 서브쿼리

-- 스칼라 서브쿼리, SELECCT절 서브쿼리
-- 부서명을 같이 보려면 JOIN을 해야함.
SELECT *
  FROM emp2 e;

-- JOIN은 건수가 만약 700만건이라해도 JOIN은 한 번만 수행
SELECT e.empno, e.name, e.deptno, d.dname AS "부서명"
  FROM emp2 e, dept2 d
 WHERE e.deptno = d.dcode
 
-- 조인없이 스칼라 서브쿼리로 해결
-- 조인으로 되는 값을 서브쿼리 쓰면 성능에 악영향을 끼침
-- 스칼라 서브쿼리를 쓰면 WHERE검색을 700만건 수행
SELECT e.empno, e.name, e.deptno
	 , (SELECT dname FROM dept2 WHERE dcode = e.deptno) AS "부서명"
	 , (SELECT area FROM dept2 WHERE dcode = e.deptno) AS "지역"
  FROM emp2 e;

-- 여기까지 스칼라(SELECT절) 서브쿼리

--FROM절 서브쿼리
SELECT *
  FROM emp2;

SELECT empno, name, birthday 
	 , deptno, emp_type, tel
  FROM emp2;

SELECT *
  FROM (SELECT empno, name, birthday 
			 , deptno, emp_type, tel
		  FROM emp2);
-- FROM절에 소괄호 내에 서브쿼리를 작성하는 방식
SELECT es.empno, es.name
  FROM (SELECT empno, name, birthday 
			 , deptno, emp_type, tel
		  FROM emp2) es;

SELECT graP.deptno, graP.paySum, count(graP.PAYSUM)
  FROM (SELECT deptno, sum(pay) AS paySum
  	 	  FROM emp2
 		 GROUP BY deptno) graP;

SELECT graP.deptno, graP.payAvg
  FROM (SELECT deptno, avg(pay) AS payAvg
  	 	  FROM emp2
 		 GROUP BY deptno) graP;

-- 각 부서별 평균연봉
SELECT deptno, sum(pay)
  FROM emp2
 GROUP BY deptno;

-- 11. emp2와 위에서 구한 값을 조인해서 평균연봉보다 얼마씩 차이가 나는지
SELECT e.name, e.empno, e.POSITION, e.deptno, e.pay, g.payavg, (e.pay - g.payavg) AS "평균연봉 차액"
  FROM emp2 e, (SELECT deptno, avg(pay) AS payAvg
		  	 	  FROM emp2
		 		 GROUP BY deptno) g --g는 가상테이블
 WHERE e.deptno = g.deptno;

-- 12. WITH절로 가상테이블 형태 서브쿼리
WITH g1 AS
(SELECT deptno, avg(pay) AS payAvg
   FROM emp2
  GROUP BY deptno
)
SELECT e.name, e.empno, e.POSITION, e.deptno, e.pay, g1.payavg, (e.pay - g1.payavg) AS "평균연봉 차액"
  FROM emp2 e, g1
 WHERE e.deptno = g1.deptno;
-- 11번과 12번은 차이가 없음

-- WHERE절 서브쿼리 > FROM절 서브쿼리 > SELECT절  서브쿼리(사용자정의함수로 대체)

-- 서브쿼리 사용시 NULL값 처리
INSERT INTO emp2 (empno, name, birthday, deptno, emp_type, tel)
VALUES (20200219, 'Ray Osmond','1988-03022','999','Intern','02)909-2345');
COMMIT;

SELECT * FROM emp2;

-- 각 직원의 부서명을 같이 출력하라
-- NULL은 출력을 안하는게 좋음
SELECT name, deptno, nvl((SELECT dname FROM dept2 WHERE dcode=emp2.deptno), '부서명없음') AS "부서명"
  FROM emp2
 ORDER BY deptno;

-- 위의 쿼리 조인으로 변경가능
SELECT e.name, e.deptno, nvl(d.dname,'부서명 없음') AS "부서명"
  FROM emp2 e, dept2 d
 WHERE e.deptno = d.DCODE(+)
 ORDER BY deptno, name;
COMMIT;