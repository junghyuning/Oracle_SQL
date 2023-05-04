--�ֿ� ���� : SIUD / PK,FK �������� / TCL
--�������� ��ġ�� ���� ����
--1. ��Į�� ��������(SCALAR SUBQUERY) : SELECT(�˻�), WHERE, GROUP BY, HAVING, ORDER BY
-- �ϳ��� SQL ������� ��޵����� ���������δ� �ϳ��� �Լ��� ó��
--> �Լ��� �ټ��� �Է��� �־ ����� �ϳ��� ����
-- ��Į�� ���������� ������ �Լ��̹Ƿ� ��ø ��� ���� BUT ���������� ������� �ΰ� �̻��̰ų� ������� �ڷ����� ������ ��� ERROR �߻�
-- "�뷮"�� DATA ó���ÿ���, ��Į�� ���������� ������ ���� ���ϸ� ������ �� �����Ƿ� ���� ���̺� ������ �̿��ϴ� ���� ����ȴ�.
    
-- 2. �ζ��κ� ��������(INLINE VIEW SUBQUERY) : FROM ���� ���� ��������
-- ���������� �̿��Ͽ� �Ͻ������� ������ ������ ���̺� - ���� ���̺�
-- ���̺� ���� Ƚ�� ���� �� ���� �������� ��� �ο�
   
--EMP ���̺� ����� ��� ����� �����ȣ, ����̸�, �޿��� �޿��� ���������Ͽ� �˻�
SELECT EMPNO, ENAME,SAL FROM EMP ;
--�ζ��κ� ���� : FROM���� �������� ����� �Ͻ������� ������ ���̺�� ���� �Ǵ°�.
SELECT EMPNO, ENAME,SAL FROM (SELECT EMPNO, ENAME,SAL FROM EMP);
--ROWNUM : �˻��࿡ �������� ���� �����ϴ� Ű����
SELECT ROWNUM, EMPNO, ENAME,SAL FROM (SELECT EMPNO, ENAME,SAL FROM EMP);
-- * �� �ٸ� �˻� ���� �Բ� ����� �Ұ��ϹǷ� �Ʒ��� ������ ���� �߻���
SELECT ROWNUM, * FROM (SELECT EMPNO, ENAME,SAL FROM EMP);
-->BUT ���̺��.* �� ���̺��� ���ó�� Ȱ���, ��밡��
--�ζ��κ信 ���̺� ��Ī�� �ο��Ͽ� ��� �����ϹǷ� ���̺�Ī.*�� ����ϴ°� ����.
SELECT ROWNUM, TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP)TEMP;
    
--���ȣ�� 6���� ���� �� �˻�
SELECT ROWNUM, TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP)TEMP WHERE ROWNUM<6;
--ROWNUM =5�� �� OR ROWNUM>5 �� �˻� �Ұ� => B/C ������ ������� : FROM�� -> WHERE�� -> SELECT �� ������ �������Ƿ�, 
--���� ROWNUM�� �ο����� ���� ���¿��� ROWNUM [= OR >] �񱳴� �Ұ��ϴ�
--(ROWNUM�� �˻��ÿ� ���������� ��ȣ�� �ο��ϴ� ������ ���� -> ���� 1���� ��µŵ� ����̾��� [<=]�� ������ �� �ִ°�.)
SELECT ROWNUM, TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP)TEMP WHERE ROWNUM=5; --ERROR
    
--����� ������ �޿������� ����������
SELECT EMPNO,ENAME,SAL FROM(SELECT EMPNO, ENAME,SAL FROM EMP)TEMP ORDER BY SAL DESC;
--+)���ȣ : ���������� ORDER BY�� ������ ���� ������ �̹Ƿ� ORDER BY �� ���� ������� ROWNUM�� �ο��ϰ� ������, 
--> SELECT���� ���ຸ�� ���� �켱������ �ִ� FROM���� �ζ��κ信�� ORDER BY �����ϵ��� �ؾ� ��.
SELECT ROWNUM,EMPNO,ENAME,SAL FROM(SELECT EMPNO, ENAME,SAL FROM EMP ORDER BY SAL DESC)TEMP ;
-- EMP���̺��� ��� �� �޿��� ���� ���� �޴� ��� 5���� �����ȣ, ����̸�, �޿� �˻�    
SELECT ROWNUM,EMPNO,ENAME,SAL FROM(SELECT EMPNO, ENAME,SAL FROM EMP ORDER BY SAL DESC)TEMP WHERE ROWNUM < 6;
    
