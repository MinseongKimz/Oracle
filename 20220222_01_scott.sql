SELECT USER
FROM DUAL;
--==>> SCOTT


--○ ROUND() 반올림을 처리해 주는 함수
SELECT 48.678 "COL1"                                                            -- 48.678
     , ROUND(48.678, 2) "COL2"  -- 소숫점 이하 2번째 자리까지 표현              -- 48.68
     , ROUND(48.674, 2) "COL3"  -- 소숫점 이하 2번째 자리까지 표현              -- 48.67
     , ROUND(48.674, 1) "COL4"  -- 소숫점 이하 1번째 자리까지 표현              -- 48.7
     , ROUND(48.674, 0) "COL5"  -- 소숫점 이하 0번째 자리까지 표현              -- 49
     , ROUND(48.674) "COL6"     -- 소숫점 이하 0번째 자리까지 표현              -- 49
     , ROUND(48.674, -1) "COL7" -- 10의 자리까지만 표현(1의 자리에서 반올림)    -- 50
     , ROUND(48.674, -2) "COL8" -- 100의자리 까지만 표현(10의 자리에서 반올림)  -- 0
     , ROUND(48.674, -3) "COL9" -- 1000의자리 까지만 표현(100의 자리에서 반올림)-- 0
FROM DUAL;


--○ TRUNC() 절삭을 처리해 주는 함수 (반올림 X)
SELECT 48.678 "COL1"                                                            -- 48.678
     , TRUNC(48.678, 2) "COL2"  -- 소숫점 이하 2번째 자리까지 표현              -- 48.67
     , TRUNC(48.674, 2) "COL3"  -- 소숫점 이하 2번째 자리까지 표현              -- 48.67
     , TRUNC(48.674, 1) "COL4"  -- 소숫점 이하 1번째 자리까지 표현              -- 48.6
     , TRUNC(48.674, 0) "COL5"  -- 소숫점 이하 0번째 자리까지 표현              -- 48
     , TRUNC(48.674) "COL6"     -- 소숫점 이하 0번째 자리까지 표현              -- 48
     , TRUNC(48.674, -1) "COL7" -- 10의 자리까지만 표현(1의 자리에서 반올림)    -- 40
     , TRUNC(48.674, -2) "COL8" -- 100의자리 까지만 표현(10의 자리에서 반올림)  -- 0
     , TRUNC(48.674, -3) "COL9" -- 1000의자리 까지만 표현(100의 자리에서 반올림)-- 0
FROM DUAL;


--○ MOD() 나머지를 반환하는 함수
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1
-- 5를 2로 나눈 나머지 결과값 반환

--○ POWER() 제곱의 결과를 반환하는 함수
SELECT POWER(5,3)
FROM DUAL;
--==>> 125
-- 5^3 =125

--○ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2)
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857 
-- 루트 2의 대한 값

--○ LOG() 로그 함수
--  (오라클은 상용로그만 지원하고, MSSQL은 상용로그 자연로그 모두 지원한다.)
SELECT LOG(10, 100) "COL1"
    ,  LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677

--○ 삼각함수
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
-- 0.8414709848078965066525023216302989996233
-- 0.5403023058681397174009366074429766037354
-- 1.55740772465490223050697480745836017308
-- 각각 위부터 사인 코사인 탄젠트 1의 결과 값

--○ 삼각함수의 역함수
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
-- 0.52359877559829887307710723054658381405
-- 1.04719755119659774615421446109316762805
-- 0.4636476090008061162142562314612144020295
-- 각각 위부터 아크사인, 아크코사인, 아크탄젠트 0.5의 결과 값.

--○ SIGN() 서명 부호 특징....
--> 연산결과 값이 양수이면1, 0이면 0, 음수이면 -1을 반환..
SELECT SIGN(5-2) "COL1", SIGN(5-5) "COL2", SIGN(4-5) "COL3"
FROM DUAL;
--==>> 1	0	-1
--> 매출이나 수지와 관련하여 적자 및 흑자의 개념을 나타낼 때 사용된다.

--○ ASCII(), CHR() → 서로 대응(상응) 하는 함수
SELECT ㅊ "COL1"
     , CHR(65)   "COL2"
