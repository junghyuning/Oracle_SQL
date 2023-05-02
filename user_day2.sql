--�����Լ� : �Ű������� ���ڰ��� ���޹޾� ���� -> ����� ��ȯ
--ROUND(���ڰ�,�Ҽ����ڸ���) : �Է¹��� �ڸ������� �ݿø�
--DUAL ���̺� : ���̺� ���� �˻������ SELECT ������� �ۼ��� ��� ���Ǵ� ������ ���̺�
SELECT ROUND(45.582, 2), ROUND(45.582, 0), ROUND(45.582, -1) FROM DUAL;

--TRUNC(���ڰ�, �Ҽ����ڸ���) : �Է¹��� �ڸ������� ���� ó�� (����)
SELECT TRUNC(45.582, 2), TRUNC(45.582,0), TRUNC(45.582,-1) FROM DUAL;
--CEIL : ���� ����� ������ �ش� ������ ū ��
SELECT CEIL(15.3), CEIL(-15.3) FROM DUAL;
--FLOOR : ���� ����� ���� �� �ش� ������ ���� ����
SELECT FLOOR(15.3), FLOOR(-15.3) FROM DUAL;

--MOD(N,M) : ������
SELECT 20/8, MOD(20/8) FROM DUAL;
--POWER : ����
SELECT 3*3*3*3, POWER(3,4) FROM DUAL;

--��¥�Լ� : �Ű������� ��¥���� ���޹޾� ���� -> ��� ��ȯ
--SYSDATE : �ý����� ���� ��¥�� �ð��� �����ϱ� ���� Ű����
--SYSDATE Ű������ �˻����� �⺻������ [RR/MM/DD] �������� �˻�������, ���������δ� ��¥�� �ð� ����
SELECT SYSDATE, ADD_MONTHS(SYSDATE,5) FROM DUAL;

--SYSDATE+���� >> �� ����
SELECT SYSDATE, SYSDATE+7 FROM DUAL;

--����/24 => �ð�ó�� //IF) 100/24 = 100�ð� = 4�� X�ð� (��갪 = DAY �����̹Ƿ�)
SELECT SYSDATE, SYSDATE+100/24 FROM DUAL;

--��¥ - ��¥ = ����ϼ�(�Ǽ���)
SELECT EMPNO, ENAME, HIREDATE, SYSDATE-HIREDATE FROM EMP WHERE EMPNO=7499;
SELECT EMPNO, ENAME, HIREDATE, CEIL(SYSDATE-HIREDATE)||'��' "�ټ��ϼ�" FROM EMP WHERE EMPNO=7499;

--NEXT_DAY(��¥, ����) : ��¥���� ���޹޾� �̷��� Ư�� ���Ͽ� ���� ��¥���� ��ȯ�ϴ� �Լ�
SELECT SYSDATE "����", NEXT_DAY(SYSDATE, '��') "�ݿ���" FROM DUAL;

--����Ŭ�� ���ӵ� ���� ����� ȯ��(SESSION)�� ���� ��� ��� �� ��¥�� �ð� ������ �ٸ��� ���� ��.
--������ ��� ��� �� ��¥, �ð����� ���� ����
ALTER SESSION SET NLS_LANGUAGE ='AMERICAN'; -- ����� ����
--���� �����̹Ƿ� �ݿ����� �ν��� �� ���� ���� �߻�.
--SELECT SYSDATE "����", NEXT_DAY(SYSDATE, '��') "�ݿ���" FROM DUAL;
SELECT SYSDATE "����" , NEXT_DAY(SYSDATE, 'FRI') "�ݿ���" FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE='KOREAN'; -- �ٽ� �ѱ� �������� �ٲ�

--TRUNC(��¥, ǥ������) : ��¥���� ���޹޾� ���ϴ� ������ ǥ���ϰ� �������� �����Ͽ� �ʱⰪ ��ȯ.
SELECT SYSDATE, TRUNC(SYSDATE, 'MONTH'),TRUNC(SYSDATE,'YEAR') FROM DUAL;

--��ȯ�Լ� : �Ű������� ���޹��� ���� ���ϴ� �ڷ����� ������ ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--TO_NUMBER(���ڰ�) �Ű������� ���ڰ� �ƴҰ�� ���� �߻�.
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO=7839;
--�� �÷��� �ڷ����� �������� ��� �񱳰��� ���ڰ��̸� TO_NUMBER �Լ��� ��� -> ���ڷ� ��ȯ�Ͽ� ��
--=> ���� ����ȯ��
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO=TO_NUMBER('7839');
--�񱳰��� �����ΰ�� �ڵ����� ����ȯ�ϹǷ� ���� ������ �ʿ����
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO='7839';

