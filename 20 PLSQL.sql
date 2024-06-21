-- PLSQL(���α׷� SQL)
-- ������ ����(�巡��)�ϰ� ������ F5���� ������ ���Ѽ� ���� -> CTRL + ���� (X)
-- ��±����� ���� ���๮
SET SERVEROUTPUT ON;

--DECLARE
--   ����
--BEGIN
--   ó���� ����
--	 DBMS_OUTPUT.PUT_LINE(��¹�)
--END;

DECLARE
    V_NUM NUMBER; -- ���� ����
    V_NAME VARCHAR2(10) := 'ȫ�浿'; -- ���� ����� �ʱ�ȭ ���ÿ� ����
BEGIN
    V_NUM := 10;
    --V_NAME := 'ȫ�浿';
    dbms_output.put_LINE(V_NAME || '���� ���̴� ' || V_NUM || '�Դϴ�.');
END;

-- DML ������ �Բ� ����� �� �ִ�
-- SELECT -> INSERT -> INSERT
DECLARE 
    NAME VARCHAR2(30);
    SALARY NUMBER;
    LAST_NAME EMPLOYEES.LAST_NAME%TYPE; -- ���� ���� �����ص� ������ EMP���̺��� LAST_NAME�÷��� ������ Ÿ������ ������ ���� ����
BEGIN
    SELECT FIRST_NAME, LAST_NAME, SALARY
    INTO NAME, LAST_NAME, SALARY -- ���� ����� ������ ����
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(NAME);
    DBMS_OUTPUT.PUT_LINE(SALARY);
    DBMS_OUTPUT.PUT_LINE(LAST_NAME);

END;
---------------------------------------------------
-- 2008�� �Ի��� ����� �޿� ����� ���ؼ� ���ο� ���̺� INSERT
CREATE TABLE EMP_SAL (
    YEARS VARCHAR2(50),
    SALARY NUMBER(10)
);

DECLARE
    YEARS VARCHAR2(50) := 2008; -- PLSQL�� ���Կ� (=)�� �ƴ� (:=)�� ���
    SALARY NUMBER;
BEGIN
    SELECT AVG(SALARY)
    INTO SALARY -- ���� SALARY�� ����
    FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'YYYY') = YEARS;
    
    INSERT INTO EMP_SAL VALUES (YEARS, SALARY);
    COMMIT;
END;
SELECT * FROM EMP_SAL;
-------------------------------------------------
--3. ��� ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� ��, 
-- �� ��ȣ +1������ �Ʒ��� ����� emps���̺� 
-- employee_id, last_name, email, hire_date, job_id�� �ű� �Է��ϴ� �͸� ����� ����� ���ô�.
--<�����>   : steven
--<�̸���>   : stevenjobs
--<�Ի�����> : ���ó�¥
--<JOB_ID> : CEO
DECLARE
    NUM NUMBER;
BEGIN
    SELECT MAX(EMPLOYEE_ID) + 1
    INTO NUM -- NUM�� ���� 
    FROM EMPLOYEES;
    
    INSERT INTO EMPS_IT(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (NUM, 'steven', 'steven jobs', SYSDATE, 'CEO');
    COMMIT;
END;

SELECT * FROM EMPS_IT;