FROM DUAL;
--==>> 65	A
--> 『ASCII()』 : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환.        ASCII('A') → 65
--  『CHR()』   : 매개변수로 넘겨받은 아스키코드 값으로 해당 문자를 반환. CHR(65)    →  A

--------------------------------------------------------------------------------

--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.

SELECT SYSDATE "COL1"
FROM DUAL;
--==>> 2022-02-22 09:39:42

--※ 날짜 연산의 기본 단위는 DAY(일수)이다!!!
SELECT SYSDATE "COL1"      -- 2022-02-22 09:44:16
     , SYSDATE + 1 "COL2"  -- 2022-02-23 09:44:16  → 하루 뒤
     , SYSDATE - 2 "COL3"  -- 2022-02-20 09:44:16  → 이틀 전
     , SYSDATE - 30 "COL4" -- 2022-01-23 09:44:16  → 30일 전
FROM DUAL;


--○ 시간 단위 연산
SELECT SYSDATE "COL1"        -- 2022-02-22 09:46:46  
     , SYSDATE + 1/24 "COL2" -- 2022-02-22 10:46:46 → 한시간 뒤
     , SYSDATE - 2/24 "COL3" -- 2022-02-22 07:46:46 → 두시간 전
FROM DUAL;

--○ 현재 시간과.. 현재 시간 기준 1일 2시간 3분 4초 후를 조회하는 쿼리문을 구해보자.
/*
  현재 시간             연산 후 시간  
-------------------  -------------------
2022-02-22 10:03:35  2022-02-23 12:05:39
-------------------  -------------------
*/
-- 방법 1. 
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + 2/24 + 3/(24*60) + 4/(24*60*60) "연산 후 시간"  
FROM DUAL;
--==>> 2022-02-22 10:06:42	2022-02-23 12:09:46

-- 방법 2. 모두 초로 처리
SELECT SYSDATE "현재 시간"
     , SYSDATE + ((1*24*60*60)+ (2*60*60)+ (3*60) +4)/(24*60*60)
FROM DUAL;
--==>> 2022-02-22 10:19:49	2022-02-23 12:22:53


--○ 날짜 - 날짜 = 일수
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD') - TO_DATE('2022-02-22', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 118

--○ 데이터 타입의 변환
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD') "RESULT"
FROM DUAL;  --==>> 2022-06-20 00:00:00 (아까 위에서 시분초 포멧 바꿈)

SELECT TO_DATE('2022-06-35', 'YYYY-MM-DD') "RESULT"  -- → 존재하지 않는 날짜 입력해보기
FROM DUAL;
--==>> 에러발생   
-- (ORA-01847: day of month must be between 1 and last day of month)

SELECT TO_DATE('2022-02-29', 'YYYY-MM-DD') "RESULT"  -- → 2022-2월은 28일까지 있음..
FROM DUAL;
--==>> 에러발생
-- (ORA-01839: date not valid for month specified)


SELECT TO_DATE('2022-13-29', 'YYYY-MM-DD') "RESULT"  -- → 존재하지 않는 달 입력
FROM DUAL;
--==>> 에러발생
-- (ORA-01843: not a valid month)

--※ TO_DATE() 함수를 통해 문자 타입을 날짜 타입으로 변환을 수행하는 과정에서 
--   내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다.

--○ ADD_MONTHS() 개월 수를 더해주는 함수
SELECT SYSDATE "COL1"                
     , ADD_MONTHS(SYSDATE, 2) "COL2"
     , ADD_MONTHS(SYSDATE, 3) "COL3"
     , ADD_MONTHS(SYSDATE, -2) "COL4"
     , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;
/* 
2022-02-22 10:30:04 → 현재
2022-04-22 10:30:04 → 2개월 후
2022-05-22 10:30:04 → 3개월 후
2021-12-22 10:30:04 → 2개월 전
2021-11-22 10:30:04 → 3개월 전
*/
-- 월을 더하고 뺄 수 있다..

