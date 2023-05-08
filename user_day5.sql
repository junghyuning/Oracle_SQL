-- DDL / CONSTRAINTS - CHECK, UNIQUE, PK
select * from emp;
delete from emp; -- ���� ���̺� ����Ǵ°��� �ƴ϶� Ʈ�����ǿ� ���� ����ϴ°�.
select *from emp;
--rollback ���� �������� db�� �����ϴ� ���� �ƴ϶�, Ʈ�����ǿ� ����� delete�� �����ϰ� ���� commit �������� ���� ���°�.
rollback;
select * from emp;

-- ���� ���ǿ��� �۾����� ���̺��� ���� Ŀ��ó�� ������ �ٸ� ���ǿ��� �˻��ǵ��� Ʈ������� ��� -> ������ �ϰ���.
select * from bonus;
delete from bonus where ename ='KIM';
select * from bonus;
--if oracle developer ���� scott ������ �������ε� ���ÿ� sql plus ������ scott ������ �����ߴٸ�? => ���� �ٸ� ���ǿ��� �۾����ΰ�.
--> delete�� oracle developer�� select�������� �ݿ��� ��, sql plus���� �ݿ����� ����
--> ��, Ʈ����� ��� ���� : ������ ���Ἲ ���̺� ���������� ���� �������� �ʾ� �������� �˻���� �����ϱ� ����

COMMIT;

SELECT * FROM BONUS;
UPDATE BONUS SET SAL=2000 WHERE ENAME='ALLEN'; -- ���̺� �࿡ ���� ����Ÿ ��ݱ��.
-- ���� COMMIT ���� �ʾ����Ƿ� �����ͺ��̽��� ������ �ݿ������� �ʾ�����, �ش� ���̺� �࿡ ���� ��ݱ���� Ȱ��ȭ ��
--SQL> UPDATE BONUS SET COMM=SAL*0.5 WHERE ENAME='ALLEN';
--> �ش� ����� �ٸ� ���ǿ��� �����Ͽ� ������ ���, TRANSACTION�� ���� ���߿� ���ٵ� ������ �Ͻ� �����ǰ� �����͸� ������ �� ����.
--> IF ������ �ٽ� ���� ��ϱ� ���ؼ��� ���� �۾����� ���ǿ��� �ش� ���̺� ���� �۾��� COMMIT OR ROLLBACK ó���� ��� ���� ����.
SELECT * FROM BONUS;
COMMIT; 
--> COMMIT ���ڸ��� �Ͻ��������ִ� Ŀ�ǵ� â���� ������Ʈ ǥ�ð� �Ϸ� ��.
--> ��ó��, �߸� ����� Ʈ������� �������°� �߻��� �� �����Ƿ� �����Ұ�.

--SAVEPOINT : Ʈ����ǿ� ��(��ġ����)�� �ο��ϴ� ��� >> SAVEPOINT �󺧸�;
--> Ʈ����ǿ� ����� DML ����� �̿��Ͽ� ���ϴ� ��ġ�� DML ��ɸ� �ѹ� ó���ϱ� ���� �����.
--1. �˷� ���� ����
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--2.MARTINE ���� ����
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

ROLLBACK;  --> Ʈ����� ������ DML����� ��� �����
SELECT* FROM BONUS;

--3.SAVEPOINT ��� ��, 
DELETE FROM BONUS WHERE ENAME='ALLEN';
SAVEPOINT ALLEN_DELETE_AFTER;
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

ROLLBACK TO ALLEN_DELETE_AFTER;  -- SAVEPOINT�� ROLLBACK ��. => �˷��� ������ ���·� �ѹ��.
-- BUT �׷��ٰ��ؼ� �˷��� ���������� DB�� �ݿ��Ȱ��� �ƴ�. �ܼ��� Ʈ����� ���� SAVEPOINT�� �����ϴ� ��.
SELECT * FROM BONUS;

--DDL(DATA DEFINITION LANGUAGE) : ����Ÿ ���Ǿ�
--����Ÿ���̽��� ��ü(���̺�, VIEW, ������, �ε���, ���Ǿ�, ����� ��)�� �����ϱ� ���� SQL ���

--���̺�(TABLE) : �����ͺ��̽����� �����͸� �����ϱ� ���� ���� �⺻���� ��ü.

--  TABLE ���� : ���̺� �Ӽ� (ATTRIBUTE)�� ����.
 
 
 --�ĺ��� ���� ��Ģ : ���̺��, �÷���, ��Ī, �󺧸� ��
 -- 1. �����ڷ� ���� -> 1~30������ ���ڵ�� ����
 -- 2. A~Z,0~9,$,# ���ڵ��� �����Ͽ� �ۼ� -> ��ҹ��� �̱��� : ������ũ ǥ��� (��ҹ��� �̱���)
 -- 3. ������ �� ���� ��� ���� BUT �����
 -- 4. Ű����� �ĺ��ڸ� ������ ��� ���� �߻� -> " " �ȿ� ǥ����, ���� BUT �����.
 
 -- �ڷ���(DATATYPE) : �÷��� ���� ������ ���� ���¸� ǥ���ϱ� ���� Ű����
 -- 1. ������
 -- 2. �ڷ��� : CHAR(10) - ũ�� : 1~2000(BYTE) >> �������� 
