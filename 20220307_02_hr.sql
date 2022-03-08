SELECT USER
FROM DUAL;
--==>> HR

-- �� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�.
--    ��, �μ����� 'IT'�� �����鸸 �����Ѵ�.
--    (����, ���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�.)

SELECT EMPLOYEE_ID, SALARY, SALARY * 1.1 "�λ�ȱ޿�"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;
/*
103	9000	9900
104	6000	6600
105	4800	5280
106	4800	5280
107	4200	4620
*/
SELECT *
FROM DEPARTMENTS;

-- ���μ���ȣ�� �� 
--  (�μ���ȣ / �μ����̺� / �μ��̸��� IT�� ������) �� ���ٴ� ���Ǹ����
--  ��
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
--==>> 5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


-- Ȯ��
SELECT SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
/*
9900
6600
5280
5280
4620
*/

-- �ѹ�
ROLLBACK;
�ѹ� �Ϸ�.

-- �ѹ鿩��Ȯ��
SELECT SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
/*
9000
6000
4800
4800
4200
*/

-- �� EMPLOYEES ���̺��� JOB_TITLE �� ��Sales Manager�� �� �������
--    SALARY �� �ش� ����(����)�� �ְ�޿�(MAX_SALARY)�� �����Ѵ�.
--    ��, �Ի����� 2006�� ����(�ش�⵵����) �Ի��ڿ� ���� ����.
--    (����, ���濡 ���� ��� Ȯ�� �� ROLLBACK ����)

-- ���� �� Sales Manager�� �Ի���, �޿�
SELECT HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' );
/*
2004-10-01	14000
2005-01-05	13500
2005-03-10	12000
2007-10-15	11000
2008-01-29	10500
*/

--  Sales Manager�� �Ի���, �޿� ����
--  ���� 1 : ������ Sales Manager
--  ���� 2 : �ش� �μ����� 2006�� ���� �Ի��ڸ�

--  �����ؾ��� �޿� : �ش�μ� ��ü���� �� ���� ���� �޿��� ����

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX(SALARY)
              FROM EMPLOYEES
              WHERE JOB_ID = (SELECT JOB_ID
                              FROM JOBS
                              WHERE JOB_TITLE = 'Sales Manager' ))
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' )  
  AND EXTRACT (YEAR FROM HIRE_DATE) < 2006;          
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- ���� ��  Sales Manager�� �Ի���, �޿� Ȯ��
SELECT HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' );
/*
2004-10-01	14000    ��
2005-01-05	14000    ����   2006�� ���� �Ի��ڵ� ���� �Ϸ�
2005-03-10	14000    ��
2007-10-15	11000
2008-01-29	10500
*/         

-- �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.

-- �ѹ� Ȯ��
SELECT HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' );
/*
2004-10-01	14000  
2005-01-05	13500
2005-03-10	12000
2007-10-15	11000
2008-01-29	10500
*/ -- �̻� ����
---------------------------------------------------------------------------------
-- ������ Ǯ��
-- �� EMPLOYEES ���̺��� JOB_TITLE �� ��Sales Manager�� �� �������
--    SALARY �� �ش� ����(����)�� �ְ�޿�(MAX_SALARY)�� �����Ѵ�.
--    ��, �Ի����� 2006�� ����(�ش�⵵����) �Ի��ڿ� ���� ����.
--    (����, ���濡 ���� ��� Ȯ�� �� ROLLBACK ����)

SELECT * 
FROM EMPLOYEES;
SELECT *
FROM JOBS;
--==>> SA_MAN	Sales Manager	10000	20080

UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'�� MAX_SALARY)
WHERE JOB_ID = 'Sales Manager' 
    AND �Ի����� 2006�� ����;


UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'�� MAX_SALARY)
WHERE JOB_ID = ('Sales Manager' �� JOB_ID)
    AND TO_CHAR(HIRE_DATE, 'YYYY') < 2006;

UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'�� MAX_SALARY)
WHERE JOB_ID = ('Sales Manager' �� JOB_ID)
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
-- 'Sales Manager'�� MAX_SALARY

SELECT MAX_SALARY
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> 20080

UPDATE EMPLOYEES
SET SALARY = (20080)
WHERE JOB_ID = ('Sales Manager' �� JOB_ID)
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = ('Sales Manager' �� JOB_ID)
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;

-- 'Sales Manager' �� JOB_ID

