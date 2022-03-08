SELECT USER
FROM DUAL;
--==>> HR

-- ○ EMPLOYEES 테이블의 직원들 SALARY 를 10% 인상한다.
--    단, 부서명이 'IT'인 직원들만 한정한다.
--    (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행한다.)

SELECT EMPLOYEE_ID, SALARY, SALARY * 1.1 "인상된급여"
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

-- 『부서번호』 가 
--  (부서번호 / 부서테이블 / 부서이름이 IT인 곳에서) 와 같다는 조건만들기
--  ↓
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
--==>> 5개 행 이(가) 업데이트되었습니다.


-- 확인
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

-- 롤백
ROLLBACK;
롤백 완료.

-- 롤백여부확인
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

-- ○ EMPLOYEES 테이블에서 JOB_TITLE 이 『Sales Manager』 인 사원들의
--    SALARY 를 해당 직무(직종)의 최고급여(MAX_SALARY)로 수정한다.
--    단, 입사일이 2006년 이전(해당년도제외) 입사자에 한해 적용.
--    (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행)

-- 변경 전 Sales Manager의 입사일, 급여
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

--  Sales Manager의 입사일, 급여 조장
--  조건 1 : 직종이 Sales Manager
--  조건 2 : 해당 부서에서 2006년 이전 입사자만

--  변경해야할 급여 : 해당부서 전체직원 중 가장 높은 급여로 변경

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
--==>> 3개 행 이(가) 업데이트되었습니다.

-- 변경 후  Sales Manager의 입사일, 급여 확인
SELECT HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' );
/*
2004-10-01	14000    ┐
2005-01-05	14000    │→   2006년 이전 입사자들 변경 완료
2005-03-10	14000    ┘
2007-10-15	11000
2008-01-29	10500
*/         

-- 롤백
ROLLBACK;
--==>> 롤백 완료.

-- 롤백 확인
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
*/ -- 이상 없음
---------------------------------------------------------------------------------
-- 선생님 풀이
-- ○ EMPLOYEES 테이블에서 JOB_TITLE 이 『Sales Manager』 인 사원들의
--    SALARY 를 해당 직무(직종)의 최고급여(MAX_SALARY)로 수정한다.
--    단, 입사일이 2006년 이전(해당년도제외) 입사자에 한해 적용.
--    (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행)

SELECT * 
FROM EMPLOYEES;
SELECT *
FROM JOBS;
--==>> SA_MAN	Sales Manager	10000	20080

UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'의 MAX_SALARY)
WHERE JOB_ID = 'Sales Manager' 
    AND 입사일이 2006년 이전;


UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'의 MAX_SALARY)
WHERE JOB_ID = ('Sales Manager' 의 JOB_ID)
    AND TO_CHAR(HIRE_DATE, 'YYYY') < 2006;

UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'의 MAX_SALARY)
WHERE JOB_ID = ('Sales Manager' 의 JOB_ID)
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
-- 'Sales Manager'의 MAX_SALARY

SELECT MAX_SALARY
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> 20080

UPDATE EMPLOYEES
SET SALARY = (20080)
WHERE JOB_ID = ('Sales Manager' 의 JOB_ID)
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = ('Sales Manager' 의 JOB_ID)
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;

-- 'Sales Manager' 의 JOB_ID

SELECT JOB_ID 
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> SA_MAN
-------------------결과적으로 
UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID 
                   FROM JOBS
                   WHERE JOB_TITLE = 'Sales Manager')
    AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--==>> 3개 행 이(가) 업데이트되었습니다.

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
잘 바껴 잇다                                                                            -----
*/

ROLLBACK;
--==>> 롤백 완료.

--○ EMPLOYEES 테이블에서 SALARY 를
--   각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--   Finance → 10 % 인상
--   Executive → 15% 인상
--   Accounting → 20 % 인상
--   변경에 대한 결과 확인 후 rollback!

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
-->> 11개 행 이(가) 업데이트되었습니다.

SELECT first_name, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID  IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN('Finance','Executive','Accounting'));;
/*
하기 전....
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

한 후 

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
--■■■ DELETE ■■■--

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는데 사용하는 구문

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];

-- 테이블 복사 
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
--==>> 1 행 이(가) 삭제되었습니다.


ROLLBACK;
--==>> 롤백 완료.

--○ EMPLOYEES 테이블에서 직원들의 데이터를 삭제한다.
--   단, 부서명이 'IT'인 경우로 한정..

--※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상 데이터)
--   다른 레코드에 의해 참조 당하고 있는 경우
--   삭제되지 않을 수 있다는 사실을 염두해야 하며
--   그에 대한 이유도 알아야 한다.

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
--==>> 오류 발생
--     (ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)
-- 이는 DEPARTMENTS 테이블에서 MANAGER_ID를 참조 했기 때문에....

SELECT *
FROM view_constcheck
WHERE TABLE_NAME = 'DEPARTMENTS';
--==>> HR	DEPT_MGR_FK	DEPARTMENTS	R	MANAGER_ID		NO ACTION

--------------------------------------------------------------------------------
--■■■ 뷰(view)■■■--
-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만
--    정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만을 모아서
--    만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.

--    가상의 테이블이란... 뷰가 실제로 존재하는 테이블(객체)이 아니라
--    하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이라는 의미이며,
--    그 정볼르 추출해내는 SQL 문장이라고 볼 수 있다.

-- 2. 형식 및 구조
-- CREATE [OR REPLACE] VIEW 뷰이름
-- [(ALIAS[, ALIAS, ....])]
-- AS
-- 서브쿼리(SUBQUERY)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]


--○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID
    AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.

--○ 뷰(VIWE) 조회
SELECT *
FROM VIEW_EMPLOYEES;


--○ 뷰 구조 조회
DESC VIEW_EMPLOYEES;
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 

*/


--○ 뷰(VIEW) 소스 확인 (CHECK~!!)
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

