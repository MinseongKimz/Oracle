select USER
FROM DUAL;

--○ TBL_출고 테이블에서 출고 수량을 수정(변경)하는 프로시저 작성
--   프로시저 명 : PRC_출고_UPDATE()
/*
실행 예)
EXEC PRC_출고_UPDATE(출고번호, 변경할수량);
*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호  IN TBL_출고.출고번호%TYPE
, V_변경수량  IN TBL_출고.출고수량%TYPE  -- 변경할 출고수량
)
IS
    V_이전출고수량 TBL_출고.출고수량%TYPE;
    V_이전재고수량 TBL_상품.재고수량%TYPE;
    -- 재고수량을 알려면 상품 코드 알아야함
    V_상품코드 TBL_상품.상품코드%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    
BEGIN
    -- 상품코드 가져오기 +  이전출고수량 가져오기
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    -- 이전재고수량 가져오기
    SELECT  재고수량 INTO V_이전재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
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

/*
1. PRC_입고_UPDATE(입고번호, 입고수량)
2. PRC_입고_DELETE(입고번호)
3. PRC_출고_DELETE(출고번호)
*/



-- 1. PRC_입고_UPDATE(입고번호, 입고수량)
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
( V_입고번호   IN TBL_입고.입고번호%TYPE
, V_입고수량   IN TBL_입고.입고수량%TYPE
)
IS
    V_상품코드   TBL_상품.상품코드%TYPE;
    V_기존입고량 TBL_입고.입고수량%TYPE;
    V_재고수량   TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
BEGIN
    -- 상품코드 가져오기 + 기존 입고수량
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_기존입고량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;

    -- 만약 출고때문에 재고(기존재고 + 새로운입고수량)가 
    -- 기존 입고량보다 작은 상황이라면 
    IF (V_재고수량 + V_입고수량 - V_기존입고량  < 0)
       THEN RAISE USER_DEFINE_ERROR;
    END IF;  

    -- 입고 테이블 업데이트
    UPDATE TBL_입고    
    SET 입고수량 = V_입고수량 
    WHERE 입고번호 = V_입고번호;
        
    -- 상품 테이블 업데이트 (재고 변경) 기존입고수량 빼주고
    UPDATE TBL_상품
    SET   재고수량 = 재고수량 - V_기존입고량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
      
       --예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004, '입고 수량 변경 불가능!');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
        
    -- 커밋
    COMMIT;

END;
--==>> Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.


-- 2. PRC_입고_DELETE(입고번호) 
-- 입고번호를 통해 입고테이블 한 행을 삭제..
-- 그러면 그만큼 재고도 줄어야함.
-- 만약 출고를 해서 재고가 준 상태면 삭제 했을때 음수가 될 수도 잇음 → 예외처리
CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
(V_입고번호 IN TBL_입고.입고번호%TYPE
)
IS
    V_상품코드 TBL_상품.상품코드%TYPE;
    V_기존입고량 TBL_입고.입고수량%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR EXCEPTION; 
    