--���ڰ��� ��������� ��� ���ڰ��� �ڵ����� ���ڰ����� ��ȯ�Ǿ� ����ó�� -> �ڵ�����ȯ
SELECT 100+'200' FROM DUAL;
SELECT '100'+'200' FROM DUAL;
--���ʿ� ���ڰ� �ƴ� ���� ��������ȯ�� �ڵ�����ȯ�� �Ұ� 
--SELECT 'A'+'B' FROM DUAL;
--SELECT TO_NUMBER('A')+TO_NUMBER('B') FROM DUAL;

--EMP���̺��� �����ȣ�� 7839�� ����� �����ȣ, ����̸�, �޿�, ���ı޿�(�޿�*0.9) �˻�
--�ڵ�/���� ����ȯ������ ��� ���� ��� ���
SELECT EMPNO,ENAME,SAL,SAL*0.9 FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*'0.9' FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*TO_NUMBER('0.9') FROM EMP WHERE EMPNO=7839;

--TO_DATE(���ڰ�,[���Ϲ���]) : ���ڰ��� ���޹޾� ��¥������ ��ȯ, ��ȯ��.
--�� �÷��� �ڷ����� ��¥���� ��� �񱳰��� ���ڰ��̸� �ڵ����� ��¥������ ��ȯ�Ǿ� �� - �ڵ� ����ȯ
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = TO_DATE('82/01/23');
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = '82/01/23';  --[RR/MM/DD]�����̹Ƿΰ���
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = '1982-01-23'; -- 'YYYY-MM-DD'�� ���������� ��� ������ �����̹Ƿ� ��� ����.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = TO_DATE('1982-01-23');

--BUT ���Ͽ� ���� �ʴ� ���ڰ��� ����� ��� ������ �߻��� EX) �ܱ��������� ��-��-�� ������ �ۼ���,
--�̷���, TO_DATE ����ϴ°�..! ��� �������� ����� ������ �˷� �ִ� ��.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = TO_DATE('01-23-1982','MM-DD-YYYY');

--2000-01-01�� �¾ ����� ���ñ��� ��ƿ� ��¥ �˻�
--SELECT SYSDATE-'2000-01-01' FROM DUAL; // ������ �������� ���� ���� �߻� -> '2000-01-01'�� ��¥������ ��ȯ�ؾ� ��.
SELECT CEIL(SYSDATE-TO_DATE('2000-01-01'))||'��' "���ñ��� ��� �� ��¥" FROM DUAL;
SELECT CEIL(SYSDATE-TO_DATE('00/01/01'))||'��' "���ñ��� ��� �� ��¥" FROM DUAL;

--TO_CHAR({���ڰ�|��¥��},���Ϲ���) : ���ڰ� OR ��¥���� ���޹޾� ���ϴ� ������ ���ڰ����� ��ȯ.
-- ��¥���� ���� : RR(��), YYYY(��), MM(��),DD(��),HH24(��),MI(��),SS(��)
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD'), TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--EMP���̺��� 1981�⿡ �Ի��� ����� �����ȣ, ����̸�, �Ի��� �˻�
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE HIREDATE BETWEEN '81/01/01' AND '81/12/31';

--���� ���ӵ� ����� ȯ���� ��¥�� �ð��� �⺻������ [RR/MM/DD/]�� ��쿡�� �˻� ����
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '81%';

--TO_CHAR �Լ��� ����Ͽ� ��¥���� ���ϴ� ������ ���ڰ����� ��ȯ�Ͽ� ��ȯ�޾� ��ó����.
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'YYYY') = '1981';

--�������Ϲ��� : 9(���� OR ����),0(����), L(ȭ�����), $(�޷�)
SELECT 1000000000, TO_CHAR(1000000000,'9,999,999,990')FROM DUAL;
SELECT 1000000000, TO_CHAR(1000000000,'0,000,000,000')FROM DUAL;
-- 9:ǥ���� ���ڰ��� ���� ��, �׳� �������� ��µ�
-- 0: ǥ���� ���ڰ��� ������, 0�� ���
SELECT 10, TO_CHAR(10,'9,999,999,990')FROM DUAL;
SELECT 10, TO_CHAR(10,'0,000,000,000')FROM DUAL;