--             VARCHAR(ũ��) : 1~4000(BYTE) >> ��������
--             LONG : �ִ� 2GB���� ���� ���� >> �������� - ���̺� �ϳ��� �÷����� ���� ���� & ���� �Ұ� 
-- TABLE�� ������ �����ϴ°��� �ʹ� ū ���ҽ��� �����ϹǷ� ���̺� ������ �����ϴ� ���� ���� X 
--             CLOB : �ִ� 4GB ���� ���� >> �������� - �ؽ�Ʈ ������ (���̺�)�����ϱ� ���� �ڷ���
--             BLOB : �ִ� 4GB ���� ���� >> �������� - ���� ������ (���̺�)�����ϱ� ���� �ڷ���
-- 3. ��¥�� : DATE - ��¥�� �ð�
--            TIMESTAMP - ��(MS)���� �ð�.

--SALESMAN ���̺� ���� - �����ȣ(������), ����̸�(������), �Ի���(��¥��)
CREATE TABLE SALESMAN (NO NUMBER(4), NAME VARCHAR2(20),STARTDATE DATE);

--Ʃ���� ������, ���̺��� �����Ȱ��� Ȯ���� ��.
--USER_DICTIOINARY(�Ϲݻ����), DBA_DICTIONARY(������), ALL_DICTIONARY(��� �����)

--USER_OBJECTS : ���� ���� ������� ��Ű���� ���� ������ ��ü ������ �����ϴ� ��ųʸ�
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

SELECT TABLE_NAME FROM USER_TABLES;

SELECT TABLE_NAME FROM TABS;

DESC SALESMAN;

INSERT INTO SALESMAN VALUES(1000,'ȫ�浿','00/04/08');
COMMIT;

--SALESMAN ���̺� �� ���� - �÷��� �����Ͽ� ����ó���� ���, ������ �÷����� �⺻���� ���޵Ǿ� ����
--���̺� ������ �÷� �⺻���� �������� ���� ��� �ڵ����� NULL�� �⺻������ �ڵ� ����
INSERT INTO SALESMAN(NO,NAME) VALUES(2000,'�Ӳ���');
--DAY4������ �����Ҷ�, NOTNULL�� �ƴѰ��� ������ �Է����� �ʾƵ� ���������Ͱ����� ��..? 
--> (NO, NAME) ���� � �࿡ ����� ������ �� ���������Ƿ� �ۼ����� ���� ������ �⺻�� ������.
SELECT * FROM SALESMAN;
COMMIT;
--���̺� ������ ���������� �������� ���� ��� �÷��� ��� ���� �����ص� ���� ó�� - ����Ÿ ���Ἲ ���� ���� 
INSERT INTO SALESMAN VALUES(1000,'����ġ','10/10/10');
SELECT *FROM SALESMAN;
COMMIT;

--MANAGER TALBLE ���� : �����ȣ(������), ����̸�(����), �Ի���(��¥��- �⺻�� : ����), �޿�(������ - �⺻�� : 1000)
--BUT ��κ��� ��� �÷� �⺻���� �������� �ʰ� NULL�� �⺻������ ���.
CREATE TABLE MANAGER (NO NUMBER(4), NAME VARCHAR2(20),STARTDATE DATE DEFAULT SYSDATE,PAY NUMBER DEFAULT 1000);
--���̺� ���
SELECT TABLE_NAME FROM USER_TABLES;
--DESCRIBE : ���̺��� ���� ����
DESC MANAGER;

--USER_TAB_COLUMNS : ���̺��� �÷� ������ �����ϴ� ��ųʸ�
SELECT COLUMN_NAME, DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'MANAGER';

INSERT INTO MANAGER VALUES (1000,'ȫ�浿','00/05/09',3000);
SELECT * FROM MANAGER;
INSERT INTO MANAGER(NO,NAME) VALUES(2000,'�Ӳ���');

--DEFAULT Ű���� ����Ͽ� ����ó��
INSERT INTO MANAGER VALUES(3000,'����ġ',DEFAULT,DEFAULT);
SELECT * FROM MANAGER;
COMMIT;

--��������(CONSTRAINT) : �÷��� ���������� ���� ����Ǵ� ���� �����ϱ� ���� ��� - ������ ���Ἲ ����
--�÷� ������ �������� : ���̺��� �Ӽ� ���� �� �÷��� ���������� ����
--���̺� ������ �������� : ���̺� ����� ���̺��� Ư�� �÷��� ���������� ������

