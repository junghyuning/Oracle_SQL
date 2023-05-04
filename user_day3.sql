--NON EQUI JOIN : �ΰ� �̻��� ���̺��� �������ǿ� = �����ڰ� �ƴ� �ٸ� �����ڸ� ����Ͽ� TRUE�� ���� ����

--EMP ���̺� ����� ��� ����� �����ȣ, ����̸�, �޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP;

--SALGRADE ���̺� ����� ���� �޿������ ��޹�ȣ, �ּұ޿�, �ִ�޿� �˻�
SELECT GRADE,LOSAL,HISAL FROM SALGRADE;

--EMP���̺�� SALGRADE ���̺��� ��� ����� �����ȣ, ����̸�, �޿�, ��޹�ȣ ���� �˻�.
--�������� : EMP ���̺��� �޿�(SAL)�� SALGRADE ���̺��� �ּұ޿�(LOSAL)~ �ִ�޿�(HISAL) ������ ���ԵǴ� ���� �����Ͽ� �˻�.
SELECT EMPNO, ENAME, SAL, GRADE FROM EMP,SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL;

--�ܺΰ���(OUTER JOIN) : ���������� ���� �ุ �����Ͽ� �˻��ϴ� ���� �ƴ϶� ���������� ���� �ʴ� �൵ NULL�� �����Ͽ� �˻���.
--�������ǽ��� (+)��� => ���������� ���� �ʴ� ���� NULL�� �����Ͽ� �˻�

--EMP���̺� ����� ��� ������ �μ���ȣ�� �ߺ����� �ʴ� ������ �÷��� ���
SELECT DISTINCT DEPTNO FROM EMP;
--DEPT ���̺� ����� ��� �μ��� �μ���ȣ, �μ��̸�, �μ���ġ �˻�
SELECT DEPTNO, DNAME, LOC FROM DEPT; 

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ, ����̸�, �޿�, �μ��̸�, �μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT���̺��� �μ���ȣ(DEPTNO)�� ���� �ุ ����
SELECT EMPNO, ENAME, SAL, DNAME, LOC FROM EMP, DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;
--����� ���� �μ��� �˻� :  EMP ���̺� (+)�� �ٿ� �˻�
SELECT EMPNO, ENAME, SAL, DEPT.DEPTNO, DNAME, LOC FROM EMP, DEPT WHERE EMP.DEPTNO(+)=DEPT.DEPTNO;

--�ڱ����(SELF JOIN) : �ϳ��� ���̺��� ���� �ٸ� ��Ī�� �ο��Ͽ� 2���̻��� ���̺�� ���� -> ���� ����.
--�˻�������δ� "ALIAS"�� �����.(�̹� ������ ���̺�� �����ϰ������Ƿ�)
--> �� ���?? ���̺��� ������ ��ȣ�� �־��� ��, �������� �̸��� �������� ���� BUT, ������ ���� ����� �Ѹ��̹Ƿ� �����ڹ�ȣ = �����ȣ -> ������� �����Ͽ� ������ �̸��� ������ �� ����.
SELECT EMPNO,ENAME,MGR FROM EMP; 
SELECT WORKER.EMPNO, WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME FROM EMP "WORKER",EMP "MANAGER" WHERE WORKER.MGR = MANAGER.EMPNO;

--���� ������ �����ڿ� NULL ���� ���� KING�� ������� ���� => �ܺΰ��� ���� ��� ��� ����
--���������̺��� NULL�̰� ������̺��� NOTNULL������ ����ؾ� �ϹǷ� ���������̺�(+)�� ������������ ����.
SELECT WORKER.EMPNO, WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME FROM EMP "WORKER",EMP "MANAGER" WHERE WORKER.MGR = MANAGER.EMPNO(+);