--���޹��� ���ڰ��� ���̰� ���Ϲ����� ���̺��� ū��� ��� ���Ϲ��ڰ� [#]���� ��ȯ�Ǿ� ���c��.
SELECT 1000000000000, TO_CHAR(1000000000000,'9,999,999,990')FROM DUAL; 
SELECT 1000000000000, TO_CHAR(1000000000000,'0,000,000,000')FROM DUAL;


--EMP ���̺��� �����ȣ�� 7844�� ����� �����ȣ, ����̸�, �޿� �˻�.
--���� L�� ǥ��.. : LOCAL �ΰ�..?
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO = 7844;
SELECT EMPNO, ENAME, TO_CHAR(SAL,'999,990') SAL FROM EMP WHERE EMPNO = 7844;
SELECT EMPNO, ENAME, TO_CHAR(SAL,'L999,990') SAL FROM EMP WHERE EMPNO = 7844;
SELECT EMPNO, ENAME, TO_CHAR(SAL,'$999,990') SAL FROM EMP WHERE EMPNO = 7844;

-- �Ϲ��Լ� : �Ű������� ���޹��� ���� Ư�� ���ǿ� ���� ��� ���氪���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�

--NVL(���ް�, ���氪) : ���ް��� NULL�� ��� ���氪���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
-- ���氪�� ���ް��� ������ �ڷ����� �����θ� ���� ������.

--EMP ���̺� ����� ��� ����� �����ȣ, ����̸�, ����(�޿� *12) 
SELECT EMPNO, ENAME, SAL*12 ALNNUAL FROM EMP;

--EMP ���̺� ����� ��� ����� �����ȣ, ����̸�, ����((�޿�+������)*12) �˻�
--�������� NULL�Ͻ�, ����� NULL ��ȯ => NVL ����Ͽ� NULL �Ͻ�, 0���� �����ؾ� ��.
SELECT EMPNO, ENAME, (SAL+NVL(COMM,0))*12 ANNUAL FROM EMP;

--NVL2(���ް�, ���氪1, ���氪2) : ���ް��� NULL�� �ƴ� ��� ���氪1�� ��ȯ NULL�� ��� ���氪 2�� ��ȯ.
SELECT EMPNO, ENAME, (SAL+NVL2(COMM,COMM,0))*12 ANNUAL FROM EMP;
SELECT EMPNO, ENAME, (SAL+NVL2(COMM,(SAL+COMM),SAL))*12 ANNUAL FROM EMP;

--DECODE(���ް�, �񱳰�1, 2, 3,...[, �⺻��]) : ���ް��� �񱳰��� ���ʷ� ���Ͽ� ������� ���氪���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--�񱳰��� ��� �ٸ���� �⺻������ ��ȯ�Ͽ� ��ȯ - �⺻���� ������ ��� NULL�� ��ȯ��.

--EMP ���̺� ����� ��� ����� EMPNO, ENAME, JOB, SAL, �Ǳ޿� �˻�
SELECT DISTINCT JOB FROM EMP ;
-- ANLALIST : *1.1 / CLERK : * 1.2 / MANAGER : *1.3 / PRESIDENT :* 1.4 / SALESMAN : *1.2
SELECT EMPNO, ENAME,JOB, SAL,DECODE(JOB,'ANALYST',SAL*1.1,'CLERK',SAL*1.2,'MANAGER',SAL*1.3,'PRESIDENT',SAL*1.4,'SALESMAN',SAL*1.5)"�Ǳ޿�" 
FROM EMP ORDER BY "�Ǳ޿�" DESC;

--EMP ���Ժ� ����� ��� ����� �����ȣ, ����̸�, ����, �޿� �˻�
SELECT EMPNO,ENAME, JOB,SAL FROM EMP;

--EMP ���̺� ����� ��� ����� �������, �̸�, ������ �޿� �˻� - �ش� ������ �ƴ� ��� -> NULL �˻�
SELECT EMPNO, ENAME, DECODE(JOB,'ANALYST',SAL)"ANALYST", DECODE(JOB,'CLERK',SAL)"CLERK", DECODE(JOB,'MANAGER',SAL)"MANAGER",
DECODE(JOB,'PRESIDENT',SAL)"PRESIDENT",DECODE(JOB,'SALESMAN',SAL)"SALESMAN"FROM EMP;

--1. �Ի����� 12���� ����� EMPNO,ENAME,HIREDATE
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM')='12';
--2.
SELECT EMPNO,ENAME,LPAD(SAL,10,'*') "�޿�" FROM EMP;
--3. 
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE,'YYYY-MM-DD') "�Ի���" FROM EMP;
 