--○ MONTHS_BETWEEN()
-- 첫 번째 인자 값에서 두번째 인자 값을 밴 개월수를 반환한다.
SELECT MONTHS_BETWEEN(SYSDATE,TO_DATE('2002-05-31','YYYY-MM-DD')) "RESULT" --오늘 날짜에서 2002년 월드컵 개최날 까지 몇개월이  
FROM DUAL;                                                                 --지났을까? 
--==>> 236.723869100955794504181600955794504182 개월전.. 

--> 개월 수의 차이를 반환하는 함수
--  결과 값의 부호가 『-』로 반환되었을 경우
--  첫 번째 인자값에 해당하는 날짜 보다
--  두 번째 인자값에 해당하는 날짜가 『미래』라는 의미로 볼 수 있다.


--○ NEXT_DAY()
SELECT NEXT_DAY(SYSDATE, '토') "COL1" -- 오늘기준으로 가장 가까운 토요일이 언제니?
     , NEXT_DAY(SYSDATE, '월') "COL2" -- 오늘기준으로 가장 가까운 월요일이 언제니? 
FROM DUAL;
--==>> 2022-02-26 10:38:35
--     2022-02-28 10:38:35


--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.


SELECT NEXT_DAY(SYSDATE, '토') "COL1" -- 오늘기준으로 가장 가까운 토요일이 언제니?
     , NEXT_DAY(SYSDATE, '월') "COL2" -- 오늘기준으로 가장 가까운 월요일이 언제니? 
FROM DUAL;
--==>> 에러발생
-- (ORA-01846: not a valid day of the week)


SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1" -- 오늘기준으로 가장 가까운 토요일이 언제니?
     , NEXT_DAY(SYSDATE, 'MON') "COL2" -- 오늘기준으로 가장 가까운 월요일이 언제니? 
FROM DUAL;
--==>> 2022-02-26 10:40:46
--     2022-02-28 10:40:46

--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1" -- 오늘기준으로 가장 가까운 토요일이 언제니?
     , NEXT_DAY(SYSDATE, 'MON') "COL2" -- 오늘기준으로 가장 가까운 월요일이 언제니? 
FROM DUAL;
--==>> 에러발생
-- (ORA-01846: not a valid day of the week)


SELECT NEXT_DAY(SYSDATE, '토') "COL1" -- 오늘기준으로 가장 가까운 토요일이 언제니?
     , NEXT_DAY(SYSDATE, '월') "COL2" -- 오늘기준으로 가장 가까운 월요일이 언제니? 
FROM DUAL;
--==>> 2022-02-26 10:42:15
--	   2022-02-28 10:42:15


--○ LAST_DAY()
--> 해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다.

SELECT LAST_DAY(SYSDATE) "COL1"
     , LAST_DAY(TO_DATE('2020-02-10','YYYY-MM-DD')) "COL2" 
     , LAST_DAY(TO_DATE('2019-02-10','YYYY-MM-DD')) "COL3" 
FROM DUAL;
/*
2022-02-28 10:44:58	
2020-02-29 00:00:00	
2019-02-28 00:00:00
*/

--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--○ 오늘 부로.. 상기가 군대에 다시 끌려 간다.. 
--   복무기간은 22개월로 한다.

-- 1. 전역 일자를 구한다.

-- 2. 하루 꼬박꼬박 3끼 식사를 한다고 가정한다면
--    상기가 몇 끼를 먹어야 집에 보내줄까?

SELECT SYSDATE "오늘 날짜 " 
     , ADD_MONTHS(SYSDATE, 22) "전역일자" 
     , 3*TRUNC(ADD_MONTHS(SYSDATE, 22)-SYSDATE) "몇끼?"
FROM DUAL;
--==>> 2022-02-22	2023-12-22	2004

--○ 현재 날짜 및 시각으로 부터...
--   수료일(2022-06-20 18:00:00) 까지
--   남은 기간을 .. 다음과 같은 형태로 조회할 수 있도록 쿼리문 구성

/*
----------------------------------------------------------------------
현재시각              | 수료일               | 일    | 시간 | 분| 초
-----------------------------------------------------------------------
2022-02-22 11:34:35   | 2022-06-20 18:00:00  | 117   | 7    | 15| 15
*/


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


SELECT SYSDATE "현재 시간"
     , TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     , TRUNC(TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE))     "일"
     
----------------------------------------------------------------------------------------    

     , TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) "시간"
