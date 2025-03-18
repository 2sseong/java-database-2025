-- PROCEDURE
--부서번호가 30번인 사람들의 JOB을 MANAGER로 변경하는 프로시저
--SELECT * FROM emp;
CREATE OR REPLACE PROCEDURE UPDATE_30
()
IS 
BEGIN
	UPDATE emp SET
		   job = 'manager'
	 WHERE deptno = 30;
END;

SELECT * FROM emp;

COMMIT;

-- 프로시저 실행
CALL UPDATE_30();