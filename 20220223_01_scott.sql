SELECT USER
FROM DUAL;
--==>> SCOTT


--○ TBL_SAWON 테이블을 활용하여
--   다음과 같은 항목을 조회할 수 잇도록 쿼리문 구성
--   사원번호, 사원명, 주민번호, 성별, 입사일


SELECT *
FROM TBL_SAWON;


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
            ELSE '성별확인불가'
       END "성별"
FROM TBL_SAWON;
/*
1001	김민성	    9707251234567	남성
1002	서민지	    9505152234567	여성
1003	이지연	    9905192234567	여성
1004	이연주	    9508162234567	여성
1005	오이삭	    9805161234567	남성
1006	이현이	    8005122234567	여성
1007	박한이	    0204053234567	남성
1008	선동렬	    6803171234567	남성
1009	선우용녀	6912232234567	여성
1010	선우선	    0303044234567	여성
1011	남주혁	    0506073234567	남성
1012	남궁민	    0208073234567	남성
1013	남진	    6712121234567	남성
1014	홍수민	    0005044234567	여성
1015	임소민	    9711232234567	여성
1016	이이경	    0603194234567	여성
*/

--○ TBL_SAWON 테이블을 활용하여
--   다음과 같은 항목들을 조회할 수 있도록 쿼리문을 구성한다
--   『사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--     , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스』
--   단, 현재 나이는 기본 한국나이 계산법에 따라 연산을 수행한다.
--   또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해의
--   그 직원의 입사 월, 일로 연산을 수행한다.
--   그리고, 보너스는 1000일 이상 2000일 미만 근무한 사원은
--   그 사원의 원래 급여 기준 30% 지급, 2000일 이상 근무한 사원은
--   그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.

-- EX) 1001 김민성 9707251234567 남성 26 2005-01-03 2056-01-03 근무일수 남은일수 3000 1500

SELECT SANO "사원번호" , SANAME "사원명", JUBUN "주민번호"
------------------[성별 확인]-------------------------------------------------------------------

     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
            ELSE '성별확인불가'
       END "성별" 
------------------[나이 확인]------------------------------------------------------------------       

     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') THEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') THEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999)
            ELSE 0
       END  "현재나이"
-----------------------------------------------------------------------------------------------      
     , HIREDATE "입사일"
------------------[정년 퇴직일]----------------------------------------------------------------     

     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2')
            THEN TO_CHAR(ADD_MONTHS(SYSDATE, (((60-(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) 
                        - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899))))*12)), 'YYYY') ||'-'||TO_CHAR(HIREDATE, 'MM-DD') 
            
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
            THEN TO_CHAR(ADD_MONTHS(SYSDATE, (((60-(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) 
                        - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999))))*12)), 'YYYY') ||'-'||TO_CHAR(HIREDATE, 'MM-DD') 
            ELSE '0'
       END
         "정년퇴직일"
----------------[근무 일수]---------------------------------------------------------------------    
     , TRUNC(SYSDATE - HIREDATE)
         "근무일수"
----------------[남은 일수]---------------------------------------------------------------------    

     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') THEN
            TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (((60-(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) 
            - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899))))*12)), 'YYYY') ||'-'||TO_CHAR(HIREDATE, 'MM-DD'), 'YYYY-MM-DD') 
            - SYSDATE)
     
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') THEN 
            TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (((60-(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) 
            - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999))))*12)), 'YYYY') ||'-'||TO_CHAR(HIREDATE, 'MM-DD'), 'YYYY-MM-DD') 
            - SYSDATE)  
        ELSE 0
        END  "남은일수"
------------------------------------------------------------------------------------------------    
     , SAL "급여"
----------------[보너스]------------------------------------------------------------------------

     , CASE WHEN 1000 <= TRUNC(SYSDATE - HIREDATE) AND TRUNC(SYSDATE - HIREDATE) < 2000 THEN
            SAL * 0.3
            WHEN  TRUNC(SYSDATE - HIREDATE) > 2000 THEN  
            SAL * 0.5
            ELSE 0 
            END "보너스"
