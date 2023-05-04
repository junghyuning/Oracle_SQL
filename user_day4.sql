--주요 내용 : SIUD / PK,FK 제약조건 / TCL
--서브쿼리 위치에 따른 종류
--1. 스칼라 서브쿼리(SCALAR SUBQUERY) : SELECT(검색), WHERE, GROUP BY, HAVING, ORDER BY
-- 하나의 SQL 명령으로 취급되지만 내부적으로는 하나의 함수로 처리
--> 함수는 다수의 입력이 있어도 결과는 하나만 제공
-- 스칼라 서브쿼리도 일종의 함수이므로 중첩 사용 가능 BUT 서브쿼리의 결과값이 두개 이상이거나 결과값의 자료형이 상이한 경우 ERROR 발생
-- "대량"의 DATA 처리시에는, 스칼라 서브쿼리의 남발은 성능 저하를 유발할 수 있으므로 차라리 테이블 결합을 이용하는 것이 권장된다.
    
-- 2. 인라인뷰 서브쿼리(INLINE VIEW SUBQUERY) : FROM 절에 사용된 서브쿼리
-- 서브쿼리를 이용하여 일시적으로 생성된 가상의 테이블 - 논리적 테이블
-- 테이블 결합 횟수 감소 및 절차 지향적인 기능 부여
   
--EMP 테이블에 저장된 모든 사원의 사원번호, 사원이름, 급여를 급여로 내림차순하여 검색
SELECT EMPNO, ENAME,SAL FROM EMP ;
--인라인뷰 사용시 : FROM절의 서브쿼리 결과가 일시적으로 가상의 테이블로 설정 되는것.
SELECT EMPNO, ENAME,SAL FROM (SELECT EMPNO, ENAME,SAL FROM EMP);
--ROWNUM : 검색행에 순차적인 값을 제공하는 키워드
SELECT ROWNUM, EMPNO, ENAME,SAL FROM (SELECT EMPNO, ENAME,SAL FROM EMP);
-- * 은 다른 검색 대상과 함께 사용이 불가하므로 아래의 쿼리는 오류 발생함
SELECT ROWNUM, * FROM (SELECT EMPNO, ENAME,SAL FROM EMP);
-->BUT 테이블명.* 로 테이블의 요소처럼 활용시, 사용가능
--인라인뷰에 테이블 별칭을 부여하여 사용 가능하므로 테이블별칭.*로 사용하는것 가능.
SELECT ROWNUM, TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP)TEMP;
    
--행번호가 6보다 작은 행 검색
SELECT ROWNUM, TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP)TEMP WHERE ROWNUM<6;
--ROWNUM =5인 행 OR ROWNUM>5 은 검색 불가 => B/C 쿼리의 실행순서 : FROM절 -> WHERE절 -> SELECT 절 순으로 행해지므로, 
--아직 ROWNUM이 부여되지 않은 상태에서 ROWNUM [= OR >] 비교는 불가하다
--(ROWNUM은 검색시에 순차적으로 번호를 부여하는 성격이 있음 -> 따라서 1부터 출력돼도 상관이없는 [<=]은 수행할 수 있는것.)
SELECT ROWNUM, TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP)TEMP WHERE ROWNUM=5; --ERROR
    
--사원의 정보를 급여순으로 내림차순함
SELECT EMPNO,ENAME,SAL FROM(SELECT EMPNO, ENAME,SAL FROM EMP)TEMP ORDER BY SAL DESC;
--+)행번호 : 쿼리문에서 ORDER BY의 연산이 가장 마지막 이므로 ORDER BY 한 값의 순서대로 ROWNUM을 부여하고 싶을시, 
--> SELECT절의 수행보다 수행 우선순위가 있는 FROM절의 인라인뷰에서 ORDER BY 수행하도록 해야 함.
SELECT ROWNUM,EMPNO,ENAME,SAL FROM(SELECT EMPNO, ENAME,SAL FROM EMP ORDER BY SAL DESC)TEMP ;
-- EMP테이블의 사원 중 급여를 가장 많이 받는 사원 5명의 사원번호, 사원이름, 급여 검색    
SELECT ROWNUM,EMPNO,ENAME,SAL FROM(SELECT EMPNO, ENAME,SAL FROM EMP ORDER BY SAL DESC)TEMP WHERE ROWNUM < 6;
    
