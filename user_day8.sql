-- CASE / FOR LOOP / PROCEDURE - MODE / TRIGGER 

--CASE�� : ������ ����� ���� ���Ͽ� ����� ���� �����ϰų� ���ǽ��� ����Ͽ� ����� ���� �����ϴ� ����
--> CASE ������ WHEN �񱳰�1 THEN ���; ...WHEN �񱳰�2 THEN ���; ... END CASE;

--EMP���̺��� �����ȣ�� 7788�� ����� ���� ����ϴ� PL/SQL �ۼ�
-- ������ �޿� �����޾� - ANALYST: �޿� * 1.1, CLERK : �޿� * 1.2, MANAGER : �޿� * 1.3, PRESIDENT : �޿� * 1.4, SALESMAN : �޿� * 1.5

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
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = '||VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('������ �Ǳ޿� = '||VPAY);

END;
/
        
--EMP ���̺��� �����ȣ�� 7788�� ��� ���� ����Ͽ� ����ϴ� SQL
-- �޿� ��� : E:0~1000 / D:1001~2000 / C: 2001~300 / ...

DECLARE
    /* ���ڵ� ���� */
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
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('��� = '||VGRADE);   
END;
/
    
--�ݺ��� : ����� �ݺ� �����ϱ� ���� ����

--BASIC LOOP : ���ѹݺ� - ���ù��� ����Ͽ� ���ǽ��� ���� ��� EXIT ������� �ݺ��� ����
--����)LOOP ���; ���; ... END LOOP;

--1~5 ������ ���ڰ��� ����ϴ� PL/SQL �ۼ�
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


--FOR  LOOP : �ݺ��� Ƚ���� ������ �ִ� ��� ����ϴ� �ݺ���
--����)FOR INDEX_COUNTER IN [REVERSE] LOWER_BOUND..HIGH_BOUND LOOP ���; ���; ... END LOOP;

--1~10 ������ �������� ���� �հ踦 ����Ͽ� ����ϴ� PL/SQL �ۼ�
DECLARE
    TOT NUMBER(2) := 0;
    
BEGIN
/*FOR LOOP �������� ���Ǵ� COUNTER_INDEX�� FOR LOOP ���� �������� ��� ����. */
    FOR I IN 1 .. 10 LOOP
        TOT := TOT+I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~10 ���� ������ �հ� ='||TOT);
END;
/

--FOR LOOP ���� >> ���� �˻��࿡���� �ݺ�ó���� ������. -> ������ Ŀ���� ����Ͽ� �ݺ��� ó����

--EMP ���̺� ����� ��� ��������� �˻��Ͽ� ��ȣ, �̸��� ����ϴ� PL/SQL��

BEGIN 
    FOR VEMP IN (SELECT*FROM EMP) LOOP
        DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO||', ����̸� = '||VEMP.ENAME);
    END LOOP;
END;
/

--Ŀ��(CURSOR):  ���̺��� �˻����� ���� & ó���ϱ����� ����� ������.
-- 1. ������ Ŀ�� : �˻������ �������� ��츦 ó���ϴ� ���� Ŀ��
-->> �������� ��� Ŀ���� ���� �������� �ʾƵ� ��.

-- 2. ����� Ŀ�� : �˻������ �������� ��츦 ó���ϴ� Ŀ�� >> "Ŀ���� ����"�ؾ� ��.
--����) DECLARE
     /* Ŀ�� ���� */
--    CURSOR Ŀ���� IS SELECT �˻����, �˻����, ... FROM ���̺�� [WHERE ���ǽ�];
--    BEGIN
--        OPEN Ŀ����; /*Ŀ�� ���� : ù �˻����� �����ޱ����� Ŀ���� ��ġ�� �̵���*/
--        FETCH Ŀ���� INTO ������1, 2, ... /* Ŀ�� ��ġ�� �˻����� �����޾� ������ ���� -> ���� ��, Ŀ���� ���������� �̵� */
--        CLOSE Ŀ����;/* Ŀ�� �ݱ� - Ŀ���� ���̻� ������� �ʵ��� ���� */
--    END;
DECLARE 
    CURSOR C IS SELECT * FROM EMP;
    VEMP EMP%ROWTYPE;
