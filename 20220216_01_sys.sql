
--1�� �ּ��� ó�� (������ �ּ��� ó��)

/*
������
(������)
�ּ���
ó��  �� java�� ����
*/


--�� ���� ����Ŭ ������ ������ �ڽ��� ���� ��ȸ
show user
--==>> USER��(��) "SYS"�Դϴ�.
--> sqlplus ������ �� ����ϴ� ��ɾ�.. 


select user 
from dual;
--==>> SYS

SELECT USER
FROM DUAL;
--==>>SYS      ��ҹ��� ���� x

select 1 + 2
from dual;
--==> 3

SELECT 1 + 2
FROM DUAL;
--==> 3

SELECT              2 + 4
FROM               DUAL;
--==>>6

SELECT 1 + 5
FROMDUAL;
--==>> �����߻�
--ORA-00923: FROM keyword not found where expected

Select �ֿ밭�ϱ������� F������
from dual;
--==>> �����߻�
--ORA-00923: FROM keyword not found where expected

SElect "�ֿ밭�ϱ������� F������"
from dual;
--==>> �����߻�
--ORA-00972: identifier is too long

SElect '�ֿ밭�ϱ������� F������'
from dual;
--==>> �ֿ밭�ϱ������� F������

select '�� �� �� �� ���ܿ� ����Ŭ ����'
from dual;
--==>> �� �� �� �� ���ܿ� ����Ŭ ����


select 3.14 + 3.14 
from dual;
--==>> 6.28

select 10 * 5
from dual;
--==>> 50

select 10 * 5.0
from dual;
--==>> 50

select 4/2
from dual;
--==>> 2

select 4.0/2
from dual;
--==>> 2

select 4.0/2.0
from dual;
--==>> 2

select 5/2
from dual;
--==>> 2.5

select 100 -23
from dual;
--==>> 77