--IF) ROWNUM을 기준으로 같거나 더 큰 숫자를 검색하고 싶다면?
-- 해당 쿼리의 문제점은 ROWNUM이 존재하는 SELECT 절보다 WHERE절의 수행순서가 이르다는 점이었다.
--> 따라서, WHERE절보다 수행순서가 빠른 FROM절(인라인뷰)에서 ROWNUM의 수행까지 완성된 테이블을 생성한다면 해당 연산도 가능해 진다.
SELECT * FROM (SELECT ROWNUM "RANKING",TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP ORDER BY SAL DESC)TEMP) WHERE RANKING=5; --ERROR
--1. 왜 이렇게 많은 서브쿼리를 사용해야만 하는지? 그냥 한번에 ROWNUM이 존재하는 서브쿼리를 만들면 안되는 건지? 2. 왜 ALIAS를 사용해야만 하는지
--1. 아래처럼 하나의 서브쿼리만을 이용할시, 정렬 이전에 ROWNUM이 붙어버려 급여순으로 ROWNUM이 생성되지 않음
SELECT * FROM (SELECT ROWNUM "RANKING",EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) WHERE RANKING=5;
--2. ROWNUM 은 애초에 컬럼이 아니라 키워드임 BUT 인라인뷰는 하나의 테이블을 생성하는것처럼 수행돼야함. 따라서 ALIAS를 부여하여 키워드를 통해 생성된 번호를 컬럼화 시켜주는 것. 
--> (ROWNUM은  테이블 내의 데이터 처럼 사용할 수 있는 것은 인라인뷰에서 컬럼화 시켜주었을 때 뿐) 
--//ROWNUM은 가상 컬럼인데 가상컬럼은 실제로 데이터베이스에 존재하는 컬럼은 아니지만, SELECT 문에서 조회할 수 있는 컬럼을 말함 BUT 존재하지 않기 때문에 쿼리를 수행할때마다 연산을 새로하여 반환함.(성능이슈)
--ROWNUM의 실행 방식 : ROWNUM은 반환될 행의 번호를 나타내는 가상 컬럼임. 
SELECT ROWNUM, TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP)TEMP WHERE ROWNUM<6;
--> 위와같이 인라인뷰가 아닌 쿼리문에서 ROWNUM 사용시, WHERE 절에서 ROWNUM명령을 수행하여 N번째 행까지만 반환하도록 걸러내는것. 
--> 그 후에 SELECT 절에서는 N개로 제한된 행을 출력하면서 일련번호를 부여하게 됨. 
--> 즉, 컬럼화된 RANKING=5 가 아닌 ROWNUM=5의 경우 키워드의 작동원리 상 ERROR가 발생하게 되는 것.


--EMP 테이블에 저장된 모든 사원 중 급여를 6번째부터 10번째까지 많이 받은 사원의 사원번호,사원이름,급여 검색
SELECT * FROM (SELECT ROWNUM "RANKING",TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP ORDER BY SAL)TEMP) WHERE RANKING BETWEEN 6 AND 10 ;

--<<SUPER_HERO 테이블 생성>> - 속성 : 이름(문자형)
CREATE TABLE SUPER_HERO(NAME VARCHAR2(20) PRIMARY KEY);

--SUPER_HERO 테이블에 행 삽입
INSERT INTO SUPER_HERO VALUES('슈퍼맨');
INSERT INTO SUPER_HERO VALUES('아이언맨');
INSERT INTO SUPER_HERO VALUES('배트맨');
INSERT INTO SUPER_HERO VALUES('앤트맨');
INSERT INTO SUPER_HERO VALUES('스파이더맨');
SELECT * FROM SUPER_HERO;
COMMIT;

--MARVEL_HERO 테이블 생성 - 속성 : 이름(문자형),등급(숫자형)
CREATE TABLE MARVEL_HERO(NAME VARCHAR2(20) PRIMARY KEY,GRADE NUMBER(1));

--MARVEL_HERO 테이블에 행 삽입
INSERT INTO MARVEL_HERO VALUES('아이언맨',3);
INSERT INTO MARVEL_HERO VALUES('헐크',1);
INSERT INTO MARVEL_HERO VALUES('스파이더맨',4);
INSERT INTO MARVEL_HERO VALUES('토르',2);
INSERT INTO MARVEL_HERO VALUES('앤트맨',5);
SELECT * FROM MARVEL_HERO;
COMMIT;

--UNION(합집합) : 두개의 SELECT 명령으로 검색된 행을 합하여 결과값을 제공하는 연산자 => 중복은 제거
--형식) SELECT 검색대상, ... FROM 테이블명1 UNION SELECT 검색대상, ... FROM 테이블명2
--2개의 SELECT 명령은 검색대생의 자료형과 갯수가 반드시 일치되도록 검색
SELECT NAME FROM SUPER_HERO UNION SELECT NAME FROM MARVEL_HERO;

