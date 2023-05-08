-- DDL / CONSTRAINTS - CHECK, UNIQUE, PK
select * from emp;
delete from emp; -- 실제 테이블에 저장되는것이 아니라 트랜젝션에 수행 기록하는것.
select *from emp;
--rollback 사용시 엄밀히는 db를 복구하는 것이 아니라, 트랜젝션에 저장된 delete를 삭제하고 이전 commit 시점으로 돌아 가는것.
rollback;
select * from emp;

-- 현재 세션에서 작업중인 테이블의 행을 커밋처리 전까지 다른 세션에서 검색되도록 트렌잭션을 사용 -> 데이터 일관성.
select * from bonus;
delete from bonus where ename ='KIM';
select * from bonus;
--if oracle developer 에서 scott 계정에 접속중인데 동시에 sql plus 에서도 scott 계정에 접속했다면? => 서로 다른 세션에서 작업중인것.
--> delete는 oracle developer의 select절에서만 반영될 뿐, sql plus에는 반영되지 않음
--> 즉, 트랜잭션 사용 이유 : 데이터 무결성 테이블에 비정상적인 값을 저장하지 않아 정상적인 검색결과 제공하기 위함

COMMIT;

SELECT * FROM BONUS;
UPDATE BONUS SET SAL=2000 WHERE ENAME='ALLEN'; -- 테이블 행에 대한 데이타 잠금기능.
-- 아직 COMMIT 하지 않았으므로 데이터베이스에 변경이 반영되지는 않았지만, 해당 테이블 행에 대한 잠금기능이 활성화 됨
--SQL> UPDATE BONUS SET COMM=SAL*0.5 WHERE ENAME='ALLEN';
--> 해당 명령을 다른 세션에서 접근하여 조작할 경우, TRANSACTION에 의해 나중에 접근된 세션은 일시 중지되고 데이터를 변경할 수 없음.
--> IF 세션을 다시 정상 운영하기 위해서는 현재 작업중인 세션에서 해당 테이블에 대한 작업을 COMMIT OR ROLLBACK 처리해 줘야 실행 가능.
SELECT * FROM BONUS;
COMMIT; 
--> COMMIT 하자마자 일시정지돼있던 커맨드 창에도 업데이트 표시가 완료 됨.
--> 이처럼, 잘못 실행시 트렌잭션의 교착상태가 발생할 수 있으므로 유의할것.

--SAVEPOINT : 트렌잭션에 라벨(위치정보)를 부여하는 명령 >> SAVEPOINT 라벨명;
--> 트렌잭션에 저장된 DML 명령을 이용하여 원하는 위치의 DML 명령만 롤백 처리하기 위해 사용함.
--1. 알렌 정보 삭제
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--2.MARTINE 정보 삭제
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

ROLLBACK;  --> 트랜잭션 단위로 DML명령이 모두 사라짐
SELECT* FROM BONUS;

--3.SAVEPOINT 사용 시, 
DELETE FROM BONUS WHERE ENAME='ALLEN';
SAVEPOINT ALLEN_DELETE_AFTER;
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

ROLLBACK TO ALLEN_DELETE_AFTER;  -- SAVEPOINT로 ROLLBACK 됨. => 알렌만 삭제된 상태로 롤백됨.
-- BUT 그렇다고해서 알렌의 변경정보가 DB에 반영된것은 아님. 단순히 트렌잭션 내의 SAVEPOINT를 형성하는 것.
SELECT * FROM BONUS;

--DDL(DATA DEFINITION LANGUAGE) : 데이타 정의어
--데이타베이스의 객체(테이블, VIEW, 시퀀스, 인덱스, 동의어, 사용자 등)을 관리하기 위한 SQL 명령

--테이블(TABLE) : 데이터베이스에서 데이터를 저장하기 위한 가장 기본적인 객체.

--  TABLE 생성 : 테이블 속성 (ATTRIBUTE)의 집합.
 
 
 --식별자 생성 규칙 : 테이블명, 컬럼명, 별칭, 라벨명 등
 -- 1. 영문자로 시작 -> 1~30범위의 문자들로 구성
 -- 2. A~Z,0~9,$,# 문자들을 조합하여 작성 -> 대소문자 미구문 : 스네이크 표기법 (대소문자 미구분)
 -- 3. 영문자 외 문자 사용 가능 BUT 비권장
 -- 4. 키워드로 식별자를 선언할 경우 에러 발생 -> " " 안에 표현시, 가능 BUT 비권장.
 
 -- 자료형(DATATYPE) : 컬럼에 저장 가능한 값의 형태를 표현하기 위한 키워드
 -- 1. 숫자형
 -- 2. 자료형 : CHAR(10) - 크기 : 1~2000(BYTE) >> 고정길이 
