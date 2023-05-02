--숫자함수 : 매개변수로 숫자값을 전달받아 가공 -> 결과값 반환
--ROUND(숫자값,소숫점자릿수) : 입력받은 자리수까지 반올림
--DUAL 테이블 : 테이블 없이 검색대상을 SELECT 명령으로 작성할 경우 사용되는 가상의 테이블
SELECT ROUND(45.582, 2), ROUND(45.582, 0), ROUND(45.582, -1) FROM DUAL;

--TRUNC(숫자값, 소숫점자릿수) : 입력받은 자릿수까지 절삭 처리 (버림)
SELECT TRUNC(45.582, 2), TRUNC(45.582,0), TRUNC(45.582,-1) FROM DUAL;
--CEIL : 가장 가까운 정수중 해당 값보다 큰 수
SELECT CEIL(15.3), CEIL(-15.3) FROM DUAL;
--FLOOR : 가장 가까운 정수 중 해당 값보다 작은 정수
SELECT FLOOR(15.3), FLOOR(-15.3) FROM DUAL;

--MOD(N,M) : 나머지
SELECT 20/8, MOD(20/8) FROM DUAL;
--POWER : 제곱
SELECT 3*3*3*3, POWER(3,4) FROM DUAL;

--날짜함수 : 매개변수로 날짜값을 전달받아 가공 -> 결과 반환
--SYSDATE : 시스템의 현재 날짜와 시간을 제공하기 위한 키워드
--SYSDATE 키워드의 검색값은 기본적으로 [RR/MM/DD] 패턴으로 검색되지만, 내부적으로는 날짜와 시간 제공
SELECT SYSDATE, ADD_MONTHS(SYSDATE,5) FROM DUAL;

--SYSDATE+숫자 >> 일 증가
SELECT SYSDATE, SYSDATE+7 FROM DUAL;

--숫자/24 => 시간처리 //IF) 100/24 = 100시간 = 4일 X시간 (계산값 = DAY 기준이므로)
SELECT SYSDATE, SYSDATE+100/24 FROM DUAL;

--날짜 - 날짜 = 경과일수(실수값)
SELECT EMPNO, ENAME, HIREDATE, SYSDATE-HIREDATE FROM EMP WHERE EMPNO=7499;
SELECT EMPNO, ENAME, HIREDATE, CEIL(SYSDATE-HIREDATE)||'일' "근속일수" FROM EMP WHERE EMPNO=7499;

--NEXT_DAY(날짜, 요일) : 날짜값을 전달받아 미래의 특정 요일에 대한 날짜값을 반환하는 함수
SELECT SYSDATE "오늘", NEXT_DAY(SYSDATE, '금') "금요일" FROM DUAL;

--오라클에 접속된 현재 사용자 환경(SESSION)에 따라 사용 언어 및 날짜와 시간 패턴이 다르게 적용 됨.
--세션의 사용 언어 및 날짜, 시간패턴 변경 가능
ALTER SESSION SET NLS_LANGUAGE ='AMERICAN'; -- 사용언어 변경
--영어 설정이므로 금요일을 인식할 수 없어 오류 발생.
--SELECT SYSDATE "오늘", NEXT_DAY(SYSDATE, '금') "금요일" FROM DUAL;
SELECT SYSDATE "오늘" , NEXT_DAY(SYSDATE, 'FRI') "금요일" FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE='KOREAN'; -- 다시 한글 설정으로 바꿈

--TRUNC(날짜, 표현단위) : 날짜값을 전달받아 원하는 단위만 표현하고 나머지는 절삭하여 초기값 반환.
SELECT SYSDATE, TRUNC(SYSDATE, 'MONTH'),TRUNC(SYSDATE,'YEAR') FROM DUAL;

--변환함수 : 매개변수로 전달받은 값을 원하는 자료형의 값으로 변환하여 반환하는 함수
--TO_NUMBER(문자값) 매개변수가 문자가 아닐경우 에러 발생.
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO=7839;
--비교 컬럼의 자료형이 숫자형인 경우 비교값이 문자값이면 TO_NUMBER 함수를 사용 -> 숫자로 변환하여 비교
--=> 강제 형변환임
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO=TO_NUMBER('7839');
--비교값이 숫자인경우 자동으로 형변환하므로 굳이 설정할 필요없음
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO='7839';