--INTERSECT(교집합) : 두개의 SELECT 명령으로 검색된 행에서 중보고딘 행을 제공하는 연산자.
SELECT NAME FROM SUPER_HERO INTERSECT SELECT NAME FROM MARVEL_HERO;

--MINUS(차집합) : 첫번째 SELECT 명령으로 검색된 행에서 두번째 SELECT 명령으로 검색 된 행을 제외한 행을 제공하는 연산자
SELECT NAME FROM SUPER_HERO MINUS SELECT NAME FROM MARVEL_HERO;

--집합 연산자 사용시, 두개의 SELECT명령에 대한 검색 대상의 자료형 OR 갯수가 다른 경우 ERROR 발생.
SELECT NAME FROM SUPER_HERO UNION SELECT NAME, GRADE FROM MARVEL_HERO; -- 검색대상의 갯수가 달라 ERROR
SELECT NAME FROM SUPER_HERO UNION SELECT GRADE FROM MARVEL_HERO;  -- 검색대상의 자료형이 달라 ERROR

--> 굳이 하고싶다면,,? 동일자료형의 임의값을 사용 OR NULL 사용하여 집합 처리 가능.
SELECT NAME, 0 FROM SUPER_HERO UNION SELECT NAME, GRADE FROM MARVEL_HERO;
SELECT NAME, NULL FROM SUPER_HERO UNION SELECT NAME, GRADE FROM MARVEL_HERO;

--집합 연산자 사용시 두개의 SELECT 명령에 대한 검색 대상의 자료형이 다른 경우 변환함수를 사용하여 집합 처리 
SELECT NAME FROM SUPER_HERO UNION SELECT TO_CHAR(GRADE,0) FROM MARVEL_HERO;

--DML(DATA MANIPULATION LANGUAGE) : 데이터 조작어
--테이블 행에 대한 삽입,변경,삭제 기능을 제공하는 SQL 명령
--DML 명령 실행 후 COMMIT(TCL) OR ROLLBACK(TCL)

--INSERT : 행 삽입
--INSERT INTO TABLE_NAME VALUES(COLUMN1, 2, ...) -> 컬럼값은 속성의 순서대로, 갯수 및 자료형에 맞게 전달해야지만, 삽입 가능.

--TABLE의 속성(컬럼&자료형) 확인 : DESC 테이블명
DESC DEPT;

--DEPT 테이블에 새로운 행(부서정보) 삽입
INSERT INTO DEPT VALUES(50,'회계부','서울');
SELECT*FROM DEPT;
COMMIT;

INSERT INTO DEPT VALUES(6000,'총무부','수원'); -- 부서번호는 숫자값 2자리만 저장 가능 -> BUT 4자리 값 입력했으므로 오류
INSERT INTO DEPT VALUES(60,'총무부','수원시 팔달구'); -- 부서위치에 13자리 문자값보다 큰값 사용 -> 한글은 1자가 2BYTE-3BYTE일 듯..?

--테이블 칼럼에 부여된 제약조건을 위반하는 값을 전달할 경우 에러 발생
--PK(PRIMARY KEY) 제약조건 : 중복된 칼럼값 저장을 방지하기 위한 제약조건
--DEPT 테이블의 DEPTNO 칼럼에 PK 제약조건이 부여되어있음
SELECT DEPTNO FROM DEPT;
--테이블 속성과 제약조건을 위배하지 않는 컬럼값을 전달해야만 행 삽입 가능 
--> BUT 컬럼에 값을 저장하고싶지 않을경우 NULL 값 전달(묵시적 NULL 사용)
--테이블 속성과 제약조건을 위반하지 않는 컬럼값을 전달하야만 행 삽입 가능
INSERT INTO DEPT VALUES(60,'총무부','수원시');
SELECT * FROM DEPT;
COMMIT;

INSERT INTO DEPT VALUES(70,'영업부',NULL);
SELECT * FROM DEPT;
COMMIT;
--> BUT PRIMARY KEY 의 경우 NULL값을 허용하지 않음.
INSERT INTO DEPT VALUES(NULL,'영업부','인천시'); --오류
--테이블의 특정 컬럼에 값을 전달하여 삽입 가능 => INSERT INTO 테이블명(컬럼명1,2, ...) VALUES (컬럼값1,2,...)
-- 이런 방식 사용시, 순서를 테이블의 순서와 꼭 맞출 필요X +) PRIMARY KEY가 아닌 NULL 값들을 굳이 묵시적 NULL로 기입하지 않아도 됨.
INSERT INTO DEPT(DNAME,LOC,DEPTNO) VALUES('자재부','인천시',80);
SELECT* FROM DEPT;
COMMIT;