--�÷������� ��������
--CHECK : �÷������� ���� ������ ������ �����Ͽ� ������ ���� ��쿡�� �÷������� ����ǵ��� ������
-->�÷����� OR ���̺� ���� ������������ ���� ����

--SAWON1 ���̺� ���� : �����ȣ, ����̸�, �޿�
CREATE TABLE SAWON1 (NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER);

INSERT INTO SAWON1 VALUES(1000,'ȫ�浿', 8000000);
INSERT INTO SAWON1 VALUES(2000, '�Ӳ���',800000);
SELECT * FROM SAWON1;
COMMIT;

--SAWON2 ���̺� : CHECK �������� WITHOUT �������Ǹ�
CREATE TABLE SAWON2(NO NUMBER(4), NAME VARCHAR2(20), PAY NUMBER);
ALTER TABLE SAWON2 MODIFY PAY NUMBER CHECK(PAY>=5000000);
DESC SAWON2;

INSERT INTO SAWON2 VALUES(1000,'ȫ�浿',8000000);
INSERT INTO SAWON2 VALUES(2000,'�Ӳ���',800000);  --CHECK �������� ���� -> ���� �ȵ�.
SELECT * FROM SAWON2;
COMMIT;
--���������� Ȯ�� : USER_CONSTRAINTS  
-- 1. CONSTRAT_NAME : ���������� �̸� -> �̸��� �������� ������, SYS_XXXXXXX(7�ڸ�)�� �������� ���� ��. 
--> BUT ���������� �������� �̸� �����ϴ°��� �����ϹǷ� �������Ǹ� ������ ������
-- CONSTRAINT_TYPE : ���������� ���� - C(CHECK), U(UNIQUE),P(PRIMARY KEY),R(REFERENCE - FOREIGN KEY)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON2';

--SAWON3 ���̺� ���� : �������Ǹ� �ο�
CREATE TABLE SAWON3 (NO NUMBER(4), NAME VARCHAR2(20), PAY NUMBER CONSTRAINT SAWON3_PAY_CHECK CHECK(PAY>=5000000));

SELECT TABLE_NAME FROM USER_TABLES;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'SAWON3';


