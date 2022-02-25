SELECT USER
FROM DUAL;
-->> HR

--�� �� �� �̻��� ���̺� ����(JOIN)

-- ���� 1. (SQL 1992 CODE)

SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1, ���̺��2, ���̺��3
WHERE ���̺��1.�÷���1 = ���̺��2.�÷���1 
  AND ���̺��2.�÷���2 = ���̺��3.�÷���2;


-- ���� 2. (SQL 1999 CODE)

SELECT ���̺��1.�÷���, ���̺��2.�÷���
FROM ���̺��1 JOIN ���̺��2
ON ���̺��1.�÷���1 = ���̺��2.�÷���1
                 JOIN ���̺��3
                 ON ���̺��2.�÷��� = ���̺��3.�÷���2;
                 
--�� HR ���� ������ ���̺� �Ǵ� �� ��� ��ȸ
SELECT *
FROM TAB;
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/

--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� ������� �������� �����͸�
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME �׸����� ��ȸ�Ѵ�.
SELECT *
FROM JOBS;
-- JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY

SELECT *
FROM employees;
/*
EMPLOYEE_ID 
FIRST_NAME 
LAST_NAME                 
EMAIL                     
PHONE_NUMBER         
HIRE_DATE  
JOB_ID   �θ� : JOBS , JOBS�� �����
SALARY 
COMMISSION_PCT   
MANAGER_ID 
DEPARTMENT_ID 
*/

SELECT *
FROM DEPARTMENTS;
/*
DEPARTMENT_ID
DEPARTMENT_NAME
MANAGER_ID 
LOCATION_ID
*/

--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� ������� �������� �����͸�
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME �׸����� ��ȸ�Ѵ�.

--VER.92     
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J,  EMPLOYEES E , DEPARTMENTS D
WHERE E.JOB_ID = J.JOB_ID
AND   E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

--VER.99     
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J JOIN EMPLOYEES E
ON E.JOB_ID = J.JOB_ID
           LEFT JOIN DEPARTMENTS D
            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- EMPLOYEES �� ���� ������ �����ϱ�
-- �װ� ���� �� �ҷ��ͼ� ���ߴ°� ������ 
-- Kimberely ���� DEPARTMENT_ID�� ���� ������ EQUI JOIN�̳� OUTER JOIN �����ָ� 
-- Kimberely ���� �����ȴ�.

--�� EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS ���̺��� �������
--   �������� �����͸� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
--     E            E          J         D               L          C          R

SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM JOBS;

SELECT *
FROM LOCATIONS;

SELECT *
FROM COUNTRIES;

SELECT *
FROM REGIONS;

--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
--     E            E          J         D               L          C          R

--VER 92
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.JOB_ID = J.JOB_ID
AND   E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND   D.LOCATION_ID = L.LOCATION_ID(+)
AND   L.COUNTRY_ID = C.COUNTRY_ID(+)
AND   C.REGION_ID = R.REGION_ID(+);


--VER 99
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID 
         JOIN JOBS J
         ON E.JOB_ID = J.JOB_ID
            LEFT JOIN LOCATIONS L
            ON D.LOCATION_ID = L.LOCATION_ID
                LEFT JOIN COUNTRIES C
                ON L.COUNTRY_ID = C.COUNTRY_ID
                    LEFT JOIN REGIONS R
                    ON C.REGION_ID = R.REGION_ID ;
                    
-- JOBS ���̺�� EMPLOYEES ���� �� OUTER JOIN �����
-- Kimberely ���� ���°� DEPARTMENT_ID 
-- DEPARTMENT_ID �� ������ JOBS ���̺��� �����ϰ� ���̺��� �ΰ����谡 �־ 
-- OUTER ��� ���ִ°� �߿�


