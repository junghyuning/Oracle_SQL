--��ũ��Ʈ ���� ó��

--��ũ��Ʈ���� �ۼ��� SQL ����� ���ӵ� ����Ŭ ������ �����Ͽ� �����ϴ� ���
--[CTRL]+[ENTER] : Ŀ�� ��ġ�� SQL ����� �����Ͽ� ����
--[F5] : ��ũ��Ʈ�� �ۼ��� ��� SQL ����� �����Ͽ� ����
--������ �����Ͽ� [CTRL]+[ENTER] �Ǵ� [F5]�� ����ϸ� ���� ������ SQL ����� �����Ͽ� ����
--��ũ��Ʈ�� �ۼ��Ǿ� ����� SQL ����� ����� [��ũ��Ʈ ���] �Ǵ� [���� ���] �ǿ� ���

--SQL ����� ��ҹ��ڸ� �������� ������ �ϳ��� ������� ó���ǵ��� ; ��ȣ ���
SHOW USER;--���� ������ ������ ������� �̸��� Ȯ���ϱ� ���� ���

--���̺�(TABLE) : ����Ÿ���̽����� ����Ÿ(��)�� �����ϱ� ���� �⺻ ��ü
--���� ���� �����(SCOTT)�� ���� ������ ��Ű���� �����ϴ� ���̺� ��� Ȯ��
SELECT TABLE_NAME FROM TABS;
SELECT * FROM TAB;

--���̺��� ���� Ȯ�� : �÷���� �ڷ��� - ���̺� �Ӽ�
--����)DESC ���̺��;
--EMP ���̺� : ��������� �����ϱ� ���� ���̺�
DESC EMP;
--DEPT ���̺� : �μ������� �����ϱ� ���� ���̺�
DESC DEPT;

--DQL(DATA QUERY LANGUAGE) : ����Ÿ ���Ǿ� - ���̺� ����� ���� �˻��ϱ� ���� SQL ���
--SELECT : �ϳ� �̻��� ���̺��� ���� �˻��ϱ� ���� ���
--����)SELECT �˻����,�˻����,... FROM ���̺��
--�ϳ��� ���̺� ����� ��� ���� �˻��Ͽ� ���� SELECT ���
--�˻���� : *(��� �÷�) - �ٸ� �˻����� ���ÿ� ��� �Ұ���, �÷���, �����, �Լ� ��
SELECT * FROM EMP;
SELECT EMPNO,ENAME,SAL FROM EMP;

--COLUMN ALIAS : �˻���� ��Ī(�ӽ� �÷���)�� �ο��ϴ� ���
--�˻������ ��Ȯ�ϰ� �����ϱ� ���� COLUMN ALIAS ��� ���
--����)SELECT �˻���� [AS] ��Ī,�˻���� [AS] ��Ī,... FROM ���̺��
SELECT EMPNO,ENAME,DEPTNO FROM EMP;
SELECT EMPNO AS NO, ENAME AS NAME, DEPTNO AS DNO FROM EMP;
--�÷��� ��Ī�� �����ϱ� ���� AS Ű���� ���� ����
SELECT EMPNO NO, ENAME NAME, DEPTNO DNO FROM EMP;
SELECT EMPNO �����ȣ, ENAME ����̸�, DEPTNO �μ���ȣ FROM EMP;

--�˻�������� �÷����� �̿��� ����� ��� ����
SELECT EMPNO, ENAME, SAL*12 FROM EMP;
SELECT EMPNO, ENAME, SAL*12 ANNUAL FROM EMP;

--SQL ����� �����(Ű����)�� ����� ���� ��Ī(�ĺ���)�� �ܾ�� ����
--�ĺ���(���̺��, �÷���, ��Ī ��)�� ������ũ ǥ���(�ܾ�� �ܾ [_]�� �����Ͽ� ǥ��)�� ����Ͽ� �ۼ�
SELECT EMPNO, ENAME, SAL*12 ANNUAL_SALARY FROM EMP;

SELECT EMPNO �����ȣ, ENAME ����̸�, SAL*12 ���� FROM EMP;
--�˻������ ��Ī���� ���� �Ǵ� Ư������ ��� �Ұ���
SELECT EMPNO ��� ��ȣ, ENAME ��� �̸�, SAL*12 ^����^ FROM EMP;--���� �߻�
--�˻������ ��Ī�� " " ��ȣ �ȿ� ǥ���ϸ� ��� ������ ��Ī ǥ�� ����
--" " ��ȣ�� �˻������ ��Ī�� ǥ���ϱ� ���� ����ϴ� Ư������
SELECT EMPNO "��� ��ȣ", ENAME "��� �̸�", SAL*12 "^����^" FROM EMP;

