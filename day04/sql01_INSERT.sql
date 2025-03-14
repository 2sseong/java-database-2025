/*
 * DML중 SELECT 이외
 * INSERT, UPDATE, DELETE
 */
-- INSERT
SELECT *
  FROM new_table;

-- INSERT QUEQRY 기본
INSERT INTO new_table (NO, name, jumin, birth, salary)
VALUES (1, '홍길동','810205-1825697','1981-02-05',5000);

-- 테이블 컬럼리스트와 동일한 순서, 동일한 값을 넣을때 
-- 단, 컬럼리스트와 순서도 다르고, 값리스트 갯수도 다르면 컬럼리스트 생략 불가!
INSERT INTO new_table
VALUES (2, '홍길순','810205-2825698','1983-02-05',4000);

-- 컬럼리스트 순서와 갯수가 다를때는 반드시 적어줘야 함. 
INSERT INTO new_table (JUMIN, NAME, NO)
VALUES ('760205-1825699','성유고', 3);

-- 값이 뭔지 모를때는 NULL로 삽입
INSERT INTO new_table
VALUES (4, '홍길태','810205-1825699',NULL,NULL);

-- 한 테이블에 있는 데이터를 모두 옮기면서 새로운 데이터 생성
-- PK는 복사가 안됨.
CREATE TABLE professor_new
AS
SELECT * FROM professor;

SELECT * FROM professor_new;

-- 만들어진 테이블에 데이터 한꺼번에 옮기기
INSERT INTO PROFESSOR_NEW
SELECT * FROM professor;

-- 새로 만들어진 테이블 Professor_new 데이터를 삽입 테스트
INSERT INTO PROFESSOR_NEW(profno, name, id, POSITION, pay, hiredate)
VALUES (4008, 'Tom Cruise','Cruise','instructor',300,'2025-03-14');

-- PROFESSOR_NEW는 PK가 없기 때문에 같은 값이 들어감
INSERT INTO PROFESSOR_NEW(profno, name, id, POSITION, pay, hiredate)
VALUES (4008, 'Tom Holland','Holland','instructor',310,'2025-03-14');

-- 대량의 데이터를 삽입
INSERT ALL
	INTO NEW_TABLE  VALUES (5, '홍길길','810205-1825697','1981-02-05',5000)
    INTO NEW_TABLE  VALUES (6, '홍길평','810205-1825697','1981-02-05',5000)
    INTO NEW_TABLE  VALUES (7, '홍길똥','810205-1825697','1981-02-05',5000)
    INTO NEW_TABLE  VALUES (8, '홍길군','810205-1825697','1981-02-05',5000)
    INTO NEW_TABLE  VALUES (9, '홍길치','810205-1825697','1981-02-05',5000)
SELECT * FROM  dual;
SELECT * FROM new_table;





