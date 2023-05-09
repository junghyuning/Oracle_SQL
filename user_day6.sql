--FOREIGN KEY / FLASHBACK - PURGE / VIEW - INLINEVIEW / SEQUENCE

--FOREIGN KEY (����Ű) : �θ����̺� ����� ���� �÷��� ���� -> �ڽ����̺��� �÷��� ���������� ���� ����Ǵ� ���� ������.
--�θ� ���̺��� PK �����Ͽ� �ڽ����̺��� �÷��� FK ���������� ������.  ->  ���̺��� ���踦 �����ϱ� ���� �������� ��.

CREATE TABLE SUBJECT1(SNO NUMBER(2) CONSTRAINT SUBJECT1_SNO_PK PRIMARY KEY, SNAME VARCHAR2(20));

INSERT INTO SUBJECT1 VALUES(10,'JAVA');
INSERT INTO SUBJECT1 VALUES(20,'JSP');
INSERT INTO SUBJECT1 VALUES(30,'SPRING');
SELECT * FROM SUBJECT1;
COMMIT;

--TRAINEE1 ���̺� ���� : ������ ��ȣ(����, PK)/�̸� : ���� / �����ڵ� : ����
CREATE TABLE TRAINEE1(TNO NUMBER(4) CONSTRAINT TRAINEE1_TNO_PK PRIMARY KEY, TNAME VARCHAR2(20),SCODE NUMBER(2));
INSERT INTO TRAINEE1 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE1 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE1 VALUES(3000,'����ġ',30);
INSERT INTO TRAINEE1 VALUES(4000,'������',40);
SELECT * FROM TRAINEE1;
COMMIT;

--TRAINEE1 ���̺�� SUBJECT1 ���̺��� ��� �������� ��������ȣ, �������̸�, ��������� �˻�
-- �������� : TRAINEE1 ���̺��� SCODE = SUBJECT1 ���̺��� SNO
-- ���� �÷��� �����̹Ƿ� -> INNER JOIN ~ ON
SELECT TNO, TNAME, SNAME FROM TRAINEE1 JOIN SUBJECT1 ON SCODE=SNO;
--> ���������� ���� �ุ �����Ͽ� �˻� => �����Ŵ� �˻����� ���� (���������� �������� ����)
--> ��� ���������� �˻��ϰ� �ʹٸ�, LEFT OUTER JOIN ����
SELECT TNO, TNAME, SNAME FROM TRAINEE1 LEFT OUTER JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 ���̺� ���� - ��������ȣ(������-PK), �̸�, �����ڵ� - FK)
CREATE TABLE TRAINEE2 (TNO NUMBER(4) CONSTRAINT TRAINEE2_TNO_PK PRIMARY KEY, TNMAE VARCHAR2(20), SCODE NUMBER(2), CONSTRAINT TRAINEE2_SCODE_FK FOREIGN KEY(SCODE)REFERENCES SUBJECT1(SNO));
INSERT INTO TRAINEE2 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE2 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE2 VALUES(3000,'����ġ',30);
INSERT INTO TRAINEE2 VALUES(4000,'������',40); --FK �������� ����
SELECT * FROM TRAINEE2;
COMMIT;

ALTER TABLE TRAINEE2 RENAME COLUMN TNMAE TO TNAME;
--TRAINEE2 & SUBJECT1 ���̺��� ������ ��ȣ, �̸�, ����� �˻�
SELECT TNO,TNAME,SNAME FROM TRAINEE2 JOIN SUBJECT1 ON SCODE=SNO;

-- ��������ȣ 1000 -> 40 ���� ����
UPDATE TRAINEE2 SET SCODE=40 WHERE TNO=1000;  --FK �������� ���� 
-->SCODE�� SUBJECT1�� SCODE�� �����ϴ� FOREIGN KEY �̱� ������ SUBJECT1���̺� ���� �����δ� �ٲܼ� ����.

--SUBJECT ���̺��� �����ڵ尡 10�� �������� ����
--�ڽ����̺��� �����Ǵ� �θ� ���̺��� �� ���� �Ұ���
DELETE FROM SUBJECT1 WHERE SNO=10;  --FK �������� ����


