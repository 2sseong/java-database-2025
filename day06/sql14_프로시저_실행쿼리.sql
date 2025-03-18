-- 
SELECT * FROM emp;

-- 커서로 반복하는 프로시저 실행
CALL emp_list();




-- 프로시저 연습 실행
CALL professor_info(2001);

CALL emp_info(7902);

-- FOR문
DECLARE 
	v_sum	NUMBER;
BEGIN
	v_sum := 0;
	FOR i IN 1..10 LOOP
		v_sum := v_sum +i;
	END LOOP;
	dbms_output.put_line(v_sum);
END;

COMMIT;