--�˻������ , ��ȣ�� ����Ͽ� ���� �ۼ� ����
SELECT ENAME,JOB FROM EMP;

--�˻���� || ��ȣ�� ����Ͽ� ���ڰ����� �����Ͽ� �˻�
SELECT ENAME||JOB FROM EMP;

--SQL���� ���ڰ��� ' ' ��ȣ�� ����Ͽ� ǥ��
SELECT ENAME||'���� ������ '||JOB||'�Դϴ�.' FROM EMP;

--EMP ���̺� ����� ��� ����� ���� �˻� - �ߺ� �÷��� �˻�
SELECT JOB FROM EMP;

--EMP ���̺� ����� ��� ����� ���� �˻� - �ߺ� �÷����� ������ ������ �ϳ��� �÷����� �˻�
--DISTINCT : �˻������ �ߺ����� �����ϰ� ������ �ϳ��� �÷����� �˻��ϴ� ����� �����ϴ� Ű����
--����)SELECT DISTINCT �˻����,�˻����,... FROM ���̺��
SELECT DISTINCT JOB FROM EMP;

--����Ŭ�� DISTINCT Ű���忡 �˻������ ������ �����Ͽ� �ۼ� ����
SELECT DISTINCT JOB,DEPTNO FROM EMP;

--WHERE : ���ǽ��� ����Ͽ� ������ ��(TRUE)�� �ุ �˻��ϴ� ����� ����
--����)SELECT �˻����,�˻����,... FROM ���̺�� WHERE ���ǽ�
--���ǽ��� �Ϲ������� �÷����� ���ϴ� �����

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

--EMP ���̺��� �����ȣ�� 7698�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE EMPNO=7698;

--EMP ���̺��� ����̸��� KING�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='KING';
--SQL ����� ��ҹ��ڸ� �������� ������ ���ڰ��� ��ҹ��ڸ� ����
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='king';

--EMP ���̺��� �Ի����� 1981�� 6�� 9���� ����� �����ȣ,����̸�,����,�޿�,�Ի��� �˻�
--��¥���� ' ' �ȿ� [RR/MM/DD] ������ �������� ǥ���Ͽ� ��� - ��¥���� �⺻ ���� : [RR/MM/DD]
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE='81/06/09';
--��¥���� ' ' �ȿ� [YYYY-MM-DD] ������ �������� ǥ���Ͽ� ��� ����
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE='1981-06-09';

--EMP ���̺��� ������ SALESMAN�� �ƴ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB<>'SALESMAN';
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB!='SALESMAN';

--EMP ���̺��� �޿��� 2000 �̻��� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL>=2000;

--EMP ���̺��� ����̸� A,B,C,�� ���۵Ǵ� ����� �����ȣ, ����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME<'D';

--EMP ���̺��� 1981�� 5�� 1������ �Ի��� ����� �����ȣ,����̸�,����,�޿�,�Ի��� �˻�
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE<'81/05/01';

--EMP ���̺��� ������ SALESMAN�� ����� �޿��� 1500 �̻��� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB='SALESMAN' AND SAL>=1500;

--EMP ���̺��� �μ���ȣ�� 10�̰ų� ������ MANAGER�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE DEPTNO=10 OR JOB='MANAGER';

SELECT * FROM EMP WHERE SAL>=1000 AND SAL<=3000;

SELECT SAL FROM EMP;
--��������� -> ����) �÷��� BETWEEN ������ AND ū��; //������ �� ū�� ���� ��.
SELECT*FROM EMP WHERE SAL BETWEEN 1100 AND 3000;

SELECT * FROM EMP WHERE JOB = 'ANALIST' OR JOB='SALESMAN';

SELECT * FROM EMP WHERE JOB IN ('ANALIST','SALESMAN');

select * from emp where ename='ALLEN';

-- BETWEEN�� �������� ��� �����ϹǷ� ���� ����� �ٸ��� ������ ��.
SELECT* FROM EMP WHERE ENAME>='A' AND ENAME<'B';
SELECT * FROM EMP WHERE ENAME BETWEEN 'A' AND 'B';