--�׷��Լ� : �Ű������� �ټ��� ���� ���޹޾� �����Ͽ� ������� ��ȯ�ϴ� �Լ�
--COUNT(�÷���) : �÷������� ���޹��� �÷����� ������ ��ȯ�ϴ� �Լ�. - �˻����� ���� ��ȯ
SELECT COUNT(EMPNO) FROM EMP;

--�׷��Լ��� �ٸ� �˻� ���� ���� ����� ��� ERROR �߻� => �׷��Լ��� �˻������ �˻����� ������ ���� �ٸ��Ƿ� ERROR �߻��ϴ� ��.
SELECT EMPNO, COUNT(EMPNO) FROM EMP; --EMPNO: 14�� �� ��µ� // COUNT�� 1�� ��� => ���� ���� �߻�.

--���� �׷��Լ������� ���� �˻�������(��� 1�ุ ����ϹǷ�)
--�׷��Լ��� NULL�� ������ ó������ �ʴ� ��� ��ȯ. 
SELECT COUNT(EMPNO), COUNT(COMM) FROM EMP; --NULL�� �����ϰ� COUNT����.

--COUNT�Լ��� ��쿡�� �÷��� ���, * ��ȣ�� ����Ͽ� ��� ���� ���� �˻� ����
SELECT COUNT(*) FROM EMP;

SELECT SUM(SAL) FROM EMP;

SELECT AVG(SAL) FROM EMP;

SELECT ROUND(AVG(SAL),2) FROM EMP;

--EMP ���̺� ����� ��� ����� ��� �������� ����Ͽ� �˻�
SELECT AVG(COMM) FROM EMP; -- NULL�� ���� �����ϰ� 4���� ��� ������ ����̹Ƿ� ��������
SELECT ROUND(AVG(NVL(COMM,0)),2) FROM EMP;

select count(*) from emp where deptno=10;
select count(*) from emp where deptno=20;
select count(*) from emp where deptno=30;
--���� ������ �ѹ��� �ϴ¹��� ����? => Group By 
--GROUP BY : �׷��Լ� ����, �÷������� �׷��� ������ �����Ͽ� �˻��ϴ� ���.
--�÷����� ���� ���, ���� �׷����� ó���Ͽ� �׷��Լ��� ����� ��ȯ.
--����) SELECT �׷��Լ�(�÷���)[,�˻����,...] FROM ���̺�� [WHERE ���ǽ�] GROUP BY {�÷���|�����|�Լ�},... [ORDER BY ...]
SELECT COUNT(*) FROM EMP GROUP BY DEPTNO;
--GROUP BY�� ����� ǥ������ �Լ��� �Բ� �˻� ����
SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO;
--GROUP BY�� ǥ�������δ� ��Ī ��� �Ұ�.
SELECT DEPTNO DNO, COUNT(*) FROM EMP GROUP BY DNO; --ERROR

--EMP ���̺� ����� ��� ����� ������ ��� �޿��� ����Ͽ� �˻�
SELECT JOB, CEIL(AVG(SAL)) "AVG_SAL" FROM EMP GROUP BY JOB;

--EMP ���̺��� ������ PRESIDENT�� ����� ������ ��� ����� ������ ��� �޿��� ��ձ޿��� �������� �����Ͽ� �˻�.
SELECT JOB, CEIL(AVG(SAL)) "AVG_SAL" FROM EMP WHERE JOB<>'PRESIDENT' GROUP BY JOB ORDER BY AVG_SAL DESC;

--HAVING �� : GROUP BY�� ���� �׷�ȭ�� �˻�������� �׷������� ��(TRUE)�� ���� �˻���.

SELECT JOB, CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY JOB HAVING JOB<>'PRESIDENT' ORDER BY AVG_SAL DESC;

--EMP ���̺� ����� ��� ����� �μ��� �޿� �հ� �� �޿� �հ谡 9000�̻��� �μ���ȣ�� �޿� �հ� �˻�
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL)>=9000;

--1. ������̺��� �μ��� �ο����� 6�� �̻��� �μ��ڵ� �˻�
SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*)>=6;
--2. �μ���ȣ, ������ �޿� �հ踦 ���
SELECT DEPTNO, SUM(DECODE(JOB,'CLERK',SAL))"CLERK", SUM(DECODE(JOB,'MANAGER',SAL))"MANAGER", SUM(DECODE(JOB,'PRESIDENT',SAL))"PRESIDENT"
,SUM(DECODE(JOB,'ANALYST',SAL))"ANALYST", SUM(DECODE(JOB,'SALESMAN',SAL))"SALESMAN" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

