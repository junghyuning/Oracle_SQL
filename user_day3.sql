--NON EQUI JOIN : 두개 이상의 테이블의 결합조건에 = 연산자가 아닌 다른 연산자를 사용하여 TRUE인 행을 결합

--EMP 테이블에 저장된 모든 사원의 사원번호, 사원이름, 급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP;

--SALGRADE 테이블에 저장된 무든 급여등급의 등급번호, 최소급여, 최대급여 검색
SELECT GRADE,LOSAL,HISAL FROM SALGRADE;

--EMP테이블과 SALGRADE 테이블에서 모든 사원의 사원번호, 사원이름, 급여, 등급번호 등을 검색.
--결합조건 : EMP 테이블의 급여(SAL)가 SALGRADE 테이블의 최소급여(LOSAL)~ 최대급여(HISAL) 범위에 포함되는 행을 결합하여 검색.
SELECT EMPNO, ENAME, SAL, GRADE FROM EMP,SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL;

--외부결합(OUTER JOIN) : 결합조건이 참인 행만 결합하여 검색하는 것이 아니라 결합조건이 맞지 않는 행도 NULL과 결합하여 검색함.
--결합조건식의 (+)사용 => 결합조건이 맞지 않는 행을 NULL과 결합하여 검색

--EMP테이블에 저장된 모든 사우너의 부서번호를 중복되지 않는 유일한 컬럼값 계산
SELECT DISTINCT DEPTNO FROM EMP;
--DEPT 테이블에 저장된 모든 부서의 부서번호, 부서이름, 부서위치 검색
SELECT DEPTNO, DNAME, LOC FROM DEPT; 

--EMP 테이블과 DEPT 테이블에 저장된 모든 사원의 사원번호, 사원이름, 급여, 부서이름, 부서위치 검색
--결합조건 : EMP 테이블의 부서번호(DEPTNO)와 DEPT테이블의 부서번호(DEPTNO)가 같은 행만 결합
SELECT EMPNO, ENAME, SAL, DNAME, LOC FROM EMP, DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;
--사원이 없는 부서도 검색 :  EMP 테이블에 (+)를 붙여 검색
SELECT EMPNO, ENAME, SAL, DEPT.DEPTNO, DNAME, LOC FROM EMP, DEPT WHERE EMP.DEPTNO(+)=DEPT.DEPTNO;

--자기결합(SELF JOIN) : 하나의 테이블을 서로 다른 별칭을 부여하여 2개이상의 테이블로 구분 -> 행을 결합.
--검색대상으로는 "ALIAS"를 사용함.(이미 별개의 테이블로 생각하고있으므로)
--> 왜 사용?? 테이블에는 관리자 번호가 주어질 뿐, 관리자의 이름은 제공하지 않음 BUT, 관리자 역시 사원중 한명이므로 관리자번호 = 사원번호 -> 사원명을 도출하여 관리자 이름을 도출할 수 있음.
SELECT EMPNO,ENAME,MGR FROM EMP; 
SELECT WORKER.EMPNO, WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME FROM EMP "WORKER",EMP "MANAGER" WHERE WORKER.MGR = MANAGER.EMPNO;

--위의 예제는 관리자에 NULL 값을 가진 KING을 출력하지 않음 => 외부결합 사용시 모두 출력 가능
--관리자테이블은 NULL이고 사원테이블은 NOTNULL인행을 출력해야 하므로 관리자테이블(+)를 결합조건으로 제공.
SELECT WORKER.EMPNO, WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME FROM EMP "WORKER",EMP "MANAGER" WHERE WORKER.MGR = MANAGER.EMPNO(+);

--EMP 테이블과 DEPT 테이블에서 SALES 부서에 근무하는 사원의 EMPNO, ENAME, SAL, 부서명,부서위치 검색.
SELECT * FROM DEPT;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND DNAME='SALES';
-->BUT 이러한 방식은 WHERE절에서 결합조건 및 행의 조건을 모두 부담해야 하므로 점점 더 쓰기 복잡해질 것임.
-->1999 채택된 표준 SQL(SQL3) -> 테이블 결합조건과 행 조건을 구분하여 사용될 수 있도록 다양한 테이블 결합 관련 문법을 제공
-->1. CROSS JOIN : 결합 테이블의 모든 행을 교차 결합 => 결합조건을 생략하는 것임 BUT 카타시안 곱이므로 효율 X
--형식) SELECT 검색대상1 , 2, 3, ... FROM 테이블명 1 CROSS JOIN 테이블명 2
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP CROSS JOIN DEPT;
--2. NATURAL JOIN : 결합테이블에 "같은 이름의 컬럼이 1개"만 있는 경우 -> 컬럼값이 같은 행을 결합
--> NATRUAL JOIN사용시에는 결합하는 컬럼병을 테이블 구분없이 그대로 사용 가능함.
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP NATURAL JOIN DEPT;

