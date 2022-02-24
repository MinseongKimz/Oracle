SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_SAWON ���̺��� Ȱ���Ͽ�
--   ������ ���� �׸��� ��ȸ�� �� �յ��� ������ ����
--   �����ȣ, �����, �ֹι�ȣ, ����, �Ի���


SELECT *
FROM TBL_SAWON;


SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
            ELSE '����Ȯ�κҰ�'
       END "����"
FROM TBL_SAWON;
/*
1001	��μ�	    9707251234567	����
1002	������	    9505152234567	����
1003	������	    9905192234567	����
1004	�̿���	    9508162234567	����
1005	���̻�	    9805161234567	����
1006	������	    8005122234567	����
1007	������	    0204053234567	����
1008	������	    6803171234567	����
1009	������	6912232234567	����
1010	���켱	    0303044234567	����
1011	������	    0506073234567	����
1012	���ù�	    0208073234567	����
1013	����	    6712121234567	����
1014	ȫ����	    0005044234567	����
1015	�Ӽҹ�	    9711232234567	����
1016	���̰�	    0603194234567	����
*/

--�� TBL_SAWON ���̺��� Ȱ���Ͽ�
--   ������ ���� �׸���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�
--   �������ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
--     , ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ���
--   ��, ���� ���̴� �⺻ �ѱ����� ������ ���� ������ �����Ѵ�.
--   ����, ������������ �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ����
--   �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�.
--   �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� �����
--   �� ����� ���� �޿� ���� 30% ����, 2000�� �̻� �ٹ��� �����
--   �� ����� ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�.

-- EX) 1001 ��μ� 9707251234567 ���� 26 2005-01-03 2056-01-03 �ٹ��ϼ� �����ϼ� 3000 1500

SELECT SANO "�����ȣ" , SANAME "�����", JUBUN "�ֹι�ȣ"
------------------[���� Ȯ��]-------------------------------------------------------------------

     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
            ELSE '����Ȯ�κҰ�'
       END "����" 
------------------[���� Ȯ��]------------------------------------------------------------------       

     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') THEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') THEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999)
            ELSE 0
       END  "���糪��"
-----------------------------------------------------------------------------------------------      
     , HIREDATE "�Ի���"
------------------[���� ������]----------------------------------------------------------------     

     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2')
            THEN TO_CHAR(ADD_MONTHS(SYSDATE, (((60-(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) 
                        - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899))))*12)), 'YYYY') ||'-'||TO_CHAR(HIREDATE, 'MM-DD') 
            
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
            THEN TO_CHAR(ADD_MONTHS(SYSDATE, (((60-(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) 
                        - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999))))*12)), 'YYYY') ||'-'||TO_CHAR(HIREDATE, 'MM-DD') 
            ELSE '0'
       END
         "����������"
----------------[�ٹ� �ϼ�]---------------------------------------------------------------------    
     , TRUNC(SYSDATE - HIREDATE)
         "�ٹ��ϼ�"
----------------[���� �ϼ�]---------------------------------------------------------------------    

     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') THEN
            TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (((60-(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) 
            - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899))))*12)), 'YYYY') ||'-'||TO_CHAR(HIREDATE, 'MM-DD'), 'YYYY-MM-DD') 
            - SYSDATE)
     
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') THEN 
            TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (((60-(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) 
            - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999))))*12)), 'YYYY') ||'-'||TO_CHAR(HIREDATE, 'MM-DD'), 'YYYY-MM-DD') 
            - SYSDATE)  
        ELSE 0
        END  "�����ϼ�"
------------------------------------------------------------------------------------------------    
     , SAL "�޿�"
----------------[���ʽ�]------------------------------------------------------------------------

     , CASE WHEN 1000 <= TRUNC(SYSDATE - HIREDATE) AND TRUNC(SYSDATE - HIREDATE) < 2000 THEN
            SAL * 0.3
            WHEN  TRUNC(SYSDATE - HIREDATE) > 2000 THEN  
            SAL * 0.5
            ELSE 0 
            END "���ʽ�"