----------------------------------------------------------------------------------------    

     , TRUNC(((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60) "분"
-----------------------------------------------------------------------------------------

      , ROUND(((((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60)-
       TRUNC(((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60))*60) "초"
    
FROM DUAL;     
--------------------------------------------------------------------------------------------------

--『1일 2시간 3분 4초』를 『초』 로 환산하면....
SELECT (1*24*60*60) + (2*60*60) + (3*60) + 4
FROM DUAL;
--==>> 93784

--『93784초』를... 다시 『일 시간 분 초』로 환산하면...?
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC(93784/60)/60),24) "시"
     , MOD(TRUNC(93784/60),60) "분"
     , MOD(93784, 60) "초"
FROM DUAL;  
--1일	2시간	3분	4초

-------------------------------------------------------------------------------
-- 수료일 까지 남은 기간 확인(단위 : 일수)
SELECT TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--118.132893518518518518518518518518518519 일 남음

-- 수료일 까지 남은 기간 확인(단위 : 초)

SELECT (TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60)
FROM DUAL;
--==>> 10205685.00000000000000000000000000000003

SELECT TRUNC(TRUNC(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60)/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60)/60)/60),24) "시"
     , MOD(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60)/60),60) "분"
     , TRUNC(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)*(24*60*60), 60)) "초"
FROM DUAL;  
-- 118일	2시간	53분	13초




--○ 각자 태어난 날짜 및 시각으로부터... 현재까지
--   얼마만큼의 시간을 살고 있는지...
--   다음과 같은 형태로 조회할 수 있도록 쿼리문을 작성한다.

/*
----------------------------------------------------------------------
현재시각              | 생년월일               | 일    | 시간 | 분| 초
-----------------------------------------------------------------------
2022-02-22 15:12:35   | 1997-07-25 15:00:00    | 117   | 7    | 15| 15
*/


-- 1일 1시간 1분 1초 를 초로 바꾸자
SELECT (1*24*60*60) + (1*60*60) + (1*60) +1

FROM DUAL;
--==>> 90061

-- 90061을 다시 1일 1시간 1분 1초 로 바꾸자

SELECT TRUNC(TRUNC(TRUNC(90061/60)/60)/24) "일" -- 1일
     , MOD(TRUNC(TRUNC(90061/60)/60), 24) "시"-- 1시 
     , MOD(TRUNC((90061/60)),60) "분" -- 1분
     , MOD(90061,60) "초"-- 1초
FROM DUAL;

--내가 지금까지 지낸 날 계산
SELECT  SYSDATE - TO_DATE('1997-07-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS') 
FROM DUAL;
--==>> 8978.016342592592592592592592592592592593 일 살았음