--JOIN USING : 같은 이름의 컬럼이 여러개 있는 경우 => JOIN할 컬럼을 지정함.
--A JOIN B USING(COLUMN)
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT USING(DEPTNO);

--INNER JOIN ~ "ON": 결합조건이 참인 행을 결합하여 검색함
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;
-- INNER 키워드는 생략 가능 
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;
--> IF DEPTNO 출력하고 싶을 시, 어느 테이블의 DEPTNO 인지 명시 해야 함.
SELECT EMPNO,ENAME,SAL,DNAME,LOC,DEPT.DEPTNO "DEPT_DEPTNO" FROM EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

--EMP 테이블과 SALGRADE 테이블에 저장된 모든 사원의 사원번호 사원이름 급여 등급번호 검색
--결합조건 : EMP테이블의 급여(SAL)가 SALGRADE 테이블의 최소급여~ 최대급여 범위에 포함되는 행을 결합하여 검색
SELECT * FROM SALGRADE;
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL;

--3개의 테이블 결합
--조건 1. EMP.DEPTNO = DEPT.DEPTNO 결합
--조건 2. EMP 테이블의 SAL 이 SALGRADE의 LOSAL ~ HISAL인 행 결합
SELECT EMPNO,ENAME,SAL,DNAME,LOC,GRADE FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES'; --이처럼, SQL3을 사용할 경우 행의 조건과 결합 조건을 분리하여 사용 가능함

--1:N 관계의 테이블을 결합할때는 거의 OUTER JOIN을 사용해야 함.
--OUTER JOIN : 결합조건이 참인 행만 결합하여 검색하는 것이 아니라 결합조건이 맞지 않는 행도 NULL과 결합하여 검색함.
-- SELECT 검색대상1, 2, 3,... FROM 테이블명 {LEFT|RIGHT|FULL} OUTER JOIN 테이블명2 ON 결합조건
--LEFT (OUTER) JOIN : 왼쪽 테이블의 모든 행을 검색 -> 결합 테이블에 조건에 맞는 행이 없어도 무조건 1번은 출력함.
--RIGHT (OUTER) JOIN : 오른쪽 테이블의 모든 행 검색 -> 결합 테이블에 조건에 맞는 행이 없어도 무조건 1번은 출력함.
--FULL (OUTER) JOIN : LEFT OUTER JOIN UNION RIGHT OUTER JOIN과 같음. 합집합과 같음.

--결합조건 : EMP.DEPTNO = DEPT.DEPTNO 인 행 + DEPT테이블의 모든 부서번호
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP RIGHT OUTER JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;