FROM TBL_SAWON;
/*
1001	��μ�	    9707251234567	����	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	������	    9505152234567	����	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	������	    9905192234567	����	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	�̿���	    9508162234567	����	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	    9805161234567	����	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	������	    8005122234567	����	43	1999-10-10	2039-10-10	8172	6437	1000	500
1007	������	    0204053234567	����	21	2010-10-10	2061-10-10	4154	14473	1000	500
1008	������	    6803171234567	����	55	1998-10-10	2027-10-10	8537	2054	1500	750
1009	������	6912232234567	����	54	1998-10-10	2028-10-10	8537	2420	1300	650
1010	���켱	    0303044234567	����	20	2010-10-10	2062-10-10	4154	14838	1600	800
1011	������	    0506073234567	����	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	���ù�	    0208073234567	����	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	����	    6712121234567	����	56	1998-10-10	2026-10-10	8537	1689	2200	1100
1014	ȫ����	    0005044234567	����	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	    9711232234567	����	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	���̰�	    0603194234567	����	17	2015-01-20	2065-01-20	2591	15671	1500	750
*/


------------------------------------------------------------------------------------------------------
-- ���� Ǭ Ǯ��

-- �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, �޿� ...

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
            ELSE '���� Ȯ�� �Ұ�' 
       END "����"
       
      --���� ���� = ����⵵ - �¾�⵵ + 1 (1900/2000��� �� ���� �ʿ�) 
       , CASE WHEN 1900��� ���̶�� THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1899) 
              WHEN 2000��� ���̶�� THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1999)
       
       ELSE END "���糪��", �Ի���, �޿�
FROM TBL_SAWON;


SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
            ELSE '���� Ȯ�� �Ұ�' 
       END "����"
       
      --���� ���� = ����⵵ - �¾�⵵ + 1 (1900/2000��� �� ���� �ʿ�) 
       , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
              WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE  -1
        END "���糪��"
        
        ,HIREDATE "�Ի���"
        ,SAL "�޿�"
FROM TBL_SAWON;
/*
1001	��μ�	    9707251234567	����	26	2005-01-03	3000
1002	������	    9505152234567	����	28	1999-11-23	4000
1003	������	    9905192234567	����	24	2006-08-10	3000
1004	�̿���	    9508162234567	����	28	2007-10-10	4000
1005	���̻�	    9805161234567	����	25	2007-10-10	4000
1006	������	    8005122234567	����	43	1999-10-10	1000
1007	������	    0204053234567	����	21	2010-10-10	1000
1008	������	    6803171234567	����	55	1998-10-10	1500
1009	������	6912232234567	����	54	1998-10-10	1300
1010	���켱	    0303044234567	����	20	2010-10-10	1600
1011	������	    0506073234567	����	18	2012-10-10	2600
1012	���ù�	    0208073234567	����	21	2012-10-10	2600
1013	����	    6712121234567	����	56	1998-10-10	2200
1014	ȫ����	    0005044234567	����	23	2015-10-10	5200
1015	�Ӽҹ�	    9711232234567	����	26	2007-10-10	5500
1016	���̰�	    0603194234567	����	17	2015-01-20	1500
*/


--     , ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ� �߰��ϱ� 

SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
     -- ����������
     -- ���������⵵ �� �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��
     -- ���糪�� 57�� ... 3�� ��   2022�� �� 2025�� ����������
     -- ���糪�� 28�� ... 32����   2022�� �� 2054�� ����������
     -- ADD_MONTH(SYSDATE, �������*12)               ������� : 60 - ���糪��
     
     -- ADD_MONTH(SYSDATE, (60-T.���糪��)*12) ��  ���� �⵵�� �����
     -- TO_CHAR('T.�Ի���', 'YYYY')    �� �������� �⵵ ���ڷ� ���
     -- TO_CHAR(HIREDATE, 'MM-DD')     �� �Ի� ���ϸ� ����Ÿ������ ���
     -- TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.���糪��)*12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"
     
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"
     
     -- �ٹ� �ϼ�
     -- �ٹ� �ϼ� = ������ - �Ի��� 
     , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     
     -- �����ϼ� = ���������� - ������
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�" 
     
     -- �޿�
     , T.�޿�
     
     -- ���ʽ�
     -- �ٹ��ϼ� 1000�� �̻� 2000�� �̸� �� ���� �޿��� 30% ����
     -- �ٹ��ϼ� 2000�� �̻�             �� ���� �޿��� 50% ����
     -- ������                           �� 0
     ------------------------------------------------------------
     -- �ٹ��ϼ� 2000�� �̻�             �� T.�޿� * 0.5
     -- �ٹ��ϼ� 1000�� �̻�             �� T.�޿� * 0.3
     -- ������                           �� 0
     ------------------------------------------------------------
     , CASE  WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
             WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
             ELSE 0
       END "���ʽ�"

FROM 
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
                ELSE '���� Ȯ�� �Ұ�' 
           END "����"
           
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE  -1
            END "���糪��"
            
            ,HIREDATE "�Ի���"
            ,SAL "�޿�"
    FROM TBL_SAWON
) T;

/*
1001	��μ�	    9707251234567	����	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	������	    9505152234567	����	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	������	    9905192234567	����	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	�̿���	    9508162234567	����	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	    9805161234567	����	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	������	    8005122234567	����	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	������	    0204053234567	����	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	������	    6803171234567	����	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	������	6912232234567	����	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	���켱	    0303044234567	����	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	������	    0506073234567	����	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	���ù�	    0208073234567	����	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	����	    6712121234567	����	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	ȫ����	    0005044234567	����	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	    9711232234567	����	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	���̰�	    0603194234567	����	17	2015-01-20	2065-01-20	2591	15671	1500	 750
1017	��ȣ��	    9611121234567	����	27	2022-02-23	2055-02-23	   0	12052	5000	   0
*/


--�� TBL_SAWON ���̺� ������ �߰� �Է�
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1017, '��ȣ��', '9611121234567', SYSDATE, 5000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_SAWON;

--Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.



-- ������ ó���� ������ �������
-- Ư�� �ٹ��ϼ��� ����� Ȯ���ؾ� �Ѵٰų�...
-- Ư�� ���ʽ� �ݾ��� �޴� ����� Ȯ���ؾ� �� ��찡 �߻��� �� �ִ�.
-- �̿� ���� ���.. �ش� �������� �ٽ� �����ؾ� �ϴ� ���ŷ����� ���� �� �ֵ���
-- ��(VIEW)�� ����� ������ �� �� �ִ�.

CREATE TABLE TBL_TEST
( COL1 NUMBER
, COL2 VARCHAR2(30)
);

CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
     
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"

     , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
    
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�" 
     
     , T.�޿�
     
     , CASE  WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
             WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
             ELSE 0
       END "���ʽ�"
FROM 
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
                ELSE '���� Ȯ�� �Ұ�' 
           END "����"
           
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE  -1
            END "���糪��"
            
            ,HIREDATE "�Ի���"
            ,SAL "�޿�"
    FROM TBL_SAWON
) T;
--==>> �����߻�
-- (ORA-01031: insufficient privileges) �� ���� ���� 

--��SYS�κ��� CREATE VIEW ������ �ο������� ����......
CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
     
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"

     , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
    
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�" 
     
     , T.�޿�
     
     , CASE  WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
             WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
             ELSE 0
       END "���ʽ�"
FROM 
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
                ELSE '���� Ȯ�� �Ұ�' 
           END "����"
           
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE  -1
            END "���糪��"
            
            ,HIREDATE "�Ի���"
            ,SAL "�޿�"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_SAWON;