--EMP ���̺�� DEPT ���̺��� SALES �μ��� �ٹ��ϴ� ����� EMPNO, ENAME, SAL, �μ���,�μ���ġ �˻�.
SELECT * FROM DEPT;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND DNAME='SALES';
-->BUT �̷��� ����� WHERE������ �������� �� ���� ������ ��� �δ��ؾ� �ϹǷ� ���� �� ���� �������� ����.
-->1999 ä�õ� ǥ�� SQL(SQL3) -> ���̺� �������ǰ� �� ������ �����Ͽ� ���� �� �ֵ��� �پ��� ���̺� ���� ���� ������ ����
-->1. CROSS JOIN : ���� ���̺��� ��� ���� ���� ���� => ���������� �����ϴ� ���� BUT īŸ�þ� ���̹Ƿ� ȿ�� X
--����) SELECT �˻����1 , 2, 3, ... FROM ���̺�� 1 CROSS JOIN ���̺�� 2
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP CROSS JOIN DEPT;
--2. NATURAL JOIN : �������̺� "���� �̸��� �÷��� 1��"�� �ִ� ��� -> �÷����� ���� ���� ����
--> NATRUAL JOIN���ÿ��� �����ϴ� �÷����� ���̺� ���о��� �״�� ��� ������.
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP NATURAL JOIN DEPT;

--JOIN USING : ���� �̸��� �÷��� ������ �ִ� ��� => JOIN�� �÷��� ������.
--A JOIN B USING(COLUMN)
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT USING(DEPTNO);

--INNER JOIN ~ "ON": ���������� ���� ���� �����Ͽ� �˻���
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;
-- INNER Ű����� ���� ���� 
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;
--> IF DEPTNO ����ϰ� ���� ��, ��� ���̺��� DEPTNO ���� ��� �ؾ� ��.
SELECT EMPNO,ENAME,SAL,DNAME,LOC,DEPT.DEPTNO "DEPT_DEPTNO" FROM EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;

--EMP ���̺�� SALGRADE ���̺� ����� ��� ����� �����ȣ ����̸� �޿� ��޹�ȣ �˻�
--�������� : EMP���̺��� �޿�(SAL)�� SALGRADE ���̺��� �ּұ޿�~ �ִ�޿� ������ ���ԵǴ� ���� �����Ͽ� �˻�
SELECT * FROM SALGRADE;
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL;

--3���� ���̺� ����
--���� 1. EMP.DEPTNO = DEPT.DEPTNO ����
--���� 2. EMP ���̺��� SAL �� SALGRADE�� LOSAL ~ HISAL�� �� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC,GRADE FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES'; --��ó��, SQL3�� ����� ��� ���� ���ǰ� ���� ������ �и��Ͽ� ��� ������

--1:N ������ ���̺��� �����Ҷ��� ���� OUTER JOIN�� ����ؾ� ��.
--OUTER JOIN : ���������� ���� �ุ �����Ͽ� �˻��ϴ� ���� �ƴ϶� ���������� ���� �ʴ� �൵ NULL�� �����Ͽ� �˻���.
-- SELECT �˻����1, 2, 3,... FROM ���̺�� {LEFT|RIGHT|FULL} OUTER JOIN ���̺��2 ON ��������
--LEFT (OUTER) JOIN : ���� ���̺��� ��� ���� �˻� -> ���� ���̺� ���ǿ� �´� ���� ��� ������ 1���� �����.
--RIGHT (OUTER) JOIN : ������ ���̺��� ��� �� �˻� -> ���� ���̺� ���ǿ� �´� ���� ��� ������ 1���� �����.
--FULL (OUTER) JOIN : LEFT OUTER JOIN UNION RIGHT OUTER JOIN�� ����. �����հ� ����.

--�������� : EMP.DEPTNO = DEPT.DEPTNO �� �� + DEPT���̺��� ��� �μ���ȣ
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP RIGHT OUTER JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;