--문자값을 산술연산할 경우 문자값이 자동으로 숫자값으로 변환되어 연산처리 -> 자동형변환
SELECT 100+'200' FROM DUAL;
SELECT '100'+'200' FROM DUAL;
--애초에 숫자가 아닌 값은 강제형변환도 자동형변환도 불가 
--SELECT 'A'+'B' FROM DUAL;
--SELECT TO_NUMBER('A')+TO_NUMBER('B') FROM DUAL;

--EMP테이블에서 사원번호가 7839인 사원의 사원번호, 사원이름, 급여, 세후급여(급여*0.9) 검색
--자동/강제 형변환에의해 모두 같은 결과 출력
SELECT EMPNO,ENAME,SAL,SAL*0.9 FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*'0.9' FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*TO_NUMBER('0.9') FROM EMP WHERE EMPNO=7839;

--TO_DATE(문자값,[패턴문자]) : 문자값을 전달받아 날짜값으로 변환, 반환함.
--비교 컬럼의 자료형이 날짜형인 경우 비교값이 문자값이면 자동으로 날짜값으로 변환되어 비교 - 자동 형변환
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = TO_DATE('82/01/23');
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = '82/01/23';  --[RR/MM/DD]형식이므로가능
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = '1982-01-23'; -- 'YYYY-MM-DD'도 공식적으로 사용 가능한 패턴이므로 사용 가능.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = TO_DATE('1982-01-23');

--BUT 패턴에 맞지 않는 문자값을 사용할 경우 에러가 발생함 EX) 외국기준으로 월-일-년 순으로 작성시,
--이럴때, TO_DATE 사용하는것..! 어떠한 패턴으로 사용한 것인지 알려 주는 것.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = TO_DATE('01-23-1982','MM-DD-YYYY');

--2000-01-01에 태어난 사람이 오늘까지 살아온 날짜 검색
--SELECT SYSDATE-'2000-01-01' FROM DUAL; // 문자의 연산으로 인해 오류 발생 -> '2000-01-01'을 날짜값으로 변환해야 함.
SELECT CEIL(SYSDATE-TO_DATE('2000-01-01'))||'일' "오늘까지 살아 온 날짜" FROM DUAL;
SELECT CEIL(SYSDATE-TO_DATE('00/01/01'))||'일' "오늘까지 살아 온 날짜" FROM DUAL;

--TO_CHAR({숫자값|날짜값},패턴문자) : 숫자값 OR 날짜값을 전달받아 원하는 패턴의 문자값으로 변환.
-- 날짜패턴 문자 : RR(년), YYYY(년), MM(월),DD(일),HH24(시),MI(분),SS(초)
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD'), TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--EMP테이블에서 1981년에 입사한 사원의 사원번호, 사원이름, 입사일 검색
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE HIREDATE BETWEEN '81/01/01' AND '81/12/31';

--현재 접속된 사용자 환경의 날짜와 시간의 기본패턴이 [RR/MM/DD/]인 경우에만 검색 가능
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '81%';

--TO_CHAR 함수를 사용하여 날짜값을 원하는 패턴의 문자값으로 변환하여 반환받아 비교처리함.
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'YYYY') = '1981';

--숫자패턴문자 : 9(숫자 OR 공백),0(숫자), L(화폐단위), $(달러)
SELECT 1000000000, TO_CHAR(1000000000,'9,999,999,990')FROM DUAL;
SELECT 1000000000, TO_CHAR(1000000000,'0,000,000,000')FROM DUAL;
-- 9:표현할 숫자값이 없을 시, 그냥 공백으로 출력됨
-- 0: 표현할 숫자값이 없을시, 0을 출력
SELECT 10, TO_CHAR(10,'9,999,999,990')FROM DUAL;
SELECT 10, TO_CHAR(10,'0,000,000,000')FROM DUAL;