SELECT *
FROM VIEW_SAWON
WHERE �ٹ��ϼ� >= 5000;

SELECT *
FROM VIEW_SAWON
WHERE �����ϼ� >= 15000;

SELECT *
FROM VIEW_SAWON
WHERE ���ʽ� >=2000;
/*
1002	������	9505152234567	����	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1004	�̿���	9508162234567	����	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	9805161234567	����	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1014	ȫ����	0005044234567	����	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	9711232234567	����	26	2007-10-10	2056-10-10	5250	12647	5500	2750
*/

--�� VIEW ���� ���� TBL_SAWON ���̺� ������ �߰� �Է�
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1018, '�Ž���', '9910322234567', SYSDATE, 5000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM VIEW_SAWON;  
--==>> 1018	�Ž���	9910322234567	����	24	2022-02-23	2058-02-23	0	13148	5000	0

COMMIT;
--�� ���������� Ȱ���Ͽ�
--   TBL_SAWON ���̺��� ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
--------------------------------------------------------
�����  ����   ���糪��   �޿�    ���̺��ʽ�
--------------------------------------------------------

��, ���̺��ʽ��� ���� ���̰� 50�� �̻��̸� �޿��� 70%  
    40�� �̻� 50�� �̸� �̸� �޿��� 50%
    20�� �̻� 40�� �̸� �̸� �޿��� 30%
    
����, �ϼ��� ��ȸ ������ ���� 
VIEW_SAWON2 ��� �̸��� ��(VIEW)�� �����Ѵ�..
*/

SELECT T.�����, T.����, T.���糪��, T.�޿�
     , CASE WHEN T.���糪��>=50 THEN T.�޿�*0.7
            WHEN T.���糪��>=40 THEN T.�޿�*0.5
            WHEN T.���糪��>=20 THEN T.�޿�*0.3
     ELSE 0
     END "���� ���ʽ�"
FROM 
(
    SELECT SANAME "�����"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
                    WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
                    ELSE '���� Ȯ�� �Ұ�' 
               END "����" 
               
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE  -1
                END "���糪��"
        , SAL "�޿�"
    FROM TBL_SAWON
) T;
/*
��μ�	    ����	26	3000	 900
������	    ����	28	4000	1200
������	    ����	24	3000	 900
�̿���	    ����	28	4000	1200
���̻�	    ����	25	4000	1200
������	    ����	43	1000	 500
������	    ����	21	1000	 300
������	    ����	55	1500	1050
������	����	54	1300	 910
���켱	    ����	20	1600	 480
������	    ����	18	2600	   0
���ù�	    ����	21	2600	 780
����	    ����	56	2200	1540
ȫ����	    ����	23	5200	1560
�Ӽҹ�	    ����	26	5500	1650
���̰�	    ����	17	1500	   0
��ȣ��	    ����	27	5000	1500
�Ž���	    ����	24	5000	1500
*/
--�� VIEW_SAWON2 �����

CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.�����, T.����, T.���糪��, T.�޿�
     , CASE WHEN T.���糪��>=50 THEN T.�޿�*0.7
            WHEN T.���糪��>=40 THEN T.�޿�*0.5
            WHEN T.���糪��>=20 THEN T.�޿�*0.3
     ELSE 0
     END "���� ���ʽ�"