-- 날을 초로 바꾸기
SELECT  (SYSDATE - TO_DATE('1997-07-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60) "초"
FROM DUAL;
--==>> 775700605 (계속 늘어나는중)


SELECT SYSDATE "현재 시각"
     , TO_DATE('1997-07-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS') "생년 월일" 
     , TRUNC(TRUNC(TRUNC((SYSDATE - TO_DATE('1997-07-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC((SYSDATE - TO_DATE('1997-07-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60)/60),24) "시"
     , MOD(TRUNC((SYSDATE - TO_DATE('1997-07-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60),60) "분"
     , MOD((SYSDATE - TO_DATE('1997-07-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60), 60) "초"
FROM DUAL;  


--○ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--※ 날짜 데이터를 대상으로도 반올림, 절삭 등의 연산을 수행 할 수 있다.

--○ 날짜 반올림
SELECT SYSDATE "COL1"                  -- 2022-02-22     → 기본 현재 날짜 데이터                                
     , ROUND(SYSDATE, 'YEAR') "COL2"   -- 2022-01-01     → 년도까지 유효한 데이터 (상반기/하반기 기준)
     , ROUND(SYSDATE, 'MONTH') "COL3"  -- 2022-03-01     → 월까지 유효한 데이터 (기준 : 15일)
     , ROUND(SYSDATE, 'DD') "COL4"     -- 2022-02-23     → 일까지 유효한 데이터 (정오 기준) (기록시각  : 16시 8분)
     , ROUND(SYSDATE, 'DAY') "COL5"    -- 2022-02-20     → 일까지 유효한 데이터 (수요일 정오 기준)(기록요일 : 화요일)  
FROM DUAL;                                               -- 만약 수요일 오후가 지났다면 그 다음 일요일 날짜로 나옴  


--○ 날짜 절삭
SELECT SYSDATE "COL1"                  -- 2022-02-22     → 기본 현재 날짜 데이터                                
     , TRUNC(SYSDATE, 'YEAR') "COL2"   -- 2022-01-01     → 년도까지 유효한 데이터 
     , TRUNC(SYSDATE, 'MONTH') "COL3"  -- 2022-01-01     → 월까지 유효한 데이터 
     , TRUNC(SYSDATE, 'DD') "COL4"     -- 2022-02-22     → 일까지 유효한 데이터 
     , TRUNC(SYSDATE, 'DAY') "COL5"    -- 2022-02-20     → 그 전주에 해당하는 일요일 날짜 
FROM DUAL;  

-----------------------------------------------------------------------------------------------

--■■■ 변환 함수 ■■■--

-- TO_CHAR()    : 숫자나 날짜데이터를 문자 타입으로 변환시켜주는 함수
-- TO_DATE()    : 문자 데이터를 날짜 타입으로 변환시켜주는 함수
-- TO_NUMBER()  : 문자 데이터를 숫자 타입으로 변환시켜주는 함수

--※ 날짜나 통화 형식이 맞지 않을 경우..
--   설정 값을 통해 세션을 설정하여 사용할 수 있다.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


--○ 날짜형 → 문자형
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "COL1"   -- 2022-02-22 (이거 날짜타입 아니고 문자다~!!)
     , TO_CHAR(SYSDATE, 'YYYY') "COL2"         -- 2022
     , TO_CHAR(SYSDATE, 'YEAR') "COL3"         -- TWENTY TWENTY-TWO  
     , TO_CHAR(SYSDATE, 'MM') "COL4"           -- 02
     , TO_CHAR(SYSDATE, 'MONTH') "COL5"        -- 2월 
     , TO_CHAR(SYSDATE, 'MON') "COL6"          -- 2월 
     , TO_CHAR(SYSDATE, 'DD') "COL7"           -- 22
     , TO_CHAR(SYSDATE, 'MM-DD') "COL8"        -- 02-22
     , TO_CHAR(SYSDATE, 'DAY') "COL9"          -- 화요일
     , TO_CHAR(SYSDATE, 'DY') "COL10"          -- 화
     , TO_CHAR(SYSDATE, 'HH24') "COL11"        -- 16
     , TO_CHAR(SYSDATE, 'HH') "COL12"          -- 04
     , TO_CHAR(SYSDATE, 'HH AM') "COL13"       -- 04 오후
     , TO_CHAR(SYSDATE, 'HH PM') "COL14"       -- 04 오후
     , TO_CHAR(SYSDATE, 'MI') "COL15"          -- 20
     , TO_CHAR(SYSDATE, 'SS') "COL16"          -- 46
     , TO_CHAR(SYSDATE, 'SSSSS') "COL17"       -- 58846 // 오늘 0시0분0초 부터 지금까지 얼만큼의 초가 흘렀는지 
     , TO_CHAR(SYSDATE, 'Q') "COL18"           -- 1     // 분기
FROM DUAL;


SELECT 7 "COL1"
     , TO_CHAR(7) "COL2"
FROM DUAL;
--==>> 7	7 -- 오라클에서 숫자는 우측정렬, 문자는 좌측 정렬이다.

SELECT '4'
     , TO_NUMBER('4')
FROM DUAL;
--==>> 4	4


SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) "RESULT"
FROM DUAL;
--==> 2022 (숫자타입)

--○ EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1"      -- 2022 (문자형) → 연도를 추출하여 문자타입으로 반환
     , TO_CHAR(SYSDATE, 'MM') "COL2"        -- 02   (문자형) → 월를 추출하여 문자타입으로 반환
     , TO_CHAR(SYSDATE, 'DD') "COL3"        -- 22   (문자형) → 일를 추출하여 문자타입으로 반환
     , EXTRACT(YEAR FROM SYSDATE) "COL4"    -- 2022 (숫자형) → 연도를 추출하여 숫자타입으로 반환 --CHECK
     , EXTRACT(MONTH FROM SYSDATE) "COL5"   -- 2    (숫자형) → 월를 추출하여 숫자타입으로 반환   --CHECK
     , EXTRACT(DAY FROM SYSDATE) "COL6"     -- 22   (숫자형) → 일를 추출하여 숫자타입으로 반환   --CHECK
FROM DUAL;
-->> 연, 월, 일 이외의 다른항목은 불가 ~!!!!!!!


--○ TO_CHAR() 활용 → 형식 맞춤 표기 결과값 반환
SELECT 60000 "COL1"
     , TO_CHAR(60000, '99,999') "COL2"
     , TO_CHAR(60000, '$99,999') "COL3"
     , TO_CHAR(60000, 'L99,999') "COL4"
FROM DUAL;
--==>>60000	 60,000	 $60,000	        ￦60,000


--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==> Session이(가) 변경되었습니다.

--○ 현재 시간을 기준으로 1일 2시간 3분 4초 후를 조회한다.
SELECT SYSDATE "현재시간"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "1일 2시간 3분 4초뒤"
FROM DUAL;
--==>>2022-02-22 16:48:31
--    2022-02-23 18:51:35


--○ 현재 시간을 기준으로 1년 2개월 3일 4시간 5분 6초 후를 조회한다.
-- TO_YMINTERVAL(), TO_DSINTERVAL() 
--   '연-월'        '일 초'          
SELECT SYSDATE "현재 시간"
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "연산 시간" --매개변수 CHECK!
FROM DUAL;
--==>> 2022-02-22 17:05:02	
--     2023-04-25 21:10:08

--------------------------------------------------------------------------------

--○ CASE 구문(조건문, 분기문)
/*
CASE
WHEN
THEN
ELSE
END
*/

SELECT CASE 5+2 WHEN 4 THEN '5+2 = 4' ELSE '5+2=몰라요' END 
FROM DUAL;
--==> 5+2=몰라요


SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2=6' END
FROM DUAL;
--==>> 5+2=7




SELECT CASE 1+1 WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                WHEN 2 THEN  '여기는 안옴'
                ELSE '5+2=6' 
                END   "RESULT"
FROM DUAL;
--==>> 1+1=2


SELECT CASE WHEN 5+2=4 THEN '5+2=4'
            WHEN 6-3=2 THEN '6-3=2'
            WHEN 7*1=8 THEN '7*1=8'
            WHEN 6/2=3 THEN '6/2=3'
            ELSE '모르겟다 '
        END "RESULT"    
FROM DUAL;
--==>> 6/2=3


--○ DECODE()
SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-2=3', '5-3=몰라요') "RESULT"
FROM DUAL;
--==>> 5-2=3

--○ CASE WHEN THEN ELSE END (조건문, 분기문) 활용

SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '5와 2는 비교 불가'
        END "RESULT"
FROM DUAL;
--==>> 5>2

SELECT CASE WHEN 5<2 OR 3>1 AND 2=2 THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
        END "RESULT"
FROM DUAL;
--==>> 은혜만세

SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '현수만세'
            WHEN 5<2 AND 2=3 THEN '이삭만세'
            ELSE '태형만세'
        END "RESULT"
FROM DUAL;
--==>> 현수만세

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '현수만세'
            WHEN 5<2 AND 2=3 THEN '이삭만세'
            ELSE '태형만세'
        END "RESULT"
FROM DUAL;
--==>> 태형만세
-------------------------------------------------------------------------------

SELECT *
FROM TBL_SAWON;

--○ TBL_SAWON 테이블을 활용하여
--   다음과 같은 항목을 조회할 수 잇도록 쿼리문 구성
--   사원번호, 사원명, 주민번호, 성별, 입사일


SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
     , CASE WHEN JUBUN LIKE '______2%' OR JUBUN LIKE '______4%' THEN '여성'
            WHEN JUBUN LIKE '______1%' OR JUBUN LIKE '______3%' THEN '남성'
            ELSE '성별 이상' END "성별", HIREDATE "입사일"
FROM TBL_SAWON;