--전달받은 숫자값의 길이가 패턴문자의 길이보다 큰경우 모든 패턴문자가 [#]으로 변환되어 반홤됨.
SELECT 1000000000000, TO_CHAR(1000000000000,'9,999,999,990')FROM DUAL; 
SELECT 1000000000000, TO_CHAR(1000000000000,'0,000,000,000')FROM DUAL;


--EMP 테이블에서 사원번호가 7844인 사원의 사원번호, 사원이름, 급여 검색.
--원은 L로 표시.. : LOCAL 인가..?
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO = 7844;
SELECT EMPNO, ENAME, TO_CHAR(SAL,'999,990') SAL FROM EMP WHERE EMPNO = 7844;
SELECT EMPNO, ENAME, TO_CHAR(SAL,'L999,990') SAL FROM EMP WHERE EMPNO = 7844;
SELECT EMPNO, ENAME, TO_CHAR(SAL,'$999,990') SAL FROM EMP WHERE EMPNO = 7844;

-- 일반함수 : 매개변수로 전달받은 값이 특정 조건에 참인 경우 변경값으로 변환하여 반환하는 함수

--NVL(전달값, 변경값) : 전달값이 NULL인 경우 변경값으로 변환하여 반환하는 함수
-- 변경값과 전달값은 동일한 자료형의 값으로만 변경 가능함.

--EMP 테이블에 저장된 모든 사원의 사원번호, 사원이름, 연봉(급여 *12) 
SELECT EMPNO, ENAME, SAL*12 ALNNUAL FROM EMP;

--EMP 테이블에 저장된 모든 사원의 사원번호, 사원이름, 연봉((급여+성과급)*12) 검색
--성과급이 NULL일시, 연산시 NULL 반환 => NVL 사용하여 NULL 일시, 0으로 변경해야 함.
SELECT EMPNO, ENAME, (SAL+NVL(COMM,0))*12 ANNUAL FROM EMP;

--NVL2(전달값, 변경값1, 변경값2) : 전달값이 NULL이 아닌 경우 변경값1로 변환 NULL인 경우 변경값 2로 변환.
SELECT EMPNO, ENAME, (SAL+NVL2(COMM,COMM,0))*12 ANNUAL FROM EMP;
SELECT EMPNO, ENAME, (SAL+NVL2(COMM,(SAL+COMM),SAL))*12 ANNUAL FROM EMP;

--DECODE(전달값, 비교값1, 2, 3,...[, 기본값]) : 전달값을 비교값과 차례로 비교하여 같은경우 변경값으로 변환하여 반환하는 함수
--비교값이 모두 다른경우 기본값으로 변환하여 반환 - 기본값이 생략된 경우 NULL을 반환함.

--EMP 테이블에 저장된 모든 사원의 EMPNO, ENAME, JOB, SAL, 실급여 검색
SELECT DISTINCT JOB FROM EMP ;
-- ANLALIST : *1.1 / CLERK : * 1.2 / MANAGER : *1.3 / PRESIDENT :* 1.4 / SALESMAN : *1.2
SELECT EMPNO, ENAME,JOB, SAL,DECODE(JOB,'ANALYST',SAL*1.1,'CLERK',SAL*1.2,'MANAGER',SAL*1.3,'PRESIDENT',SAL*1.4,'SALESMAN',SAL*1.5)"실급여" 
FROM EMP ORDER BY "실급여" DESC;

--EMP 테입블에 저장된 모든 사원의 사원번호, 사원이름, 업무, 급여 검색
SELECT EMPNO,ENAME, JOB,SAL FROM EMP;

--EMP 테이블에 저장된 모든 사원의 사원버놓, 이름, 업무별 급여 검색 - 해당 업무가 아닌 경우 -> NULL 검색
SELECT EMPNO, ENAME, DECODE(JOB,'ANALYST',SAL)"ANALYST", DECODE(JOB,'CLERK',SAL)"CLERK", DECODE(JOB,'MANAGER',SAL)"MANAGER",
DECODE(JOB,'PRESIDENT',SAL)"PRESIDENT",DECODE(JOB,'SALESMAN',SAL)"SALESMAN"FROM EMP;

--1. 입사일이 12월인 사원의 EMPNO,ENAME,HIREDATE
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM')='12';
--2.
SELECT EMPNO,ENAME,LPAD(SAL,10,'*') "급여" FROM EMP;
--3. 
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE,'YYYY-MM-DD') "입사일" FROM EMP;
 
