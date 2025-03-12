# javaDatabase-2025
java개발자 과정 Database 리포지토리

## 1일차
- Github Desktop 설치
    - https://desktop.github.com/download/ 다운로드
    - 기존 Github계정으로 Sign in with Browser
    - Git 명령어 없이 사용가능
- Database(DB) 개요
    - 데이터를 저장하는 장소, 서비스를 하는 서버
    - 데이터베이스를 관리하는 프로그램 DBMS
    - 가장 유명한것이 Oracle
    - 사용자는 SQL로 요청, DB서버는 처리결과를 테이블로 리턴
    - SQL을 배우는 것!
- Oracle 설치(Docker)
    1. powershell 오픈
    2. docker search로 다운받고 싶은 이미지 검색
    2. docker pull 내려받기
        ```shell
        PS C:\Users\Admin> docker pull oracleinanutshell/oracle-xe-11g
        Using default tag: latest
        latest: Pulling from oracleinanutshell/oracle-xe-11g
        f747bf1d551d: Download complete
        987088a85b96: Download complete
        d42beb8ded59: Download complete
        b4624b3efe06: Download complete
        15522cc0fb47: Download complete
        6cf436f81810: Download complete
        Digest: sha256:8b740e77d4b90add693fedb22938f340821e89665fb58ecaeeb0dace853b9ee5
        Status: Downloaded newer image for oracleinanutshell/oracle-xe-11g:latest
        docker.io/oracleinanutshell/oracle-xe-11g:latest
        ```
    3. 다운로드 이미지 확인
        ```shell
        PS C:\Users\Admin> docker image ls
        REPOSITORY                        TAG       IMAGE ID       CREATED        SIZE
        ....
        oracleinanutshell/oracle-xe-11g   latest    8b740e77d4b9   6 years ago    2.79GB
        ```
    4. Docker 컨테이너 실행
        ```shell
        docker run --name oracle11g -d -p 1521:1521 --restart=always oracleinanutshell/oracle-xe-11g
        ```
        - 1521 - Oracle 기본포트
        - 아이디 system / oracle
    5. 도커 실행확인
        - Docker Desktop > containers 확인
    6. Powershell 오픈
        ```shell
        docker exec -it oracle19c bash
        [oracle@66ade25faca5 ~]$ sqlplus / as sysdba
        SQL >
        ```
    7. DBeaver 접속
        - Connection > Select your DB > Oracle 선택
        
        <img src='.\image\KakaoTalk_20250311_134748062.png' width=650>
-  DBeaver Community 툴 설치
    - https://dbeaver.io/download/
- DML, DDL, DCL
    - 언어의 특징을 가지고 있음
        - 프로그래밍언어 - 어떻게(how)
        - SQL - 무엇(what) 
    - SQL의 구성요소 3가지
        - DDL(Data Definition Lang) - 데이터베이스 생성, 테이블 생성, 객체 생성, 수정, 삭제
            - CREATE, ALTER, DROP ...
        - DCL(Data Control Lang) - 사용자 권한 부여, 해제, 트랜잭션 시작, 종료
            - GRANT, REVOKE, BEGIN TRANS, COMMIT, ROLLBACK
        - **DML**(Data Manupulation Lang) - 데이터 조작언어(핵심!), 데이터 삽입, 조회, 수정, 삭제
            - `INSERT`, `SELECT`, `UPDATE`, `DELETE`

- SELECT 기본
    - 데이터 조회 시 사용하는 기본명령어 
        ```sql
        -- 기본 주석(한줄)
        /*여러줄 주석
          여러줄로 주석 작성가능*/
        SELECT [ALL|DISTINCT] [*|컬럼명(들)]
          FROM 테이블명(들)
         [WHERE 검색조건(들)]
         [GROUP BY 속성명(들)]
         [HAVING 집계함수조건(들)]
         [ORDER BY 정렬속성(들) ASC|DESC]
         [WITH ROLLUP]
        ```
    - 기본 쿼리 학습 : [SQL](./day01/sql01_select기본.sql)
        1. 기본 SELECT
        2. WHERE 조건절
        3. NULL(!)
        4. ORDER BY 정렬
        5. 집합

- 함수(내장함수)
    - 문자함수 [SQL](./day01/sql02_함수.sql)
    - 숫자함수
    


## 2일차
- 함수(계속)
    - 문자함수 부터: [SQL](./day02/sql01_함수계속.sql)
    - 숫자함수
    - 날짜함수
    - 형변환함수
- 복수행함수 : [SQL](./day02/sql02_복수행함수.sql)
    - 집계함수
    - GROUP BY
    - HAVING
    - ROLLUP
    - RANK, DENSE_RANK, ROW_NUMBER

- 데이터베이스 타입형
    - **CHAR(n)** - 고정형 문자열, 최대 2000byte
        - CHAR(20)으로 'Hello World'를 저장하면, 'Hello World         '로 저장!(공백포함됨)
        - 기준코드나 반드시 자리수를 지켜야하는 데이터 필요
    - **VARCHAR2(n)** - 가변형 문자열, 최대 4000byte 
        - VARCHAR2(20)로'Hello World'를 저장하면, 'Hello World'로 저장!
    - **NUMBER(p,s)** - 숫자값, p 전체자리수, s 소수점길이. 최대 22byte
    - INTEGER - 모든 데이터의 기준. 4byte, 정수를 담는 데이터형
    - FLOAT(p) - 실수형 타입, 최대 22byte
    - **DATE** - 날짜타입
    - **LONG(n)** - 가변길이문자열, 최대 2G바이트
    - LONG RAW(n) - 원시이진 데이터, 최대 2G바이트
    - CLOB - 대용량 텍스트 데이터타입, 최대 4G
    - BLOB - 대용량 바이너리 데이터타입, 최대 4G
    - BFILE - 외부파일에 저장된 데이터, 최대 4G

## 3일차
- JOIN
    - 커티션곱
    - 내부조인, 외부조인
