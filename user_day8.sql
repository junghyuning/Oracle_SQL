-- CASE / FOR LOOP / PROCEDURE - MODE / TRIGGER 

--CASE문 : 변수에 저장된 값을 비교하여 명령을 선택 실행하거나 조건식을 사용하여 명령을 선택 실행하는 구문
--> CASE 변수명 WHEN 비교값1 THEN 명령; ...WHEN 비교값2 THEN 명령; ... END CASE;

--EMP테이블에서 사원번호가 7788인 사원의 정보 출력하는 PL/SQL 작성
-- 업무별 급여 실지급액 - ANALYST: 급여 * 1.1, CLERK : 급여 * 1.2, MANAGER : 급여 * 1.3, PRESIDENT : 급여 * 1.4, SALESMAN : 급여 * 1.5

SET SERVEROUTPUT ON;
DECLARE 
    VEMP EMP%ROWTYPE;
    VPAY NUMBER(7,2);
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    CASE VEMP.JOB
        WHEN 'ANALYST' THEN VPAY := VEMP.SAL*1.1;
        WHEN 'CLERK' THEN VPAY := VEMP.SAL*1.2;
        WHEN 'MANAGER' THEN VPAY := VEMP.SAL*1.3;
        WHEN 'PRESIDENT' THEN VPAY := VEMP.SAL*1.4;
        WHEN 'SALESMAN' THEN VPAY := VEMP.SAL*1.5;
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = '||VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('급여 = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('업무별 실급여 = '||VPAY);

END;
/
        
--EMP 테이블에서 사원번호가 7788인 사원 정보 계산하여 출력하는 SQL
-- 급여 등급 : E:0~1000 / D:1001~2000 / C: 2001~300 / ...

DECLARE
    /* 레코드 변수 */
    VEMP EMP%ROWTYPE;
    VGRADE VARCHAR2(1);
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO =7788;
    
    CASE 
        WHEN VEMP.SAL BETWEEN 0 AND 1000 THEN VGRADE := 'E';
        WHEN VEMP.SAL BETWEEN 1001 AND 2000 THEN VGRADE := 'D';
        WHEN VEMP.SAL BETWEEN 2001 AND 3000 THEN VGRADE := 'C';
        WHEN VEMP.SAL BETWEEN 3001 AND 4000 THEN VGRADE := 'B';
        WHEN VEMP.SAL BETWEEN 4001 AND 5000 THEN VGRADE := 'A';
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('등급 = '||VGRADE);   
END;
/
    
--반복문 : 명령을 반복 실행하기 위한 구문

--BASIC LOOP : 무한반복 - 선택문을 사용하여 조건식이 참인 경우 EXIT 명령으로 반복문 종료
--형식)LOOP 명령; 명령; ... END LOOP;

--1~5 범위의 숫자값을 출력하는 PL/SQL 작성
DECLARE
    I NUMBER(1) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        IF I > 5 THEN 
            EXIT;
        END IF;
    END LOOP;
END;
/


--FOR  LOOP : 반복의 횟수가 정해져 있는 경우 사용하는 반복문
--형식)FOR INDEX_COUNTER IN [REVERSE] LOWER_BOUND..HIGH_BOUND LOOP 명령; 명령; ... END LOOP;

--1~10 범위의 정수값에 대한 합계를 계산하여 출력하는 PL/SQL 작성
DECLARE
    TOT NUMBER(2) := 0;
    
BEGIN
/*FOR LOOP 구문에서 사용되는 COUNTER_INDEX는 FOR LOOP 구문 내에서만 사용 가능. */
    FOR I IN 1 .. 10 LOOP
        TOT := TOT+I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~10 범위 정수의 합계 ='||TOT);
END;
/

--FOR LOOP 구문 >> 다중 검색행에대한 반복처리가 가능함. -> 내부적 커서를 사용하여 반복을 처리함

--EMP 테이블에 저장된 모든 사원정보를 검색하여 번호, 이름을 출력하는 PL/SQL문

BEGIN 
    FOR VEMP IN (SELECT*FROM EMP) LOOP
        DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO||', 사원이름 = '||VEMP.ENAME);
    END LOOP;
END;
/

--커서(CURSOR):  테이블의 검색행을 저장 & 처리하기위한 기능을 제공함.
-- 1. 묵시적 커서 : 검색결과가 단일행인 경우를 처리하는 위한 커서
-->> 단일행일 경우 커서를 따로 생성하지 않아도 됨.