--그룹함수 : 매개변수로 다수의 값을 전달받아 가공하여 결과값을 변환하는 함수
--COUNT(컬럼명) : 컬럼값으로 전달받은 컬럼값의 갯수를 반환하는 함수. - 검색행의 갯수 반환
SELECT COUNT(EMPNO) FROM EMP;

--그룹함수를 다른 검색 대상과 같이 사용할 경우 ERROR 발생 => 그룹함수와 검색대상의 검색행의 갯수가 서로 다르므로 ERROR 발생하는 것.
SELECT EMPNO, COUNT(EMPNO) FROM EMP; --EMPNO: 14개 행 출력됨 // COUNT행 1줄 출력 => 따라서 오류 발생.

--따라서 그룹함수끼리는 같이 검색가능함(모두 1행만 출력하므로)
--그룹함수는 NULL을 값으로 처리하지 않는 결과 반환. 
SELECT COUNT(EMPNO), COUNT(COMM) FROM EMP; --NULL은 제외하고 COUNT했음.

--COUNT함수의 경우에는 컬럼명 대신, * 기호를 사용하여 모든 행의 갯수 검색 가능
SELECT COUNT(*) FROM EMP;

SELECT SUM(SAL) FROM EMP;

SELECT AVG(SAL) FROM EMP;

SELECT ROUND(AVG(SAL),2) FROM EMP;

--EMP 테이블에 저장된 모든 사원의 평균 서오가급 계산하여 검색
SELECT AVG(COMM) FROM EMP; -- NULL인 값은 제외하고 4인의 평균 성과급 계산이므로 계산오류임
SELECT ROUND(AVG(NVL(COMM,0)),2) FROM EMP;

select count(*) from emp where deptno=10;
select count(*) from emp where deptno=20;
select count(*) from emp where deptno=30;
--위의 수행을 한번에 하는법은 없나? => Group By 
--GROUP BY : 그룹함수 사용시, 컬럼값으로 그룹을 여러개 구분하여 검색하는 기능.
--컬럼값이 같은 경우, 같은 그룹으로 처리하여 그룹함수의 결과값 반환.
--형식) SELECT 그룹함수(컬럼명)[,검색대상,...] FROM 테이블명 [WHERE 조건식] GROUP BY {컬럼명|연산식|함수},... [ORDER BY ...]
SELECT COUNT(*) FROM EMP GROUP BY DEPTNO;
--GROUP BY에 사용한 표현식은 함수와 함께 검색 가능
SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO;
--GROUP BY의 표현식으로는 별칭 사용 불가.
SELECT DEPTNO DNO, COUNT(*) FROM EMP GROUP BY DNO; --ERROR

--EMP 테이블에 저장된 모든 사원의 업무별 평균 급여를 계산하여 검색
SELECT JOB, CEIL(AVG(SAL)) "AVG_SAL" FROM EMP GROUP BY JOB;

--EMP 테이블에서 업무가 PRESIDENT인 사원을 제외한 모든 사원의 업무별 평균 급여를 평균급여로 내림차순 정렬하여 검색.
SELECT JOB, CEIL(AVG(SAL)) "AVG_SAL" FROM EMP WHERE JOB<>'PRESIDENT' GROUP BY JOB ORDER BY AVG_SAL DESC;

--HAVING 절 : GROUP BY에 의해 그룹화된 검색결과에서 그룹조건이 참(TRUE)인 행을 검색함.

SELECT JOB, CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY JOB HAVING JOB<>'PRESIDENT' ORDER BY AVG_SAL DESC;

--EMP 테이블에 저장된 모든 사원의 부서별 급여 합계 중 급여 합계가 9000이상인 부서번호와 급여 합계 검색
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL)>=9000;

--1. 사원테이블에서 부서별 인원수가 6명 이상인 부서코드 검색
SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*)>=6;
--2. 부서번호, 업무별 급여 합계를 계산
SELECT DEPTNO, SUM(DECODE(JOB,'CLERK',SAL))"CLERK", SUM(DECODE(JOB,'MANAGER',SAL))"MANAGER", SUM(DECODE(JOB,'PRESIDENT',SAL))"PRESIDENT"
,SUM(DECODE(JOB,'ANALYST',SAL))"ANALYST", SUM(DECODE(JOB,'SALESMAN',SAL))"SALESMAN" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

