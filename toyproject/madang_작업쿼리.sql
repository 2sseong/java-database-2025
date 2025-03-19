-- madang로그인

-- 조회
SELECT * FROM Students;

-- 더미데이터 삽입
INSERT INTO Students (std_id, std_name, std_mobile, std_regyear) 
	 VALUES (seq_student.nextval, '홍길동', '010-0000-9999', 1997);

INSERT INTO Students (std_id, std_name, std_mobile, std_regyear) 
	 VALUES (seq_student.nextval, '홍길순', '010-0000-9998', 2000);

COMMIT;
ROLLBACK;