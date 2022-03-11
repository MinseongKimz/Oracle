SELECT USER
FROM DUAL;
--==>> SCOTT

DESC TBL_INSA;
/*
이름       널?       유형           
-------- -------- ------------ 
NUM      NOT NULL NUMBER(5)    
NAME     NOT NULL VARCHAR2(20) 
SSN      NOT NULL VARCHAR2(14) 
IBSADATE NOT NULL DATE         
CITY              VARCHAR2(10) 
TEL               VARCHAR2(15) 
BUSEO    NOT NULL VARCHAR2(15) 
JIKWI    NOT NULL VARCHAR2(15) 
BASICPAY NOT NULL NUMBER(10)   
SUDANG   NOT NULL NUMBER(10)   
*/

--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   으로 구성된 컬럼 중 NUM 을 제외한
--   NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG 
--   의 데이터 입력시
--   NUM 컬럼(사원번호)의 값은
--   기존 부여된 사원번호의 마지막 번호 그다음 번호를 자동으로 입력 처리할 수 있는
--   프로시저로 구성한다.
--   프로시저 명 : PRC_INSA_INSERT()
/*
실행 예)
EXEC PRC_INSA_INSERT('양윤정', '9701310-2234567', SYSDATE, '서울', '010-8624-4553', '개발부', '대리', 2000000, 2000000);
프로시저 호출로 처리된 결과
1061 양윤정 9701310-2234567 SYSDATE 서울 010-8624-4553 개발부 대리 2000000 2000000
의 데이터가 TBL_INSA 테이블에 추가된 상황.
*/
--   기존 부여된 사원번호의 마지막 번호 
SELECT MAX(NUM)
FROM TBL_INSA;
-- 1060

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE    
, V_CITY        IN TBL_INSA.CITY%TYPE    
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM TBL_INSA.NUM%TYPE; 
BEGIN
    SELECT MAX(NVL(NUM,0)) INTO V_NUM -- NULL 을 고려하자...
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES((V_NUM + 1), V_NAME, V_SSN, V_IBSADATE, V_CITY
         , V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
         
    COMMIT;     
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.

-- 프로시저로 데이터 넣는 과정은 『20220311_02_scott.sql』 파일 에서 진행



--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시 (즉,  입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리 (시퀀스 사용 X)
--   TBL_입고 테이블 구성 컬럼
--   : 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

--  'H001' , 30, 400
--  → 입고테이블의 데이터 입력(프로시저 매개변수로 전달받지 못한 나머지 값 → 자동 입력)
--  → 상품테이블의 바밤바 재고수량 30개
/*
SELECT MAX(NVL(입고번호,0))
FROM TBL_입고;
--==>> NULL
SELECT NVL(MAX(입고번호),0)
FROM TBL_입고;
--==>> 0
*/

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드 IN TBL_상품.상품코드%TYPE   -- 가급적 부모테이블껄 쓰자
, V_입고수량 IN TBL_입고.입고수량%TYPE
, V_입고단가 IN TBL_입고.입고단가%TYPE
)
IS
   --입고번호는 자동 증가 처리 (시퀀스 사용 X)
   V_입고번호 TBL_입고.입고번호%TYPE;
BEGIN
     -- 입고 
     SELECT NVL(MAX(입고번호),0) + 1 INTO V_입고번호
     FROM TBL_입고;
     INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
     VALUES (V_입고번호, V_상품코드, V_입고수량, V_입고단가); 
     
     -- 상품테이블 업데이트
     UPDATE TBL_상품
     SET 재고수량 = 재고수량 + V_입고수량  
     WHERE 상품코드 = V_상품코드;
     
     
     -- 예외처리
     EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
     
     COMMIT;   

END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.

-- 프로시저로 데이터 넣는 과정은 『20220311_02_scott.sql』 파일 에서 진행

--------------------------------------------------------------------------------

--■■■ 프로시저 내에서의 예외처리 ■■■--

--○ TBL_MEMBER 테이블의 데이터를 입력하는 프로시저를 작성
--   단, 이 프로시저를 통해 데이터를 입력하는 경우
--   CITY(지역) 항목에 '서울', '경기', '대전' 입력이 가능하도록 구성한다.
--   이 지역 외의 다른 지역을 프로시저 호출을 통해 입력하고자 하는 경우
--   (즉, 입력을 시도하는 경우)
--   예외에 대한 처리를 하려고 한다.
--   프로시져명 : PRC_MEMBER_INSERT()

/*
실행 예)
EXEC PRC_MEMBER_INSERT('임소민', '010-1111-1111', '서울');
--==>> 데이터 입력 가능

EXEC PRC_MEMBER_INSERT('이연주', '010-2222-2222', '부산');
--==>> 데이터 입력 X
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE 
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS
-- 선언부(주요 변수 선언)

    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 선언
    V_NUM  TBL_MEMBER.NUM%TYPE;
--  변수명    데이터타입;
 
    -- 사용자 정의 예외에 대한 변수 선언 CHECK~!!   
    USER_DEFINE_ERROR  EXCEPTION;
    -- 예외도 변수다~!(오라클에서)
    
BEGIN
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인 할 수 있는 코드 구성
    IF  (V_CITY NOT IN ('서울', '경기', '대전'))
        -- 예외발생 CHECK~!!
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM), 0) INTO V_NUM
    FROM TBL_MEMBER;

    -- 쿼리문 구성 → INSERT
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM + 1), V_NAME, V_TEL, V_CITY);
    
    -- 예외 처리 구문
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울, 경기, 대전만 입력가능합니다.'); -- 20000 보다 크게 설정.
                 ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
            
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.



--○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 재고 수량이 변동되는 프로시저를 작성한다.
--   단, 출고 번호는 입고 번호와 마찬가지로 자동 증가.
--   또한, 출고수량이 재고수량보다 많으면 
--   출고 액션을 취소할 수 있도록 처리한다. (출고가 되지 않도록 → 예외처리 활용)
--   프로시저 명 : PRC_출고_INSERT()
/*
실행 예)
EXEC PRC_출고_INSERT('H001', 10, 600);


-- 현재 상품 테이블의 밤바 재고수량은 50개 
EXEC PRC_출고_INSERT('H001', 60, 600);
--==> 에러발생
    (재고부족) 
*/

CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드    IN TBL_출고.상품코드%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
, V_출고단가    IN TBL_출고.출고단가%TYPE
)
IS
    -- 1. 출고번호 필요.
    V_출고번호 TBL_출고.출고번호%TYPE;
    -- 2. 사용자 지정 예외 선언
    USER_DEFINE_ERROR  EXCEPTION;
    -- 3. 재고수량 비교용 변수 (IF 문안에다 서브쿼리 하려다 실패)
    V_재고수량 TBL_상품.재고수량%TYPE;