--SUBJECT2 ���̺� ���� - �����ڵ�(������-PRIMARY KEY),�����(������) : �θ� ���̺�
CREATE TABLE SUBJECT2(SNO NUMBER(2) CONSTRAINT SUBJECT2_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT2 ���̺� �� ����
INSERT INTO SUBJECT2 VALUES(10,'JAVA');
INSERT INTO SUBJECT2 VALUES(20,'JSP');
INSERT INTO SUBJECT2 VALUES(30,'SPRING');
SELECT * FROM SUBJECT2;
COMMIT;

--TRAINEE3 ���̺� ���� - ��������ȣ(������-PRIMARY KEY),�������̸�(������),���������ڵ�(������-FOREIGN KEY) : �ڽ� ���̺�
--TRAINEE3 ���̺��� ���������ڵ�(SCODE)�� FOREIGN KEY ���������� �����Ͽ� SUBJECT2 ���̺��� �����ڵ�(SNO)�� ����
--FOREIGN KEY �������� ������ ON DELETE CASCADE �Ǵ� ON DELETE SET NULL ��� �߰�
--ON DELETE CASCADE : �θ� ���̺��� ���� ������ ��� �ڽ� ���̺��� ���� �÷����� ����� �൵ ���� ó���ϴ� ��� ����
--ON DELETE SET NULL : �θ� ���̺��� ���� ������ ��� �ڽ� ���̺��� ���� �÷����� NULL�� �����ϴ� ��� ����
CREATE TABLE TRAINEE3(TNO NUMBER(4) CONSTRAINT TRAINEE3_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2)
    ,CONSTRAINT TRAINEE3_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT2(SNO) ON DELETE CASCADE);
INSERT INTO TRAINEE3 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE3 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE3 VALUES(3000,'����ġ',30);
SELECT * FROM TRAINEE3;
COMMIT;

--subject2 ���̺��� �����ڵ尡 10�� �������� ����
DELETE FROM SUBJECT2 WHERE SNO=10;  -- ON DELETE CASCADE�� �ش� ���̺��� �����ϴ� ���̺��� �������� �Բ� ���������ν� ������� ����� �����߻�X
--SUBJECT2 ���̺�(�θ� TABLE)�� �����ڵ带 �����ϴ� TRAINEE3 ���̺��� ������ ���� ����
SELECT * FROM SUBJECT2;
SELECT * FROM TRAINEE3;

-- ���������� ����Ͽ� ���̺� ���� ���� - ���� ���̺��� �̿��Ͽ� ���ο� ���̺� ���� -> �� ���� ���� // �������� ���� �Ұ�
-- ���������� �˻���� => Ÿ�����̺� ���� // �˻��� ���� Ÿ�����̺��� ������ ����ó��
-- Ÿ�����̺��� �÷��� ���氡�� -> BUT �ڷ��� & ũ�� ���� �Ұ�
-- �������̺��� ���������� ������� ����

-- EMP ���̺� ����� ��� ����� ��� ������ �˻��Ͽ� EMP_COPY ���̺� ���� - �˻��� ����ó��
CREATE TABLE EMP_COPY AS SELECT * FROM EMP;

-- EMP ���̺�� EMP_COPY ���̺��� ���� �� -> �������̺� �Ӽ� = Ÿ�����̺� �Ӽ�
DESC EMP;
DESC EMP_COPY;

-- ����, Ÿ�� ���̺��� �������� �� (�������� ����X)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP_COPY';  --�������. ���������� COPY ���� ����.

-- ����, ī�� ��� (�� ����O)
SELECT * FROM EMP;
SELECT * FROM EMP_COPY;

-- EMP ���̺� ����� ��� ����� �����ȣ, ����̸�, �޿��� �˻��Ͽ� EMP_COPY2 ���̺��� �����ϰ� �˻����� ����ó�� ��.
CREATE TABLE EMP_COPY2 AS SELECT EMPNO,ENAME,SAL FROM EMP;
DESC EMP_COPY2;  --3�� �÷��� ���� ��
SELECT * FROM EMP_COPY2;

--EMP ���̺��� �޿��� 2000�̻��� ����� �����ȣ, �̸�, �޿� �˻� -> EMP_COPY3 ����
CREATE TABLE EMP_COPY3 AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;
DESC EMP_COPY3;  
SELECT * FROM EMP_COPY3;

