SElect user 
from dual;
--==>> KMS


--�� ���̺� ����(TBL_ORAUSERTEST) 
create TABLE TBL_ORAUSERTEST
( no Number(10)
, name VARCHAR2(30)
);
--==>> �����߻�
--  (ORA-01031: insufficient privileges)
-->  ���� ������ �̸� ������ CREATE SESSION ���Ѹ� ���� ������
--   ���̺� ���� ������ ���� ���� �ʴ� �����̴�.
--   �׷��Ƿ� �����ڷκ��� ���̺��� ������ �� �մ� ������ �ο��޾ƾ� �Ѵ�.


--��SYS�� ���� ���̺� ���� ����(create table)�ο� ���� ��
-- ���̺� ����(TBL_ORAUSERTEST) 
create TABLE TBL_ORAUSERTEST
( no Number(10)
, name VARCHAR2(30)
);
--==>> �����߻� 
-- (ORA-01950: no privileges on tablespace 'TBS_EDUA') �Ҵ緮 �ο� X 
--> ���̺� ���� ���ѱ��� �ο����� ��Ȳ������
--  ������ �̸� ������ �⺻ ���̺� �����̽�(DEFAULT TABLESPACE)��
--  TBS_EDUA �̸�, �� ������ ���� �Ҵ緮�� �ο����� ���� �����̴�.
--  �׷��Ƿ� �� ���̺� �����̽��� ����� ������ ���ٴ� �����޼�����
--  ����Ŭ�� ������ְ� �ִ� ��Ȳ


--�� SYS�κ��� ���̺����̽�(TBS_EDUA)�� ���� �Ҵ緮�� �ο����� ��
--   �ٽ� ���̺� ����(TBL_ORAUSERTEST) 
create TABLE TBL_ORAUSERTEST
( no Number(10)
, name VARCHAR2(30)
);
--==>> Table TBL_ORAUSERTEST��(��) �����Ǿ����ϴ�.


Select *
from TBL_ORAUSERTEST;
-->> ���̺��� ������ Ȯ���� �� �ִ� ����
--   ��, ��ȸ ����� ����


--�� �ڽſ��� �ο��� �Ҵ緮 ��ȸ
Select *
from USER_TS_QUOTAS;
--==>> TBS_EDUA	65536	-1	8	-1	NO
-- ��-1���� �������� �ǹ�...


--�� ������ ���̺�(TBL_ORAUSERTEST)��
--   � ���̺� �����̽��� ����Ǿ� �ִ��� ��ȸ
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>> TBL_ORAUSERTEST	TBS_EDUA