-- 2. 명시적 커서 : 검색결과가 다중행인 경우를 처리하는 커서 >> "커서를 생성"해야 함.
--형식) DECLARE
     /* 커서 생성 */
--    CURSOR 커서명 IS SELECT 검색대상, 검색대상, ... FROM 테이블명 [WHERE 조건식];
--    BEGIN
--        OPEN 커서명; /*커서 열기 : 첫 검색행을 제공받기위해 커서의 위치를 이동함*/
--        FETCH 커서명 INTO 변수명1, 2, ... /* 커서 위치의 검색행을 제공받아 변수에 저장 -> 실행 후, 커서는 다음행으로 이동 */
--        CLOSE 커서명;/* 커서 닫기 - 커서를 더이상 사용하지 않도록 제거 */
--    END;
DECLARE 
    CURSOR C IS SELECT * FROM EMP;
    VEMP EMP%ROWTYPE;
BEGIN
    OPEN C;
    
    LOOP
        FETCH C INTO VEMP; /*커서위치의 검색행을 VEMP에 저장하고 다른 위치로 이동*/
        EXIT WHEN C%NOTFOUND; /* 커서 위치의 검색행이 없는 경우 반복문 종료*/
    END LOOP;
    
    CLOSE C;
END;
/

-- WHILE LOOP :반복의 횟수가 부정확한 경우 사용하는 반복문

DECLARE
    I NUMBER(2) := 1;
    TOT NUMBER(2) := 0;
BEGIN 
    WHILE I <= 10 LOOP
    TOT := TOT +I;
    I:= I+1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~10 범위의 정수들의 합계'||TOT);
END;
/

--저장 프로시저(STORED PROCEDUER) : PL/SQL 프로시저에 이름을 부여하여 저장 -> 필요한 경우 해당 이름으로 호출하여 사용함 >> 메서드와 유사한 형태
--> CREATE [OR REPLACE] PROCEDURE 프로시저명[(매개변수 [MODE] 자료형, 매개변수 [MODE] 자료형,...)]
--      IS [변수선언] BEGIN 명령; 명령; ... END;

--EMP_COPY 테이블에 저장된 모든 사원 정보를 삭제하는 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE DELETE_ALL_EMP_COPY IS /* 이자리에 원래 변수 선언. BUT 변수가 필요 없을시, 생략*/
BEGIN
    DELETE FROM EMP_COPY;
    COMMIT;
END;
/
-- 저장 프로시저 확인 : USER_SOURCE: 저장 프로시저 및 저장 함수 정보 제공하는 딕셔너리
--CF) 프로시져 VS 함수
--프로시저 : 일련의 쿼리를 마치 하나의 함수처럼 실행하기 위한 쿼리의 집합이며, 일련의 작업을 정리한 절차입니다.
--      1.보통 단독으로 실행해야 할 작업을 위임받았을 때 사용
--      2.값 반환 불가
--함수 : 하나의 특별한 목적의 작업을 수행하기 위해 독립적으로 설계된 코드의 집합 
--      1. 보통 로직을 도와주는 역할이며, 간단한 계산, 수치 등을 나타낼 때 사용
--      2. 값 반환 가능
--      3. 쿼리문에 포함하여 사용할 수 있음. (함수는 반드시 1개의 값을 RETRUN하므로 변수처럼 사용 가능함.)
-->>즉, 함수가 여러 작업을 위한 기능이라면 프로시저는 작업을 정리한 절차입니다.

SELECT NAME, TEXT FROM USER_SOURCE WHERE NAME='DELETE_ALL_EMP_COPY';

--저장 프로시저 호출 - 저장 프로시저에 작성된 PL/SQL 실행
--형식) EXECUTE 프로시저명[({변수값|값},{변수값|값},...)]
SELECT * FROM EMP_COPY;
EXECUTE DELETE_ALL_EMP_COPY;
SELECT * FROM EMP_COPY;

--> IF 저장프로시저 생성시 컴파일 에러 발생 => 컴파일 로그 확인 (에러확인)
SHOW ERROR;

SELECT NAME, TEXT FROM USER_SOURCE WHERE NAME='DELETE_ALL_EMP_COPY';

