SELECT * FROM HR.EMPLOYEES; -- HR의 EMPLOYEES테이블을 볼 수 있음

-- 유저 목록
SELECT * FROM ALL_USERS; -- 다른 사용자 클릭하면 어떤 사용자들이 있는지 볼 수 있음
-- 현재 유저 권한 확인
SELECT * FROM USER_SYS_PRIVS;

-- 계정 생성
CREATE USER USER01 IDENTIFIED BY USER01; -- 아이디 USER01, 비밀번호 USER01
-- 권한부여 (접속권한, 테이블 뷰 시퀀스 프로시저 생성권한)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01; -- USER01한테 부여
-- 테이블 스페이스(데이터를 저장하는 물리적인 공간) 지정
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 해석: 수정한다 유저 USER01 기본 테이블스페이스는 USERS이고, 무제한으로 사용한다 ON USERS 테이블스페이스를
-- USER01 사용자가 데이터베이스에서 기본적으로 사용할 테이블스페이스를 USERS로 설정하고, 이 테이블스페이스에 데이터를 저장하는 데 있어 용량 제한을 두지 않도록 설정

-- 권한 회수
REVOKE CREATE SESSION FROM USER01; -- USER01의 접속 권한 회수
-- 계정 삭제
DROP USER USER01;
--------------------------------------------------------------
-- 롤(Role) : 권한의 그룹을 통한 권한 부여
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT CONNECT, RESOURCE TO USER01; -- CONNECT 접속롤, RESOURCES 개발롤
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