-- EMP_COPY4 ���̺��� EMP_COPY3�� ���� ������ �����ϰ� �÷��� �����ϱ�. -> NO, NAME, PAY
CREATE TABLE EMP_COPY4(NO,NAME,PAY) AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;
DESC EMP_COPY4;  
SELECT * FROM EMP_COPY4;

--������ ���� Ÿ���� �࿡ ����ó������ �ʵ���
CREATE TABLE EMP_COPY5 AS SELECT * FROM EMP WHERE 0=1; --���ǽ��� ������ ���� -> �� �̰˻� -> ������ ����� 
DESC EMP_COPY5;  
SELECT * FROM EMP_COPY5;


--���̺� ���� = DROP (AUTO COMMIT �ǹǷ� ���� �Ұ�)

--���̺��� Ȯ�� - USER_TABLES ��ųʸ� �̿�
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME LIKE 'USER%';
SELECT * FROM TAB WHERE TNAME LIKE 'USER%';

DROP TABLE USER1;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME LIKE 'USER%';

--USER_TABLES ��ųʸ� ��� TAB �並 �̿��Ͽ� ���̺� ��� �˻� ����
--����Ŭ�� ��� ���̺� ������ �ٷ� �����ϴ°��� �ƴ϶� �������̶�� ���� ���̺�� �̵���(���� ����) => ��, ORACLE�� ��쿡�� DROP �� ���̺� ���� ����
-- BIN~~~���̺��� �ٷ� ������ ���̺�
SHOW RECYCLEBIN;
--FLASHBACK ~ TO BEFORE DROP��ɾ� ���� ���� ���̺� ����
FLASHBACK TABLE USER1 TO BEFORE DROP;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';
SELECT * FROM USER1;

--TABLE USER2 ���� 
--����Ŭ �����뿡�� ���̺� �Ӹ� �ƴ϶� �ε��� ��ü�� ���� ������
DROP TABLE USER2;
SHOW RECYCLEBIN;

--USER2 ���̺� ���� -> ���Ӱ����� �ε��� ��ü�� ����
FLASHBACK TABLE USER2 TO BEFORE DROP;
SHOW RECYCLEBIN;

--����Ŭ �������� ���̺� ���� - ���̺� ���ӵ� �ε��� ��ü�� ���� ���� ó��
--����) PURGE TABLE ���̺�� 
DROP TABLE USER4;
PURGE TABLE USER4;--������ ����
SHOW RECYCLEBIN;

--MGR1 ���̺� ����
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'MGR%';
DROP TABLE MGR1;
SHOW RECYCLEBIN;
PURGE RECYCLEBIN; --������ ��ü ����

SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='MGR%';

--���̺� �ʱ�ȭ : ���̺��� ���� ������ ���·� �ʱ�ȭ ó���ϴ� ��� - ���̺� ����� ��� �� ���� ó��
-- TRUNCATE TABLE-> ���̺� ������ ������ ������ �ƴ� ���� ó�� ���·� �ѹ��ϴ°�. 
DELETE FROM BONUS; --���� ���̺��� �� ����X (Ʈ����ǿ� ����� ������ ��.)
SELECT* FROM BONUS;
ROLLBACK;

TRUNCATE TABLE BONUS;  -- DDL�̹Ƿ� AUTO COMMIT�� -> ���� �Ұ� (�����뿡�� ����X)
SELECT * FROM BONUS;

SHOW RECYCLEBIN;

--���̺� �̸� ���� : RENAME
RENAME BONUS TO COMM;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME IN ('BONUS','COMM'); --COMM�� ������.

--���̺��� �Ӽ� �� �������� ����
--����)ALTER TALBE ���̺�� ����ɼ�(�Ӽ�OR��������)
DROP TABLE USER1;
CREATE TABLE USER1(NO NUMBER(4), NAME VARCHAR2(20), PHONE VARCHAR2(15));
DESC USER1;