--1. 부서 테이블과 사원테이블에서 사번, 사원명, 부서코드, 부서명을 검색하시오.( 사원명 오름차순 정렬할 것 )
SELECT EMPNO,ENAME,DEPT.DEPTNO,DNAME FROM EMP INNER JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME;
--2. 부서 테이블과 사원테이불에서 사번, 사원명 , 급여 , 부서명을 검색하시오. 단, 급여가 2000 이상인 사원에 대하여 급여기준으로 내림차순 정렬할 것.
SELECT EMPNO, ENAME, SAL, DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE SAL>=2000 ORDER BY SAL DESC;
--3. 부서 테이블과 사원 테이블에서 사번, 사원명, 업무, 급여 , 부서명을 검색하시오. 단, 업무가 Manager이며 급여가 2500 이상인 사원에 대하여 사번을 기준으로 오름차순 정렬할 것.
SELECT EMPNO,ENAME,JOB,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE JOB='MANAGER' AND SAL>=2500 ORDER BY EMPNO;
--4. 사원 테이블과 급여 등급 테이블에서 사번, 사원명, 급여, 등급을 검색하시오. 단, 등급은 급여가 하한값과 상한값 범위에 포함되고 등급이 4이며 급여를 기준으로 내림차순정렬할 것.
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL WHERE GRADE=4 ORDER BY SAL DESC;
--5. 부서 테이블, 사원 테이블, 급여등급 테이블에서 사번, 사원명, 부서명, 급여 , 등급을 검색하시오. 단, 등급은 급여가 하한값과 상한값 범위에 포함되며 등급을 기준으로 내림차순 정렬할 것.
SELECT EMPNO,ENAME,DNAME,SAL,GRADE FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;
--6. 사원 테이블에서 사원명과 해당 사원의 관리자명을 검색하시오.  //SELF JOIN
SELECT W.ENAME "사원명", M.ENAME "관리자명" FROM EMP "W" JOIN EMP "M" ON W.MGR = M.EMPNO;
--7. 사원 테이블에서 사원명, 해당 사원의 관리자명, 해당 사원의 관리자의 관리자명을 검색하시오
SELECT W.ENAME "사원",M.ENAME "관리자",B.ENAME "관리자의 관리자" FROM EMP "W" JOIN EMP "M" ON W.MGR=M.EMPNO JOIN EMP "B" ON M.MGR = B.EMPNO;
--8. 7번 결과에서 상위 관리자가 없는 모든 사원의 이름도 사원명에 출력되도록 수정하시오.
SELECT W.ENAME "사원",M.ENAME "관리자",B.ENAME "관리자의 관리자" FROM EMP "W" LEFT JOIN EMP "M" ON W.MGR=M.EMPNO LEFT JOIN EMP "B" ON M.MGR = B.EMPNO;


--SUBQUERY : 쿼리 안의 쿼리 -> 액자식 구성 느낌
--WHERE/HAVING절에서 사용: 스칼라 서브쿼리
--FROM절에서 사용 : INLINE VIEW

--EMP테이블에서 사원이름이 SCOTT인 사원보다 많은 급여를 받는 사원의 사원번호, 사원이름, 급여
SELECT SAL FROM EMP WHERE ENAME = 'SCOTT';
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>3000;


--SELECT 명령에 서브쿼리 사용시, SELECT문을 한번만 써도 원하는 조건 검색 가능해짐
--> WHERE문이 조건문 대신 서브쿼리를 받아야 함. -> 단, 서브쿼리는 하나의 값(단일행, 단일컬럼)만이 검색되도록 작성해야함.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='SCOTT');

-- EMP TABLE에서 사원번호가 7844인 사원과 같은 업무를 하는 사원의 사원번호, 사원이름, 업무, 급여 검색  (7844는 제외해주는것이 정석)
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7844) AND EMPNO<>7844;

--EMP 테이블에서 사원번호가 7521인 사원과 같은 업무를 하는 사원 중 사원번호가 7844인 사원보다 많은 급여를 받는 사원의 정보 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO = 7521) AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7844);

--EMP 테이블에서 SALES 부서에서 근무하는 사원의 정보 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';
-->이런 방식으로해도 결과는 나옴 BUT 내가 찾고싶은 정보든 모두 EMP TABLE에 있고 JOIN이라는 행위는 노력이 많이드는 행위임 
--> 서브쿼리를 이용할 경우 JOIN하지 않고도 정보를 찾을 수 있음
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');

--EMP 테이블에 저장된 모든 사원 중 가장 적은 급여를 받는 사원의 정보
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL =(SELECT MIN(SAL) FROM EMP);

