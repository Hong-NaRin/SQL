-- INSERT 
-- 테이블 구조를 빠르게 확인하는 방법
DESC DEPARTMENTS;

-- 1ST
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER', NULL, 1700);
SELECT * FROM DEPARTMENTS;

-- DML문은 트랜잭션이 항상 기록되는데 ROLLBACK이용해서 되돌릴 수 있음
ROLLBACK;

-- 2ND (컬럼명만 지정가능)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) 
VALUES (280, 'DEVELOPER', 1700);

-- INSERT구문도 서브쿼리됨 (단일값)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) 
VALUES ((SELECT MAX(DEPARTMENT_ID)+10 FROM DEPARTMENTS), 'DEV');

-- INSERT구문의 서브쿼리 (여러행)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- 테이블 구조 복사
SELECT * FROM EMPS; -- 이 테이블에 원본테이블의 특정 데이터를 삽입할 예정

INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) 
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN'); -- 서브쿼리는 VALUES 생략하고 ()작성 가능
COMMIT; -- 트랜잭션을 반영함

--------------------------------------------------------
-- UPDATE
SELECT * FROM EMPS;
-- 업데이트 구문을 사용하기 전에는 SELECT로 해당값이 고유한 행인지 확인하고 업데이트 처리해야 함
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148; -- KEY를 조건에 적는 게 일반적
UPDATE EMPS SET SALARY = NVL(SALARY, 0) + 1000 WHERE EMPLOYEE_ID >= 145;

-- 업데이트 구문의 서브쿼리절
-- 1ST(단일값 서브쿼리)
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;

-- 2ND(여러값 서브쿼리)
UPDATE EMPS
SET (SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
= (SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100)
WHERE EMPLOYEE_ID = 148;

-- 3ND(WHERE절에도 가능)
UPDATE EMPS
SET SALARY = 1000     
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');