--저장 프로시저의 매개변수 : MODE(모드)
--1. IN : 저장 프로시저 호출시 외부로부터 값을 전달받아 저장 프로시저의 PL/SQL 명령에서 사용할 목적의 매개변수를 선언할 때 
--2. OUT : 저장 프로시저 호출시 "바인딩 변수"를 전달받아 저장 프로시저의 PL/SQL 실행 결과를 저장하여 외부에 결과값을 제공할 목적으로 매개변수를 선언할 때 사용
--> 프로시저의 경우 값을 반환할 수 없음 (CF. 함수의 경우 값을 반환 가능) >> BUT 외부로 값을 전달하고싶다면? BINDING 변수 사용.
--3. INOUT: 저장 프로시저 호출시 바인딩 변수를 전달받아 저장 프로시저의 PL/SQL 명령에서 사용하거나 실행 결과를 저장하여 외부에 결과값을 제공할 목적의 매개변수를 선언할 때 사용.

--"사원번호를 매개변수로 전달받아 EMP테이블에서 검색 -> 이름, 업무, 급여를 매개변수로 전달 -> 외부로 제공"하는 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE SELECT_EMPNO(VEMPNO IN EMP.EMPNO%TYPE, VENAME OUT EMP.ENAME%TYPE, VJOB OUT EMP.JOB%TYPE, VSAL OUT EMP.SAL%TYPE) IS
BEGIN
/*전달받은 매개변수 VEMPNO의 값이 EMP 테이블의 EMPNO의 값과 같을시, VENAME,VJOB,VSAL에 값을 저장하여 외부에 전달.*/
    SELECT ENAME,JOB,SAL INTO VENAME,VJOB,VSAL FROM EMP WHERE EMPNO=VEMPNO;  
END;
/

--OUT 모드의 매개변수에 의해 제공받는 값을 저장하기위한 바인딩 변수 선언
-- 형식) VARIABLE 바인딩변수명 자료형
-- 바인딩 변수 : "현재 접속 사용자의 세션"에서"만" 사용할 수 있는 시스템 변수
-- 프로시저와 프로시저간의 값의 교환에 사용됨.
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_JOB VARCHAR2(20);
VARIABLE VAR_SAL NUMBER;

--SELECT_EMPNO 프로시저 호출 
-- OUT 모드의 매개변수에 바인딩 변수를 전달하여 값을 저장하기 위해서는 반드시 바인딩 변수 앖에 [:]FMF 붙여 사용함.
-- 저장시에만 [:] 붙임 (출력시에는 사용X)
EXECUTE SELECT_EMPNO(7788,:VAR_ENAME,:VAR_JOB,:VAR_SAL);

--바인딩변수 저장값 출력
PRINT VAR_ENAME;
PRINT VAR_JOB;
PRINT VAR_SAL;


-- 저장함수(STORE FUNCTION) : 저장 프로시저와 유사한 기능을 제공하지만, 반드시 하나의 결과값을 반환함.

--저장함수 생성
-- CREATE [OR REPLACE] FUNCTION 저장함수명[(매개변수 [MODE] 자료형, 매개변수 [MODE] 자료형,...)]
--          RETURN 자료형 IS [변수선언부] BEGIN 명령1, 2, .. RETURN 반환값; END;

--사원번호를 매개변수로 전달받아 EMP 테이블에서 해당 사원의 급여의 2배에 해당하는 결과값을 반환하는 저장함수 생성.
CREATE OR REPLACE FUNCTION CAL_SAL(VEMPNO IN EMP.EMPNO%TYPE) RETURN NUMBER IS VSAL NUMBER(7,2);
BEGIN
    SELECT SAL INTO VSAL FROM EMP WHERE EMPNO=VEMPNO;
    RETURN VSAL*2;
END;
/

--저장함수 확인 딕셔너리 : USER_SOURCE 
SELECT NAME, TEXT FROM USER_SOURCE WHERE NAME = 'CAL_SAL';

--저장함수의 반환값을 저장하기 위한 바인딩 함수 선언
VARIABLE VAR_SAL NUMBER;

--저장함수 호출 - 저장 함수의 반환값을 바인딩 변수에 저장 (저장시에는 [:] 붙이기)
EXECUTE :VAR_SAL := CAL_SAL(7788) --CAL_SAL함수 실행한 결과값을 저장함.
PRINT VAR_SAL;

--> 저장함수의 경우 SQL 명령에 포함하여 사용할 수 있음.
SELECT EMPNO,ENAME,SAL,CAL_SAL(EMPNO) "특별수당" FROM EMP;

