SELECT USER
FROM DUAL;
--==>> SCOTT

--○ IF 문(조건문)
-- IF~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL 의 IF 문장은 다른 언어의 IF 조건문과 거의 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 잇도록 한다.
--    TRUE 이면 THEN 과 ELSE 사이의 문장을 수행하고
--    FALSE 나 NULL 이면 ELSE 와 END IF; 사이의 문장을 수행하게 된다.

-- 2. 형식 및 구조
/*
IF 조건 
    THEN 처리문;
END IF;
*/


/*
IF 조건 
    THEN 처리문;
ELSE
    처리문; (THEN 없음)
END IF;
*/

/*
IF 조건 
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSE
    처리문; 
END IF;
*/
SET SERVEROUT ON;


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    GRADE CHAR;
BEGIN
    -- 실행부
    GRADE := 'C';
    
    DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('COOL');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
/*
C
COOL

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ CASE 문(조건문)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1 THEN 실행문;
    WHEN 값2 THEN 실행문;
    ELSE 실행문;
END CASE;
*/

ACCEPT NUM PROMPT '남자1 여자2 입력하세요'; 

DECLARE
    -- 주요변수 선언
    SEL NUMBER := &NUM;                    
    RESULT VARCHAR2(10) := '남자';
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('SEL : '|| SEL);
   -- DBMS_OUTPUT.PUT_LINE('RESULT : '|| RESULT );
    
    -- 연산 및 처리
    /*
    CASE SEL
        WHEN 1 
        THEN DBMS_OUTPUT.PUT_LINE('남자입니다'); 
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자입니다');
        ELSE
             DBMS_OUTPUT.PUT_LINE('확인불가');
    END CASE;*/
    
    CASE SEL
        WHEN 1
        THEN RESULT := '남자';
        WHEN 2
        THEN RESULT := '여자';
        ELSE 
            RESULT := '확인불가';
    END CASE;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('처리 결과는 ' || RESULT || ' 입니다.');
END;


--※ 외부 입력 처리
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수로 전달할 때
-- 『&외부변수명』 형태로 접근하게 된다.

--○ 정수 2개를 외부로부터(사용자로부터) 입력받아
--   이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.


ACCEPT NUM1 PROMPT '정수 입력 1'; 
ACCEPT NUM2 PROMPT '정수 입력 2';

DECLARE
    N1 NUMBER := &NUM1;
    N2 NUMBER := &NUM2;
    TOT NUMBER := 0;
BEGIN 
    TOT := N1 + N2;
    DBMS_OUTPUT.PUT_LINE(N1 || ' + ' || N2 || ' = ' || TOT);
END;
--==>> 2 + 3 = 5

--○ 사용자로부터 입력받은 금액을 화폐단위로 구분하여 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.\
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/

ACCEPT WON PROMPT '금액 입력 (1000원 미만 10원 이상)';

DECLARE
    WON1 NUMBER := &WON;
    WON500 NUMBER;
    WON100 NUMBER;
    WON50 NUMBER;
    WON10 NUMBER;
    
BEGIN
    --○ 연산 및 처리
    WON500  := TRUNC(WON1 / 500);
    WON100  := TRUNC(MOD(WON1,500)/100);    
    WON50   := TRUNC(MOD(MOD(WON1,500),100)/50);
    WON10   := TRUNC(MOD(MOD(MOD(WON1,500),100),50)/10);
    DBMS_OUTPUT.PUT_LINE('입력 받은 금액 : ' || WON1||'원');
    
    DBMS_OUTPUT.PUT_LINE('오백원: ' || WON500 || ' 백원: '|| WON100 || ' 오십원: '|| WON50
                        || ' 십원: '|| WON10);
END;
/*
입력 받은 금액 : 999원
오백원: 1 백원: 4 오십원: 1 십원: 4

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ 기본 반복문
-- LOOP ~ END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문
    
    EXIT WHEN 조건; -- 조건이 참인 경우 반복문을 빠져나간다.
END LOOP;
*/

-- 1 부터 10 까지 수 출력 (LOOP문 활용)
DECLARE 
    N NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N >= 10;
        
        N := N + 1;     --『N++, N+=1』 이런 구문 없음
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 구문을 사용한다.
--    조건은 반복이 시작되는 시점에 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP
    -- 실행문;