INSERT INTO USER1 VALUES(1000,'ȫ�浿','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--�Ӽ� �߰�
ALTER TABLE USER1 ADD (ADDRESS VARCHAR2(100));
DESC USER1;
SELECT * FROM USER1;
UPDATE USER1 SET ADDRESS='����� ������' WHERE NO=1000;
--> BUT �������� ���� ���̺� �÷� �߰���, �ش� �÷��� �ڷḦ �ϳ��ϳ� �Է��ؾ� �ϹǷ� �� ����X
--> ���� �� ���̺��� ����� MERGE? JOIN? ��Ű�� ���� ����.
COMMIT;

TRUNCATE TABLE USER1;
--�ڷ��� / ũ�� ���� : MODIFY : �⺻�� �� �÷� ������ �������� ���� ����
ALTER TABLE USER1 MODIFY (NO VARCHAR2(4));

DESC USER1;
INSERT INTO USER1 VALUES('1000','ȫ�浿','010-1234-5678','����� ������');
COMMIT;

SELECT* FROM USER1;
--NO�� �Ӽ��� ������ -> ���������� ���� : �Ұ���! (�̹� ������ִ� �÷����� �ִ� ��� �÷����� ũ�⺸�� ���� �÷��� ũ��δ� ������ �Ұ���.)
ALTER TABLE USER1 MODIFY(NO NUMBER(5));  -- ���� �߻�

--���̺� �Ӽ��� �÷��� ���� (������ ���� ���X)
DESC USER1;
ALTER TABLE USER1 RENAME COLUMN ADDRESS TO ADDR;

--�Ӽ� ���� : ���̺� �Ӽ��� ����� �÷��� ����
ALTER TABLE USER1 DROP COLUMN PHONE;
DESC USER1;

--�������� �߰� : NAME �÷��� NOT NULL �������� �߰�
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME ='USER1';
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10) CONSTRAINT USER1_NAME_NN NOT NULL);
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--���̺� ���� �������� : ADD �ɼ� ����Ͽ� �߰�
--EX) NO �÷��� PK �������� �߰�
ALTER TABLE USER1 ADD CONSTRAINT USER1_NO_PK PRIMARY KEY(NO);
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--�������� ����
ALTER TABLE USER1 DROP CONSTRAINT USER1_NAME_NN;
ALTER TABLE USER1 DROP PRIMARY KEY;

--��(VIEW) : ���̺��� ������� ��������� ������ ���̺� - �ܼ���� ���պ�� ����
--��� ���̺��� ��˻� �Ǵ� ���̺��� ���� ������ �����ϰ� �����ϱ� ���� ����
--�ܼ��� : �ϳ��� ���̺��� ������� �����Ǵ� �� - �並 �̿��� ���̺��� �˻��Ӹ� �ƴ϶� ���̺��� �� ����,����,���� ����
--�ܼ��� ������ �׷��Լ� �Ǵ� DISTINCT Ű���带 ����� ��� �˻��� ����
--���պ� : �������� ���̺��� ������� ������ �� - ���̺��� ���� �����Ͽ� ������ �� - �˻��� ����

--�� ���� -> �������� �̿� (����� ���������� �̿��� CREATE  TABLE �ѰͰ� ������)
-- 1. CREATE OR REPLACE : ������ �̸��� �䰡 �ִ� ��� ���� �並 �����ϰ� ���ο� �䰡 ������
-- 2. FORCE : ���������� �˻������ ��� ������ �並 �����ϱ� ���� ����� ������
-- 3. WITH CHECK OPTION : �並 ������ ���������� ���ǽĿ��� ���� �÷����� �������� ���ϵ��� �����ϴ� ��� ����
-- 4. WITH READ ONLY : �˻��� �����ϵ��� ����

-- EMP_COPY ���̺�ο��� �μ���ȣ�� 30�� �����ȣ, �̸�, �μ���ȣ �˻� -> EMP_VIEW30 ����
SELECT * FROM EMP_COPY;
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO=30; -- ���� ����� ERROR (������� ���� �Ǹ��� �����ڿ��Ը� ���� -> ���� �Ϲݻ���ڴ� ��� X)
--> ���� �ο����� : GRANT CREATE VIEW TO SCOTT; -> ������(SYS)�������� �����Ͽ� ���� �ο� 
--GRANT CREATE VIEW TO SCOTT;
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO=30; -- ���� ����� ERROR (������� ���� �Ǹ��� �����ڿ��Ը� ���� -> ���� �Ϲݻ���ڴ� ��� X)

