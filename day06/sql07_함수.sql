CREATE OR REPLACE FUNCTION MAX_SAL
(
	 v_deptno	emp.deptno%TYPE 
)
RETURN NUMBER
IS
	max_sal		emp.sal%TYPE;
BEGIN
	SELECT max(sal) INTO max_sal
	  FROM emp
	 WHERE deptno = v_deptno;
	RETURN max_sal;
END MAX_SAL;
 
