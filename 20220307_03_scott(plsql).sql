SELECT USER
FROM DUAL;
--==>> SCOTT

--■■■ PL/SQL ■■■--

-- 1. PL/SQL(Procedural Language extension to SQL)
--    프로그래밍 언어의 특성을 가지는 SQL의 확장이며
--    데이터 조작과 질의 문장은 PL/SQL 의 절차적 코드 안에 포함된다.
--    또한, PL/SQL 을 사용하려면 SQL 로 할  수 없는 절차적 작업이 가능하다.
--    여기에서 『절차적』 이라는 단어가 가지는 의미는
--    어떤 것이 어떤 과정을 거쳐서 어떻게 완료되는지
--    그 방법을 정확하게 코드에 기술한다는 것을 의미한다.

-- 2. PL/SQL 은 절차적으로 표현하기 위해
--    번수를 선언할 수 있는 기능,
--    참과 거짓을 구별할 수 있는 기능,
--    실행 흐름을 컨트롤할 수 있는 기능 등을 제공한다.

-- 3. PL/SQL 은 블럭 구조로 되어 있으며
--    블럭은 선언 부분, 실행 부분, 예외 처리 부분의
--    세 부분으로 구성되어 있다.
--    또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다.

-- 4. 형식 및 구조
/*
[DECLARE]
    -- 선언문(DECLARATIONS)
BEGIN
    -- 실행문(STATEMENTS)
    
    [EXCEPTION]
        -- 예외 처리문 (EXCEPTION HANDLERS)
END;
*/

-- 5. 변수 선언
/*
DECLARE
    변수명 자료형;
    변수명 자료형 := 초기값;  := 는 <= 으로 생각하자 
BEGIN
 PL/SQL구문;
END;
*/

/*
    java 에선...
    int num;
    int num = 10;
    
    Oracle 에선...
    col1 number;
    col1 number := 10;
*/



-- PL/SQL 구문은 반드시!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!

--※ 『DBMS_OUTPUT.PUT_LINE()』 을 통해
--   화면에 결과를 출력하기 위한 환경변수 설정
SET SERVEROUTPUT ON;

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'Oracle';
    
BEGIN
    -- 실행부
    DBMS_OUTPUT.PUT_LINE(V1);  -- System.out.println() 같은..
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
--==>> 
/*
10
HELLO
Oracle

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
-- PL/SQL 구문은 반드시!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE 
    -- 선언부
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'ORACLE';
BEGIN
    -- 실행부
    -- (연산 및 처리)
    V1 := V1 + 20; 
    V2 := V2 || '신시은';
    V3 := V3 || 'World~!!!';
    
    -- (결과 출력)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
30
HELLO신시은
ORACLEWorld~!!!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ PL/SQL 