FROM TBL_SAWON;
/*
1001	김민성	    9707251234567	남성	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	    9505152234567	여성	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	    9905192234567	여성	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	    9508162234567	여성	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	    9805161234567	남성	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	    8005122234567	여성	43	1999-10-10	2039-10-10	8172	6437	1000	500
1007	박한이	    0204053234567	남성	21	2010-10-10	2061-10-10	4154	14473	1000	500
1008	선동렬	    6803171234567	남성	55	1998-10-10	2027-10-10	8537	2054	1500	750
1009	선우용녀	6912232234567	여성	54	1998-10-10	2028-10-10	8537	2420	1300	650
1010	선우선	    0303044234567	여성	20	2010-10-10	2062-10-10	4154	14838	1600	800
1011	남주혁	    0506073234567	남성	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	남궁민	    0208073234567	남성	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	남진	    6712121234567	남성	56	1998-10-10	2026-10-10	8537	1689	2200	1100
1014	홍수민	    0005044234567	여성	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	    9711232234567	여성	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	이이경	    0603194234567	여성	17	2015-01-20	2065-01-20	2591	15671	1500	750
*/


------------------------------------------------------------------------------------------------------
-- 같이 푼 풀이

-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여 ...

SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
            ELSE '성별 확인 불가' 
       END "성별"
       
      --현재 나이 = 현재년도 - 태어난년도 + 1 (1900/2000년대 생 구분 필요) 
       , CASE WHEN 1900년대 생이라면 THEN 현재년도 - (주민번호앞두자리 + 1899) 
              WHEN 2000년대 생이라면 THEN 현재년도 - (주민번호앞두자리 + 1999)
       
       ELSE END "현재나이", 입사일, 급여
FROM TBL_SAWON;


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
            WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
            ELSE '성별 확인 불가' 
       END "성별"
       
      --현재 나이 = 현재년도 - 태어난년도 + 1 (1900/2000년대 생 구분 필요) 
       , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
              WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE  -1
        END "현재나이"
        
        ,HIREDATE "입사일"
        ,SAL "급여"
FROM TBL_SAWON;
/*
1001	김민성	    9707251234567	남성	26	2005-01-03	3000
1002	서민지	    9505152234567	여성	28	1999-11-23	4000
1003	이지연	    9905192234567	여성	24	2006-08-10	3000
1004	이연주	    9508162234567	여성	28	2007-10-10	4000
1005	오이삭	    9805161234567	남성	25	2007-10-10	4000
1006	이현이	    8005122234567	여성	43	1999-10-10	1000
1007	박한이	    0204053234567	남성	21	2010-10-10	1000
1008	선동렬	    6803171234567	남성	55	1998-10-10	1500
1009	선우용녀	6912232234567	여성	54	1998-10-10	1300
1010	선우선	    0303044234567	여성	20	2010-10-10	1600
1011	남주혁	    0506073234567	남성	18	2012-10-10	2600
1012	남궁민	    0208073234567	남성	21	2012-10-10	2600
1013	남진	    6712121234567	남성	56	1998-10-10	2200
1014	홍수민	    0005044234567	여성	23	2015-10-10	5200
1015	임소민	    9711232234567	여성	26	2007-10-10	5500
1016	이이경	    0603194234567	여성	17	2015-01-20	1500
*/


--     , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스 추가하기 

SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     -- 정년퇴직일
     -- 정년퇴직년도 → 해당 직원의 나이가 한국나이로 60세가 되는 해
     -- 현재나이 57세 ... 3년 후   2022년 → 2025년 정년퇴직해
     -- 현재나이 28세 ... 32년후   2022년 → 2054년 정년퇴직해
     -- ADD_MONTH(SYSDATE, 남은년수*12)               남은년수 : 60 - 현재나이
     
     -- ADD_MONTH(SYSDATE, (60-T.현재나이)*12) →  이제 년도만 쓰면됨
     -- TO_CHAR('T.입사일', 'YYYY')    → 정년퇴직 년도 문자로 출력
     -- TO_CHAR(HIREDATE, 'MM-DD')     → 입사 월일만 문자타입으로 출력
     -- TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.현재나이)*12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
     
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
     
     -- 근무 일수
     -- 근무 일수 = 현재일 - 입사일 
     , TRUNC(SYSDATE - T.입사일) "근무일수"
     
     -- 남은일수 = 정년퇴직일 - 현재일
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수" 
     
     -- 급여
     , T.급여
     
     -- 보너스
     -- 근무일수 1000일 이상 2000일 미만 → 원래 급여의 30% 지급
     -- 근무일수 2000일 이상             → 원래 급여의 50% 지급
     -- 나머지                           → 0
     ------------------------------------------------------------
     -- 근무일수 2000일 이상             → T.급여 * 0.5
     -- 근무일수 1000일 이상             → T.급여 * 0.3
     -- 나머지                           → 0
     ------------------------------------------------------------
     , CASE  WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
             WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
             ELSE 0
       END "보너스"

