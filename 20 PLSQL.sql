-- PLSQL(프로그램 SQL)
-- 범위를 지정(드래그)하고 실행을 F5으로 컴파일 시켜서 실행 -> CTRL + 엔터 (X)
-- 출력구문을 위한 실행문
SET SERVEROUTPUT ON;

--DECLARE
--   변수
--BEGIN
--   처리할 내용
--	 DBMS_OUTPUT.PUT_LINE(출력문)
--END;

DECLARE
    V_NUM NUMBER; -- 변수 선언
    V_NAME VARCHAR2(10) := '홍길동'; -- 변수 선언과 초기화 동시에 가능
BEGIN
    V_NUM := 10;
    --V_NAME := '홍길동';
    dbms_output.put_LINE(V_NAME || '님의 나이는 ' || V_NUM || '입니다.');
END;

-- DML 구문과 함께 사용할 수 있다
-- SELECT -> INSERT -> INSERT
DECLARE 
    NAME VARCHAR2(30);
    SALARY NUMBER;
    LAST_NAME EMPLOYEES.LAST_NAME%TYPE; -- 위와 같이 선언해도 되지만 EMP테이블의 LAST_NAME컬럼과 동일한 타입으로 선언할 수도 있음
BEGIN
    SELECT FIRST_NAME, LAST_NAME, SALARY
    INTO NAME, LAST_NAME, SALARY -- 위에 선언된 변수에 대입
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(NAME);
    DBMS_OUTPUT.PUT_LINE(SALARY);
    DBMS_OUTPUT.PUT_LINE(LAST_NAME);

END;
---------------------------------------------------
-- 2008년 입사한 사원의 급여 평균을 구해서 새로운 테이블에 INSERT
CREATE TABLE EMP_SAL (
    YEARS VARCHAR2(50),
    SALARY NUMBER(10)
);

DECLARE
    YEARS VARCHAR2(50) := 2008; -- PLSQL은 대입에 (=)이 아닌 (:=)를 사용
    SALARY NUMBER;
BEGIN
    SELECT AVG(SALARY)
    INTO SALARY -- 변수 SALARY에 대입
    FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'YYYY') = YEARS;
    
    INSERT INTO EMP_SAL VALUES (YEARS, SALARY);
    COMMIT;
END;
SELECT * FROM EMP_SAL;
-------------------------------------------------
--3. 사원 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤, 
-- 이 번호 +1번으로 아래의 사원을 emps테이블에 
-- employee_id, last_name, email, hire_date, job_id를 신규 입력하는 익명 블록을 만들어 봅시다.
--<사원명>   : steven
--<이메일>   : stevenjobs
--<입사일자> : 오늘날짜
--<JOB_ID> : CEO
DECLARE
    NUM NUMBER;
BEGIN
    SELECT MAX(EMPLOYEE_ID) + 1
    INTO NUM -- NUM에 대입 
    FROM EMPLOYEES;
    
    INSERT INTO EMPS_IT(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (NUM, 'steven', 'steven jobs', SYSDATE, 'CEO');
    COMMIT;
END;

SELECT * FROM EMPS_IT;