BEGIN
    OPEN C;
    
    LOOP
        FETCH C INTO VEMP; /*Ŀ����ġ�� �˻����� VEMP�� �����ϰ� �ٸ� ��ġ�� �̵�*/
        EXIT WHEN C%NOTFOUND; /* Ŀ�� ��ġ�� �˻����� ���� ��� �ݺ��� ����*/
    END LOOP;
    
    CLOSE C;
END;
/

-- WHILE LOOP :�ݺ��� Ƚ���� ����Ȯ�� ��� ����ϴ� �ݺ���

DECLARE
    I NUMBER(2) := 1;
    TOT NUMBER(2) := 0;
BEGIN 
    WHILE I <= 10 LOOP
    TOT := TOT +I;
    I:= I+1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~10 ������ �������� �հ�'||TOT);
END;
/

--���� ���ν���(STORED PROCEDUER) : PL/SQL ���ν����� �̸��� �ο��Ͽ� ���� -> �ʿ��� ��� �ش� �̸����� ȣ���Ͽ� ����� >> �޼���� ������ ����
--> CREATE [OR REPLACE] PROCEDURE ���ν�����[(�Ű����� [MODE] �ڷ���, �Ű����� [MODE] �ڷ���,...)]
--      IS [��������] BEGIN ���; ���; ... END;

--EMP_COPY ���̺� ����� ��� ��� ������ �����ϴ� ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE DELETE_ALL_EMP_COPY IS /* ���ڸ��� ���� ���� ����. BUT ������ �ʿ� ������, ����*/
BEGIN
    DELETE FROM EMP_COPY;
    COMMIT;
END;
/
-- ���� ���ν��� Ȯ�� : USER_SOURCE: ���� ���ν��� �� ���� �Լ� ���� �����ϴ� ��ųʸ�
--CF) ���ν��� VS �Լ�
--���ν��� : �Ϸ��� ������ ��ġ �ϳ��� �Լ�ó�� �����ϱ� ���� ������ �����̸�, �Ϸ��� �۾��� ������ �����Դϴ�.
--      1.���� �ܵ����� �����ؾ� �� �۾��� ���ӹ޾��� �� ���
--      2.�� ��ȯ �Ұ�
--�Լ� : �ϳ��� Ư���� ������ �۾��� �����ϱ� ���� ���������� ����� �ڵ��� ���� 
--      1. ���� ������ �����ִ� �����̸�, ������ ���, ��ġ ���� ��Ÿ�� �� ���
--      2. �� ��ȯ ����
--      3. �������� �����Ͽ� ����� �� ����. (�Լ��� �ݵ�� 1���� ���� RETRUN�ϹǷ� ����ó�� ��� ������.)
-->>��, �Լ��� ���� �۾��� ���� ����̶�� ���ν����� �۾��� ������ �����Դϴ�.

SELECT NAME, TEXT FROM USER_SOURCE WHERE NAME='DELETE_ALL_EMP_COPY';

--���� ���ν��� ȣ�� - ���� ���ν����� �ۼ��� PL/SQL ����
--����) EXECUTE ���ν�����[({������|��},{������|��},...)]
SELECT * FROM EMP_COPY;
EXECUTE DELETE_ALL_EMP_COPY;
SELECT * FROM EMP_COPY;

--> IF �������ν��� ������ ������ ���� �߻� => ������ �α� Ȯ�� (����Ȯ��)
SHOW ERROR;

SELECT NAME, TEXT FROM USER_SOURCE WHERE NAME='DELETE_ALL_EMP_COPY';

--���� ���ν����� �Ű����� : MODE(���)
--1. IN : ���� ���ν��� ȣ��� �ܺηκ��� ���� ���޹޾� ���� ���ν����� PL/SQL ��ɿ��� ����� ������ �Ű������� ������ �� 
--2. OUT : ���� ���ν��� ȣ��� "���ε� ����"�� ���޹޾� ���� ���ν����� PL/SQL ���� ����� �����Ͽ� �ܺο� ������� ������ �������� �Ű������� ������ �� ���
--> ���ν����� ��� ���� ��ȯ�� �� ���� (CF. �Լ��� ��� ���� ��ȯ ����) >> BUT �ܺη� ���� �����ϰ�ʹٸ�? BINDING ���� ���.
--3. INOUT: ���� ���ν��� ȣ��� ���ε� ������ ���޹޾� ���� ���ν����� PL/SQL ��ɿ��� ����ϰų� ���� ����� �����Ͽ� �ܺο� ������� ������ ������ �Ű������� ������ �� ���.