BEGIN

    SELECT 상품코드, 입고수량 INTO V_상품코드, V_기존입고량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF (V_재고수량 - V_기존입고량 < 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 삭제되는 입고만큼 재고 빼주기     
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_기존입고량
    WHERE 상품코드 = V_상품코드;

    -- 행삭제
    DELETE TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
         THEN RAISE_APPLICATION_ERROR(-20005, '삭제할 입고량보다 현재 재고가 작습니다.' );
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.

-- 3. PRC_출고_DELETE(출고번호)
-- 출고항목을 삭제하면
-- 원래 출고 했던 양 만큼 재고를 늘려주어야 함.
-- 1. 재고량 변경
-- 2. 출고 행 삭제
CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
( V_출고번호 IN TBL_출고.출고번호%TYPE
)
IS
    V_출고수량 TBL_출고.출고수량%TYPE;
    V_상품코드 TBL_상품.상품코드%TYPE;
    
BEGIN
    --0. 필요 데이터 가져오기
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    --1. 출고됬던거 다시 재고로 돌려주기
    UPDATE TBL_상품
    SET  재고수량 = 재고수량 + V_출고수량  
    WHERE 상품코드 = V_상품코드;
    
    --2. DELETE
    DELETE TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    COMMIT;
END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.

-- 모든 테스트는 『20220314_02_scott.sql』에서 확인~!!!!

--------------------------------------------------------------------------------
--■■■ CURSOR(커서) ■■■--

-- 1. 오라클에서는 하나의 레코드가 아닌 여러 레코드로 구성된
--    작업 영역에서 SQL 문을 실행하고 그 과정에서 발생한 정보를
--    저장하기 위해 커서(CURSOR)를 사용하며,
--    커서에는 암시적인 커서와 명시적인 커서가 있다.

-- 2. 암시적 커서는 모든 SQL 구문에 존재하며
--    SQL 문 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
--    그러나 SQL 문을 실행한 결과물(RESULT SET)이
--    여러 행(ROW)으로 구성된 경우
--    커서(CURSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다.

-- ○ 커서 이용 전 상황(단일 행 접근 시)
SET SERVEROUTPUT ON;

DECLARE 
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
/*
홍길동 -- 011-2356-4528

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ○ 커서 이용 전 상황(다중 행 접근 시)

DECLARE 
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;

    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>> 에러발생
--     (ORA-01422: exact fetch returns more than requested number of rows)

-- 반복문을 사용해야 한다...

DECLARE 
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL  TBL_INSA.TEL%TYPE;
    V_NUM  TBL_INSA.NUM%TYPE := 1001;
BEGIN
    
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM; -- WHERE NUM = 1001;
    
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
        V_NUM := V_NUM +1;
        
        EXIT WHEN V_NUM >= 1061;
    END LOOP;

END;
/*
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
이순애 -- 010-4231-1236
김정훈 -- 019-5236-4221
한석봉 -- 018-5211-3542
이기자 -- 010-3214-5357
장인철 -- 011-2345-2525
김영년 -- 016-2222-4444
나윤균 -- 019-1111-2222
김종서 -- 011-3214-5555
유관순 -- 010-8888-4422
정한국 -- 018-2222-4242
조미숙 -- 019-6666-4444
황진이 -- 010-3214-5467
이현숙 -- 016-2548-3365
이상헌 -- 010-4526-1234
엄용수 -- 010-3254-2542
이성길 -- 018-1333-3333
박문수 -- 017-4747-4848
유영희 -- 011-9595-8585
홍길남 -- 011-9999-7575
이영숙 -- 017-5214-5282
김인수 -- 
김말자 -- 011-5248-7789
우재옥 -- 010-4563-2587
김숙남 -- 010-2112-5225
김영길 -- 019-8523-1478
이남신 -- 016-1818-4848
김말숙 -- 016-3535-3636
정정해 -- 019-6564-6752
지재환 -- 019-5552-7511
심심해 -- 016-8888-7474
김미나 -- 011-2444-4444
이정석 -- 011-3697-7412
정영희 -- 
이재영 -- 011-9999-9999
최석규 -- 011-7777-7777
손인수 -- 010-6542-7412
고순정 -- 010-2587-7895
박세열 -- 016-4444-7777
문길수 -- 016-4444-5555
채정희 -- 011-5125-5511
양미옥 -- 016-8548-6547
지수환 -- 011-5555-7548
홍원신 -- 011-7777-7777
허경운 -- 017-3333-3333
산마루 -- 018-0505-0505
이기상 -- 
이미성 -- 010-6654-8854
이미인 -- 011-8585-5252
권영미 -- 011-5555-7548
권옥경 -- 010-3644-5577
김싱식 -- 011-7585-7474
정상호 -- 016-1919-4242
정한나 -- 016-2424-4242
전용재 -- 010-7549-8654
이미경 -- 016-6542-7546
김신제 -- 010-2415-5444
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

/*
참고
일반변수 → 선언
예외변수 → 선언
커서     → 정의

작성 방법
    변수명     타입
    예외변수명 타입
그런데 커서는 왜 정의냐??
    커서명 CURSOR  (X)  이렇게 쓰지 않는다.

 TABLE 테이블명
 INDEX 인덱스명
 USER  사용자명
 
CURSOR 커서명 (○) 
 
    
*/

--○ 커서 이용 후 상황
DECLARE
    -- 주요 변수 선언
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- 커서 이용을 위한 커서 정의 구문
    CURSOR CUR_INSA_SELECT 
    IS 
    SELECT NAME, TEL
    FROM TBL_INSA;
BEGIN
    -- 커서는 사용하려면 열어줘야함
    -- 커서 오픈
    OPEN CUR_INSA_SELECT;
    
    -- 커서 오픈시 쏟아져 나오는 데이터들 처리(반복문을 활용하여 처리)
    LOOP 
        -- 한 행 한 행 받아다가 처리하는 행위 → 가져오다(데려오다) → 『FETCH』
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        -- 커서에서 더이상 데이터 가 쏟아져 나오지 않는 상태... 『NOTFOUND』
    EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
    
    --출력
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
    
    END LOOP;
    
    -- 커서 클로즈
    CLOSE CUR_INSA_SELECT;
END;
/*
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
이순애 -- 010-4231-1236
김정훈 -- 019-5236-4221
한석봉 -- 018-5211-3542
이기자 -- 010-3214-5357
장인철 -- 011-2345-2525
김영년 -- 016-2222-4444
나윤균 -- 019-1111-2222
김종서 -- 011-3214-5555
유관순 -- 010-8888-4422
정한국 -- 018-2222-4242
조미숙 -- 019-6666-4444
황진이 -- 010-3214-5467
이현숙 -- 016-2548-3365
이상헌 -- 010-4526-1234
엄용수 -- 010-3254-2542
이성길 -- 018-1333-3333
박문수 -- 017-4747-4848
유영희 -- 011-9595-8585
홍길남 -- 011-9999-7575
이영숙 -- 017-5214-5282
김인수 -- 
김말자 -- 011-5248-7789
우재옥 -- 010-4563-2587
김숙남 -- 010-2112-5225
김영길 -- 019-8523-1478
이남신 -- 016-1818-4848
김말숙 -- 016-3535-3636
정정해 -- 019-6564-6752
지재환 -- 019-5552-7511
심심해 -- 016-8888-7474
김미나 -- 011-2444-4444
이정석 -- 011-3697-7412
정영희 -- 
이재영 -- 011-9999-9999
최석규 -- 011-7777-7777
손인수 -- 010-6542-7412
고순정 -- 010-2587-7895
박세열 -- 016-4444-7777
문길수 -- 016-4444-5555
채정희 -- 011-5125-5511
양미옥 -- 016-8548-6547
지수환 -- 011-5555-7548
홍원신 -- 011-7777-7777
허경운 -- 017-3333-3333
산마루 -- 018-0505-0505
이기상 -- 
이미성 -- 010-6654-8854
이미인 -- 011-8585-5252
권영미 -- 011-5555-7548
권옥경 -- 010-3644-5577
김싱식 -- 011-7585-7474
정상호 -- 016-1919-4242
정한나 -- 016-2424-4242
전용재 -- 010-7549-8654
이미경 -- 016-6542-7546
김신제 -- 010-2415-5444
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444
양윤정 -- 010-8624-4553

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--------------------------------------------------------------------------------

--■■■ TRIGGER(트리거) ■■■

-- 사전적인 의미 : 방아쇠, 촉발시키다, 야기하다, 유발하다.

-- 1. TRIGGER(트리거)란 DML 작업 즉, INSERT, UPDATE, DELETE 작업이 일어날 때
--    자동적으로 실행되는(유발되는, 촉발되는) 객체로
--    이와 같은 특징을 강조하여 DML TRIGGER 라고 부르기도 한다.
--    TRIGGER 는 무결성 뿐 아니라
--    다음과 같은 작업에도 널리 사용된다.


-- 자동으로 파생된 열 값 생성
-- 잘못된 트랜잭션 방지
-- 복잡한 보안 권한 강제 수행
-- 분산 데이터베이스 노드 상에서 참조 무결성 강제 수행
-- 복잡한 업무 규칙 강제 적용
-- 투명한 이벤트 로깅 제공
-- 복잡한 감사 제공
-- 동기 테이블 복제 유지관리
-- 테이블 액세스 통계 수집

-- 2. TRIGGER(트리거) 내에서는 COMMIT, ROLLBACK 문을 사용할 수 없다.

-- 3. 특징 및 종류
--   - BEFORE STATEMENT
--   - BEFORE ROW
--   - AFTER STATEMENT
--   - AFTER ROW

-- 4. 형식 및 구조
/*
CREATE [OR REPLACE] TRIGGER 트리거명
    [BEFORE | AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명
    [FOR EACH ROW [WHEN TRIGGER 조건]]
[DECLARE]
    -- 선언 구문;
BEGIN
    -- 실행 구문;
END;
*/

--■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■
--※ DML 작업에 대한 이벤트 기록

--○ TRIGGER(트리거) 생성 → TRG_EVENTLOG
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
        AFTER 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    -- 이벤트 종류 구분(조건문을 통한 분기)
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('INSERT 쿼리가 실행되었습니다.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('UPDATE 쿼리가 실행되었습니다.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('DELETE 쿼리가 실행되었습니다');
    END IF;

    -- COMMIT;
    -- ※ TRIGGER 내에서는 COMMIT/ ROLLBACK 구문 사용 불가
END;
--==>> Trigger TRG_EVENTLOG이(가) 컴파일되었습니다.


--■■■ BEFORE STATMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업 수행 전에 작업에 대한 가능 여부 확인

--○ TRIGGER(트리거) 생성 → TRG_TEST1_DML
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1  
BEGIN
    IF (작업시간이 오전 9 시 이전이거나... 오후 6시 이후라면... )
        THEN 작업을 수행할 수 없음.
    END IF;
    
END;
-----------------
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1  
BEGIN
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 OR 
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17)
        THEN 사용자 정의 예외를 발생 시킬 수 있도록 하겠다..
    END IF;
    
END;
-----------------
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1  
BEGIN
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 OR 
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17)
        THEN RAISE_APPLICATION_ERROR(-20003, '작업은 09:00 ~ 18:00 까지만 가능합니다.');
    END IF;
    
END;
--==>> Trigger TRG_TEST1_DML이(가) 컴파일되었습니다.


--■■■ BEFORE ROW TRIGGER 상황 실습 ■■■
--※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델


--○ TRIGGER(트리거) 생성 → TRG_TEST2_DELETE
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE 
          BEFORE 
          DELETE ON TBL_TEST2
          FOR EACH ROW -- ROW TRIGGER 에선 필요
BEGIN
    DELETE 
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE; -- ← CHECK
END;
--==>> Trigger TRG_TEST2_DELETE이(가) 컴파일되었습니다.

--※ 『:OLD』
--  참조 전 열의 값
--  (INSERT : 입력하기 이전 자료, DELETE : 삭제하기 이전 자료 즉, 삭제할 자료)

--※ UPDATE : 내부적으로 DELETE 그리고 INSERT 가 결합된 형태
--            UPDATE 하기 이전의 데이터는 『:OLD』
--            UPDATE 수행한 이후의 데이터는 『:NEW』



--------------------------------------------------------------------------------

--■■■ AFTER ROW TRIGGER 상황 실습 ■■■--
--※ 참조 테이블 관련 트랜잭션 처리

-- TBL_입고, TBL_상품, TBL_출고

--○ TBL_입고 테이블의 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량 변동 트리거 작성
--   트리거 명 : TRG_IBGO

CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_입고
        FOR EACH ROW    
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + 새로 입고되는 수량
             WHERE 상품코드 = 새로 입고되는 상품코드;
    END IF;
END;
-------------------------
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_입고
        FOR EACH ROW    
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 =:NEW.상품코드;
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.


--○ TBL_입고 테이블의 데이터 입력, 수정, 삭제 시
--   TBL_상품 테이블의 재고 수량 변동 트리거 작성.
--   트리거 명 : TRG_IBGO

CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT ON TBL_입고
        FOR EACH ROW    
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 =:NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량 - :OLD.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (DELETING)         
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.

















































































































