--저장함수 삭제 : DROP FUNCTION 함수명
DROP FUNCTION CAL_SAL;
SELECT NAME, TEXT FROM USER_SOURCE WHERE NAME = 'CAL_SAL';

--TRIGGER : 특정 테이블에서 SQL 명령(DML)이 실행될 경우 PL/SQL 프로시저의 명령을 실행하는 기능

--트리거 생성 : CREATE [OR REPLACE] TRIGGER 트리거명 {AFTER|BEFORE} {INSERT|UPDATE|DELETE} ON 테이블명
--              [FOR EACH ROW] [WITH 조건식] BEGIN 명령1,2, ... END;

--FOR EACH ROW : 선언시, 행레벨 트리거 생성 / 생략 -> 문장레벨 트리거 생성  
--1. 문장레벨 트리거 : 이벤트 DML 명령이 실행되면 트리거에 작성된 PL/SQL 프로시저의 명령을 한번만 실행 함.
--2. 행레벨 트리거 : 이벤트 DML 명령이 실행되면 트리거에 작성된 PL/SQL 프로시저의 명령을 행의 갯수만큼 실행
--> 트리거에 등록된 PL/SQL 프로시저의 명령으로 TCL 명령(COMMIT, ROLLBACK) 사용 불가

CREATE OR REPLACE TRIGGER EMP_COPY2_INSERT_TRIGGER AFTER INSERT ON EMP_COPY2
BEGIN
    DBMS_OUTPUT.PUT_LINE('새로운 사원이 입사 하였습니다.');
END;
/

--트리거 확인 - USER_TRIGGERS : 트리거 정보를 제공하는 딕셔너리
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP_COPY2 테이블에 행 삽입
SELECT * FROM EMP_COPY2;
INSERT INTO EMP_COPY2 VALUES(1111,'홍길동',4000);
SELECT * FROM EMP_COPY2;
COMMIT;

--트리거 삭제
--형식)DROP TRIGGER 트리거명

--EMP_COPY2_INSERT_TRIGGER 트리거 삭제
DROP TRIGGER EMP_COPY2_INSERT_TRIGGER;
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,급여,부서번호를 검색하여 EMP_TRI 테이블을 생성하여 검색행 삽입
CREATE TABLE EMP_TRI AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;
SELECT * FROM EMP_TRI;

--EMP_HIS 테이블 생성 - 사원번호(숫자형-PRIMARY-KEY), 사원이름(문자형), 사원상태(문자형)
CREATE TABLE EMP_HIS(NO NUMBER(4), NAME VARCHAR2(20), STATUS VARCHAR2(50));

--EMP_TRI 테이블에서 행을 삽입하거나 변경 OR 삭제한 경우 DML 명령 실행 후 삽입, 변경, 삭제에 대한 이유를 EMP_HIS 테이블에 행으로 삽입하는 트리거 생성
CREATE OR REPLACE TRIGGER EMP_HIS_TRIGGER AFTER INSERT OR UPDATE OR DELETE ON EMP_TRI FOR EACH ROW
BEGIN
   IF INSERTING THEN /* INSERT 명령이 실행된 경우 */
        INSERT INTO EMP_HIS VALUES(:NEW.EMPNO, :NEW.ENAME, '입사');
    ELSIF UPDATING THEN  /* UPDATE 명령이 실행된 경우 */
        IF :NEW.DEPTNO <> :OLD.DEPTNO THEN
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '부서이동');
        ELSIF :NEW.SAL <> :OLD.SAL THEN
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '급여변경');
        ELSE    
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '개인사유');
        END IF;            
    ELSIF DELETING THEN   /* DELETE 명령이 실행된 경우 */
        INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '퇴사');
    END IF;
END;
/

--행삽입
SELECT * FROM EMP_TRI;
INSERT INTO EMP_TRI VALUES(5000,'PARK',2000,10);
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

UPDATE EMP_TRI SET DEPTNO=20 WHERE EMPNO=5000;
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
UPDATE EMP_TRI SET SAL=3000 WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
UPDATE EMP_TRI SET ENAME='홍길동' WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

--EMP_TRI 테이블에 저장된 행 삭제 - EMP_HIS_TRIGGER 트리거에 의해 EMP_HIS 테이블에서 행 삽입
DELETE FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