--             VARCHAR(크기) : 1~4000(BYTE) >> 가변길이
--             LONG : 최대 2GB까지 저장 가능 >> 가변길이 - 테이블 하나의 컬럼에만 설정 가능 & 정렬 불가 
-- TABLE에 파일을 저장하는것은 너무 큰 리소스를 차지하므로 테이블에 파일을 저장하는 경우는 거의 X 
--             CLOB : 최대 4GB 저장 가능 >> 가변길이 - 텍스트 파일을 (테이블에)저장하기 위한 자료형
--             BLOB : 최대 4GB 저장 가능 >> 가변길이 - 이진 파일을 (테이블에)저장하기 위한 자료형
-- 3. 날짜형 : DATE - 날짜와 시간
--            TIMESTAMP - 초(MS)단위 시간.

--SALESMAN 테이블 생성 - 사원번호(숫자형), 사원이름(문자형), 입사일(날짜형)
CREATE TABLE SALESMAN (NO NUMBER(4), NAME VARCHAR2(20),STARTDATE DATE);

--튜플이 없지만, 테이블이 생성된것을 확인할 때.
--USER_DICTIOINARY(일반사용자), DBA_DICTIONARY(관리자), ALL_DICTIONARY(모든 사용자)

--USER_OBJECTS : 현재 접속 사용자의 스키마로 접근 가능한 객체 정보를 제공하는 딕셔너리
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

SELECT TABLE_NAME FROM USER_TABLES;

SELECT TABLE_NAME FROM TABS;

DESC SALESMAN;

INSERT INTO SALESMAN VALUES(1000,'홍길동','00/04/08');
COMMIT;

--SALESMAN 테이블에 행 삽입 - 컬럼을 생략하여 삽입처리한 경우, 생략된 컬럼에는 기본값이 전달되어 삽입
--테이블 생성시 컬럼 기본값을 설정하지 않은 경우 자동으로 NULL이 기본값으로 자동 설정
INSERT INTO SALESMAN(NO,NAME) VALUES(2000,'임꺽정');
--DAY4에서는 삽입할때, NOTNULL이 아닌곳의 정보를 입력하지 않아도 오류났던것같은데 왜..? 
--> (NO, NAME) 통해 어떤 행에 어떤값을 삽입할 지 지정했으므로 작성되지 않은 값에는 기본값 적성됨.
SELECT * FROM SALESMAN;
COMMIT;
--테이블 생성시 제약조건을 설정하지 않은 경우 컬럼에 어떤한 값을 전달해도 삽입 처리 - 데이타 무결성 위반 가능 
INSERT INTO SALESMAN VALUES(1000,'전우치','10/10/10');
SELECT *FROM SALESMAN;
COMMIT;

--MANAGER TALBLE 생성 : 사원번호(숫자형), 사원이름(문자), 입사일(날짜형- 기본값 : 현재), 급여(숫자형 - 기본값 : 1000)
--BUT 대부분의 경우 컬럼 기본값은 설정하지 않고 NULL을 기본값으로 사용.
CREATE TABLE MANAGER (NO NUMBER(4), NAME VARCHAR2(20),STARTDATE DATE DEFAULT SYSDATE,PAY NUMBER DEFAULT 1000);
--테이블 목록
SELECT TABLE_NAME FROM USER_TABLES;
--DESCRIBE : 테이블의 구조 제공
DESC MANAGER;

--USER_TAB_COLUMNS : 테이블의 컬럼 정보를 제공하는 딕셔너리
SELECT COLUMN_NAME, DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'MANAGER';

INSERT INTO MANAGER VALUES (1000,'홍길동','00/05/09',3000);
SELECT * FROM MANAGER;
INSERT INTO MANAGER(NO,NAME) VALUES(2000,'임꺽정');

--DEFAULT 키워드 사용하여 삽입처리
INSERT INTO MANAGER VALUES(3000,'전우치',DEFAULT,DEFAULT);
SELECT * FROM MANAGER;
COMMIT;

--제약조건(CONSTRAINT) : 컬럼에 비정상적인 값이 저장되는 것을 방지하기 위한 기능 - 데이터 무결성 유지
--컬럼 수준의 제약조건 : 테이블의 속성 선언 시 컬럼에 제약조건을 설정
--테이블 수준의 제약조건 : 테이블 선언시 테이블의 특정 컬럼에 제약조건을 설정함

--컬럼수준의 제약조건
--CHECK : 컬럼값으로 저장 가능한 조건을 제공하여 조건이 참인 경우에만 컬럼값으로 저장되도록 설정함
-->컬럼수준 OR 테이블 수준 제약조건으로 설정 가능