FROM 
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
                ELSE '성별 확인 불가' 
           END "성별"
           
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE  -1
            END "현재나이"
            
            ,HIREDATE "입사일"
            ,SAL "급여"
    FROM TBL_SAWON
) T;

/*
1001	김민성	    9707251234567	남성	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	    9505152234567	여성	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	    9905192234567	여성	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	    9508162234567	여성	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	    9805161234567	남성	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	    8005122234567	여성	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	박한이	    0204053234567	남성	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	선동렬	    6803171234567	남성	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	선우용녀	6912232234567	여성	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	선우선	    0303044234567	여성	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	남주혁	    0506073234567	남성	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	남궁민	    0208073234567	남성	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	남진	    6712121234567	남성	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	홍수민	    0005044234567	여성	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	    9711232234567	여성	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	이이경	    0603194234567	여성	17	2015-01-20	2065-01-20	2591	15671	1500	 750
1017	이호석	    9611121234567	남성	27	2022-02-23	2055-02-23	   0	12052	5000	   0
*/


--○ TBL_SAWON 테이블에 데이터 추가 입력
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1017, '이호석', '9611121234567', SYSDATE, 5000);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_SAWON;

--커밋
COMMIT;
--==>> 커밋 완료.



-- 위에서 처리한 내용을 기반으로
-- 특정 근무일수의 사원을 확인해야 한다거나...
-- 특정 보너스 금액을 받는 사원을 확인해야 할 경우가 발생할 수 있다.
-- 이와 같은 경우.. 해당 쿼리문을 다시 구성해야 하는 번거러움을 줄일 수 있도록
-- 뷰(VIEW)를 만들어 저장해 둘 수 있다.

CREATE TABLE TBL_TEST
( COL1 NUMBER
, COL2 VARCHAR2(30)
);

CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"

     , TRUNC(SYSDATE - T.입사일) "근무일수"
    
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수" 
     
     , T.급여
     
     , CASE  WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
             WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
             ELSE 0
       END "보너스"
FROM 
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
                ELSE '성별 확인 불가' 
           END "성별"
           
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE  -1
            END "현재나이"
            
            ,HIREDATE "입사일"
            ,SAL "급여"
    FROM TBL_SAWON
) T;
--==>> 에러발생
-- (ORA-01031: insufficient privileges) → 권한 부족 

--○SYS로부터 CREATE VIEW 권한을 부여받은후 실행......
CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
     
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"

     , TRUNC(SYSDATE - T.입사일) "근무일수"
    
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수" 
     
     , T.급여
     
     , CASE  WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
             WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
             ELSE 0
       END "보너스"
FROM 
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
                ELSE '성별 확인 불가' 
           END "성별"
           
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE  -1
            END "현재나이"
            
            ,HIREDATE "입사일"
            ,SAL "급여"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON이(가) 생성되었습니다.

SELECT *
FROM VIEW_SAWON;

SELECT *
FROM VIEW_SAWON
WHERE 근무일수 >= 5000;

SELECT *
FROM VIEW_SAWON
WHERE 남은일수 >= 15000;

SELECT *
FROM VIEW_SAWON
WHERE 보너스 >=2000;
/*
1002	서민지	9505152234567	여성	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1004	이연주	9508162234567	여성	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	9805161234567	남성	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1014	홍수민	0005044234567	여성	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	9711232234567	여성	26	2007-10-10	2056-10-10	5250	12647	5500	2750
*/