--EMP 테이블에서 SALES 부서에 근무하는 사원 중 가장 적은 급여를 받는 사원 정보 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP WHERE DEPTNO =(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES'));

--평균급여가 가장 높은 부서의 부서번호 및 평균급여  // HAVING은 GROUP BY 의 조건이므로 ~~한 그룹을 찾을 때는 HAVING 조건절이 필요함.
SELECT DEPTNO, CEIL(AVG(SAL)) FROM EMP GROUP BY DEPTNO HAVING AVG(SAL) = (SELECT MAX(AVG(SAL)) FROM EMP GROUP BY DEPTNO);

--부서별 가장 적은 급여를 받는 사원 --> 그룹별 가장 적은 급여를 먼저 구하고, 그 급여를 가지는 
SELECT DEPTNO, EMPNO, ENAME, SAL  FROM EMP WHERE SAL = (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);
-->BUT 서브쿼리의 결과가 MULTI-ROW 이므로 오류 발생
--> 서브쿼리의 결과가 다중행인 경우, [=]대신, [IN]키워드 사용
SELECT DEPTNO, ENAME, SAL FROM EMP ORDER BY DEPTNO;
SELECT DEPTNO, EMPNO, ENAME, SAL  FROM EMP WHERE SAL IN (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);
--> 이때 만약 DEPTNO=20 인데 SAL은 950인 사원이 있다면 검색에서 제외 되는지????????? => 제외 안됨. 완벽하게 하기 위해서는 다른 조건도 붙여줘야 함.

--서브쿼리의 결과가 다중행인 경우 > OR < 연산자로 컬럼값을 비교하기위해 서브쿼리 앞에 ANY OR ALL 키워드 사용하여 검색
--ANY : 어떤 CASE 1 보다는 OO 하다.
--ALL : 모든 CASE 보다 OO 하다.
--부서번호가 10인 부서에서 근부하는 어떠한 사원보다 급여가 적은 사원의 정보
--ANY 사용하는 예 / 단일행 서브쿼리 사용 예
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT SAL FROM EMP WHERE DEPTNO =10) AND DEPTNO<>10;
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT MAX(SAL) FROM EMP WHERE DEPTNO =10) AND DEPTNO<>10;

--부서번호 10의 모든 사원보다 급여가 적은 사원의 정보
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ALL(SELECT SAL FROM EMP WHERE DEPTNO =10);
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ALL(SELECT MIN(SAL) FROM EMP WHERE DEPTNO =10);

--부서번호 20인 어떠한 사원보다 급여가 많은 사원의 정보
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT SAL FROM EMP WHERE DEPTNO =20) AND DEPTNO<>20;
--부서번호가 20인 부서에 근무하는 모든 사원보다 급여가 많은 사원
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>ALL(SELECT SAL FROM EMP WHERE DEPTNO =20);

--EMP 테이블에서 사원이름이 ALLEN인 사원과 관리자가 같으며, 같은 업무를 하는 사원의 정보
SELECT EMPNO, ENAME, MGR, JOB, SAL FROM EMP WHERE MGR = (SELECT MGR FROM EMP WHERE ENAME='ALLEN')AND JOB=(SELECT JOB FROM EMP WHERE ENAME='ALLEN')AND ENAME<>'ALLEN';
--> BUT SUB쿼리가 대상으로하는 행은 모두 ALLEN으로 같음 -> 한번에 검색하려면? 
SELECT EMPNO, ENAME, MGR, JOB, SAL FROM EMP WHERE (MGR,JOB) = (SELECT MGR,JOB FROM EMP WHERE ENAME='ALLEN')AND ENAME<>'ALLEN';

--1. 사원 테이블에서 BLAKE 보다 급여가 많은 사원들의 사번, 이름 , 급여를 검색하시오.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='BLAKE');
--2. 사원 테이블에서 MILLER 보다 늦게 입사한 사원의 사번, 이름, 입사일을 검색하시오.
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME='MILLER');
--3. 사원 테이블에서 사원 전체 평균 급여보다 급여가 많은 사원들의 사번, 이름, 급여를 검색하시오.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL> (SELECT AVG(SAL) FROM EMP);
--4. 사원 테이블에서 CLARK와 같은 부서이며, 사번이 7698인 직원의 급여보다 많은 급여를 받는 사원들의 사번, 이름, 급여를 검색하시오.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE EMPNO=7698) AND DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='CLARK');
--5. 사원 테이블에서 부서별 최대 급여를 받는 사원들의 사번, 이름, 부서코드, 급여를 검색하시오. 
--(E1=사원정보를 추출할 테이블 / E2 = 부서별 급여를 비교할 테이블) -> 조건절에서 E1.DEPTNO=E2.DEPTNO 라고 조건을 한정했으므로 사원이 본인의 부서의 최대급여와만 비교가능
--해당 쿼리에서는 서브쿼리가먼저 수행되는것이 아니라 쿼리가 동시에 돌아가기때문에 위처럼 IN절의 조건이 메인쿼리에도 영향을 줄 수있음.)
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP E1 WHERE SAL IN (SELECT MAX(SAL) FROM EMP E2 WHERE E1.DEPTNO=E2.DEPTNO GROUP BY DEPTNO);