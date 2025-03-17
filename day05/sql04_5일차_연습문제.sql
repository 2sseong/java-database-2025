-- p.421 1번
CREATE OR REPLACE VIEW v_prof_dept2
AS
	SELECT p.profno, p.name, d.dname
	  FROM professor p, department d
	 WHERE p.deptno = d.deptno;

SELECT * FROM professor;
SELECT * FROM v_prof_dept2;

-- 2번
CREATE OR REPLACE VIEW v_avg
AS
	SELECT d.dname, s.height, s.weight
	  FROM department d, (SELECT deptno1, max(height) AS height, max(weight) AS weight
	  				   	    FROM student
	  				   	   GROUP BY deptno1
	  					   ORDER BY deptno1) s
	 WHERE s.deptno1 = d.deptno;

	
SELECT * FROM student;
SELECT * FROM department;
	
SELECT * FROM v_avg;

-- 3번
SELECT d.dname, s.height, s.name, s.height  
  FROM department d, (SELECT deptno1, max(height) AS height, max(name) AS name
	  				   	    FROM student
	  				   	   GROUP BY deptno1) s
 WHERE s.deptno1 = d.deptno;
