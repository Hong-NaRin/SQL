SELECT * FROM HR.EMPLOYEES; -- HR�� EMPLOYEES���̺��� �� �� ����

-- ���� ���
SELECT * FROM ALL_USERS; -- �ٸ� ����� Ŭ���ϸ� � ����ڵ��� �ִ��� �� �� ����
-- ���� ���� ���� Ȯ��
SELECT * FROM USER_SYS_PRIVS;

-- ���� ����
CREATE USER USER01 IDENTIFIED BY USER01; -- ���̵� USER01, ��й�ȣ USER01
-- ���Ѻο� (���ӱ���, ���̺� �� ������ ���ν��� ��������)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01; -- USER01���� �ο�
-- ���̺� �����̽�(�����͸� �����ϴ� �������� ����) ����
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- �ؼ�: �����Ѵ� ���� USER01 �⺻ ���̺����̽��� USERS�̰�, ���������� ����Ѵ� ON USERS ���̺����̽���
-- USER01 ����ڰ� �����ͺ��̽����� �⺻������ ����� ���̺����̽��� USERS�� �����ϰ�, �� ���̺����̽��� �����͸� �����ϴ� �� �־� �뷮 ������ ���� �ʵ��� ����

-- ���� ȸ��
REVOKE CREATE SESSION FROM USER01; -- USER01�� ���� ���� ȸ��
-- ���� ����
DROP USER USER01;
--------------------------------------------------------------
-- ��(Role) : ������ �׷��� ���� ���� �ο�
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT CONNECT, RESOURCE TO USER01; -- CONNECT ���ӷ�, RESOURCES ���߷�
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
