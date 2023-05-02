--워크시트 설명문 처리

--워크시트에서 작성된 SQL 명령을 접속된 오라클 서버에 전달하여 실행하는 방법
--[CTRL]+[ENTER] : 커서 위치의 SQL 명령을 전달하여 실행
--[F5] : 워크시트에 작성된 모든 SQL 명령을 전달하여 실행
--범위를 지정하여 [CTRL]+[ENTER] 또는 [F5]를 사용하면 범위 내부의 SQL 명령을 전달하여 실행
--워크시트에 작성되어 실행된 SQL 명령의 결과는 [스크립트 출력] 또는 [질의 결과] 탭에 출력

--SQL 명령은 대소문자를 구분하지 않으며 하나의 명령으로 처리되도록 ; 기호 사용
SHOW USER;--현재 서버에 접속한 사용자의 이름을 확인하기 위한 명령

--테이블(TABLE) : 데이타베이스에서 데이타(행)을 저장하기 위한 기본 객체
--현재 접속 사용자(SCOTT)가 접근 가능한 스키마에 존재하는 테이블 목록 확인
SELECT TABLE_NAME FROM TABS;
SELECT * FROM TAB;

--테이블의 구조 확인 : 컬럼명과 자료형 - 태이블 속성
--형식)DESC 테이블명;
--EMP 테이블 : 사원정보를 저장하기 위한 테이블
DESC EMP;
--DEPT 테이블 : 부서정보를 저장하기 위한 테이블
DESC DEPT;

--DQL(DATA QUERY LANGUAGE) : 데이타 질의어 - 테이블에 저장된 행을 검색하기 위한 SQL 명령
--SELECT : 하나 이상의 테이블에서 행을 검색하기 위한 명령
--형식)SELECT 검색대상,검색대상,... FROM 테이블명
--하나의 테이블에 저장된 모든 행을 검색하여 위한 SELECT 명령
--검색대상 : *(모든 컬럼) - 다른 검색대상과 동시에 사용 불가능, 컬럼명, 연산식, 함수 등
SELECT * FROM EMP;
SELECT EMPNO,ENAME,SAL FROM EMP;

--COLUMN ALIAS : 검색대상에 별칭(임시 컬럼명)을 부여하는 기능
--검색대상을 명확하게 구분하기 위해 COLUMN ALIAS 기능 사용
--형식)SELECT 검색대상 [AS] 별칭,검색대상 [AS] 별칭,... FROM 테이블명
SELECT EMPNO,ENAME,DEPTNO FROM EMP;
SELECT EMPNO AS NO, ENAME AS NAME, DEPTNO AS DNO FROM EMP;
--컬럼의 별칭을 설정하기 위한 AS 키워드 생략 가능
SELECT EMPNO NO, ENAME NAME, DEPTNO DNO FROM EMP;
SELECT EMPNO 사원번호, ENAME 사원이름, DEPTNO 부서번호 FROM EMP;

--검색대상으로 컬럼값을 이용한 연산식 사용 가능
SELECT EMPNO, ENAME, SAL*12 FROM EMP;
SELECT EMPNO, ENAME, SAL*12 ANNUAL FROM EMP;

--SQL 명령은 예약어(키워드)와 사용자 정의 명칭(식별자)의 단어로 구성
--식별자(테이블명, 컬럼명, 별칭 등)은 스네이크 표기법(단어와 단어를 [_]로 구분하여 표현)을 사용하여 작성
SELECT EMPNO, ENAME, SAL*12 ANNUAL_SALARY FROM EMP;

SELECT EMPNO 사원번호, ENAME 사원이름, SAL*12 연봉 FROM EMP;
--검색대상의 별칭으로 공백 또는 특수문자 사용 불가능
SELECT EMPNO 사원 번호, ENAME 사원 이름, SAL*12 ^연봉^ FROM EMP;--에러 발생
--검색대상의 별칭을 " " 기호 안에 표현하면 모든 형태의 별칭 표현 가능
--" " 기호는 검색대상의 별칭을 표현하기 위해 사용하는 특수문자
SELECT EMPNO "사원 번호", ENAME "사원 이름", SAL*12 "^연봉^" FROM EMP;