BEGIN        
        SELECT 재고수량 INTO V_재고수량
        FROM TBL_상품
        WHERE 상품코드 = V_상품코드;

        -- 예외 발생 부분 (출고수량 > 재고수량)
        IF  (V_출고수량 > V_재고수량)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        SELECT NVL(MAX(출고번호),0) INTO V_출고번호
        FROM TBL_출고; 
        -- 이 구문은 재고 검사한 후에 작동해도 늦지 않다. 
        -- 먼저  실행 된다면 리소스 낭비 될 수 있다.
        
        -- 출고 테이블 INSERT
        INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES(V_출고번호 + 1, V_상품코드, V_출고수량, V_출고단가);
        
        -- 상품 테이블 UPDATE
        UPDATE TBL_상품
        SET 재고수량 = 재고수량 - V_출고수량  
        WHERE 상품코드 = V_상품코드;
        
        -- 예외 처리 구문
        EXCEPTION 
            WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고부족'); -- 20000 보다 크게 설정.
                 ROLLBACK;
            WHEN OTHERS 
            THEN ROLLBACK;
            
        COMMIT;    
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.





--○ TBL_출고 테이블에서 출고 수량을 수정(변경)하는 프로시저 작성
--   프로시저 명 : PRC_출고_UPDATE()
/*
실행 예)
EXEC PRC_출고_UPDATE(출고번호, 변경할수량);
*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호  IN TBL_출고.출고번호%TYPE
, V_변경수량  IN TBL_상품.재고수량%TYPE
)
IS
    V_이전출고수량 TBL_출고.출고수량%TYPE;
    V_이전재고수량 TBL_상품.재고수량%TYPE;
    -- 재고수량을 알려면 상품 코드 알아야함
    V_상품코드 TBL_상품.상품코드%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    
BEGIN
    -- 상품코드 가져오기
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    -- 이전재고수량 가져오기
    SELECT  재고수량 INTO V_이전재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 이전출고수량 가져오기
    SELECT 출고수량 INTO V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    -- 변경출고수량 > 이전출고수량 + 이전재고수량 .. ERROR 
    IF (V_변경수량 > V_이전출고수량 + V_이전재고수량)
       THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 출고 업데이트 구문
    UPDATE TBL_출고
    SET 출고수량 = V_변경수량
    WHERE 출고번호 = V_출고번호;
    
    -- 상품 업데이트 구문
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_변경수량 
    WHERE 상품코드 = V_상품코드;
    -- 이전 재고수량 에서 이전출고량 다시 복구하고 그담에 변경수량 빼줌
    
    --예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '재고부족');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
        
    -- 커밋
    COMMIT;

END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.





