--IF) ROWNUM�� �������� ���ų� �� ū ���ڸ� �˻��ϰ� �ʹٸ�?
-- �ش� ������ �������� ROWNUM�� �����ϴ� SELECT ������ WHERE���� ��������� �̸��ٴ� ���̾���.
--> ����, WHERE������ ��������� ���� FROM��(�ζ��κ�)���� ROWNUM�� ������� �ϼ��� ���̺��� �����Ѵٸ� �ش� ���굵 ������ ����.
SELECT * FROM (SELECT ROWNUM "RANKING",TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP ORDER BY SAL DESC)TEMP) WHERE RANKING=5; --ERROR
--1. �� �̷��� ���� ���������� ����ؾ߸� �ϴ���? �׳� �ѹ��� ROWNUM�� �����ϴ� ���������� ����� �ȵǴ� ����? 2. �� ALIAS�� ����ؾ߸� �ϴ���
--1. �Ʒ�ó�� �ϳ��� ������������ �̿��ҽ�, ���� ������ ROWNUM�� �پ���� �޿������� ROWNUM�� �������� ����
SELECT * FROM (SELECT ROWNUM "RANKING",EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) WHERE RANKING=5;
--2. ROWNUM �� ���ʿ� �÷��� �ƴ϶� Ű������ BUT �ζ��κ�� �ϳ��� ���̺��� �����ϴ°�ó�� ����ž���. ���� ALIAS�� �ο��Ͽ� Ű���带 ���� ������ ��ȣ�� �÷�ȭ �����ִ� ��. 
--> (ROWNUM��  ���̺� ���� ������ ó�� ����� �� �ִ� ���� �ζ��κ信�� �÷�ȭ �����־��� �� ��) 
--//ROWNUM�� ���� �÷��ε� �����÷��� ������ �����ͺ��̽��� �����ϴ� �÷��� �ƴ�����, SELECT ������ ��ȸ�� �� �ִ� �÷��� ���� BUT �������� �ʱ� ������ ������ �����Ҷ����� ������ �����Ͽ� ��ȯ��.(�����̽�)
--ROWNUM�� ���� ��� : ROWNUM�� ��ȯ�� ���� ��ȣ�� ��Ÿ���� ���� �÷���. 
SELECT ROWNUM, TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP)TEMP WHERE ROWNUM<6;
--> ���Ͱ��� �ζ��κ䰡 �ƴ� ���������� ROWNUM ����, WHERE ������ ROWNUM����� �����Ͽ� N��° ������� ��ȯ�ϵ��� �ɷ����°�. 
--> �� �Ŀ� SELECT �������� N���� ���ѵ� ���� ����ϸ鼭 �Ϸù�ȣ�� �ο��ϰ� ��. 
--> ��, �÷�ȭ�� RANKING=5 �� �ƴ� ROWNUM=5�� ��� Ű������ �۵����� �� ERROR�� �߻��ϰ� �Ǵ� ��.


--EMP ���̺� ����� ��� ��� �� �޿��� 6��°���� 10��°���� ���� ���� ����� �����ȣ,����̸�,�޿� �˻�
SELECT * FROM (SELECT ROWNUM "RANKING",TEMP.* FROM (SELECT EMPNO, ENAME,SAL FROM EMP ORDER BY SAL)TEMP) WHERE RANKING BETWEEN 6 AND 10 ;

--<<SUPER_HERO ���̺� ����>> - �Ӽ� : �̸�(������)
CREATE TABLE SUPER_HERO(NAME VARCHAR2(20) PRIMARY KEY);

