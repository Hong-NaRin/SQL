-- 트리거 : 테이블에 부착한 형태로 AFTER, BEFORE 트리거가 있다
-- AFTER는 DML문장이 타겟테이블에 실행된 이후에 동작하는 트리거
-- BEFORE는 DML문장이 타겟테이블에 실행되기 이전에 동작하는 트리거
SET SERVEROUTPUT ON; 

CREATE TABLE TBL_TEST (
    ID VARCHAR2(30),
    TEXT VARCHAR2(30)
);

-- 트리거 생성
CREATE OR REPLACE TRIGGER TBL_TEST_TRG
    AFTER UPDATE OR INSERT OR DELETE -- UPDATE, INSERT, DELETE일 때 트리거 발생 (트리거 종류와 동작시점)
    ON TBL_TEST -- 부착할 테이블
    FOR EACH ROW -- 모든 행에 적용
BEGIN
    DBMS_OUTPUT.PUT_LINE('트리거 동작함');
END;
-- 
INSERT INTO TBL_TEST VALUES('AAA123', 'HELLO'); -- INSERT했기 때문에 트리거 동작
UPDATE TBL_TEST SET TEXT = 'BYE' WHERE ID = 'AAA123'; -- 트리거 동작
DELETE FROM TBL_TEST WHERE ID = 'AAA123'; -- 트리거 동작
------------------------------------------------------------------------------
--AFTER TRIGGER
-- :OLD = 참조 전 값 (I : 입력 전 자료, U : 변경 전 자료, D : 삭제 전 자료)

-- 원본테이블과 백업테이블 생성
CREATE TABLE TBL_USER(
    ID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    ADDRESS VARCHAR2(30)
);

CREATE TABLE TBL_USER_BACKUP(
    ID VARCHAR2(20),
    NAME VARCHAR2(20),
    ADDRESS VARCHAR2(30),
    UPDATEDATE DATE DEFAULT SYSDATE,
    M_TYPE CHAR(10), --변경타입
    M_USER VARCHAR2(20) --변경한 사용자
);

-- TLB_USER에 UPDATE OR DELETE가 일어나면 기존 데이터를 백업
CREATE OR REPLACE TRIGGER TBL_USER_BACKUP_TRG
    AFTER UPDATE OR DELETE
    ON TBL_USER
    FOR EACH ROW
DECLARE
    V VARCHAR2(10); -- 지역변수 선언
BEGIN
    IF UPDATING THEN -- 수정이 일어났다는 걸 알려주는 시스템 구문
        V := '수정'; -- 위 변수에 수정을 저장
    ELSIF DELETING THEN -- 삭제가 일어났다는 걸 알려주는 시스템 구문
        V := '삭제';
    END IF;
    
    -- 변경되기 전 자료
    INSERT INTO TBL_USER_BACKUP VALUES(:OLD.ID, :OLD.NAME, :OLD.ADDRESS, SYSDATE, V, USER()); -- 아이디, NAME, ADDRESS
END;

INSERT INTO TBL_USER VALUES('AAA', 'AAA', 'AAA');
INSERT INTO TBL_USER VALUES('BBB', 'BBB', 'BBB');

UPDATE TBL_USER SET NAME = 'NEWAAA' WHERE ID = 'AAA'; -- 트리거 동작
DELETE FROM TBL_USER WHERE ID = 'BBB'; -- 트리거 동작

SELECT * FROM TBL_USER_BACKUP;

-- BEFORE TRIGGER
-- :NEW 참조 후 값 (I : 입력할 자료, U : 수정할 자료)
CREATE OR REPLACE TRIGGER TBL_USER_MAKING_TRG
    BEFORE INSERT
    ON TBL_USER
    FOR EACH ROW
BEGIN
    -- 인서트가 되기 전에 들어오는 데이터를 홍** 변경
    :NEW.NAME := SUBSTR(:NEW.NAME, 1, 1) || '**'; -- SUBSTR(:NEW.NAME, 1, 1) : 첫번째 인덱스에서 1글자
END;
--
INSERT INTO TBL_USER VALUES('CCC', '홍길동', '서울시');
INSERT INTO TBL_USER VALUES('DDD', '이순신', '서울시');
SELECT * FROM TBL_USER;