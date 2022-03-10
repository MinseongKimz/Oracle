SELECT USER
FROM DUAL;
--==>> SCOTT


-- ※ 사용자 정의 함수(스토어드 함수)는
--    IN 파라미터(입력 매개변수)만 사용할 수 있으며
--    반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
--    FUNCTION 은 반드시 단일 값만 반환한다.

--○ TLB_INSA 테이블 전용 성별 확인  함수 정의 (생성)
-- 함수명 : FN_GENDER()
--                   ↑ SSN(주민등록번호) → '771212-1022432' → 'YYMMDD-NNNNNNN'       

CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2 ) -- 매개변수   : 자릿수(길이) 지정 안함
RETURN VARCHAR2                                       -- 반환자료형 : 자릿수(길이) 지정 안함
IS
    -- 선언부 → 주요 변수 선언
    V_RESULT VARCHAR2(20);
BEGIN
    -- 실행부(정의부) → 연산 및 처리
    IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
        THEN V_RESULT := '남자';
    ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
        THEN V_RESULT := '여자';
    ELSE  
        V_RESULT := '성별확인불가';
    END IF;
    
    -- 결과값 반환 CHECK~!!
    RETURN V_RESULT;
    
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.

--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아 → (A,B)
--   A 의 B 승의 값을 반환하는 사용자 정의 함수를 작성하낟.
--   함수명 : FN_POW()
/*
사용 예)
SELECT FN_POW(10,3)
FROM DUAL;
--==>> 1000
*/

CREATE OR REPLACE FUNCTION FN_POW(N1 NUMBER, N2 NUMBER)
RETURN NUMBER
IS
    RESULT NUMBER := 1;
    COUNT NUMBER;
BEGIN
    FOR COUNT IN 1 .. N2
    LOOP
        RESULT := RESULT * N1;
    END LOOP;
    RETURN RESULT;
END;
--==>> Function FN_POW이(가) 컴파일되었습니다

--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--   급여는 『(기본급*12)+수당』 기반으로 연산을 수행한다.
--   함수명 : FN_PAY(기본급, 수당)


CREATE OR REPLACE FUNCTION FN_PAY(BASIC NUMBER, SU NUMBER)
RETURN NUMBER
IS 
    PAY NUMBER;
BEGIN
    PAY := (NVL(BASIC,0)*12)+NVL(SU, 0);
    RETURN PAY;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.

--○ TBL_INSA 테이블에서 입사일을 기준으로 현재까지의
--   근무년수를 반환하는 함수를 정의한다.
--   단, 근무년수는 소수점 이하 한자리까지 계산한다.
--   함수명 : FN_WORKYEAR(입사일)

CREATE OR REPLACE FUNCTION FN_WORKYEAR(V_HIREDATE DATE)
RETURN NUMBER
IS
    YEARS NUMBER;
BEGIN
    YEARS := TRUNC(MONTHS_BETWEEN(SYSDATE, V_HIREDATE)/12, 1);
    RETURN YEARS;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

--※ 참고

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML 구문 (Data Manipulation Language)
--     COMMIT / ROLLBACK이 필요한 구문~ 

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL 구문 (Data Definition Language)
--     실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE 
--==>> DCL 구문 (Data Control Language)
--     실행하면 자동으로 COMMIT 된다.

-- 4. COMMIT, ROLLBACK
--==>> TCL 구문(Transaction Control Language)

-- 정적 pl/sql문 → DML문, TCL문만 사용한다.
-- 동적 pl/sql문 → DML문, DDL문, DCL문, TCL문 사용 가능함

--------------------------------------------------------------------------------

--■■■ PROCEDURE(프로시저) ■■■--

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때 마다 호출하여 실행할 수 있도록 처리해 주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입
 , 매개변수 OUT 데이터타입
 , 매개변수 INOUT 데이터타입
)]
IS
    [-- 주요 변수 선언]
BEGIN 
    -- 실행 구문;
    ...
    
    [EXCEPTION
        -- 예외 처리 구문;]
END;
*/


-- ※ FUNCTION 과 비교했을 때 『RETURN 반환자료형』 부분이 존재하지 않으며,
--    『RETURN』문 자체도 존재하지 않으며,
--    프로시져 실행 시 넘겨주게 되는 매개변수의 종류는
--    IN(입력), OUT(출력), INOUT(입출력) 으로 구분된다.

-- 3. 실행(호출)
/*
EXEC[UTE] 프로시저명[(인수1, 인수2, ...)];
*/