--SUPER_HERO ���̺� �� ����
INSERT INTO SUPER_HERO VALUES('���۸�');
INSERT INTO SUPER_HERO VALUES('���̾��');
INSERT INTO SUPER_HERO VALUES('��Ʈ��');
INSERT INTO SUPER_HERO VALUES('��Ʈ��');
INSERT INTO SUPER_HERO VALUES('�����̴���');
SELECT * FROM SUPER_HERO;
COMMIT;

--MARVEL_HERO ���̺� ���� - �Ӽ� : �̸�(������),���(������)
CREATE TABLE MARVEL_HERO(NAME VARCHAR2(20) PRIMARY KEY,GRADE NUMBER(1));

--MARVEL_HERO ���̺� �� ����
INSERT INTO MARVEL_HERO VALUES('���̾��',3);
INSERT INTO MARVEL_HERO VALUES('��ũ',1);
INSERT INTO MARVEL_HERO VALUES('�����̴���',4);
INSERT INTO MARVEL_HERO VALUES('�丣',2);
INSERT INTO MARVEL_HERO VALUES('��Ʈ��',5);
SELECT * FROM MARVEL_HERO;
COMMIT;

--UNION(������) : �ΰ��� SELECT ������� �˻��� ���� ���Ͽ� ������� �����ϴ� ������ => �ߺ��� ����
--����) SELECT �˻����, ... FROM ���̺��1 UNION SELECT �˻����, ... FROM ���̺��2
--2���� SELECT ����� �˻������ �ڷ����� ������ �ݵ�� ��ġ�ǵ��� �˻�
SELECT NAME FROM SUPER_HERO UNION SELECT NAME FROM MARVEL_HERO;

--INTERSECT(������) : �ΰ��� SELECT ������� �˻��� �࿡�� �ߺ���� ���� �����ϴ� ������.
SELECT NAME FROM SUPER_HERO INTERSECT SELECT NAME FROM MARVEL_HERO;

--MINUS(������) : ù��° SELECT ������� �˻��� �࿡�� �ι�° SELECT ������� �˻� �� ���� ������ ���� �����ϴ� ������
SELECT NAME FROM SUPER_HERO MINUS SELECT NAME FROM MARVEL_HERO;

--���� ������ ����, �ΰ��� SELECT��ɿ� ���� �˻� ����� �ڷ��� OR ������ �ٸ� ��� ERROR �߻�.
SELECT NAME FROM SUPER_HERO UNION SELECT NAME, GRADE FROM MARVEL_HERO; -- �˻������ ������ �޶� ERROR
SELECT NAME FROM SUPER_HERO UNION SELECT GRADE FROM MARVEL_HERO;  -- �˻������ �ڷ����� �޶� ERROR

--> ���� �ϰ�ʹٸ�,,? �����ڷ����� ���ǰ��� ��� OR NULL ����Ͽ� ���� ó�� ����.
SELECT NAME, 0 FROM SUPER_HERO UNION SELECT NAME, GRADE FROM MARVEL_HERO;
SELECT NAME, NULL FROM SUPER_HERO UNION SELECT NAME, GRADE FROM MARVEL_HERO;

--���� ������ ���� �ΰ��� SELECT ��ɿ� ���� �˻� ����� �ڷ����� �ٸ� ��� ��ȯ�Լ��� ����Ͽ� ���� ó�� 
SELECT NAME FROM SUPER_HERO UNION SELECT TO_CHAR(GRADE,0) FROM MARVEL_HERO;

--DML(DATA MANIPULATION LANGUAGE) : ������ ���۾�
--���̺� �࿡ ���� ����,����,���� ����� �����ϴ� SQL ���
--DML ��� ���� �� COMMIT(TCL) OR ROLLBACK(TCL)

--INSERT : �� ����
--INSERT INTO TABLE_NAME VALUES(COLUMN1, 2, ...) -> �÷����� �Ӽ��� �������, ���� �� �ڷ����� �°� �����ؾ�����, ���� ����.