-- �˻����� => [%] - ��ü  /  [_] - ���� �ϳ�  /  
-- = �����ڷ� ���� ��� �˻����ڰ� �ƴ� �Ϲݹ��ڷ� �˻���
-- ���� �˻����ڸ� �̿��Ͽ� �÷����� �� �˻��� ���, [=] ������ ���, like Ű���带 �����.
select * from emp where ename='A%'; -- �̶��� ����� �ȳ���(Ư�����ڸ� �����ϴ� ����� ���� ����)
SELECT * FROM EMP WHERE ENAME LIKE 'A%'; -- �̶��� ����� ����

--�˻����ڸ� ������� �ʾƵ� [=] ���, LIKE ����ص� ��� ����.
SELECT * FROM EMP WHERE ENAME LIKE 'ALLEN';

-- Ư�� ���ڸ� �����ϴ� �ܾ ã�� ��.
SELECT * FROM EMP WHERE ENAME LIKE '%A%';

--EMP ���̺��� ����̸��� �ι�° ���ڰ� L�� ��� �˻�
SELECT * FROM EMP WHERE ENAME LIKE '_L%';

--EMP TABLE�� ���ο� �����ȣ ����
INSERT INTO EMP VALUES (9000,'M_BEER','CLERK',7788,'81/12/12',1300,NULL,10);

SELECT * FROM EMP;
COMMIT;

-- �̸��� _ ���ڰ� ���Ե� ����� ����
-- �׳� _�ξ��� �˻����ڷ� �ݿ��Ǳ� ������ ȸ�ǹ���(escape character) �� ����Ͽ� �Ϲݹ��ڷ� ó���� �˻��ϴ°��� ������.
SELECT* FROM EMP WHERE ENAME LIKE '%\_%' escape '\';

-EMP ���̺��� �����ȣ�� 9000�� �������(��) ����
DELETE FROM EMP WHERE EMPNO=9000;
COMMIT;

--emp ���̺��� ������ manager�� �ƴ� ��� �˻�
SELECT * FROM EMP WHERE JOB<>'MANAGER';
--NOT Ű������ Ȱ��
SELECT * FROM EMP WHERE NOT (JOB = 'MANAGER');

--EMP ���̺��� �������� ���� ��� �˻� NULL�� ���θ� �����Ҷ���
-- IS NULL // IS NOT NULL
SELECT * FROM EMP;
SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;

--ORDER BY : �÷����� ���Ͽ� ���� ���ĵǵ��� �˻��ϴ� ����� ����. ASC / DESC
--������ �÷����� ���� ���, �ٸ� �÷��� ���� ���ϵ��� �ϴ� �͵� ������.
--INDEX [1]���� ������..!
SELECT EMPNO, ENAME, JOB, SAL, COMM FROM EMP WHERE SAL>1000 ORDER BY SAL, ENAME DESC;

--�������� ������������
SELECT EMPNO, ENAME, SAL*12 AS ANNUAL, COMM FROM EMP ORDER BY SAL*12 DESC;
SELECT EMPNO, ENAME, SAL*12 AS ANNUAL, COMM FROM EMP ORDER BY ANNUAL DESC;
-- INDEX[1] = EMPNO, INDEX[2] = ENAME, INDEX[3] = SAL*12
SELECT EMPNO, ENAME, SAL*12 AS ANNUAL FROM EMP ORDER BY 3 DESC;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP ORDER BY DEPTNO, SAL DESC;

-- ���� ��� �÷��� �˻������� *�� ���� �ʰ� ������ �÷��� ���°��� �˻��ӵ��� �����Ƿ� �����δ� *�� ������� ����

--�˻���� : EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO
-- ����1. ����̸��� SCOTT�� ���
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE ENAME = 'SCOTT';

--USER = ���� ���� ������� �̸��� ǥ���ϱ����� �����
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE ENAME = USER;

--����2. �޿��� 1500 ������ ���
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE SAL <= 1500; 
--����3. 1981�⿡ �Ի��� ���
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE HIREDATE BETWEEN '81/01/01' AND '81/12/31';
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE HIREDATE LIKE '81%';

--����4. ������ 'SALESMAN' OR 'MANAGER'�� ��� �� �޿��� 1500�̻��� ��� �˻�
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE JOB IN ('SALESMAN', 'MANAGER') AND SAL>=1500;
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE (JOB ='SALESMAN' OR JOB = 'MANAGER') AND SAL>=1500;