END LOOP;
*/

-- 1 부터 10 까지 출력 (WHILE LOOP문 활용)
DECLARE 
    N NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N:= N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『시작수』에서 1씩 증가하여
--    『끝냄수』가 될 때 까지 반복 수행한다.

-- 2. 형식 및 구조
/*
FOR 카운터 IN [REVERSE] 시작수 .. 끝남수 LOOP
    -- 실행문;
END LOOP;
*/

-- 1 부터 10 까지 출력 (FOR LOOP문 활용) 

DECLARE
    N NUMBER;
BEGIN
    FOR  N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2

2*1 = 2
2*2 = 4
    :
2*9 = 18    
*/

-- 1. LOOP 문의 경우

ACCEPT INPUT PROMPT '단을 입력하세요 : ';

DECLARE 
    DAN NUMBER := &INPUT;
    NUM NUMBER := 1;
BEGIN
    LOOP
        EXIT WHEN NUM > 9;
        DBMS_OUTPUT.PUT_LINE (DAN ||  ' * ' || NUM ||' = ' || DAN*NUM);        
        NUM := NUM + 1;
    END LOOP;
END;


-- 2. WHILE LOOP 에 경우

ACCEPT INPUT PROMPT '단을 입력하세요 : ';

DECLARE 
    DAN NUMBER := &INPUT;
    NUM NUMBER := 1; 
BEGIN 
    WHILE NUM <= 9 LOOP 
            DBMS_OUTPUT.PUT_LINE (DAN ||  ' * ' || NUM ||' = ' || DAN*NUM);
            NUM := NUM+1;
    END LOOP;
END;


-- 3. FOR LOOP
    
ACCEPT INPUT PROMPT '단을 입력하세요 : ';

DECLARE 
    DAN NUMBER := &INPUT;
    NUM NUMBER; 
BEGIN 
    FOR NUM IN 1 .. 9 
    LOOP
        DBMS_OUTPUT.PUT_LINE (DAN ||  ' * ' || NUM ||' = ' || DAN*NUM);                
    END LOOP;
END;
/*
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ 구구단 전체 (2~9단을) 출력하는 PL/SQL 구문을 작성한다.
--   단, 2중 반복문 구문을 활용한다,.
/*
실행 예)
==[2단]==
2 * 1 = 2
    :
==[9단]==    

*/
--  FOR LOOP 버전---------------------------------------------------------------
DECLARE 
    DAN NUMBER ;
    NUM NUMBER ;
    
BEGIN
    FOR DAN IN 2 .. 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('==[' || DAN || '단]==');
        FOR NUM IN 1 .. 9
        LOOP 
            DBMS_OUTPUT.PUT_LINE(DAN ||' * '||NUM ||' = ' || (DAN*NUM));  
        END LOOP;
    END LOOP;  
END;

--  WHILE LOOP 버전-------------------------------------------------------------
DECLARE 
    DAN NUMBER := 2;
    NUM NUMBER := 1;
BEGIN 
    WHILE DAN <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==[' || DAN || '단]==');
        
        WHILE NUM <=9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN ||' * '||NUM ||' = ' || (DAN*NUM));
            NUM := NUM + 1;
        END LOOP;
       NUM := 1; 
       DAN := DAN + 1; 
    END LOOP;
END;

-- LOOP 버전--------------------------------------------------------------------
DECLARE 
    DAN NUMBER := 2;
    NUM NUMBER := 1;    
BEGIN 
    LOOP
         DBMS_OUTPUT.PUT_LINE('==[' || DAN || '단]==');
         LOOP
           DBMS_OUTPUT.PUT_LINE(DAN ||' * '||NUM ||' = ' || (DAN*NUM));
           NUM := NUM + 1;
           EXIT WHEN NUM > 9;
         END LOOP;
         NUM := 1;
         DAN := DAN +1;
         EXIT WHEN DAN > 9;
    END LOOP;
END;
/*
==[2단]==
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
==[3단]==
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
==[4단]==
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36
==[5단]==
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
==[6단]==
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54
==[7단]==
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63
==[8단]==
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72
==[9단]==
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
--------------------------------------------------------------------------------