FROM 
(
    SELECT SANAME "�����"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '����'
                    WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '����'
                    ELSE '���� Ȯ�� �Ұ�' 
               END "����" 
               
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE  -1
                END "���糪��"
        , SAL "�޿�"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON2��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_SAWON2;

-----------------------------------------------------------------------------------------------

--�� RANK() �� ���(����)�� ��ȯ�ϴ� �Լ�
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     ,RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
/*
7839	KING	10	5000	 1
7902	FORD	20	3000	 2
7788	SCOTT	20	3000	 2
7566	JONES	20	2975	 4
7698	BLAKE	30	2850	 5
7782	CLARK	10	2450	 6
7499	ALLEN	30	1600	 7
7844	TURNER	30	1500	 8
7934	MILLER	10	1300	 9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	 950	13
7369	SMITH	20	 800	14
*/

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
/*
7839	KING	10	5000	1	 1
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4
7698	BLAKE	30	2850	1	 5
7782	CLARK	10	2450	2	 6
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7934	MILLER	10	1300	3	 9
7521	WARD	30	1250	4	10
7654	MARTIN	30	1250	4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	 950	6	13
7369	SMITH	20	 800	5	14
*/
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP
ORDER BY DEPTNO;
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 6
7934	MILLER	10	1300	3	 9
7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	 800	5	14
7698	BLAKE	30	2850	1	 5
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	 950	6	13
*/

--�� DENSE_RANK() �� ������ ��ȯ�ϴ� �Լ� (���� ��� �־ ���� ��� ����)
                                        -- EX) ����2�� ���� �ص� 3�� ����

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP
ORDER BY DEPTNO;
/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	20	3000	1	2 
7788	SCOTT	20	3000	1	2 
7566	JONES	20	2975	2	3  << ���� 2���� �־ 4���� �ƴ϶� 3��
7876	ADAMS	20	1100	3	10
7369	SMITH	20	 800	4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	 950	5	11
*/

--�� EMP ���̺��� ��������͸�
--   �����, �μ���ȣ, ����, �μ�����������, ��ü�������� �׸����� ��ȸ�Ѵ�.
--   ��, ���⿡�� ������ �ռ� �����ߴ� ������ ��å�� �����ϴ�.

SELECT *
FROM EMP;

SELECT ENAME "�����", DEPTNO "�μ���ȣ" 
     , SAL*12+NVL(COMM,0) "����"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY (SAL*12+NVL(COMM,0)) DESC) "�μ�����������"
     , RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) "��ü��������"
FROM EMP;
/*
KING	10	60000	1	1
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
BLAKE	30	34200	1	5
CLARK	10	29400	2	6
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
MILLER	10	15600	3	10
WARD	30	15500	5	11
ADAMS	20	13200	4	12
JAMES	30	11400	6	13
SMITH	20	9600	5	14
*/

SELECT T.*
     , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.���� DESC) "�μ�����������"
     , RANK() OVER(ORDER BY T.���� DESC) "��ü��������" 
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
    FROM EMP
) T;
/*
KING	10	60000	1	1
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
BLAKE	30	34200	1	5
CLARK	10	29400	2	6
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
MILLER	10	15600	3	10
WARD	30	15500	5	11
ADAMS	20	13200	4	12
JAMES	30	11400	6	13
SMITH	20	9600	5	14
*/

--�� EMP ���̺��� ��ü ���� ��� (����)�� 1����� 5�� ������...
--   �����, �μ���ȣ, ����, ��ü�������� �׸����� ��ȸ�Ѵ�.

SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) "��ü��������"
FROM EMP
WHERE RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) <=5;
--==>> �����߻�
--    (ORA-30483: window  functions are not allowed here)

--�� ���� ������ RANK() OVER() �� ���� �м��Լ�(WINDOW)�� WHERE ������ ����� ����̸�...
--   �� �Լ��� WHERE ���������� ����� �� ���⶧���� �߻��ϴ� �����̴�
--   �� ���, �츮�� INLINE VIEW�� Ȱ���� Ǯ���ؾ� �Ѵ�.


SELECT T.�����, T.�μ���ȣ, T.����, T."��ü��������"
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) "��ü��������"
    FROM EMP
) T
WHERE T.��ü��������<6;
/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/

--�� EMP ���̺��� �� �μ����� ��������� 1����� 2�� ������ ��ȸ�Ѵ�. 
--  �����, �μ���ȣ, ����, �μ����������, ��ü������� �׸��� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY (SAL*12+NVL(COMM,0)) DESC) "�μ�����������"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) "��ü��������"   
    FROM EMP
) T
WHERE T.�μ����������� <=2;
/*
KING	10	60000	1	1
CLARK	10	29400	2	6
FORD	20	36000	1	2
SCOTT	20	36000	1	2
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
*/
----------------------------------------------------------------------------------