--○ VIEW 생성 이후 TBL_SAWON 테이블에 데이터 추가 입력
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1018, '신시은', '9910322234567', SYSDATE, 5000);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM VIEW_SAWON;  
--==>> 1018	신시은	9910322234567	여성	24	2022-02-23	2058-02-23	0	13148	5000	0

COMMIT;
--○ 서브쿼리를 활용하여
--   TBL_SAWON 테이블을 다음과 같이 조회할 수 있도록 한다.
/*
--------------------------------------------------------
사원명  성별   현재나이   급여    나이보너스
--------------------------------------------------------

단, 나이보너스는 현재 나이가 50세 이상이면 급여의 70%  
    40세 이상 50세 미만 이면 급여의 50%
    20세 이상 40세 미만 이면 급여의 30%
    
또한, 완성된 조회 구문을 통해 
VIEW_SAWON2 라는 이름의 뷰(VIEW)를 생성한다..
*/

SELECT T.사원명, T.성별, T.현재나이, T.급여
     , CASE WHEN T.현재나이>=50 THEN T.급여*0.7
            WHEN T.현재나이>=40 THEN T.급여*0.5
            WHEN T.현재나이>=20 THEN T.급여*0.3
     ELSE 0
     END "나이 보너스"
FROM 
(
    SELECT SANAME "사원명"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
                    WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
                    ELSE '성별 확인 불가' 
               END "성별" 
               
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE  -1
                END "현재나이"
        , SAL "급여"
    FROM TBL_SAWON
) T;
/*
김민성	    남성	26	3000	 900
서민지	    여성	28	4000	1200
이지연	    여성	24	3000	 900
이연주	    여성	28	4000	1200
오이삭	    남성	25	4000	1200
이현이	    여성	43	1000	 500
박한이	    남성	21	1000	 300
선동렬	    남성	55	1500	1050
선우용녀	여성	54	1300	 910
선우선	    여성	20	1600	 480
남주혁	    남성	18	2600	   0
남궁민	    남성	21	2600	 780
남진	    남성	56	2200	1540
홍수민	    여성	23	5200	1560
임소민	    여성	26	5500	1650
이이경	    여성	17	1500	   0
이호석	    남성	27	5000	1500
신시은	    여성	24	5000	1500
*/
--○ VIEW_SAWON2 만들기

CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.사원명, T.성별, T.현재나이, T.급여
     , CASE WHEN T.현재나이>=50 THEN T.급여*0.7
            WHEN T.현재나이>=40 THEN T.급여*0.5
            WHEN T.현재나이>=20 THEN T.급여*0.3
     ELSE 0
     END "나이 보너스"
FROM 
(
    SELECT SANAME "사원명"
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('2','4') THEN '여성'
                    WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','3') THEN '남성'
                    ELSE '성별 확인 불가' 
               END "성별" 
               
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN  ('1','2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                    WHEN SUBSTR(JUBUN, 7, 1) IN  ('3','4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE  -1
                END "현재나이"
        , SAL "급여"
    FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON2이(가) 생성되었습니다.

SELECT *
FROM VIEW_SAWON2;

-----------------------------------------------------------------------------------------------

--○ RANK() → 등수(순위)를 반환하는 함수
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     ,RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
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

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
     , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
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
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
     , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
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

--○ DENSE_RANK() → 서열을 반환하는 함수 (공동 등수 있어도 다음 등수 존재)
                                        -- EX) 공동2등 존재 해도 3등 존재

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP
ORDER BY DEPTNO;
/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	20	3000	1	2 
7788	SCOTT	20	3000	1	2 
7566	JONES	20	2975	2	3  << 공동 2등이 있어도 4등이 아니라 3등
7876	ADAMS	20	1100	3	10
7369	SMITH	20	 800	4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	 950	5	11
*/

--○ EMP 테이블의 사원데이터를
--   사원명, 부서번호, 연봉, 부서내연봉순위, 전체연봉순위 항목으로 조회한다.
--   단, 여기에서 연봉은 앞서 구성했던 연봉의 정책과 동일하다.

SELECT *
FROM EMP;

SELECT ENAME "사원명", DEPTNO "부서번호" 
     , SAL*12+NVL(COMM,0) "연봉"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY (SAL*12+NVL(COMM,0)) DESC) "부서내연봉순위"
     , RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) "전체연봉순위"
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
     , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내연봉순위"
     , RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위" 
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉"
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

