-- 제어문
/*
IF 조건절 THEN
ELSIF 조건절 THEN --ELSE IF(X)
ELSE ~~ 
END IF;
*/
SET SERVEROUTPUT ON;
DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1, 101)); -- 1~ 101미만 랜덤수
BEGIN
    /*
    DBMS_OUTPUT.PUT_LINE('점수: ' || POINT);
    IF POINT >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점입니다');
    ELSIF POINT >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('C학점입니다');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('F학점입니다');
    END IF; 
    */
    
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A학점입니다');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B학점입니다');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C학점입니다');
         ELSE DBMS_OUTPUT.PUT_LINE('F학점입니다');
    END CASE;
END;

-------------------------------------------------------------------
-- While문
DECLARE
    CNT NUMBER := 1;
BEGIN
    WHILE CNT <= 9
    LOOP 
        DBMS_OUTPUT.PUT_LINE('3 X ' || CNT || ' =' || CNT * 3);
        CNT := CNT + 1; -- 1증가 (CNT++은 쓸 수 없음)
    END LOOP;    
END;
---------------------------------------------------------------------
-- For문
DECLARE
BEGIN
    FOR I IN 1..9 -- 1~9까지
    LOOP
        CONTINUE WHEN I = 5; -- I가 5면 다음으로
        DBMS_OUTPUT.PUT_LINE('3 X' || I || ' =' || I * 3);
        -- EXIT WHEN I = 5; -- I가 5면 탈출
    END LOOP;
END;
---------------------------------------------------------------------
-- 1. 2~9단까지 출력하는 익명블록
DECLARE
BEGIN
    FOR I IN 2..9
    LOOP
        FOR J IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(I ||' X ' || J || ' =' || I * J);
        END LOOP;
    END LOOP;    
END;
----------------------------------------------------------------------
-- 커서
DECLARE
    NAME VARCHAR2(30);
BEGIN
    -- SELECT 결과가 여러 행이라서 ERROR가 남
    SELECT FIRST_NAME
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
    
    DBMS_OUTPUT.PUT_LINE(NAME);
END;
----------------------------------------------------------------------
DECLARE
    NM VARCHAR2(20); -- 일반변수
    SALARY NUMBER;
    CURSOR X IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
BEGIN
    OPEN X; -- 커서 선언
        DBMS_OUTPUT.PUT_LINE('-----------커서 시작-----------');
    LOOP
        FETCH X INTO NM, SALARY; -- NM변수와 SLARAY 변수 저장
        EXIT WHEN X%NOTFOUND; -- X커서의 더 이상 읽을 값이 없으면 TRUE
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.PUT_LINE(SALARY);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('-------커서 종료-------');            
    DBMS_OUTPUT.PUT_LINE('데이터 수 :' || X%ROWCOUNT); -- 커서에서 읽은 데이터 수

    CLOSE X; -- 커서 닫음
END;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
-----------------------------------------------------------------
--4. 부서별 급여합을 출력하는 커서구문을 작성해봅시다.
DECLARE
    ID NUMBER;
    SALARY NUMBER;
    CURSOR X IS SELECT DEPARTMENT_ID, SUM(SALARY) 
                FROM EMPLOYEES 
                GROUP BY DEPARTMENT_ID
                ORDER BY DEPARTMENT_ID DESC;
BEGIN
    OPEN X;
    LOOP
        FETCH X INTO ID, SALARY; -- FETCH로 읽기
        EXIT WHEN X%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('부서: ' || ID);
        DBMS_OUTPUT.PUT_LINE('부서급여: ' || SALARY);
        
    END LOOP;
    CLOSE X;
END;
--5. 사원테이블의 연도별 급여합을 구하여 EMP_SAL에 순차적으로 INSERT하는 커서구문을 작성해봅시다.
DECLARE
    CURSOR X IS SELECT HIRE, SUM(SALARY) AS MONEY
                FROM(SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS HIRE, SALARY 
                FROM EMPLOYEES)
                GROUP BY HIRE;
BEGIN
    FOR I IN X -- 커서를 FOR IN 구문에 넣으면 OPEN, CLOSE 생략 가능  
    LOOP 
        -- DBMS_OUTPUT.PUT_LINE(I.A || ' ' || I.B);
        INSERT INTO EMP_SAL VALUES(I.HIRE, I.MONEY); -- INSERT
    END LOOP;
END;

SELECT * FROM EMP_SAL;