--※ 프로시저 실습을 위한 테이블 생성은
--   『20220310_02_scott.sql』 참고

--○ 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( 아이디
, 패스워드
, 이름
, 전화
, 주소
)
IS
BEGIN
END;

-- 만들면~
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_STUDENT_INSERT이(가) 컴파일되었습니다.


--※ 프로시저 실습을 위한 테이블 생성은
--   『20220310_02_scott.sql』 참고

--○ 데이터 입력 시 특정 항목의 데이터만 입력하면
                    --------
--                  (학번, 이름, 국, 영, 수 점수)                    
--   내부적으로 다른 추가항목에 대한 처리가 함께 이루어질 수 있도록 하는
                    ---------
--                  (총점, 평균, 등급)                    
--   프로시저를 작성한다. (생성한다.)
--   프로시저 명 : PRC_SUNJUK_INSERT()

/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(1, '최선하', 90, 80, 70);

프로시저 호출로 처리된 결과
학번   이름     국어점수   영어점수  수학점수  총점 평균 등급
  1    최선하      90         80       70       240  80   B
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS 
    -- 주요 데이터 선언
    V_TOT TBL_SUNGJUK.TOT%TYPE;
    V_AVG TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 주요 데이터 연산 및 정의
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    CASE WHEN V_AVG >= 90 THEN V_GRADE := 'A';
         WHEN V_AVG >= 80 THEN V_GRADE := 'B';
         WHEN V_AVG >= 70 THEN V_GRADE := 'C';
         WHEN V_AVG >= 60 THEN V_GRADE := 'D';
         
         ELSE V_GRADE := 'F';
         END CASE;
    
    --INSERT 구문
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    --커밋
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.

--※ 『20220310_02_scott.sql』 에서 데이터 삽입 


--○ TBL_SUNGJUK 테이블에서 특정 학생의 점수
-- (학번, 국어점수, 영어점수, 수학점수) 데이터 수정시
-- 총점, 평균, 등급까지 함께 수정되는 프로시저를 생성한다.
-- 프로시저 명 : PRC_SUNGJUK_UPDATE()

/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);

프로시저 호출로 처리된 결과
학번   이름     국어점수   영어점수  수학점수  총점 평균 등급
  2    박현수      50        50       50       150   50    F
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR    IN TBL_SUNGJUK.KOR%TYPE
, V_ENG    IN TBL_SUNGJUK.ENG%TYPE
, V_MAT    IN TBL_SUNGJUK.MAT%TYPE
)
IS
    V_TOT TBL_SUNGJUK.TOT%TYPE;
    V_AVG TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF (V_AVG>=90)      THEN V_GRADE := 'A';
    ELSIF (V_AVG>=80)   THEN V_GRADE := 'B';
    ELSIF (V_AVG>=70)   THEN V_GRADE := 'C';
    ELSIF (V_AVG>=60)   THEN V_GRADE := 'D';
    ELSE V_GRADE := 'F';
    END IF;
    
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT = V_TOT
      , AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.

-- 데이터 입력은 『20220310_02_scott.sql』 에서




--○ TBL_STUDENTS 테이블에서 전화번호와 주소 데이터를 수정하는(변경하는) 
--   프로시저를 작성한다.
--   단, ID와PW를 넘겨받아 일치하는 경우에만 수정을 진행한다.
--   프로시저 명 : PRC_STUDENTS_UPDATE()

/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('happy', 'java006', '010-9999-9999', '강원도 횡성');
--==>> 데이터 수정 실패 (비밀번호 오류)

EXEC PRC_STUDENTS_UPDATE('happy', 'java006$', '010-9999-9999', '강원도 횡성');
--==>> 데이터 수정 성공
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_STUDENTS.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
        UPDATE TBL_STUDENTS
        SET TEL = V_TEL, ADDR = V_ADDR
        WHERE ID = V_ID AND (SELECT PW
                             FROM TBL_IDPW
                             WHERE ID = V_ID) = V_PW;
        COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.

-- 데이터 입력은 『20220310_02_scott.sql』 에서...

--------- 다른 방법 풀이 (FLAG 사용)

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2   TBL_IDPW.PW%TYPE;
    V_FLAG  NUMBER := 0;

BEGIN
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    IF(V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE 
        V_FLAG := 2;
    END IF;   
    
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID 
        AND V_FLAG = 1;
    
    COMMIT;    
END;


--------- 다른 방법 풀이 (JOIN 이용)
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
              ON T1.ID = T2.ID) T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID AND T.PW = V_PW;
    
    COMMIT;
END;














