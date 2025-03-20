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

DELETE FROM students;

SELECT std_id, std_name
	 , std_mobile, std_regyear
  FROM students;

INSERT INTO Students (std_id, std_name, std_mobile, std_regyear) 
	 VALUES (1, '홍길동', '010-0000-9999', 1997);

INSERT INTO Students (std_id, std_name, std_mobile, std_regyear) 
	 VALUES (2, '홍길순', '010-0000-9998', 2000);

UPDATE students
SET std_id =1
WHERE std_name ='홍길동';


INSERT INTO MADANG.STUDENTS
(STD_ID, STD_NAME, STD_MOBILE, STD_REGYEAR)
VALUES(0, '', '', 0);