--테이블 컬럼 생략 가능 - 테이블 컬럼을 생략할 경우 생략된 컬럼에는 컬럼 기본값이 자동으로 전달되어 삽입 처리
--테이블 생성 또는 테이블의 컬럼 변경시 컬럼에 저장될 기본값 변경 가능
--컬럼 기본값을 변경하지 않으면 NULL을 기본값으로 사용되도록 자동 설정
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'인사부');--LOC 컬럼에 NULL이 전달되어 삽입 처리 : 묵시적 NULL 사용

--EMP 테이블의 속성 확인
DESC EMP; 
INSERT INTO EMP VALUES(9000,'KIM','MANAGER',7298,'00/12/01',3500,1000,40);
COMMIT;
--날짜형 컬럼에는 날짜값대신, SYSDATE 키워드를 사용하여 값전달이 가능함.
INSERT INTO EMP VALUES(9001,'LEE','ANALYSY',9000,SYSDATE,2000,NULL,40);
COMMIT;

--INSERT 명령에 서브쿼리를 사용하여 행 삽입 가능.
--서브쿼리의 검색결과를 이용 -> 테이블에 행 삽입. -> 테이블 행 복사

--BONUS 테이블 구조 확인
DESC BONUS;
SELECT * FROM BONUS;

--EMP 테이블에서 성과급이 존재하는 사원 정보를 검색하여 BONUS 테이블에 행을 삽입
INSERT INTO BONUS SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM BONUS;
COMMIT;

--UPDATE : TABLE에 저장된 행의 컬럼값을 변경하는 SQL명령
--테이블에 저장된 행 중 WHERE 조건식의 결과가 참인 행의 컬럼값을 변경할 때 사용.
--> WHERE 생략시 테이블에 저장된 모든 행의 컬럼값을 동일하게 변경 처리
--\WHERE 조건식에서 사용하는 비교컬럼은 PK제약조건이 부여된 컬럼을 이용해 변경하는것을 권장
-- B/C PK제약조건이 있는 컬럼의 경우 중복값이 없는것이 보장되므로 잘못된 변경을 방지할 수 있음.  

--DEPT 테이블에서 부서번호가 50인 부서정보 검색
SELECT * FROM DEPT WHERE DEPTNO=50;

--> 부서이름 [경리부] 부서위치[부천시] 변경
UPDATE DEPT SET DNAME='경리부',LOC='부천시' WHERE DEPTNO=50;
COMMIT;

--컬럼의 변경값은 컬럼의 자료형, 크기, 제약조건이 맞는 경우에만 변경 처리
UPDATE DEPT SET LOC='부천시 원미구' WHERE DEPTNO=50; --변경값의 조건이 맞지 않아 에러

--UPDATE 명령에서 서브쿼리 사용 가능. => SET의 변경값 OR WHERE 비교값 대신 서브쿼리 사용

UPDATE DEPT SET LOC=(SELECT LOC FROM DEPT WHERE DNAME='총무부') WHERE DNAME='영업부';
SELECT * FROM DEPT WHERE DNAME='영업부';
COMMIT;

--BONUS 테이블에서 사원이름이 KIM인 사원보다 성과급이 적은 사원의 성과급이 100 증가되도록 변경(WHERE절의 서브쿼리)
UPDATE BONUS SET COMM=COMM+100 WHERE COMM<(SELECT COMM FROM EMP WHERE ENAME='KIM');
SELECT * FROM BONUS;
COMMIT;

--DELETE : 테이블에 저장된 행을 삭제하는 SQL 명령-> 테이블간 관계에 큰 영향을 줄 수 있어 삭제는 잘 사용하지 않음.
-- DELETE ~ FROM
--WHERE 생략한 경우 테이블에 저장된 모든 행 삭제 
--마찬가지로 PK 제약조건이 있는 행을 삭제하는것이 좋음.

--DEPT 테이블에서 부서번호가 90인 부서정보 삭제
SELECT* FROM DEPT;
DELETE FROM DEPT WHERE DEPTNO=90;
SELECT* FROM DEPT;
COMMIT;

--부서정보가 10인 부서정보 삭제
--자식테이블에서 참조되는 행은 삭제 불가(FK 제약조건)

SELECT DISTINCT DEPTNO FROM EMP; -- 검색결과 : 10,20,30,40 - 부모 테이블을 참조하여 저장된 컬럼값.
DELETE FROM DEPT WHERE DEPTNO=20;--자식 테이블이 참조하는 부모테이블의 행을 삭제하여 에러 발생
DELETE FROM DEPT WHERE DEPTNO=80;
SELECT * FROM DEPT;
COMMIT;