--���� 5. �μ���ȣ�� 30�� ��� �� �������� �����ϴ� ���
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE DEPTNO = 30 AND COMM IS NOT NULL;
--���� 6. �μ���ȣ�� 30�� ��� �� �޿��� 1000~3000������ ��� �˻�
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE DEPTNO = 10 AND SAL BETWEEN 1000 AND 3000;
--���� 7. ��� ����� ������ �������� �����Ͽ� �˻��ϰ� ���� ������ ����� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP ORDER BY JOB, SAL DESC;
--���� 8. ������ 'SALESMAN' �� ����� �޿��� �������� ����
SELECT EMPNO, ENAME, JOB, SAL, COMM, HIREDATE, DEPTNO FROM EMP WHERE JOB = 'SALESMAN' ORDER BY SAL DESC;

-- �Լ� : �Ű������� ���޹��� ���� �����Ͽ� ó�� ������� ��ȯ�ϴ� ����� ������
--�����Լ� : �ϳ��� �� ���޹޾� ����� ��ȯ => ����, ����, ��¥, ��ȯ, �Ϲ� �Լ�
--�׷��Լ� : �ټ��� ���� ���޹޾� ���� -> ����� ����

--�����Լ� : �Ű������� ���ڰ��� ���޹޾� �������� �� ������� ��ȯ��.
--UPPER / LOWER
SELECT ENAME,UPPER(ENAME),LOWER(ENAME) FROM EMP;

--SQL�� ��ҹ��ڸ� �������� ������, ������ ��쿡�� ��ҹ��ڸ� �����ϰ�����
--��ҹ��ڸ� �������� �ʰ� ��ġ�ϴ� �ڷḦ �˻��ϰ� ������, UPPER . LOWER �� ����� �� �ִ�.
SELECT ENAME FROM EMP WHERE UPPER(ENAME) = UPPER('smith');
 
 --INITCAP(���ڰ�) : ù��° ���ڸ� �빮�ڷ� ��ȯ -> ������ ���ڴ� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ
 SELECT ENAME, INITCAP(ENAME) FROM EMP;
 
 -- CONCAT : �ΰ��� ���ڸ� ���� (||�� ����)
 SELECT ENAME, JOB, CONCAT(ENAME,JOB), ENAME||JOB FROM EMP;
 
 --SUBSTR(���ڿ�, ������ġ, ����) : ���� ~N���� ������ŭ�� ����
SELECT EMPNO, ENAME, JOB, SUBSTR(JOB,6,3) FROM EMP WHERE EMPNO=7499;

--LENGTH(���ڰ�) : ���ڰ��� ���޹޾� ���� ������ ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, JOB, LENGTH(JOB) FROM EMP WHERE EMPNO = 7499;

--INSTR(���ڰ�, �˻��ҹ���, ����, �˻���ġ) : ������ġ���� �˻� -> ���ϴ� ��ġ�� ���ڰ��� ����(IF �˻��� ���� = 1 / �˻���ġ = 2 => 2��° 1�� ��ġ�� ��ȯ��)
SELECT EMPNO, ENAME, JOB, INSTR(JOB, 'A', 1,2)FROM EMP WHERE EMPNO=7499;

--LPAD(���ڰ�, �ڸ���, ä�﹮��) : ���ڸ� ���޹޾� ���ʺ��� ä��� ������ ���� �ڸ��� ä�﹮�ڷ� ä���� ��ȯ
--RPAD(���ڰ�, �ڸ���, ä�﹮��) : ���ڸ� ���޹޾� �����ʺ��� ä��� ������ ���� �ڸ��� ä�﹮�ڷ� ä���� ��ȯ��.
SELECT EMPNO, ENAME, SAL, LPAD(SAL,8,'*'),RPAD(SAL,8,'*') FROM EMP;

--TRIM({LEADING|TRAILING} ���Ź��� FROM ���ڰ�) : ���ڰ��� ���޹޾� ��(LEADING) OR ��(TRAILING)�� �����ϴ� ���Ź��ڸ� �����ϰ� ��ȯ.
SELECT EMPNO,ENAME, JOB, TRIM(LEADING 'S' FROM JOB), TRIM(TRAILING 'N' FROM JOB) FROM EMP WHERE EMPNO=7499;

--REPLACE(���ڰ�, �˻����ڰ�, ġȯ���ڰ�)
SELECT EMPNO, ENAME, JOB, REPLACE(JOB,'MAN','PERSON')FROM EMP WHERE EMPNO=7499;