--1. �μ� ���̺�� ������̺��� ���, �����, �μ��ڵ�, �μ����� �˻��Ͻÿ�.( ����� �������� ������ �� )
SELECT EMPNO,ENAME,DEPT.DEPTNO,DNAME FROM EMP INNER JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME;
--2. �μ� ���̺�� ������̺ҿ��� ���, ����� , �޿� , �μ����� �˻��Ͻÿ�. ��, �޿��� 2000 �̻��� ����� ���Ͽ� �޿��������� �������� ������ ��.
SELECT EMPNO, ENAME, SAL, DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE SAL>=2000 ORDER BY SAL DESC;
--3. �μ� ���̺�� ��� ���̺��� ���, �����, ����, �޿� , �μ����� �˻��Ͻÿ�. ��, ������ Manager�̸� �޿��� 2500 �̻��� ����� ���Ͽ� ����� �������� �������� ������ ��.
SELECT EMPNO,ENAME,JOB,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE JOB='MANAGER' AND SAL>=2500 ORDER BY EMPNO;
--4. ��� ���̺�� �޿� ��� ���̺��� ���, �����, �޿�, ����� �˻��Ͻÿ�. ��, ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���Եǰ� ����� 4�̸� �޿��� �������� �������������� ��.
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL WHERE GRADE=4 ORDER BY SAL DESC;
--5. �μ� ���̺�, ��� ���̺�, �޿���� ���̺��� ���, �����, �μ���, �޿� , ����� �˻��Ͻÿ�. ��, ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���ԵǸ� ����� �������� �������� ������ ��.
SELECT EMPNO,ENAME,DNAME,SAL,GRADE FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;
--6. ��� ���̺��� ������ �ش� ����� �����ڸ��� �˻��Ͻÿ�.  //SELF JOIN
SELECT W.ENAME "�����", M.ENAME "�����ڸ�" FROM EMP "W" JOIN EMP "M" ON W.MGR = M.EMPNO;
--7. ��� ���̺��� �����, �ش� ����� �����ڸ�, �ش� ����� �������� �����ڸ��� �˻��Ͻÿ�
SELECT W.ENAME "���",M.ENAME "������",B.ENAME "�������� ������" FROM EMP "W" JOIN EMP "M" ON W.MGR=M.EMPNO JOIN EMP "B" ON M.MGR = B.EMPNO;
--8. 7�� ������� ���� �����ڰ� ���� ��� ����� �̸��� ����� ��µǵ��� �����Ͻÿ�.
SELECT W.ENAME "���",M.ENAME "������",B.ENAME "�������� ������" FROM EMP "W" LEFT JOIN EMP "M" ON W.MGR=M.EMPNO LEFT JOIN EMP "B" ON M.MGR = B.EMPNO;


--SUBQUERY : ���� ���� ���� -> ���ڽ� ���� ����
--WHERE/HAVING������ ���: ��Į�� ��������
--FROM������ ��� : INLINE VIEW

--EMP���̺��� ����̸��� SCOTT�� ������� ���� �޿��� �޴� ����� �����ȣ, ����̸�, �޿�
SELECT SAL FROM EMP WHERE ENAME = 'SCOTT';
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>3000;


--SELECT ��ɿ� �������� ����, SELECT���� �ѹ��� �ᵵ ���ϴ� ���� �˻� ��������
--> WHERE���� ���ǹ� ��� ���������� �޾ƾ� ��. -> ��, ���������� �ϳ��� ��(������, �����÷�)���� �˻��ǵ��� �ۼ��ؾ���.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='SCOTT');

-- EMP TABLE���� �����ȣ�� 7844�� ����� ���� ������ �ϴ� ����� �����ȣ, ����̸�, ����, �޿� �˻�  (7844�� �������ִ°��� ����)
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7844) AND EMPNO<>7844;

--EMP ���̺��� �����ȣ�� 7521�� ����� ���� ������ �ϴ� ��� �� �����ȣ�� 7844�� ������� ���� �޿��� �޴� ����� ���� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO = 7521) AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7844);

--EMP ���̺��� SALES �μ����� �ٹ��ϴ� ����� ���� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';
-->�̷� ��������ص� ����� ���� BUT ���� ã����� ������ ��� EMP TABLE�� �ְ� JOIN�̶�� ������ ����� ���̵�� ������ 
--> ���������� �̿��� ��� JOIN���� �ʰ� ������ ã�� �� ����
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');

--EMP ���̺� ����� ��� ��� �� ���� ���� �޿��� �޴� ����� ����
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL =(SELECT MIN(SAL) FROM EMP);