--검색대상을 , 기호를 사용하여 나열 작성 가능
SELECT ENAME,JOB FROM EMP;

--검색대상에 || 기호를 사용하여 문자값으로 결합하여 검색
SELECT ENAME||JOB FROM EMP;

--SQL에서 문자값은 ' ' 기호를 사용하여 표현
SELECT ENAME||'님의 업무는 '||JOB||'입니다.' FROM EMP;

--EMP 테이블에 저장된 모든 사원의 업무 검색 - 중복 컬럼값 검색
SELECT JOB FROM EMP;

--EMP 테이블에 저장된 모든 사원의 업무 검색 - 중복 컬럼값을 제외한 유일한 하나의 컬럼값만 검색
--DISTINCT : 검색대상의 중복값을 제외하고 유일한 하나의 컬럼값만 검색하는 기능을 제공하는 키워드
--형식)SELECT DISTINCT 검색대상,검색대상,... FROM 테이블명
SELECT DISTINCT JOB FROM EMP;

--오라클은 DISTINCT 키워드에 검색대상을 여러개 나열하여 작성 가능
SELECT DISTINCT JOB,DEPTNO FROM EMP;

--WHERE : 조건식을 사용하여 조건이 참(TRUE)인 행만 검색하는 기능을 제공
--형식)SELECT 검색대상,검색대상,... FROM 테이블명 WHERE 조건식
--조건식은 일반적으로 컬럼값을 비교하는 연산식

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

--EMP 테이블에서 사원번호가 7698인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE EMPNO=7698;

--EMP 테이블에서 사원이름이 KING인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='KING';
--SQL 명령은 대소문자를 구분하지 않지만 문자값은 대소문자를 구분
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='king';

--EMP 테이블에서 입사일이 1981년 6월 9일인 사원의 사원번호,사원이름,업무,급여,입사일 검색
--날짜값은 ' ' 안에 [RR/MM/DD] 형식의 패턴으로 표현하여 사용 - 날짜형의 기본 패턴 : [RR/MM/DD]
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE='81/06/09';
--날짜값은 ' ' 안에 [YYYY-MM-DD] 형식의 패턴으로 표현하여 사용 가능
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE='1981-06-09';

--EMP 테이블에서 업무가 SALESMAN이 아닌 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB<>'SALESMAN';
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB!='SALESMAN';

--EMP 테이블에서 급여가 2000 이상인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL>=2000;

--EMP 테이블에서 사원이름 A,B,C,로 시작되는 사원의 사원번호, 사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME<'D';

--EMP 테이블에서 1981년 5월 1일전에 입사한 사원의 사원번호,사원이름,업무,급여,입사일 검색
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE<'81/05/01';

--EMP 테이블에서 업무가 SALESMAN인 사원중 급여가 1500 이상인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB='SALESMAN' AND SAL>=1500;

--EMP 테이블에서 부서번호가 10이거나 업무가 MANAGER인 사원의 사원번호,사원이름,업무,급여,부서번호 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE DEPTNO=10 OR JOB='MANAGER';

SELECT * FROM EMP WHERE SAL>=1000 AND SAL<=3000;

SELECT SAL FROM EMP;
--범위연산식 -> 형식) 컬럼명 BETWEEN 작은값 AND 큰값; //작은값 및 큰값 포함 함.
SELECT*FROM EMP WHERE SAL BETWEEN 1100 AND 3000;

SELECT * FROM EMP WHERE JOB = 'ANALIST' OR JOB='SALESMAN';

SELECT * FROM EMP WHERE JOB IN ('ANALIST','SALESMAN');

select * from emp where ename='ALLEN';

-- BETWEEN은 범위값을 모두 포함하므로 둘의 결과는 다르게 나오게 됨.
SELECT* FROM EMP WHERE ENAME>='A' AND ENAME<'B';
SELECT * FROM EMP WHERE ENAME BETWEEN 'A' AND 'B';

