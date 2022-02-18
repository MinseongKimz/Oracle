select user
from dual;
--==>> SYS

select '���ڿ�'
FRom dual;
--==>>���ڿ�

select 550 + 230
from dual;
--==>> 780

select '������' + 'ȫ����' 
from dual;
--==>> ���� �߻�
--ORA-01722: invalid number  ���� �ƴϸ� ���� �Ұ�!


--�� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ��ȸ
select Username, account_status
from dba_users;
--==>>
/*
SYS                 OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
HR	                OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/

select 
from dba_users;
/*
SYS	0		OPEN		2022-08-14	SYSTEM	TEMP	2014-05-29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
SYSTEM	5		OPEN		2022-08-14	SYSTEM	TEMP	2014-05-29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
ANONYMOUS	35		OPEN		2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP			N	PASSWORD
HR	43		OPEN		2022-08-15	USERS	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_PUBLIC_USER	45		LOCKED	2014-05-29	2014-11-25	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
FLOWS_FILES	44		LOCKED	2014-05-29	2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_040000	47		LOCKED	2014-05-29	2014-11-25	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
OUTLN	9		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DIP	14		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
ORACLE_OCM	21		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XS$NULL	2147483638		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
MDSYS	42		EXPIRED & LOCKED	2014-05-29	2022-02-15	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
CTXSYS	32		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DBSNMP	29		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XDB	34		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APPQOSSYS	30		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX	TEMP	2014-05-29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
*/


select Username, created
from Dba_users;
/*
SYS	2014-05-29
SYSTEM	2014-05-29
ANONYMOUS	2014-05-29
HR	2014-05-29
APEX_PUBLIC_USER	2014-05-29
FLOWS_FILES	2014-05-29
APEX_040000	2014-05-29
OUTLN	2014-05-29
DIP	2014-05-29
ORACLE_OCM	2014-05-29
XS$NULL	2014-05-29
MDSYS	2014-05-29
CTXSYS	2014-05-29
DBSNMP	2014-05-29
XDB	2014-05-29
APPQOSSYS	2014-05-29
*/


--> ��DBA_���� �����ϴ� Oracle Data Dictionary View�� 
--  ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
--  ���� ������ ��ųʸ� ������ ���� ���ص� ��� ����.


--�� ��hr�� ����� ������ ��� ���·� ���� 
alter user hr Account Lock;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� ����� ���� ���� ��ȸ
select username, account_status
from dba_users;
--==>>
/*
    :
HR	LOCKED
    :
*/


--�ۡ�hr�� ����� ������ ��� ���� ����
alter user hr account Unlock;
--==>> User HR��(��) ����Ǿ����ϴ�.



--�� ����� ���� ���� ��ȸ
select username, account_status
from dba_users;
--==>>
/*
    :
HR	OPEN
    :
*/


------------------------------------------------------------------------------

--�� TABLESPACE ����

--�� TABLESPACE ��?
--> ���׸�Ʈ(���̺�, �ε���, ....)�� ��Ƶδ� (�����صδ�)
--  ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.

CREATE TableSpace TBS_EDUA             --�����ϰڴ�.���̺����̽���.. TBS_EDUA��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF'  --������ ������ ���� ��� �� �̸�
SIZE 4M                                --������������ �뷮(������)             
EXTENT MANAGEMENT LOCAL                --����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;         --���׸�Ʈ ���� ������ ����Ŭ ������ �ڵ����� ����
--==>> TableSpace TBS_EDUA��(��) �����Ǿ����ϴ�.

--�� ���̺����̽� ���� ������ �����ϱ� ����
--   �ش� ����� �������� ���͸� ������ �ʿ��ϴ�.
--   (C:\TESTDATA)


-- �� ������ ���̺����̽� ��ȸ
select *
from dba_tablespaces;
--==>>
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/


--�� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)
select *
from DBA_DATA_FILES;
/*
    :
C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
    :
*/


--�� ����Ŭ ����� ���� ����
Create user kms IDENTIFIED BY java006$
default tablespace TBS_EDUA;
--==>> User KMS��(��) �����Ǿ����ϴ�.
--> kms ��� ����� ������ �����ϰڴ�. (����ڴ�)
-- �� ����� ������ �н������ java006$�̴�.
-- �� ������ ���� �����ϴ� ����Ŭ ���׸�Ʈ�� 
-- �⺻������ TBS_EDUA ��� ���̺� �����̽��� ������ �� �ֵ��� ����.


--�� ������ ����Ŭ ����� ����(����  ���� �̸� �̴ϼ� ����)�� ���� ���� �õ�
-- �� ���� �Ұ�(����)
--    ��creat session�� ������ ���� ������ ���� �Ұ�.

--�� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)��
--   ����Ŭ ���� ������ �����ϵ��� CREATE SESSION ���� �ο�
grant create session to kms; -- /�ο��ϰڴ�/ create /session /~���� /kms
--==>> Grant��(��) �����߽��ϴ�.

--�� ���� ������ ����Ŭ ����� ������ �ý��� ���� ���� ��ȸ
SELECT *
 from  DBA_SYS_PRIVS;
--==>> KMS	CREATE SESSION	NO

--�� ���� ������ ����Ŭ ����� ������
--   ���̺� ������ �����ϵ��� CREATE TABLE ���� �ο�

grant create table to KMS;
--==>> Grant��(��) �����߽��ϴ�.

--�� ���� ������ ����Ŭ ����� ������
--   ���̺� �����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮) ����.

/*
����(����)  ������ - ALTER
            ������ - UPDATE

����(����)  ������ - DROP
            ������ - DELETE
            
����(�Է�)  ������ - CREATE
            ������ - INSERT
*/
alter user KMS
QUOTA UNLIMITED on TBS_EDUA; -- TBS_EDUA ���� �뷮 ���� ���� ���ٴ�
--==>> User KMS��(��) ����Ǿ����ϴ�.


-----------------------------------------------------------------------------


CREATE USER scott 
IDENTIFIED BY tiger; -- tiger ��й�ȣ ��ҹ��� ����
--==>> User SCOTT��(��) �����Ǿ����ϴ�.

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO SCOTT; 
--==>> Grant��(��) �����߽��ϴ�.

ALTER USER SCOTT DEFAULT TABLESPACE USERS; 
--==>> User SCOTT��(��) ����Ǿ����ϴ�.


ALTER USER SCOTT TEMPORARY TABLESPACE TEMP; -- �ӽ� ���̺� �����̽� ����
--==>> User SCOTT��(��) ����Ǿ����ϴ�.

