--"�����ȣ�� �Ű������� ���޹޾� EMP���̺��� �˻� -> �̸�, ����, �޿��� �Ű������� ���� -> �ܺη� ����"�ϴ� ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE SELECT_EMPNO(VEMPNO IN EMP.EMPNO%TYPE, VENAME OUT EMP.ENAME%TYPE, VJOB OUT EMP.JOB%TYPE, VSAL OUT EMP.SAL%TYPE) IS
BEGIN
/*���޹��� �Ű����� VEMPNO�� ���� EMP ���̺��� EMPNO�� ���� ������, VENAME,VJOB,VSAL�� ���� �����Ͽ� �ܺο� ����.*/
    SELECT ENAME,JOB,SAL INTO VENAME,VJOB,VSAL FROM EMP WHERE EMPNO=VEMPNO;  
END;
/

--OUT ����� �Ű������� ���� �����޴� ���� �����ϱ����� ���ε� ���� ����
-- ����) VARIABLE ���ε������� �ڷ���
-- ���ε� ���� : "���� ���� ������� ����"����"��" ����� �� �ִ� �ý��� ����
-- ���ν����� ���ν������� ���� ��ȯ�� ����.
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_JOB VARCHAR2(20);
VARIABLE VAR_SAL NUMBER;

--SELECT_EMPNO ���ν��� ȣ�� 
-- OUT ����� �Ű������� ���ε� ������ �����Ͽ� ���� �����ϱ� ���ؼ��� �ݵ�� ���ε� ���� �׿� [:]FMF �ٿ� �����.
-- ����ÿ��� [:] ���� (��½ÿ��� ���X)
EXECUTE SELECT_EMPNO(7788,:VAR_ENAME,:VAR_JOB,:VAR_SAL);

--���ε����� ���尪 ���
PRINT VAR_ENAME;
PRINT VAR_JOB;
PRINT VAR_SAL;


-- �����Լ�(STORE FUNCTION) : ���� ���ν����� ������ ����� ����������, �ݵ�� �ϳ��� ������� ��ȯ��.

--�����Լ� ����
-- CREATE [OR REPLACE] FUNCTION �����Լ���[(�Ű����� [MODE] �ڷ���, �Ű����� [MODE] �ڷ���,...)]
--          RETURN �ڷ��� IS [���������] BEGIN ���1, 2, .. RETURN ��ȯ��; END;

--�����ȣ�� �Ű������� ���޹޾� EMP ���̺��� �ش� ����� �޿��� 2�迡 �ش��ϴ� ������� ��ȯ�ϴ� �����Լ� ����.
CREATE OR REPLACE FUNCTION CAL_SAL(VEMPNO IN EMP.EMPNO%TYPE) RETURN NUMBER IS VSAL NUMBER(7,2);
BEGIN
    SELECT SAL INTO VSAL FROM EMP WHERE EMPNO=VEMPNO;
    RETURN VSAL*2;
END;
/

--�����Լ� Ȯ�� ��ųʸ� : USER_SOURCE 
SELECT NAME, TEXT FROM USER_SOURCE WHERE NAME = 'CAL_SAL';

--�����Լ��� ��ȯ���� �����ϱ� ���� ���ε� �Լ� ����
VARIABLE VAR_SAL NUMBER;

--�����Լ� ȣ�� - ���� �Լ��� ��ȯ���� ���ε� ������ ���� (����ÿ��� [:] ���̱�)
EXECUTE :VAR_SAL := CAL_SAL(7788) --CAL_SAL�Լ� ������ ������� ������.
PRINT VAR_SAL;

--> �����Լ��� ��� SQL ��ɿ� �����Ͽ� ����� �� ����.
SELECT EMPNO,ENAME,SAL,CAL_SAL(EMPNO) "Ư������" FROM EMP;