-- 검색문자 => [%] - 전체  /  [_] - 문자 하나  /  
-- = 연산자로 비교할 경우 검색문자가 아닌 일반문자로 검색됨
-- 따라서 검색문자를 이용하여 컬럼값을 비교 검색할 경우, [=] 연산자 대신, like 키워드를 사용함.
select * from emp where ename='A%'; -- 이때는 결과값 안나옴(특수문자를 포함하는 결과가 없기 때문)
SELECT * FROM EMP WHERE ENAME LIKE 'A%'; -- 이때는 결과값 나옴

--검색문자를 사용하지 않아도 [=] 대신, LIKE 사용해도 상관 없음.
SELECT * FROM EMP WHERE ENAME LIKE 'ALLEN';

-- 특정 문자를 포함하는 단어를 찾을 때.
SELECT * FROM EMP WHERE ENAME LIKE '%A%';

--EMP 테이블에서 사원이름의 두번째 문자가 L인 사원 검색
SELECT * FROM EMP WHERE ENAME LIKE '_L%';

--EMP TABLE에 새로운 사원번호 삽입
INSERT INTO EMP VALUES (9000,'M_BEER','CLERK',7788,'81/12/12',1300,NULL,10);

SELECT * FROM EMP;
COMMIT;

-- 이름에 _ 문자가 포함된 사원의 정보
-- 그냥 _로쓰면 검색문자로 반영되기 때문에 회피문자(escape character) 를 사용하여 일반문자로 처리해 검색하는것이 가능함.
SELECT* FROM EMP WHERE ENAME LIKE '%\_%' escape '\';

-EMP 테이블에서 사원번호가 9000인 사원정보(행) 삭제
DELETE FROM EMP WHERE EMPNO=9000;
COMMIT;

--emp 테이블에서 업무가 manager가 아닌 사원 검색
SELECT * FROM EMP WHERE JOB<>'MANAGER';
--NOT 키워드의 활용
SELECT * FROM EMP WHERE NOT (JOB = 'MANAGER');

--EMP 테이블에서 성과급이 없는 사원 검색 NULL값 여부를 결정할때는
-- IS NULL // IS NOT NULL
SELECT * FROM EMP;
SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;

--ORDER BY : 컬럼값을 비교하여 행이 정렬되도록 검색하는 기능을 제공. ASC / DESC
--정렬한 컬럼값이 같을 경우, 다른 컬럼의 값을 비교하도록 하는 것도 가능함.
--INDEX [1]부터 시작함..!
SELECT EMPNO, ENAME, JOB, SAL, COMM FROM EMP WHERE SAL>1000 ORDER BY SAL, ENAME DESC;

--연봉으로 내림차순정렬
SELECT EMPNO, ENAME, SAL*12 AS ANNUAL, COMM FROM EMP ORDER BY SAL*12 DESC;
SELECT EMPNO, ENAME, SAL*12 AS ANNUAL, COMM FROM EMP ORDER BY ANNUAL DESC;
-- INDEX[1] = EMPNO, INDEX[2] = ENAME, INDEX[3] = SAL*12
SELECT EMPNO, ENAME, SAL*12 AS ANNUAL FROM EMP ORDER BY 3 DESC;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP ORDER BY DEPTNO, SAL DESC;

-- 설령 모든 컬럼을 검색할지라도 *을 쓰지 않고 일일히 컬럼을 적는것이 검색속도가 빠르므로 실제로는 *은 사용하지 않음

--검색대상 : EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO
-- 문제1. 사원이름의 SCOTT인 사원
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE ENAME = 'SCOTT';

--USER = 현재 접속 사용자의 이름을 표현하기위한 예약어
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE ENAME = USER;

--문제2. 급여가 1500 이하인 사원
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE SAL <= 1500; 
--문제3. 1981년에 입사한 사원
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE HIREDATE BETWEEN '81/01/01' AND '81/12/31';
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE HIREDATE LIKE '81%';

--문제4. 업무가 'SALESMAN' OR 'MANAGER'인 사원 중 급여가 1500이상인 사원 검색
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE JOB IN ('SALESMAN', 'MANAGER') AND SAL>=1500;
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE (JOB ='SALESMAN' OR JOB = 'MANAGER') AND SAL>=1500;