--○ EMP 테이블에서 전체 연봉 등수 (순위)가 1등부터 5등 까지만...
--   사원명, 부서번호, 연봉, 전체연봉순위 항목으로 조회한다.

SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) "전체연봉순위"
FROM EMP
WHERE RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) <=5;
--==>> 에러발생
--    (ORA-30483: window  functions are not allowed here)

--※ 위의 내용은 RANK() OVER() 와 같은 분석함수(WINDOW)를 WHERE 절에서 사용한 경우이며...
--   이 함수는 WHERE 조건절에서 사용할 수 없기때문에 발생하는 에러이다
--   이 경우, 우리는 INLINE VIEW를 활용해 풀이해야 한다.


SELECT T.사원명, T.부서번호, T.연봉, T."전체연봉순위"
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) "전체연봉순위"
    FROM EMP
) T
WHERE T.전체연봉순위<6;
/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/

--○ EMP 테이블에서 각 부서별로 연봉등수가 1등부터 2등 까지만 조회한다. 
--  사원명, 부서번호, 연봉, 부서내연봉등수, 전체연봉등수 항목을 조회할 수 있도록 쿼리문을 구성한다.
SELECT T.*
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY (SAL*12+NVL(COMM,0)) DESC) "부서내연봉순위"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM,0)) DESC) "전체연봉순위"   
    FROM EMP
) T
WHERE T.부서내연봉순위 <=2;
/*
KING	10	60000	1	1
CLARK	10	29400	2	6
FORD	20	36000	1	2
SCOTT	20	36000	1	2
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
*/
----------------------------------------------------------------------------------

--■■■ 그룹 함수 ■■■--

--SUM(), AVG() 평균, COUNT() 카운트, MAX() 최대값, MIN() 최소값
--, VERIENCE() 분산, STDDEV() 표준편차

--※ 그룹 함수의 가장 큰 특징
--   처리해야할 데이터들 중 NULL이 존재한다면(포함되어 있다면)
--   이 NULL은 제외한 상태로 연산을 수행한다는 것이다.
--   즉, 그룹 함수가 작동하는 과정에서 NULL은 연산의 대상에서 제외된다.

--○ SUM() 합
--EMP 테이블을 대상으로 전체 사원들의 급여 총합을 구해보자.

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
--==>> 에러발생
--    (ORA-00937: not a single-group group function)
-- 말이 안되는 구문 이름은 16LOWS SUM은 1개

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
--==>> 2200 (NULL은 스킵된다.)

--○ COUNT() 행(레코드)의 갯수 조회 → 데이터가 몇 건인지 확인
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)  -- NULL이 다 스킵 되버렷다,..
FROM EMP;
--==>> 4

SELECT COUNT(*)
FROM EMP;
--==>> 14 NULL에 휘둘리지 않고 카운트 하려면...


--○ AVG() 평균 반환 함수
SELECT SUM(SAL)  / COUNT(SAL) "급여평균" -- 2073.214285714285714285714285714285714286
     , AVG(SAL)                          -- 2073.214285714285714285714285714285714286
FROM EMP;

SELECT SUM(COMM)/COUNT(COMM) "RESULT1" -- 550 이게 제대로된 평균임?
     , AVG(COMM)                       -- 550 커미션 NULL인사람이 10명임 그 10명 빠져버림
FROM EMP;                              -- 분모가 잘못됨

SELECT SUM(COMM)/COUNT(*)              -- 157.142857142857142857142857142857142857 이게 제대로된 평균
FROM EMP;


--○ VARIANCE(), STDDEV()
--  ※ 표준편차의 제곱 분산, 분산의 제곱근이 표준편차

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


--○ MAX() / MIN()
--  최대값 / 최소값

SELECT MAX(SAL)   -- 5000
     , MIN(SAL)   --  800
FROM EMP;


--※ 주의
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> 에러발생
--    (ORA-00937: not a single-group group function)
-- 말이 안되는 구문 이름은 16LOWS SUM은 1개


SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==>> 에러발생
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