--SAWON1 테이블 생성 : 사원번호, 사원이름, 급여
CREATE TABLE SAWON1 (NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER);

INSERT INTO SAWON1 VALUES(1000,'홍길동', 8000000);
INSERT INTO SAWON1 VALUES(2000, '임꺽정',800000);
SELECT * FROM SAWON1;
COMMIT;

--SAWON2 테이블 : CHECK 제약조건 WITHOUT 제약조건명
CREATE TABLE SAWON2(NO NUMBER(4), NAME VARCHAR2(20), PAY NUMBER);
ALTER TABLE SAWON2 MODIFY PAY NUMBER CHECK(PAY>=5000000);
DESC SAWON2;

INSERT INTO SAWON2 VALUES(1000,'홍길동',8000000);
INSERT INTO SAWON2 VALUES(2000,'임꺽정',800000);  --CHECK 제약조건 위배 -> 저장 안됨.
SELECT * FROM SAWON2;
COMMIT;
--제약조건의 확인 : USER_CONSTRAINTS  
-- 1. CONSTRAT_NAME : 제약조건의 이름 -> 이름을 지정하지 않을시, SYS_XXXXXXX(7자리)의 형식으로 설정 됨. 
--> BUT 제약조건의 관리에는 이름 설정하는것이 유리하므로 제약조건명 지정을 권장함
-- CONSTRAINT_TYPE : 제약조건의 종류 - C(CHECK), U(UNIQUE),P(PRIMARY KEY),R(REFERENCE - FOREIGN KEY)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON2';

--SAWON3 테이블 생성 : 제약조건명 부여
CREATE TABLE SAWON3 (NO NUMBER(4), NAME VARCHAR2(20), PAY NUMBER CONSTRAINT SAWON3_PAY_CHECK CHECK(PAY>=5000000));

SELECT TABLE_NAME FROM USER_TABLES;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'SAWON3';