--TABLE�� �Ӽ�(�÷�&�ڷ���) Ȯ�� : DESC ���̺��
DESC DEPT;

--DEPT ���̺� ���ο� ��(�μ�����) ����
INSERT INTO DEPT VALUES(50,'ȸ���','����');
SELECT*FROM DEPT;
COMMIT;

INSERT INTO DEPT VALUES(6000,'�ѹ���','����'); -- �μ���ȣ�� ���ڰ� 2�ڸ��� ���� ���� -> BUT 4�ڸ� �� �Է������Ƿ� ����
INSERT INTO DEPT VALUES(60,'�ѹ���','������ �ȴޱ�'); -- �μ���ġ�� 13�ڸ� ���ڰ����� ū�� ��� -> �ѱ��� 1�ڰ� 2BYTE-3BYTE�� ��..?

--���̺� Į���� �ο��� ���������� �����ϴ� ���� ������ ��� ���� �߻�
--PK(PRIMARY KEY) �������� : �ߺ��� Į���� ������ �����ϱ� ���� ��������
--DEPT ���̺��� DEPTNO Į���� PK ���������� �ο��Ǿ�����
SELECT DEPTNO FROM DEPT;
--���̺� �Ӽ��� ���������� �������� �ʴ� �÷����� �����ؾ߸� �� ���� ���� 
--> BUT �÷��� ���� �����ϰ���� ������� NULL �� ����(������ NULL ���)
--���̺� �Ӽ��� ���������� �������� �ʴ� �÷����� �����Ͼ߸� �� ���� ����
INSERT INTO DEPT VALUES(60,'�ѹ���','������');
SELECT * FROM DEPT;
COMMIT;

INSERT INTO DEPT VALUES(70,'������',NULL);
SELECT * FROM DEPT;
COMMIT;
--> BUT PRIMARY KEY �� ��� NULL���� ������� ����.
INSERT INTO DEPT VALUES(NULL,'������','��õ��'); --����
--���̺��� Ư�� �÷��� ���� �����Ͽ� ���� ���� => INSERT INTO ���̺��(�÷���1,2, ...) VALUES (�÷���1,2,...)
-- �̷� ��� ����, ������ ���̺��� ������ �� ���� �ʿ�X +) PRIMARY KEY�� �ƴ� NULL ������ ���� ������ NULL�� �������� �ʾƵ� ��.
INSERT INTO DEPT(DNAME,LOC,DEPTNO) VALUES('�����','��õ��',80);
SELECT* FROM DEPT;
COMMIT;

--���̺� �÷� ���� ���� - ���̺� �÷��� ������ ��� ������ �÷����� �÷� �⺻���� �ڵ����� ���޵Ǿ� ���� ó��
--���̺� ���� �Ǵ� ���̺��� �÷� ����� �÷��� ����� �⺻�� ���� ����
--�÷� �⺻���� �������� ������ NULL�� �⺻������ ���ǵ��� �ڵ� ����
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'�λ��');--LOC �÷��� NULL�� ���޵Ǿ� ���� ó�� : ������ NULL ���

--EMP ���̺��� �Ӽ� Ȯ��
DESC EMP; 
INSERT INTO EMP VALUES(9000,'KIM','MANAGER',7298,'00/12/01',3500,1000,40);
COMMIT;
--��¥�� �÷����� ��¥�����, SYSDATE Ű���带 ����Ͽ� �������� ������.
INSERT INTO EMP VALUES(9001,'LEE','ANALYSY',9000,SYSDATE,2000,NULL,40);
COMMIT;

--INSERT ��ɿ� ���������� ����Ͽ� �� ���� ����.
--���������� �˻������ �̿� -> ���̺� �� ����. -> ���̺� �� ����

--BONUS ���̺� ���� Ȯ��
DESC BONUS;
SELECT * FROM BONUS;

--EMP ���̺��� �������� �����ϴ� ��� ������ �˻��Ͽ� BONUS ���̺� ���� ����
INSERT INTO BONUS SELECT ENAME, JOB, SAL, COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM BONUS;
COMMIT;