--���� �׷� �Լ� ����--

--SUM(), AVG() ���, COUNT() ī��Ʈ, MAX() �ִ밪, MIN() �ּҰ�
--, VERIENCE() �л�, STDDEV() ǥ������

--�� �׷� �Լ��� ���� ū Ư¡
--   ó���ؾ��� �����͵� �� NULL�� �����Ѵٸ�(���ԵǾ� �ִٸ�)
--   �� NULL�� ������ ���·� ������ �����Ѵٴ� ���̴�.
--   ��, �׷� �Լ��� �۵��ϴ� �������� NULL�� ������ ��󿡼� ���ܵȴ�.

--�� SUM() ��
--EMP ���̺��� ������� ��ü ������� �޿� ������ ���غ���.

SELECT SAL
FROM EMP;
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
*/

SELECT SUM(SAL)
FROM EMP;
--==>> 29025

SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> �����߻�
--    (ORA-00937: not a single-group group function)
-- ���� �ȵǴ� ���� �̸��� 16LOWS SUM�� 1��

SELECT COMM
FROM EMP;
/*
(NULL)
300
500
(NULL)
1400
(NULL)
(NULL)
(NULL)
(NULL)
0
(NULL)
(NULL)
(NULL)
(NULL)
*/

SELECT SUM(COMM)
FROM EMP;
--==>> 2200 (NULL�� ��ŵ�ȴ�.)

--�� COUNT() ��(���ڵ�)�� ���� ��ȸ �� �����Ͱ� �� ������ Ȯ��
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)  -- NULL�� �� ��ŵ �ǹ��Ǵ�,..
FROM EMP;
--==>> 4

SELECT COUNT(*)
FROM EMP;
--==>> 14 NULL�� �ֵѸ��� �ʰ� ī��Ʈ �Ϸ���...


--�� AVG() ��� ��ȯ �Լ�
SELECT SUM(SAL)  / COUNT(SAL) "�޿����" -- 2073.214285714285714285714285714285714286
     , AVG(SAL)                          -- 2073.214285714285714285714285714285714286
FROM EMP;

SELECT SUM(COMM)/COUNT(COMM) "RESULT1" -- 550 �̰� ����ε� �����?
     , AVG(COMM)                       -- 550 Ŀ�̼� NULL�λ���� 10���� �� 10�� ��������
FROM EMP;                              -- �и� �߸���

SELECT SUM(COMM)/COUNT(*)              -- 157.142857142857142857142857142857142857 �̰� ����ε� ���
FROM EMP;


--�� VARIANCE(), STDDEV()
--  �� ǥ�������� ���� �л�, �л��� �������� ǥ������

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
/*
1398313.87362637362637362637362637362637	1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL), 2) "RESULT1"     -- 1398313.87362637362637362637362637362637
     , VARIANCE(SAL)                       -- 1398313.87362637362637362637362637362637
FROM EMP;

SELECT SQRT(VARIANCE(SAL)) "RESULT1"     -- 1182.503223516271699458653359613061928508
     , STDDEV(SAL)                       -- 1182.503223516271699458653359613061928508
FROM EMP;


--�� MAX() / MIN()
--  �ִ밪 / �ּҰ�

SELECT MAX(SAL)   -- 5000
     , MIN(SAL)   --  800
FROM EMP;


--�� ����
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> �����߻�
--    (ORA-00937: not a single-group group function)
-- ���� �ȵǴ� ���� �̸��� 16LOWS SUM�� 1��


SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==>> �����߻�
--    (ORA-00937: not a single-group group function)

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
/*
30	 9400
20	10875
10	 8750
*/


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
/*
10	8750
20	10875
30	9400
*/