--���̺������ �������� �����ϱ�
--��� 4 ���̺� -> �޿� : �ּұ޿� 5000000
CREATE TABLE SAWON4 (NO NUMBER(4), NAME VARCHAR2(20), PAY NUMBER, CONSTRAINT SAWON4_PAY_CHECK CHECK(PAY>=5000000));
--> �÷����� �������� VS ���̺� ���� �������� : �ش� �÷��� �̿��� ���ǽ� ���� ����  -->  CHECK(NAME IS NOT NULL AND CHECK(PAY>=5000000)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'SAWON4';

--NOT NULL : NULL�� ������� �ʴ� �������� : �÷��� �ݵ�� ���� ����ž� ��. -> �÷����� ��������


--DEPT1 ���̺� ���� : �μ���ȣ(������),�μ��̸�(������),�μ���ġ(������)
CREATE TABLE DEPT1(DEPTNO NUMBER(2), DNAME VARCHAR2(12), LOC VARCHAR2(11));

INSERT INTO DEPT1 VALUES(10,'�ѹ���','�����');
INSERT INTO DEPT1 VALUES(20,NULL,NULL); --����� NULL
INSERT INTO DEPT1(DEPTNO) VALUES(30); -- ������ NULL
SELECT * FROM DEPT1;
COMMIT;

--DEPT2 ���̺� : �μ���ȣ, �̸�, �μ���ġ => ��ο� NOT NULL ��������

CREATE TABLE DEPT2 (DEPTNO NUMBER(4) CONSTRAINT DEPT2_DEPTNO_NN NOT NULL, 
DNAME VARCHAR2(12)CONSTRAINT DEPT2_DNAME_NN NOT NULL, 
LOC VARCHAR2(11) CONSTRAINT DEPT2_LOC_NN NOT NULL );

INSERT INTO DEPT2 VALUES(10,'�ѹ���','�����');
INSERT INTO DEPT2 VALUES(20,NULL,NULL); --NOT NULL �������� ����
INSERT INTO DEPT2(DEPTNO) VALUES(30); -- NOT NULL �������� ����
SELECT * FROM DEPT2;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'DEPT2';

--UNIQUE : �ߺ� �÷��� ���� --> [�÷����� | ���̺� ����]�� ��������
--> ���̺� ������ ���� ���� + NULL ���

--USER1 ���̺� ���� - ID(������), �̸�(������), ��ȭ��ȣ(������)
CREATE TABLE USER1 (ID VARCHAR2(20), NAME VARCHAR2(30), PHONE VARCHAR2(15));

--USER1 ���̺� �� ����
INSERT INTO USER1 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER1 VALUES('ABC','ȫ�浿','010-1234-5678'); --BUT �ϳ��� ���̺��� �������� �����ؼ��� �ȵ�.
SELECT * FROM USER1;
COMMIT;

--USER2 ���̺� ���� : ID, ��ȭ��ȣ - ����ũ �������� (�÷� ������ ��������)
CREATE TABLE USER2 (ID VARCHAR2(20) CONSTRAINT ID_UNIQUE UNIQUE, NAME VARCHAR2(30), PHONE VARCHAR2(15)CONSTRAINT PHONE_UNIQUE UNIQUE);
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER2';

INSERT INTO USER2 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER2 VALUES('ABC','ȫ�浿','010-1234-5678'); --ERROR
INSERT INTO USER2 VALUES('ABC','�Ӳ���','010-7890-1234'); --ERROR
INSERT INTO USER2 VALUES('XYZ','�Ӳ���','010-1234-5678'); --ERROR
INSERT INTO USER2 VALUES('XYZ','�Ӳ���','010-7890-1234'); -- ID �� PHONE�� ��� ������ ��쿡�� �� ���� ����
SELECT * FROM USER2;
COMMIT;

--UNIQUE ���������� ������ �÷��� NULL�� �����Ͽ� ���԰���. (UNIQUE!=PK)
INSERT INTO USER2 VALUES('OPQ','����ġ',NULL);
--NULL�� ���� �ƴϹǷ� UNIQUE ���������� �������� �ʴ� ������ ó��
INSERT INTO USER2 VALUES('IJK','������',NULL);
SELECT * FROM USER2;
COMMIT;

--���̺� ������ ������������ ����� ��.
CREATE TABLE USER3 (ID VARCHAR2(20), NAME VARCHAR2(30), PHONE VARCHAR2(15),
CONSTRAINT USER3_ID_UK UNIQUE(ID),CONSTRAINT USER3_PHONE_UK UNIQUE(PHONE));
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';

INSERT INTO USER3 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER3 VALUES('ABC','ȫ�浿','010-1234-5678'); --ERROR
INSERT INTO USER3 VALUES('ABC','�Ӳ���','010-7890-1234'); --ERROR
INSERT INTO USER3 VALUES('XYZ','�Ӳ���','010-1234-5678'); --ERROR

SELECT * FROM USER3;
COMMIT;

--USER4 ���̺� ���� - ���̵�(������),�̸�(������),��ȭ��ȣ(������) 
--���̵�� ��ȭ��ȣ�� ��� UNIQUE �������� ���� - ���̺� ������ �����������θ� ���� ����
CREATE TABLE USER4(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15)
    ,CONSTRAINT USER4_ID_PHONE_UK UNIQUE(ID,PHONE));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER4';

--USER4 ���̺� �� ����
INSERT INTO USER4 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER4 VALUES('ABC','ȫ�浿','010-1234-5678');--UNIQUE ���������� �����Ͽ� ���� �߻� : ���̵�� ��ȭ��ȣ �ߺ�
INSERT INTO USER4 VALUES('ABC','�Ӳ���','010-7890-1234');
INSERT INTO USER4 VALUES('XYZ','�Ӳ���','010-1234-5678');
SELECT * FROM USER4;
COMMIT;

--PRIMARY KEY(PK) : �ߺ� �÷��� ������ �����ϱ� ���� ��������
--�÷� ������ �������� �Ǵ� ���̺� ������ �������� ���� ����
--PRIMARY KEY ���������� ���̺� �ѹ��� ���� �����ϸ� NULL �����
--PRIMARY KEY ���������� ���̺� �ѹ��� ���� �����ϹǷ� ���������� �̸� ���� ���� ����
--PRIMARY KEY ���������� ���̺��� ���踦 ��üȭ�ϱ� ���� �ݵ�� ����

--MGR1 ���̺� ���� - �����ȣ(������-PRIMARY KEY),����̸�(������),�Ի���(������) - �÷� ������ ��������
CREATE TABLE MGR1(NO NUMBER(4) CONSTRAINT MGR1_NO_PK PRIMARY KEY,NAME VARCHAR2(20),STARTDATE DATE);
DESC MGR1;

--�������� Ȯ��--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR3';

--MGR3 ���̺� �� ����
INSERT INTO MGR3 VALUES(1000,'ȫ�浿',SYSDATE);
INSERT INTO MGR3 VALUES(1000,'�Ӳ���',SYSDATE);
INSERT INTO MGR3 VALUES(2000,'�Ӳ���',SYSDATE);
INSERT INTO MGR3 VALUES(1000,'ȫ�浿',SYSDATE);--PRIMARY KEY ���������� �����Ͽ� ���� �߻� - �����ȣ�� �̸� �ߺ� 
SELECT * FROM MGR3;
COMMIT;