--�ܼ���� ����, ����, ���� ����
INSERT INTO EMP_VIEW30 VALUES(1111,'ȫ�浿',30);
SELECT* FROM EMP_VIEW30;
SELECT* FROM EMP_COPY;

--EMP_VIEW10 ����
CREATE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO; -- ���պ�
SELECT* FROM emp_view10;

--���� �̸����� ������ ���� �߻�
CREATE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO; -- ���պ�
--CREATE OR REPLACE ��ɾ� ��� : ���� �� ���� -> ���ο� VIEW ����
CREATE OR REPLACE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO; -- ���պ�
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

--�並 �������� �ʰ� SELECT ����� ���������� ����Ͽ� �ζ��� �並 �����Ͽ� ���
SELECT * FROM (SELECT EMPNO,ENAME, SAL, DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO);
--> �ζ��κ��ǰ�� CREATE VIEW ������ �ʿ� X

-- �� ���� : DROP
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;
DROP VIEW EMP_VIEW30;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--������(SEQUENCE) : ���ڰ�(������)�� ���� -> �ڵ� �����Ǵ� ���� �����ϴ� ��ü - ���̺� �÷��� ������ ����
--> 1. ���� : CREATE SEQUENCE
--> 2. START WITH �ʱⰪ : �������� ����� �ʱⰪ ���� (������ NULL)
--> 3. INCREMENT BY ������ : �ڵ� �����Ǵ� ���ڰ� ���� ->  ���� : 1
--> 4. MAXVALUE : ���� ���� �ִ� - ���� : ����Ŭ���� ���ڰ����� ǥ�� ������ �ִ�
--> 5. MINVALUE : ���� ���� �ּڰ� - ���� : 1
--> 6. CYCLE : �������� ����� ���� �ִ��� �ʰ��� ��� �ּҰ����� �ٽ� �����ǵ��� �ݺ���� ����
--> 7. CACHE ���� : ������ ��������� �ڵ� �������� �̸� �����Ͽ� ����� �� �ִ� ���� ���� - ���� : 20
SELECT* FROM TAB;
DROP TABLE USER2;
CREATE TABLE USER2 (NO NUMBER(2) CONSTRAINT USER_NO_PK PRIMARY KEY, NAME VARCHAR2(20),BIRTHDAT DATE);
DESC USER2;




--������ ����
CREATE SEQUENCE USER2_SEQ;
--Ȯ��
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--�������� ����� ���ڰ� Ȯ��
--����) ��������.CURRVAL : ���簪 // NEXTVAL : 1����
SELECT USER2_SEQ.CURRVAL FROM DUAL; -- �������� NULL���� ������ִ� ��� ERROR

--�������� ����� ���ڰ��� �̿��Ͽ� ������ ���� �����ϴ� ��� - ������ �� ������ �������� ������ ������ �ڵ� ����
--�������� NULL�� ����Ǿ� �ִ� ��� �������� �ּҰ��� ������ �� �������� ���尪 ���� ó��

SELECT * FROM USER2;
SELECT USER2_SEQ.NEXTVAL FROM DUAL;
SELECT USER2_SEQ.CURRVAL FROM DUAL;
SELECT USER2_SEQ.NEXTVAL FROM DUAL;
SELECT USER2_SEQ.CURRVAL FROM DUAL;

SHOW RECYCLEBIN;
DROP TABLE USER3;
DROP TABLE USER4;
PURGE RECYCLEBIN;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';

INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'ȫ�浿','00/01/01');
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'�Ӳ���','00/12/31');
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'����ġ',SYSDATE);

SELECT* FROM USER2;
COMMIT;

--������ ����
SELECT* FROM USER2;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;
ALTER SEQUENCE USER2_SEQ MAXVALUE 99 INCREMENT BY 5;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

SELECT USER2_SEQ.CURRVAL FROM DUAL; -- ��� 5
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'������','03/09/09');
--INCREMENT_BY�� �������� 5�� �ٲپ����Ƿ� NO = 10 / SEQ.CURRVAL = 10
SELECT * FROM USER2;
SELECT USER2_SEQ.CURRVAL FROM DUAL;--�˻���� : 10
COMMIT;