--문제 5. 부서번호가 30인 사원 중 성과급이 존재하는 사원
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE DEPTNO = 30 AND COMM IS NOT NULL;
--문제 6. 부서번호가 30인 사원 중 급여가 1000~3000범위인 사원 검색
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE DEPTNO = 10 AND SAL BETWEEN 1000 AND 3000;
--문제 7. 모든 사원을 업무로 오름차순 정렬하여 검색하고 같은 업무의 사원은 급여로 내림차순 정렬하여 검색
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP ORDER BY JOB, SAL DESC;
--문제 8. 업무가 'SALESMAN' 인 사원을 급여로 내림차순 정렬
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE JOB = 'SALESMAN' ORDER BY SAL DESC;

-- 함수 : 매개변수로 전달받은 값을 가공하여 처리 결과값을 반환하는 기능을 제공함
--단일함수 : 하나의 값 전달받아 결과값 반환 => 문자, 숫자, 날짜, 변환, 일반 함수
--그룹함수 : 다수의 값을 전달받아 가공 -> 결과값 전달

--문자함수 : 매개변수로 문자값을 전달받아 가공가고 그 결과값을 반환함.
--UPPER / LOWER
SELECT ENAME,UPPER(ENAME),LOWER(ENAME) FROM EMP;

--SQL은 대소문자를 구분하지 않지만, 문자의 경우에는 대소문자를 구분하고잇음
--대소문자를 구분하지 않고 일치하는 자료를 검색하고 싶을때, UPPER . LOWER 를 사용할 수 있다.
SELECT ENAME FROM EMP WHERE UPPER(ENAME) = UPPER('smith');
 
 --INITCAP(문자값) : 첫번째 문자만 대문자로 변환 -> 나머지 문자는 소문자로 변환하여 반환
 SELECT ENAME, INITCAP(ENAME) FROM EMP;
 
 -- CONCAT : 두개의 문자를 결합 (||와 유사)
 SELECT ENAME, JOB, CONCAT(ENAME,JOB), ENAME||JOB FROM EMP;
 
 --SUBSTR(문자열, 시작위치, 갯수) : 시작 ~N개의 갯수만큼의 문자
SELECT EMPNO, ENAME, JOB, SUBSTR(JOB,6,3) FROM EMP WHERE EMPNO=7499;

--LENGTH(문자값) : 문자값을 전달받아 문자 갯수를 반환하는 함수
SELECT EMPNO, ENAME, JOB, LENGTH(JOB) FROM EMP WHERE EMPNO = 7499;

--INSTR(문자값, 검색할문자, 시작, 검색위치) : 시작위치부터 검색 -> 원하는 위치의 문자값을 시작(IF 검색할 문자 = 1 / 검색위치 = 2 => 2번째 1의 위치를 반환함)
SELECT EMPNO, ENAME, JOB, INSTR(JOB, 'A', 1,2)FROM EMP WHERE EMPNO=7499;

--LPAD(문자값, 자릿수, 채울문자) : 문자를 전달받아 왼쪽부터 채우고 오른쪽 남는 자리는 채울문자로 채워서 반환
--RPAD(문자값, 자릿수, 채울문자) : 문자를 전달받아 오른쪽부터 채우고 왼쪽의 남는 자리는 채울문자로 채워서 반환함.
SELECT EMPNO, ENAME, SAL, LPAD(SAL,8,'*'),RPAD(SAL,8,'*') FROM EMP;

--TRIM({LEADING|TRAILING} 제거문자 FROM 문자값) : 문자값을 전달받아 앞(LEADING) OR 뒤(TRAILING)에 존재하는 제거문자를 삭제하고 반환.
SELECT EMPNO,ENAME, JOB, TRIM(LEADING 'S' FROM JOB), TRIM(TRAILING 'N' FROM JOB) FROM EMP WHERE EMPNO=7499;

--REPLACE(문자값, 검색문자값, 치환문자값)
SELECT EMPNO, ENAME, JOB, REPLACE(JOB,'MAN','PERSON')FROM EMP WHERE EMPNO=7499;