--DELETE 명령에서 WHERE절의 비교값 대신 서브쿼리 사용 가능
--DEPT테이블에서 부서이름이 영업부인 부서와 같은 부서위치에 있는 부서정보 - 영업부 포함
DELETE FROM DEPT WHERE LOC = (SELECT LOC FROM DEPT WHERE DNAME='영업부');
SELECT * FROM DEPT;

--MERGE : 원본 테이블의 행을 검색하여 타겟 테이블에 행으로 삽입하거나 타겟 테이블에 저장된 행의 컬럼값을 변경하는 SQL 명령 -> 테이블의 행 병합
--MERGE - INTO TABLNAME USING ORIGINAL_TABEL_NAME ON (조건식)
--WHEN MATCHED THEN UPDATE SET TARGETED_COLUMN = ORIGINAL_COLUMN, ...
--WHEN NOT MATCHED THEN INSERT (TARGETED_COLUMN1, 2, ..) VALUES (ORIGINAL_COLUMN1, 2, ..)

--MERGE_DEPT 테이블 생성 - 속성 : 부서번호(숫자형), 부서이름(문자형), 부서위치(문자형)
DESC DEPT;
CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2), DNAME VARCHAR2(14), LOC VARCHAR(13));
DESC MERGE_DEPT;

--MERGE_DEPT TABLE에 행 삽입
INSERT INTO MERGE_DEPT VALUES (30,'총무부','서울시');
INSERT INTO MERGE_DEPT VALUES(60,'자재부','수원시');
SELECT * FROM MERGE_DEPT;
COMMIT;

--DEPT테이블과 MERGE_DEPT테이블을 MERGE 하려고 할때, 
--> MERGE 조건 : 부서번호 비교 -> 같은 것이 있을 경우 : 변경(UPDATE) // 없을 경우 : 삽입(INSERT)처리
MERGE INTO MERGE_DEPT "M" USING DEPT "D" ON ( M.DEPTNO = D.DEPTNO)
    WHEN MATCHED THEN UPDATE SET M.DNAME = D.DNAME, M.LOC = D.LOC
    WHEN NOT MATCHED THEN INSERT (M.DEPTNO,M.DNAME,M.LOC) VALUES (D.DEPTNO,D.DNAME,D.LOC);
SELECT * FROM MERGE_DEPT;
COMMIT;

--TCL(TRANSACTION CONTROL LANGUAGE) 트랜잭션 제어어
-- 트렌잭션에 저장된 SQL 명령을 실제 테이블에 적용하거나 테이블에 적용하지 않고 취소하는 명령

-- 트렌젝션 : 세션에서 DBMS 서버에 전달되어 실행될 SQL 명령을 저장하는 논리적인 작업 단위.
--> 커밋하기전까지 행해진 DML명령은 바로 DB에 저장되는것이 아니라 각각의 트랜젝션에 저장돼있음 (ROLLBACK이 가능한 원리)
--> 이 상태에서 검색시 사용하는 것.

--실제 테이블에 적용하기 위해서는 커밋(COMMIT) 처리 - 커밋 처리 후 트렌젝션 초기화
--1.현재 세션에서 정상적으로 서버 접속을 종료한 경우 자동 커밋 처리
--2. DDL 명령 OR DCL명령을 작성하여 서버에 절달할 경우 -> 자동 커밋 ( 즉, 롤백은 불가함)
--3. 서버에 전달하여 트렌젝션에 저장된 명령은 COMMIT 명령을 사용하여 커밋 처리함. (ROLLBACK 가능)
--> 즉, DML -> 수동 COMMIT  // DCL,DDL -> AUTO COMMIT

--DEPT 테이블에서 부서번호가 50인 부서정보 삭제
SELECT * FROM DEPT;
--DELETE 명령을 전달하면 DEPT 테이블의 행을 삭제하지 않고 트렌젝션에 DELETE 명령 저장
DELETE FROM DEPT WHERE DEPTNO=50;
--DEPT 테이블의 검색행에서 트랜젝션에 저장된 DELETE 명령을 실행한 검색결과 제공
SELECT * FROM DEPT;

--ROLLBACK 명령을 이용한 롤백처리 - 트렌젝션 초기화 
ROLLBACK;
SELECT * FROM DEPT;

--다시 삭제해봄 + COMMIT + ROLLBACK
DELETE FROM DEPT WHERE DEPTNO=50;
COMMIT;
SELECT*FROM DEPT;
ROLLBACK;
SELECT*FROM DEPT; -- 롤백해봤자 커밋시점으로 롤백하므로 소용X