--3. ������̺�κ��� ������, ���� �޿��հ� ���
SELECT TO_CHAR(HIREDATE,'YYYY')"��", TO_CHAR(HIREDATE,'MM')"��", SUM(SAL) FROM EMP GROUP BY TO_CHAR(HIREDATE,'YYYY'), TO_CHAR(HIREDATE,'MM')ORDER BY 1, 2;


--4. �μ��� COMM�� ������ ������ �հ� �������� ���� ������ ��
SELECT DEPTNO, SAL, COMM FROM EMP ORDER BY DEPTNO;

SELECT DEPTNO, SUM(SAL*12)"����" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO; 
SELECT DEPTNO, SUM((SAL+NVL(COMM,0))*12)"����" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

--5. SALESMAN�� ������ JOB�� �޿� �հ� 
SELECT JOB, SUM(SAL) FROM EMP GROUP BY JOB HAVING JOB<>'SALESMAN';

--join : �ΰ� �̻��� ���̺��� ���� �����Ͽ� ���ϴ� �÷����� �˻��ϱ� ���� ���.

--EMP ���̺� ����� ��� ����� �����ȣ, ����̸�, �޿�, �μ���ȣ �˻�
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP;

---DEPT���̺� ����� ��� �μ��� �μ���ȣ, �μ��̸�, �μ���ġ �˻�
SELECT DEPTNO,DNAME,LOC FROM DEPT;

--DEPT ���̺� ����� ��� �μ��� �μ���ȣ,�μ��̸�,�μ���ġ �˻�
--�ΰ��̻��� ���̺��� �÷����� �˻��ϱ� ���ؼ��� �ݵ�� �˻����� �����ϱ� ���� ������ �����Ͽ� �˻�
--ī�ٽþ� ���δ�Ʈ(CATSIAN PRODUCT) : �ΰ��̻��� ���̺��� �������� ���� �˻��� ��� �߻��Ǵ� �˻� ���
--���������� �˻��� ��� �ΰ��̻��� ���̺� ����� ��� ���� ���� �����Ͽ� �˻� ��� ����
--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT; -- ī�ٽþȰ�

--EQUI JOIN : �ΰ� �̻��� ���̺��� �������ǿ� [=]�����ڸ� ����Ͽ� ���� �ุ �����Ͽ� �˻�.
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� �ุ ���� -> ��ȯ
--���������� WHERE���ǽ��� ����Ͽ� ���� 
--�ΰ��̻��� ���̺� ���� �̸��� �����ϴ� ��� �ݵ�� [���̺��.�÷���] �������� �����Ͽ� ǥ����.
SELECT EMPNO, ENAME, SAL, DEPTNO, DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
SELECT EMPNO, ENAME, SAL, EMP.DEPTNO, DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
SELECT EMPNO, ENAME, SAL, DEPT.DEPTNO, DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- �� ���̺��� ������ �� ���� �̸��� �÷��� ��� ȣ���� ��, DEPTNO / DEPTNO_1 ó�� �ϳ��� ��Ī�� �ڵ����� ������
SELECT EMPNO, ENAME, SAL, EMP.DEPTNO, DEPT.DEPTNO, DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
--BUT �̷��� ������, �̸��� �ٲ��÷��� ��� ���߿� ���� �̾Ƴ� ���� ���� => ALLIAS ����� �˻��Ұ��� ������.
SELECT EMPNO, ENAME, SAL, EMP.DEPTNO "EMP_DEPTNO", DEPT.DEPTNO "DEPT_DEPTNO", DNAME, LOC FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

--TABLE ALLIAS : ���̺� �Ͻ������� ���ο� �̸��� �ο��Ͽ� ����ϴ� ���. -> ���̺� ��Ī
--����)SELECT �˻����, ... FROM ���̺� ��Ī, ���̺� ��Ī,...
--���̺� ���ս�, ���̺��� �̸��� �����ϰ� ǥ���ϱ� ���� ����ϰų� �ϳ��� ���̺��� �ټ��� ���̺�� ǥ���ϱ�����
SELECT EMPNO,ENAME,SAL,E.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;
SELECT EMPNO,ENAME,SAL,D.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;

--���̺� ��Ī�� �ѹ� �����ߴٸ�, ��Ī�� ��� ����ؾ���. => EX) EMP E => E.DEPTNO (O)  // EMP.DEPTNO(X)
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;--���� �߻�SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;--���� �߻