--3. 사원테이블로부터 연도별, 월별 급여합계 출력
SELECT TO_CHAR(HIREDATE,'YYYY')"년", TO_CHAR(HIREDATE,'MM')"월", SUM(SAL) FROM EMP GROUP BY TO_CHAR(HIREDATE,'YYYY'), TO_CHAR(HIREDATE,'MM')ORDER BY 1, 2;


--4. 부서별 COMM을 포함한 연봉의 합과 포함하지 않은 연봉의 합
SELECT DEPTNO, SAL, COMM FROM EMP ORDER BY DEPTNO;

SELECT DEPTNO, SUM(SAL*12)"연봉" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO; 
SELECT DEPTNO, SUM((SAL+NVL(COMM,0))*12)"연봉" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

--5. SALESMAN을 제외한 JOB별 급여 합계 
SELECT JOB, SUM(SAL) FROM EMP GROUP BY JOB HAVING JOB<>'SALESMAN';

--join : 두개 이상의 테이블에서 행을 결합하여 원하는 컬럼값을 검색하기 위한 기능.

--EMP 테이블에 저장된 모든 사원의 사원번호, 사원이름, 급여, 부서번호 검색
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP;

---DEPT테이블에 저장된 모든 부서의 부서번호, 부서이름, 부서위치 검색
SELECT DEPTNO,DNAME,LOC FROM DEPT;

--DEPT 테이블에 저장된 모든 부서의 부서번호,부서이름,부서위치 검색
--두개이상의 테이블에서 컬럼값을 검색하기 위해서는 반드시 검색행을 결합하기 위한 조건을 제공하여 검색
--카다시안 프로덕트(CATSIAN PRODUCT) : 두개이상의 테이블을 결합조건 없이 검색한 경우 발생되는 검색 결과
--결합조건이 검색한 경우 두개이상의 테이블에 저장된 모든 행을 교차 결합하여 검색 결과 제공
--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서이름,부서위치 검색
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT; -- 카다시안곱

--EQUI JOIN : 두개 이상의 테이블에서 결합조건에 [=]연산자를 사용하여 참인 행만 결합하여 검색.
--결합조건 : EMP 테이블의 부서번호(DEPTNO)와 DEPT 테이블의 부서번호(DEPTNO)가 같은 행만 결함 -> 반환
--결합조건은 WHERE조건식을 사용하여 결합 
--두개이상의 테이블에 같은 이름이 존재하는 경우 반드시 [테이블명.컬럼명] 형식으로 구분하여 표현함.
SELECT EMPNO, ENAME, SAL, DEPTNO, DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
SELECT EMPNO, ENAME, SAL, EMP.DEPTNO, DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
SELECT EMPNO, ENAME, SAL, DEPT.DEPTNO, DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 두 테이블을 결합할 때 같은 이름의 컬럼을 모두 호출할 시, DEPTNO / DEPTNO_1 처럼 하나는 명칭이 자동으로 변형됨
SELECT EMPNO, ENAME, SAL, EMP.DEPTNO, DEPT.DEPTNO, DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
--BUT 이렇게 됐을시, 이름이 바뀐컬럼의 경우 나중에 값을 뽑아낼 수가 없음 => ALLIAS 사용해 검색할것을 권장함.
SELECT EMPNO, ENAME, SAL, EMP.DEPTNO "EMP_DEPTNO", DEPT.DEPTNO "DEPT_DEPTNO", DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

--TABLE ALLIAS : 테이블에 일시적으로 새로운 이름을 부여하여 사용하는 기능. -> 테이블 별칭
--형식)SELECT 검색대상, ... FROM 테이블 별칭, 테이블 별칭,...
--테이블 결합시, 테이블의 이름을 간단하게 표현하기 위해 사용하거나 하나의 테이블을 다수의 테이블로 표현하기위함
SELECT EMPNO,ENAME,SAL,E.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;
SELECT EMPNO,ENAME,SAL,D.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;

--테이블 별칭을 한번 설정했다면, 별칭을 계속 사용해야함. => EX) EMP E => E.DEPTNO (O)  // EMP.DEPTNO(X)
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;--에러 발생SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;--에러 발생