SELECT JOB_ID 
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> SA_MAN
-------------------��������� 
UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID 
                   FROM JOBS
                   WHERE JOB_TITLE = 'Sales Manager')
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID 
                   FROM JOBS
                   WHERE JOB_TITLE = 'Sales Manager')
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;

/*
145	John	Russell	    JRUSSEL	    011.44.1344.429268	2004-10-01	SA_MAN	20080	0.4	100	80
146	Karen	Partners	KPARTNER	011.44.1344.467268	2005-01-05	SA_MAN	20080	0.3	100	80
147	Alberto	Errazuriz	AERRAZUR	011.44.1344.429278	2005-03-10	SA_MAN	20080	0.3	100	80
�� �ٲ� �մ�                                                                            -----
*/

ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� EMPLOYEES ���̺��� SALARY ��
--   �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--   Finance �� 10 % �λ�
--   Executive �� 15% �λ�
--   Accounting �� 20 % �λ�
--   ���濡 ���� ��� Ȯ�� �� rollback!

SELECT *
FROM DEPARTMENTS;


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Finance')
                                THEN SALARY * 1.1
                                WHEN  (SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = 'Executive') 
                                THEN SALARY * 1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Accounting')
                                THEN SALARY * 1.2
                                ELSE SALARY
                                END
WHERE DEPARTMENT_ID  IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN('Finance','Executive','Accounting'));
-->> 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT first_name, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID  IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN('Finance','Executive','Accounting'));;
/*
�ϱ� ��....
Steven	    24000	90
Neena	    17000	90
Lex	        17000	90
Nancy	    12008	100
Daniel	    9000	100
John	    8200	100
Ismael	    7700	100
Jose Manuel	7800	100
Luis	    6900	100
Shelley 	12008	110
William 	8300	110

�� �� 

Steven	    27600	90
Neena	    19550	90
Lex 	    19550	90
Nancy	    13208.8	100
Daniel	    9900	100
John	    9020	100
Ismael	    8470	100
Jose Manuel	8580	100
Luis	    7590	100
Shelley	    14409.6	110
William	    9960	110
*/

ROLLBACK;


---------------------------------------------------------------------------------
--���� DELETE ����--

-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴµ� ����ϴ� ����

-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];

-- ���̺� ���� 
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>>


SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 198	Donald	OConnell	DOCONNEL	650.507.9833	2007-06-21	SH_CLERK	2600		124	50


DELETE 
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198; 
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� EMPLOYEES ���̺��� �������� �����͸� �����Ѵ�.
--   ��, �μ����� 'IT'�� ���� ����..

--�� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ��� ������)
--   �ٸ� ���ڵ忡 ���� ���� ���ϰ� �ִ� ���
--   �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�
--   �׿� ���� ������ �˾ƾ� �Ѵ�.

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
/*
103	Alexander	Hunold	    AHUNOLD	    590.423.4567	2006-01-03	IT_PROG	9000		102	60
104	Bruce	    Ernst	    BERNST	    590.423.4568	2007-05-21	IT_PROG	6000		103	60
105	David	    Austin	    DAUSTIN	    590.423.4569	2005-06-25	IT_PROG	4800		103	60
106	Valli	    Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
107	Diana	    Lorentz 	DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60
*/

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ���� �߻�
--     (ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)
-- �̴� DEPARTMENTS ���̺��� MANAGER_ID�� ���� �߱� ������....

SELECT *
FROM view_constcheck
WHERE TABLE_NAME = 'DEPARTMENTS';
--==>> HR	DEPT_MGR_FK	DEPARTMENTS	R	MANAGER_ID		NO ACTION

--------------------------------------------------------------------------------
--���� ��(view)����--
-- 1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
--    �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸
--    ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸�� ��Ƽ�
--    �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.

--    ������ ���̺��̶�... �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
--    �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̶�� �ǹ��̸�,
--    �� ������ �����س��� SQL �����̶�� �� �� �ִ�.

-- 2. ���� �� ����
-- CREATE [OR REPLACE] VIEW ���̸�
-- [(ALIAS[, ALIAS, ....])]
-- AS
-- ��������(SUBQUERY)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]


--�� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID
    AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.

--�� ��(VIWE) ��ȸ
SELECT *
FROM VIEW_EMPLOYEES;


--�� �� ���� ��ȸ
DESC VIEW_EMPLOYEES;
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 

*/


--�� ��(VIEW) �ҽ� Ȯ�� (CHECK~!!)
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
/*
VIEW_EMPLOYEES	

"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID
    AND C.REGION_ID = R.REGION_ID"
*/

