-- DDL문장 (트랜잭션이 없습니다)
-- CREATE, ALTER, DROP

DROP TABLE DEPTS; -- 테이블 삭제
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2), -- 숫자 2자리
    DEPT_NAME VARCHAR2(30), -- 30바이트 (한글은 15글자, 숫자 영어 30글자)
    DEPT_YN CHAR(1), -- 고정문자 1BYTE (값을 넣어도, 넣지 않아도 1BYTE)
    DEPT_DATE DATE, 
    DEPT_BONUS NUMBER(10,2), -- 정수 10자리, 실수 2자리까지 저장
    DEPT_CONTENT LONG -- 2기가 가변문자열 (VARCHAR2보다 더 큰 - DB마다 이름이 조금씩 다름)
);

SELECT * FROM DEPTS;
DESC DEPTS; -- 데이터타입의 유형을 알 수 있음
INSERT INTO DEPTS VALUES(99, 'HELLO', 'Y', SYSDATE, 3.14, 'LONG TEXT~~');
INSERT INTO DEPTS VALUES(100, 'HELLO', 'Y', SYSDATE, 3.14, 'LONG TEXT~'); -- 100은 DEPT_NO NUMBER(3)여야 가능함
INSERT INTO DEPTS VALUES(1, 'HELLO', '가', SYSDATE, 3.14, 'LONG~ TEXT~'); -- 한글은 2바이트 = DEPT_YN CHAR(2)

-----------------------------------------------------------------------------
-- 테이블 구조 변경 ALTER
-- ADD, MODIFY, RENAME COLUMN, DROP COLUMN
DESC DEPTS;
SELECT * FROM DEPTS;

ALTER TABLE DEPTS ADD DEPT_COUNT NUMBER(3); -- 마지막에 컬럼 추가
ALTER TABLE DEPTS RENAME COLUMN DEPT_COUNT TO EMP_COUNT; -- 컬럼명 변경

ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(5); -- 컬럼의 크기를 수정
ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(1); -- 컬럼의 크기를 수정
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(1); -- 기존데이터가 변경할 크기보다 큰 경우, 변경불가

ALTER TABLE DEPTS DROP COLUMN EMP_COUNT; -- 컬럼 삭제

---------------------------------------------------------------
-- 테이블 삭제
DROP TABLE DEPTS /*CASECADE 제약조건명*/; -- 테이블이 가지는 FK제약조건을 삭제하면서 테이블을 날려버림 (위험한 DROP)
DROP TABLE DEPARTMENTS; -- DEPARTMENTS는 EMPLOYEES테이블과 참조관계를 가지고 있어서, 한 번에 삭제되지 않음 (제약조건이 지워지면 삭제 가능) 