--테이블수준의 제약조건 설정하기
--사원 4 테이블 -> 급여 : 최소급여 5000000
CREATE TABLE SAWON4 (NO NUMBER(4), NAME VARCHAR2(20), PAY NUMBER, CONSTRAINT SAWON4_PAY_CHECK CHECK(PAY>=5000000));
--> 컬럼수준 제약조건 VS 테이블 수준 제약조건 : 해당 컬럼을 이용한 조건식 설정 가능  -->  CHECK(NAME IS NOT NULL AND CHECK(PAY>=5000000)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'SAWON4';

--NOT NULL : NULL을 허용하지 않는 제약조건 : 컬럼에 반드시 값이 저장돼야 함. -> 컬럼수준 제약조건


--DEPT1 테이블 생성 : 부서번호(숫자형),부서이름(문자형),부서위치(문자형)
CREATE TABLE DEPT1(DEPTNO NUMBER(2), DNAME VARCHAR2(12), LOC VARCHAR2(11));

INSERT INTO DEPT1 VALUES(10,'총무부','서울시');
INSERT INTO DEPT1 VALUES(20,NULL,NULL); --명시적 NULL
INSERT INTO DEPT1(DEPTNO) VALUES(30); -- 묵시적 NULL
SELECT * FROM DEPT1;
COMMIT;

--DEPT2 테이블 : 부서번호, 이름, 부서위치 => 모두에 NOT NULL 제약조건

CREATE TABLE DEPT2 (DEPTNO NUMBER(4) CONSTRAINT DEPT2_DEPTNO_NN NOT NULL, 
DNAME VARCHAR2(12)CONSTRAINT DEPT2_DNAME_NN NOT NULL, 
LOC VARCHAR2(11) CONSTRAINT DEPT2_LOC_NN NOT NULL );

INSERT INTO DEPT2 VALUES(10,'총무부','서울시');
INSERT INTO DEPT2 VALUES(20,NULL,NULL); --NOT NULL 제약조건 위배
INSERT INTO DEPT2(DEPTNO) VALUES(30); -- NOT NULL 제약조건 위배
SELECT * FROM DEPT2;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'DEPT2';

--UNIQUE : 중복 컬럼값 방지 --> [컬럼수준 | 테이블 수준]의 제약조건
--> 테이블에 여러개 설정 가능 + NULL 허용

--USER1 테이블 생성 - ID(문자형), 이름(문자형), 전화번호(문자형)
CREATE TABLE USER1 (ID VARCHAR2(20), NAME VARCHAR2(30), PHONE VARCHAR2(15));

--USER1 테이블 행 삽입
INSERT INTO USER1 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER1 VALUES('ABC','홍길동','010-1234-5678'); --BUT 하나의 테이블에는 같은행이 존재해서는 안됨.
SELECT * FROM USER1;
COMMIT;

--USER2 테이블 생성 : ID, 전화번호 - 유니크 제약조건 (컬럼 수준의 제약조건)
CREATE TABLE USER2 (ID VARCHAR2(20) CONSTRAINT ID_UNIQUE UNIQUE, NAME VARCHAR2(30), PHONE VARCHAR2(15)CONSTRAINT PHONE_UNIQUE UNIQUE);
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER2';

INSERT INTO USER2 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER2 VALUES('ABC','홍길동','010-1234-5678'); --ERROR
INSERT INTO USER2 VALUES('ABC','임꺽정','010-7890-1234'); --ERROR
INSERT INTO USER2 VALUES('XYZ','임꺽정','010-1234-5678'); --ERROR
INSERT INTO USER2 VALUES('XYZ','임꺽정','010-7890-1234'); -- ID 와 PHONE이 모두 유일한 경우에만 행 삽입 가능
SELECT * FROM USER2;
COMMIT;

--UNIQUE 제약조건이 설정된 컬럼에 NULL을 전달하여 삽입가능. (UNIQUE!=PK)
INSERT INTO USER2 VALUES('OPQ','전우치',NULL);
--NULL은 값이 아니므로 UNIQUE 제약조건을 위반하지 않는 것으로 처리
INSERT INTO USER2 VALUES('IJK','일지매',NULL);
SELECT * FROM USER2;
COMMIT;

--테이블 수준의 제약조건으로 만드는 법.
CREATE TABLE USER3 (ID VARCHAR2(20), NAME VARCHAR2(30), PHONE VARCHAR2(15),
CONSTRAINT USER3_ID_UK UNIQUE(ID),CONSTRAINT USER3_PHONE_UK UNIQUE(PHONE));
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';

INSERT INTO USER3 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER3 VALUES('ABC','홍길동','010-1234-5678'); --ERROR
INSERT INTO USER3 VALUES('ABC','임꺽정','010-7890-1234'); --ERROR
INSERT INTO USER3 VALUES('XYZ','임꺽정','010-1234-5678'); --ERROR

SELECT * FROM USER3;
COMMIT;

--USER4 테이블 생성 - 아이디(문자형),이름(문자형),전화번호(문자형) 
--아이디와 전화번호를 묶어서 UNIQUE 제약조건 설정 - 테이블 수준의 제약조건으로만 설정 가능
CREATE TABLE USER4(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15)
    ,CONSTRAINT USER4_ID_PHONE_UK UNIQUE(ID,PHONE));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER4';

--USER4 테이블에 행 삽입
INSERT INTO USER4 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER4 VALUES('ABC','홍길동','010-1234-5678');--UNIQUE 제약조건을 위반하여 에러 발생 : 아이디와 전화번호 중복
INSERT INTO USER4 VALUES('ABC','임꺽정','010-7890-1234');
INSERT INTO USER4 VALUES('XYZ','임꺽정','010-1234-5678');
SELECT * FROM USER4;
COMMIT;

--PRIMARY KEY(PK) : 중복 컬럼값 저장을 방지하기 위한 제약조건
--컬럼 수준의 제약조건 또는 테이블 수준의 제약조건 설정 가능
--PRIMARY KEY 제약조건의 테이블에 한번만 설정 가능하며 NULL 미허용
--PRIMARY KEY 제약조건은 테이블에 한번만 설정 가능하므로 제약조건의 이름 지정 생략 가능
--PRIMARY KEY 제약조건은 테이블의 관계를 구체화하기 위해 반드시 설정

--MGR1 테이블 생성 - 사원번호(숫자형-PRIMARY KEY),사원이름(문자형),입사일(숫자형) - 컬럼 수준의 제약조건
CREATE TABLE MGR1(NO NUMBER(4) CONSTRAINT MGR1_NO_PK PRIMARY KEY,NAME VARCHAR2(20),STARTDATE DATE);
DESC MGR1;

--제약조건 확인--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR3';

--MGR3 테이블 행 삽입
INSERT INTO MGR3 VALUES(1000,'홍길동',SYSDATE);
INSERT INTO MGR3 VALUES(1000,'임꺽정',SYSDATE);
INSERT INTO MGR3 VALUES(2000,'임꺽정',SYSDATE);
INSERT INTO MGR3 VALUES(1000,'홍길동',SYSDATE);--PRIMARY KEY 제약조건을 위반하여 에러 발생 - 사원번호와 이름 중복 
SELECT * FROM MGR3;
COMMIT;