--UPDATE : TABLE�� ����� ���� �÷����� �����ϴ� SQL���
--���̺� ����� �� �� WHERE ���ǽ��� ����� ���� ���� �÷����� ������ �� ���.
--> WHERE ������ ���̺� ����� ��� ���� �÷����� �����ϰ� ���� ó��
--\WHERE ���ǽĿ��� ����ϴ� ���÷��� PK���������� �ο��� �÷��� �̿��� �����ϴ°��� ����
-- B/C PK���������� �ִ� �÷��� ��� �ߺ����� ���°��� ����ǹǷ� �߸��� ������ ������ �� ����.  

--DEPT ���̺��� �μ���ȣ�� 50�� �μ����� �˻�
SELECT * FROM DEPT WHERE DEPTNO=50;

--> �μ��̸� [�渮��] �μ���ġ[��õ��] ����
UPDATE DEPT SET DNAME='�渮��',LOC='��õ��' WHERE DEPTNO=50;
COMMIT;

--�÷��� ���氪�� �÷��� �ڷ���, ũ��, ���������� �´� ��쿡�� ���� ó��
UPDATE DEPT SET LOC='��õ�� ���̱�' WHERE DEPTNO=50; --���氪�� ������ ���� �ʾ� ����

--UPDATE ��ɿ��� �������� ��� ����. => SET�� ���氪 OR WHERE �񱳰� ��� �������� ���

UPDATE DEPT SET LOC=(SELECT LOC FROM DEPT WHERE DNAME='�ѹ���') WHERE DNAME='������';
SELECT * FROM DEPT WHERE DNAME='������';
COMMIT;

--BONUS ���̺��� ����̸��� KIM�� ������� �������� ���� ����� �������� 100 �����ǵ��� ����(WHERE���� ��������)
UPDATE BONUS SET COMM=COMM+100 WHERE COMM<(SELECT COMM FROM EMP WHERE ENAME='KIM');
SELECT * FROM BONUS;
COMMIT;

--DELETE : ���̺� ����� ���� �����ϴ� SQL ���-> ���̺� ���迡 ū ������ �� �� �־� ������ �� ������� ����.
-- DELETE ~ FROM
--WHERE ������ ��� ���̺� ����� ��� �� ���� 
--���������� PK ���������� �ִ� ���� �����ϴ°��� ����.

--DEPT ���̺��� �μ���ȣ�� 90�� �μ����� ����
SELECT* FROM DEPT;
DELETE FROM DEPT WHERE DEPTNO=90;
SELECT* FROM DEPT;
COMMIT;

--�μ������� 10�� �μ����� ����
--�ڽ����̺��� �����Ǵ� ���� ���� �Ұ�(FK ��������)

SELECT DISTINCT DEPTNO FROM EMP; -- �˻���� : 10,20,30,40 - �θ� ���̺��� �����Ͽ� ����� �÷���.
DELETE FROM DEPT WHERE DEPTNO=20;--�ڽ� ���̺��� �����ϴ� �θ����̺��� ���� �����Ͽ� ���� �߻�
DELETE FROM DEPT WHERE DEPTNO=80;
SELECT * FROM DEPT;
COMMIT;

--DELETE ��ɿ��� WHERE���� �񱳰� ��� �������� ��� ����
--DEPT���̺��� �μ��̸��� �������� �μ��� ���� �μ���ġ�� �ִ� �μ����� - ������ ����
DELETE FROM DEPT WHERE LOC = (SELECT LOC FROM DEPT WHERE DNAME='������');
SELECT * FROM DEPT;

--MERGE : ���� ���̺��� ���� �˻��Ͽ� Ÿ�� ���̺� ������ �����ϰų� Ÿ�� ���̺� ����� ���� �÷����� �����ϴ� SQL ��� -> ���̺��� �� ����
--MERGE - INTO TABLNAME USING ORIGINAL_TABEL_NAME ON (���ǽ�)
--WHEN MATCHED THEN UPDATE SET TARGETED_COLUMN = ORIGINAL_COLUMN, ...
--WHEN NOT MATCHED THEN INSERT (TARGETED_COLUMN1, 2, ..) VALUES (ORIGINAL_COLUMN1, 2, ..)