--EMP ���̺��� SALES �μ��� �ٹ��ϴ� ��� �� ���� ���� �޿��� �޴� ��� ���� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP WHERE DEPTNO =(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES'));

--��ձ޿��� ���� ���� �μ��� �μ���ȣ �� ��ձ޿�  // HAVING�� GROUP BY �� �����̹Ƿ� ~~�� �׷��� ã�� ���� HAVING �������� �ʿ���.
SELECT DEPTNO, CEIL(AVG(SAL)) FROM EMP GROUP BY DEPTNO HAVING AVG(SAL) = (SELECT MAX(AVG(SAL)) FROM EMP GROUP BY DEPTNO);

--�μ��� ���� ���� �޿��� �޴� ��� --> �׷캰 ���� ���� �޿��� ���� ���ϰ�, �� �޿��� ������ 
SELECT DEPTNO, EMPNO, ENAME, SAL  FROM EMP WHERE SAL = (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);
-->BUT ���������� ����� MULTI-ROW �̹Ƿ� ���� �߻�
--> ���������� ����� �������� ���, [=]���, [IN]Ű���� ���
SELECT DEPTNO, ENAME, SAL FROM EMP ORDER BY DEPTNO;
SELECT DEPTNO, EMPNO, ENAME, SAL  FROM EMP WHERE SAL IN (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);
--> �̶� ���� DEPTNO=20 �ε� SAL�� 950�� ����� �ִٸ� �˻����� ���� �Ǵ���????????? => ���� �ȵ�. �Ϻ��ϰ� �ϱ� ���ؼ��� �ٸ� ���ǵ� �ٿ���� ��.

--���������� ����� �������� ��� > OR < �����ڷ� �÷����� ���ϱ����� �������� �տ� ANY OR ALL Ű���� ����Ͽ� �˻�
--ANY : � CASE 1 ���ٴ� OO �ϴ�.
--ALL : ��� CASE ���� OO �ϴ�.
--�μ���ȣ�� 10�� �μ����� �ٺ��ϴ� ��� ������� �޿��� ���� ����� ����
--ANY ����ϴ� �� / ������ �������� ��� ��
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT SAL FROM EMP WHERE DEPTNO =10) AND DEPTNO<>10;
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT MAX(SAL) FROM EMP WHERE DEPTNO =10) AND DEPTNO<>10;

--�μ���ȣ 10�� ��� ������� �޿��� ���� ����� ����
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ALL(SELECT SAL FROM EMP WHERE DEPTNO =10);
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ALL(SELECT MIN(SAL) FROM EMP WHERE DEPTNO =10);

--�μ���ȣ 20�� ��� ������� �޿��� ���� ����� ����
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT SAL FROM EMP WHERE DEPTNO =20) AND DEPTNO<>20;
--�μ���ȣ�� 20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ���
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>ALL(SELECT SAL FROM EMP WHERE DEPTNO =20);

--EMP ���̺��� ����̸��� ALLEN�� ����� �����ڰ� ������, ���� ������ �ϴ� ����� ����
SELECT EMPNO, ENAME, MGR, JOB, SAL FROM EMP WHERE MGR = (SELECT MGR FROM EMP WHERE ENAME='ALLEN')AND JOB=(SELECT JOB FROM EMP WHERE ENAME='ALLEN')AND ENAME<>'ALLEN';
--> BUT SUB������ ��������ϴ� ���� ��� ALLEN���� ���� -> �ѹ��� �˻��Ϸ���? 
SELECT EMPNO, ENAME, MGR, JOB, SAL FROM EMP WHERE (MGR,JOB) = (SELECT MGR,JOB FROM EMP WHERE ENAME='ALLEN')AND ENAME<>'ALLEN';

--1. ��� ���̺��� BLAKE ���� �޿��� ���� ������� ���, �̸� , �޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='BLAKE');
--2. ��� ���̺��� MILLER ���� �ʰ� �Ի��� ����� ���, �̸�, �Ի����� �˻��Ͻÿ�.
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME='MILLER');
--3. ��� ���̺��� ��� ��ü ��� �޿����� �޿��� ���� ������� ���, �̸�, �޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL> (SELECT AVG(SAL) FROM EMP);
--4. ��� ���̺��� CLARK�� ���� �μ��̸�, ����� 7698�� ������ �޿����� ���� �޿��� �޴� ������� ���, �̸�, �޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE EMPNO=7698) AND DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='CLARK');
--5. ��� ���̺��� �μ��� �ִ� �޿��� �޴� ������� ���, �̸�, �μ��ڵ�, �޿��� �˻��Ͻÿ�. 
--(E1=��������� ������ ���̺� / E2 = �μ��� �޿��� ���� ���̺�) -> ���������� E1.DEPTNO=E2.DEPTNO ��� ������ ���������Ƿ� ����� ������ �μ��� �ִ�޿��͸� �񱳰���
--�ش� ���������� �������������� ����Ǵ°��� �ƴ϶� ������ ���ÿ� ���ư��⶧���� ��ó�� IN���� ������ ������������ ������ �� ������.)
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP E1 WHERE SAL IN (SELECT MAX(SAL) FROM EMP E2 WHERE E1.DEPTNO=E2.DEPTNO GROUP BY DEPTNO);