--�����Լ� ���� : DROP FUNCTION �Լ���
DROP FUNCTION CAL_SAL;
SELECT NAME, TEXT FROM USER_SOURCE WHERE NAME = 'CAL_SAL';

--TRIGGER : Ư�� ���̺��� SQL ���(DML)�� ����� ��� PL/SQL ���ν����� ����� �����ϴ� ���

--Ʈ���� ���� : CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ� {AFTER|BEFORE} {INSERT|UPDATE|DELETE} ON ���̺��
--              [FOR EACH ROW] [WITH ���ǽ�] BEGIN ���1,2, ... END;

--FOR EACH ROW : �����, �෹�� Ʈ���� ���� / ���� -> ���巹�� Ʈ���� ����  
--1. ���巹�� Ʈ���� : �̺�Ʈ DML ����� ����Ǹ� Ʈ���ſ� �ۼ��� PL/SQL ���ν����� ����� �ѹ��� ���� ��.
--2. �෹�� Ʈ���� : �̺�Ʈ DML ����� ����Ǹ� Ʈ���ſ� �ۼ��� PL/SQL ���ν����� ����� ���� ������ŭ ����
--> Ʈ���ſ� ��ϵ� PL/SQL ���ν����� ������� TCL ���(COMMIT, ROLLBACK) ��� �Ұ�

CREATE OR REPLACE TRIGGER EMP_COPY2_INSERT_TRIGGER AFTER INSERT ON EMP_COPY2
BEGIN
    DBMS_OUTPUT.PUT_LINE('���ο� ����� �Ի� �Ͽ����ϴ�.');
END;
/

--Ʈ���� Ȯ�� - USER_TRIGGERS : Ʈ���� ������ �����ϴ� ��ųʸ�
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP_COPY2 ���̺� �� ����
SELECT * FROM EMP_COPY2;
INSERT INTO EMP_COPY2 VALUES(1111,'ȫ�浿',4000);
SELECT * FROM EMP_COPY2;
COMMIT;

--Ʈ���� ����
--����)DROP TRIGGER Ʈ���Ÿ�

--EMP_COPY2_INSERT_TRIGGER Ʈ���� ����
DROP TRIGGER EMP_COPY2_INSERT_TRIGGER;
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ�� �˻��Ͽ� EMP_TRI ���̺��� �����Ͽ� �˻��� ����
CREATE TABLE EMP_TRI AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;
SELECT * FROM EMP_TRI;

--EMP_HIS ���̺� ���� - �����ȣ(������-PRIMARY-KEY), ����̸�(������), �������(������)
CREATE TABLE EMP_HIS(NO NUMBER(4), NAME VARCHAR2(20), STATUS VARCHAR2(50));

--EMP_TRI ���̺��� ���� �����ϰų� ���� OR ������ ��� DML ��� ���� �� ����, ����, ������ ���� ������ EMP_HIS ���̺� ������ �����ϴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER EMP_HIS_TRIGGER AFTER INSERT OR UPDATE OR DELETE ON EMP_TRI FOR EACH ROW
BEGIN
   IF INSERTING THEN /* INSERT ����� ����� ��� */
        INSERT INTO EMP_HIS VALUES(:NEW.EMPNO, :NEW.ENAME, '�Ի�');
    ELSIF UPDATING THEN  /* UPDATE ����� ����� ��� */
        IF :NEW.DEPTNO <> :OLD.DEPTNO THEN
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '�μ��̵�');
        ELSIF :NEW.SAL <> :OLD.SAL THEN
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '�޿�����');
        ELSE    
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '���λ���');
        END IF;            
    ELSIF DELETING THEN   /* DELETE ����� ����� ��� */
        INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '���');
    END IF;
END;
/

--�����
SELECT * FROM EMP_TRI;
INSERT INTO EMP_TRI VALUES(5000,'PARK',2000,10);
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

UPDATE EMP_TRI SET DEPTNO=20 WHERE EMPNO=5000;
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
UPDATE EMP_TRI SET SAL=3000 WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
UPDATE EMP_TRI SET ENAME='ȫ�浿' WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

--EMP_TRI ���̺� ����� �� ���� - EMP_HIS_TRIGGER Ʈ���ſ� ���� EMP_HIS ���̺��� �� ����
DELETE FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