--MERGE_DEPT ���̺� ���� - �Ӽ� : �μ���ȣ(������), �μ��̸�(������), �μ���ġ(������)
DESC DEPT;
CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2), DNAME VARCHAR2(14), LOC VARCHAR(13));
DESC MERGE_DEPT;

--MERGE_DEPT TABLE�� �� ����
INSERT INTO MERGE_DEPT VALUES (30,'�ѹ���','�����');
INSERT INTO MERGE_DEPT VALUES(60,'�����','������');
SELECT * FROM MERGE_DEPT;
COMMIT;

--DEPT���̺�� MERGE_DEPT���̺��� MERGE �Ϸ��� �Ҷ�, 
--> MERGE ���� : �μ���ȣ �� -> ���� ���� ���� ��� : ����(UPDATE) // ���� ��� : ����(INSERT)ó��
MERGE INTO MERGE_DEPT "M" USING DEPT "D" ON ( M.DEPTNO = D.DEPTNO)
    WHEN MATCHED THEN UPDATE SET M.DNAME = D.DNAME, M.LOC = D.LOC
    WHEN NOT MATCHED THEN INSERT (M.DEPTNO,M.DNAME,M.LOC) VALUES (D.DEPTNO,D.DNAME,D.LOC);
SELECT * FROM MERGE_DEPT;
COMMIT;

--TCL(TRANSACTION CONTROL LANGUAGE) Ʈ����� �����
-- Ʈ����ǿ� ����� SQL ����� ���� ���̺� �����ϰų� ���̺� �������� �ʰ� ����ϴ� ���

-- Ʈ������ : ���ǿ��� DBMS ������ ���޵Ǿ� ����� SQL ����� �����ϴ� ������ �۾� ����.
--> Ŀ���ϱ������� ������ DML����� �ٷ� DB�� ����Ǵ°��� �ƴ϶� ������ Ʈ�����ǿ� ��������� (ROLLBACK�� ������ ����)
--> �� ���¿��� �˻��� ����ϴ� ��.

--���� ���̺� �����ϱ� ���ؼ��� Ŀ��(COMMIT) ó�� - Ŀ�� ó�� �� Ʈ������ �ʱ�ȭ
--1.���� ���ǿ��� ���������� ���� ������ ������ ��� �ڵ� Ŀ�� ó��
--2. DDL ��� OR DCL����� �ۼ��Ͽ� ������ ������ ��� -> �ڵ� Ŀ�� ( ��, �ѹ��� �Ұ���)
--3. ������ �����Ͽ� Ʈ�����ǿ� ����� ����� COMMIT ����� ����Ͽ� Ŀ�� ó����. (ROLLBACK ����)
--> ��, DML -> ���� COMMIT  // DCL,DDL -> AUTO COMMIT

--DEPT ���̺��� �μ���ȣ�� 50�� �μ����� ����
SELECT * FROM DEPT;
--DELETE ����� �����ϸ� DEPT ���̺��� ���� �������� �ʰ� Ʈ�����ǿ� DELETE ��� ����
DELETE FROM DEPT WHERE DEPTNO=50;
--DEPT ���̺��� �˻��࿡�� Ʈ�����ǿ� ����� DELETE ����� ������ �˻���� ����
SELECT * FROM DEPT;

--ROLLBACK ����� �̿��� �ѹ�ó�� - Ʈ������ �ʱ�ȭ 
ROLLBACK;
SELECT * FROM DEPT;

--�ٽ� �����غ� + COMMIT + ROLLBACK
DELETE FROM DEPT WHERE DEPTNO=50;
COMMIT;
SELECT*FROM DEPT;
ROLLBACK;
SELECT*FROM DEPT; -- �ѹ��غ��� Ŀ�Խ������� �ѹ��ϹǷ� �ҿ�X
