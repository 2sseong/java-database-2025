-- SELECT 
--DISTNICT 중복제거


SELECT name || '''s ID: ' || id || ',weight is ' || weight || 'kg' AS "ID and WEIGHT"
  FROM student;

SELECT ename || '(' || job || ')' || ', ' || ename || '''' || job || ''''  AS "NAME AND JOB0"
  FROM emp;
  

-- WHERE
-- 문자나 날짜 조회의 경우 반드시 작은따옴표
-- =,!= <> , BETWEEN a AND b, IN(a,b,c), LIKE, IS NULL, IS NOT NULL, A AND B, A OR B, NOT A
select *
  FROM emp
 WHERE ename = 'ALLEN';

-- ORDER BY
SELECT ename, sal, hiredate
  FROM emp;
-- 집합연산자 UNION(합집합 중복값제거), UNIONALL(합집합 중복값제거X), INERSECT(교집합), MINUS(차집합)

-- 단일행 함수
SELECT ename
	 , initcap(ename) AS "첫글자 대문자"
	 , lower(ename) AS "다 소문자"
	 , upper(ename) AS "다 대문자"
	 , length(ename) AS "길이"
	 , lengthb(ename) AS "바이트길이"
	 , concat(ename,sal) AS "붙이기"
  FROM emp;


SELECT ename 
	 , REPLACE(ename,substr(ename,2,2),'--') AS "REPLACE"
  FROM emp;


SELECT name
	 , jumin
	 , replace(jumin,substr(jumin,-7),'-/-/-/-') AS "REPLACE"
  FROM student
 WHERE deptno1 = 101;


