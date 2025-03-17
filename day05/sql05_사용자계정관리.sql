/*
 * 사용자 생성, 기존 사용자 사용해제, 권한주기 
 */

-- HR 계정 잠금해제
ALTER USER hr account unlock;
ALTER USER hr IDENTIFIED BY 12345;


SELECT *
  FROM employees;

-- PRIVILEGES 권한
-- CREATE SESSIION - 접속권한
-- CREATE TABLE, ALTER ANY TABLE, DROP ANY TABLE, ..
-- 권한은

/*
-- SCOTT 계정 잠금해제 계정이 없을 수도 있음.
ALTER USER scott account unlock;

-- SCOTT은 CREATE SESSION권한없음. LOGON DENIED.
-- SCOTT에서 접속권한 부여
GRANT CREATE SESSION TO scott;
*/
SELECT * FROM JOBS;

CREATE VIEW JOBS_VIEW
AS
	SELECT *
	  FROM jobs;

-- HR계정에 어떤 권한이 있는지 조회
SELECT *
  FROM USER_tab_privs;

-- HR로 테이블 생성
CREATE TABLE test(
	id NUMBER PRIMARY KEY,
	name varchar(20) NOT null
);

-- Role(역할) 관리
-- 여러 권한을 묶어놓은 개념
-- role 확인 
-- CONNECT - DB접속 및 테이블생성 조회 권한
-- RESOURCE - PL/SQL 사용권한
-- DBA - 모든 시스템권한
-- EXP_FULL_DATABASE - DB익스포트 권한...
SELECT * FROM user_role_privs;

SELECT * FROM dba_role_privs;

-- HR에게 DBA역할 role 부여
GRANT DBA TO hr;

SELECT * FROM sampleuser.MEMBER;

-- HR에게 DBA역할 revoke 해제
REVOKE DBA FROM hr;
