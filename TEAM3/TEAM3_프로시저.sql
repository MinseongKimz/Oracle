-- TEAM3 프로시저

--■■■ 1. 관리자 로그인 PRC_LOGIN_ADMIN(관리자ID, 비밀번호) ■■■--
CREATE OR REPLACE PROCEDURE PRC_LOGIN_ADMIN
( V_ID  IN ADMIN.ADMIN_ID%TYPE
, V_PW  IN ADMIN.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID 있는지 카운트한 수 
    V_NAME      ADMIN.ADMIN_NAME%TYPE; -- 이름 변수
    V_PWTEMP    ADMIN.PASSWORD%TYPE;  -- 비밀번호(등록되어 있는 비밀번호)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID가 있는지 확인
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    -- 입력한 아이디가 테이블에 없으면 에러 발생(등록되지 않은 아이디)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. 아이디와 비밀번호가 일치하는지 확인
    SELECT PASSWORD INTO V_PWTEMP
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    -- 비밀번호 다르면 에러 발생
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. 아이디, 비밀번호 부합 시     
    SELECT ADMIN_NAME INTO V_NAME
    FROM ADMIN
    WHERE ADMIN_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' 관리자님 어서오세요.');
    
    -- 4. 에러 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '등록되지 않은 아이디입니다.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '아이디 또는 비밀번호가 일치하지 않습니다.');
END;
--------------------------------------------------------------------------------
--■■■ 2. 교수 로그인 PRC_LOGIN_PROF(교수ID, 비밀번호) ■■■--
CREATE OR REPLACE PROCEDURE PRC_LOGIN_PROF
( V_ID  IN PROF.PROF_ID%TYPE
, V_PW  IN PROF.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID 있는지 카운트한 수 
    V_NAME      PROF.PROF_NAME%TYPE; -- 이름 변수
    V_PWTEMP    PROF.PASSWORD%TYPE;  -- 비밀번호(등록되어 있는 비밀번호)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID가 있는지 확인
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    -- 입력한 아이디가 테이블에 없으면 에러 발생(등록되지 않은 아이디)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. 아이디와 비밀번호가 일치하는지 확인
    SELECT PASSWORD INTO V_PWTEMP
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    -- 비밀번호 다르면 에러 발생
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. 아이디, 비밀번호 부합 시     
    SELECT PROF_NAME INTO V_NAME
    FROM PROF
    WHERE PROF_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' 교수자님 어서오세요.');
    
    -- 4. 에러 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '등록되지 않은 아이디입니다.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '아이디 또는 비밀번호가 일치하지 않습니다.');
END;
--------------------------------------------------------------------------------
--■■■ 3. 학생 로그인 PRC_LOGIN_STU(학생ID, 비밀번호) ■■■--
CREATE OR REPLACE PROCEDURE PRC_LOGIN_STU
( V_ID  IN STU.STU_ID%TYPE
, V_PW  IN STU.PASSWORD%TYPE
)

IS
    V_IDCOUNT   NUMBER; -- ID 있는지 카운트한 수 
    V_NAME      STU.STU_NAME%TYPE; -- 이름 변수
    V_PWTEMP    STU.PASSWORD%TYPE;  -- 비밀번호(등록되어 있는 비밀번호)
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    -- 1. ID가 있는지 확인
    SELECT COUNT(*) INTO V_IDCOUNT
    FROM STU
    WHERE STU_ID = V_ID;
    
    -- 입력한 아이디가 테이블에 없으면 에러 발생(등록되지 않은 아이디)
    IF (V_IDCOUNT = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 2. 아이디와 비밀번호가 일치하는지 확인
    SELECT PASSWORD INTO V_PWTEMP
    FROM STU
    WHERE STU_ID = V_ID;
    
    -- 비밀번호 다르면 에러 발생
    IF (V_PWTEMP != V_PW)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 3. 아이디, 비밀번호 부합 시     
    SELECT STU_NAME INTO V_NAME
    FROM STU
    WHERE STU_ID = V_ID;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' 학생님 어서오세요.');
    
    -- 4. 에러 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '등록되지 않은 아이디입니다.');
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20002, '아이디 또는 비밀번호가 일치하지 않습니다.');
END;
--------------------------------------------------------------------------------
--■■■ 4. 교수 등록 PRC_PROF_INSERT(교수명, 주민번호) ■■■--
CREATE OR REPLACE PROCEDURE PRC_PROF_INSERT
( V_NAME   IN PROF.PROF_NAME%TYPE          -- 이름
, V_SSN    IN PROF.SSN%TYPE                -- 주민번호
)
IS
    V_ID   PROF.PROF_ID%TYPE;               -- ID
    V_FSSN PROF.SSN%TYPE;                   -- 주민번호 중복검사용
    
    PROF_OVERLAP_ERROR EXCEPTION;           -- 주민번호 중복시 에러
    
BEGIN 

     -- 주민번호 중복값 찾기
    SELECT NVL((SELECT SSN 
                 FROM PROF
                 WHERE SSN = V_SSN), '0')  INTO V_FSSN-- 중복된 값이 있다면 V_FSSN 에 0을 담을꺼임
    FROM DUAL;
     
     IF (V_FSSN != '0') -- 위에서 V_FSSN 이 0이 아니라면 중복된 값이 V_FSSN에 담길거임
        THEN RAISE PROF_OVERLAP_ERROR;
     END IF;   
     
     V_ID := CONCAT('P', TO_CHAR(SYSDATE, 'YYYY')) || LPAD(TO_CHAR(PROF_SEQ0.NEXTVAL), 5, '0'); 
     
     INSERT INTO PROF(PROF_ID, PROF_NAME, SSN, PASSWORD) 
     VALUES(V_ID, V_NAME, V_SSN, SUBSTR(V_SSN,8));
     
    EXCEPTION
       
        WHEN PROF_OVERLAP_ERROR
        THEN RAISE_APPLICATION_ERROR(-20003, '이미등록된 주민번호입니다.');
        ROLLBACK;
       WHEN OTHERS
       THEN ROLLBACK;
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 5. 교수 수정 PRC_PROF_UPDATE(교수ID, 주민번호) ■■■--
CREATE OR REPLACE PROCEDURE PRC_PROF_UPDATE
( V_PROF_ID       IN PROF.PROF_ID%TYPE 
, V_SSN           IN PROF.SSN %TYPE     
)
IS
    V_FSSN PROF.SSN%TYPE;                   -- 주민번호 중복검사용
    
    PROF_OVERLAP_ERROR EXCEPTION;           -- 주민번호 중복시 에러
BEGIN
    
    -- 주민번호 중복값 찾기
    SELECT NVL((SELECT SSN 
                 FROM PROF
                 WHERE SSN = V_SSN), '0')  INTO V_FSSN -- 중복된 값이 있다면 V_FSSN 에 0을 담을꺼임
    FROM DUAL;
    
    IF (V_FSSN != '0') -- 위에서 V_FSSN 이 0이 아니라면 중복된 값이 V_FSSN에 담길거임
        THEN RAISE PROF_OVERLAP_ERROR;
    END IF;  
    
    -- 교수 주민등록번호 변경
    UPDATE PROF
    SET SSN = V_SSN 
    WHERE PROF_ID = V_PROF_ID;
    
    EXCEPTION   
        WHEN PROF_OVERLAP_ERROR
        THEN RAISE_APPLICATION_ERROR(-20003, '이미등록된 주민번호입니다.');
        ROLLBACK;
        WHEN OTHERS
        THEN ROLLBACK;
        
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 6. 교수 삭제 PRC_PROF_DELETE(교수ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_PROF_DELETE
(
    -- 아이디 입력 변수
    V_PROF_ID IN PROF.PROF_ID%TYPE
)
IS
    -- 에러 변수 선언
    -- 찾는 데이터가 존재하지 않는 에러
    NOTEXIST_ERROR EXCEPTION;
BEGIN
    -- 교수 테이블에서 ID로 조회 후 삭제
    DELETE
    FROM PROF
    WHERE PROF_ID = V_PROF_ID;
    
    -- 결과 집합의 결과 ROW 수가 0이면 TRUE, 아니면 FALSE를 반환(묵시적 커서 이용)
    -- 조회 결과 수가 0일 경우엔 에러 발생
    IF SQL%NOTFOUND
    THEN RAISE NOTEXIST_ERROR;
    END IF;

COMMIT;

EXCEPTION
    WHEN NOTEXIST_ERROR
        THEN RAISE_APPLICATION_ERROR(-20005,'일치하는 데이터가 없습니다.');
            ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
END;
--------------------------------------------------------------------------------
--■■■ 7. 교수 삭제2 PRC_PROF_DELETE_1 (트리거) ■■■--
-- ○교수 삭제 트리거
-- 교수 삭제 시, 개설과정에서도 삭제
CREATE OR REPLACE TRIGGER PRC_PROF_DELETE_1
    BEFORE
    DELETE ON PROF
    FOR EACH ROW
BEGIN
    DELETE
    FROM OPEN_COUR
    WHERE PROF_ID=:OLD.PROF_ID;
END;

DROP PROCEDURE PROF_DELETE;
DROP TRIGGER PROF_DELETE_1;
--------------------------------------------------------------------------------
--■■■ 8. 학생 등록 PRC_STU_INSERT(학생명, 주민번호) ■■■--
CREATE OR REPLACE PROCEDURE PRC_STU_INSERT
( V_NAME   IN STU.STU_NAME%TYPE          -- 이름
, V_SSN    IN STU.SSN%TYPE                -- 주민번호
)
IS
    V_ID   STU.STU_ID%TYPE;            -- ID
    V_FSSN STU.SSN%TYPE;                   -- 주민번호 중복검사용
    
    PROF_OVERLAP_ERROR EXCEPTION;           -- 주민번호 중복시 에러
    
BEGIN 

     -- 주민번호 중복값 찾기
    SELECT NVL((SELECT SSN 
                 FROM STU
                 WHERE SSN = V_SSN), '0')  INTO V_FSSN-- 중복된 값이 있다면 V_FSSN 에 0을 담을꺼임
    FROM DUAL;
     
     IF (V_FSSN != '0') -- 위에서 V_FSSN 이 0이 아니라면 중복된 값이 V_FSSN에 담길거임
        THEN RAISE PROF_OVERLAP_ERROR;
     END IF;   
     
     V_ID := CONCAT('S', TO_CHAR(SYSDATE, 'YYYY')) || LPAD(TO_CHAR(STU_SEQ0.NEXTVAL), 5, '0'); 
     
     INSERT INTO STU(STU_ID, STU_NAME, SSN, PASSWORD) 
     VALUES(V_ID, V_NAME, V_SSN, SUBSTR(V_SSN,8));
     
    EXCEPTION
       
        WHEN PROF_OVERLAP_ERROR
        THEN RAISE_APPLICATION_ERROR(-20003, '이미등록된 주민번호입니다.');
        ROLLBACK;
        WHEN OTHERS
        THEN ROLLBACK;
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 9.학생 수정 PRC_STU_UPDATE(학생ID, 주민번호) ■■■--
CREATE OR REPLACE PROCEDURE PRC_STU_UPDATE
( V_STU_ID        IN STU.STU_ID %TYPE 
, V_SSN           IN STU.SSN %TYPE     
)
IS
    V_FSSN STU.SSN%TYPE;                   -- 주민번호 중복검사용
    
    PROF_OVERLAP_ERROR EXCEPTION;           -- 주민번호 중복시 에러
BEGIN
    
    -- 주민번호 중복값 찾기
    SELECT NVL((SELECT SSN 
                 FROM STU
                 WHERE SSN = V_SSN), '0')  INTO V_FSSN-- 중복된 값이 있다면 V_FSSN 에 0을 담을꺼임
    FROM DUAL;
     
     IF (V_FSSN != '0') -- 위에서 V_FSSN 이 0이 아니라면 중복된 값이 V_FSSN에 담길거임
        THEN RAISE PROF_OVERLAP_ERROR;
     END IF;   
    
    -- 학생 주민등록번호 변경
    UPDATE STU
    SET SSN = V_SSN 
    WHERE STU_ID = V_STU_ID;
    
    EXCEPTION
        WHEN PROF_OVERLAP_ERROR
        THEN RAISE_APPLICATION_ERROR(-20003, '이미등록된 주민번호입니다.');
        ROLLBACK;
        WHEN OTHERS
        THEN ROLLBACK;
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 10. 학생 삭제 PRC_STU_DELETE(학생ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_STU_DELETE
(
    V_STU_ID    IN STU.STU_ID%TYPE
)
IS
    NOTEXIST_ERROR EXCEPTION;
BEGIN
    DELETE
    FROM STU
    WHERE STU_ID = V_STU_ID; 

    -- 결과 집합의 결과 ROW 수가 0이면 TRUE, 아니면 FALSE를 반환
    -- 조회 결과 수가 0일 경우엔 에러 발생    
    IF SQL%NOTFOUND 
    THEN RAISE NOTEXIST_ERROR;
    END IF;
     
    COMMIT;
    
    EXCEPTION
        WHEN NOTEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005,'일치하는 데이터가 없습니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;  
END;
--------------------------------------------------------------------------------
--■■■ 11. 학생 삭제2 PRC_STU_DELETE_1 (트리거) ■■■--
--○ 학생 삭제 트리거
--> 학생에서 DELETE가 실행됐을 때 
--> 수강신청 테이블에서도 학생 삭제
-- ▶개설과정에서 과정 삭제
CREATE OR REPLACE TRIGGER PRC_STU_DELETE_1
    BEFORE
    DELETE ON STU
    FOR EACH ROW
BEGIN
    DELETE
    FROM APP
    WHERE STU_ID=:OLD.STU_ID;
END; 
--------------------------------------------------------------------------------
--■■■ 12. 과정 등록 PRC_COURSE_INSERT(과정명) ■■■--
CREATE OR REPLACE PROCEDURE PRC_COURSE_INSERT
( V_COURSE_NAME IN COURSE.COURSE_NAME%TYPE
)
IS
-- 선언부
    --V_COURSE_ID         COURSE.COURSE_ID%TYPE;
    CHECK_COURSE_NAME   COURSE.COURSE_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT NVL((SELECT COURSE_NAME
               FROM COURSE
               WHERE COURSE_NAME = V_COURSE_NAME),'0') INTO CHECK_COURSE_NAME
    FROM DUAL;
    
    IF (CHECK_COURSE_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 선언한 변수에 값 담아내기
    --V_COURSE_ID := ('C' || LPAD(TO_CHAR(COURSE_SEQ.NEXTVAL), 5, '0'));

    -- INSERT 쿼리문 수행
    INSERT INTO COURSE(COURSE_ID, COURSE_NAME)
    VALUES(('C' || LPAD(TO_CHAR(COURSE_SEQ.NEXTVAL), 5, '0')), V_COURSE_NAME);
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20004, '이미 등록된 과정입니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 13. 과정 수정 PRC_COURSE_UPDATE(과정ID, 과정명) ■■■--
CREATE OR REPLACE PROCEDURE PRC_COURSE_UPDATE
( V_COURSE_ID   IN COURSE.COURSE_ID%TYPE
, V_COURSE_NAME IN COURSE.COURSE_NAME%TYPE
)
IS
       CHECK_COURSE_NAME   COURSE.COURSE_NAME%TYPE;
       USER_DEFINE_ERROR EXCEPTION;
BEGIN
    
    SELECT NVL((SELECT COURSE_NAME
               FROM COURSE
               WHERE COURSE_NAME = V_COURSE_NAME),'0') INTO CHECK_COURSE_NAME
    FROM DUAL;
    
    IF (CHECK_COURSE_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 과정 이름 변경
    UPDATE COURSE
    SET COURSE_NAME = V_COURSE_NAME
    WHERE COURSE_ID = V_COURSE_ID;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20004, '이미 등록된 과정입니다.' );
        ROLLBACK;
    
    COMMIT;
    
END;
--------------------------------------------------------------------------------
--■■■ 14. 과정 삭제 PRC_COURSE_DELETE(과정ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_COURSE_DELETE
(
    V_COURSE_ID IN COURSE.COURSE_ID%TYPE
)
IS
    NOTEXIST_ERROR EXCEPTION;
BEGIN
    DELETE
    FROM COURSE
    WHERE COURSE_ID = V_COURSE_ID;

    -- 결과 집합의 결과 ROW 수가 0이면 TRUE, 아니면 FALSE를 반환
    -- 조회 결과 수가 0일 경우엔 에러 발생    
    IF SQL%NOTFOUND 
    THEN RAISE NOTEXIST_ERROR;
    END IF;
    
    COMMIT;

EXCEPTION
    WHEN NOTEXIST_ERROR
        THEN RAISE_APPLICATION_ERROR(-20005,'일치하는 데이터가 없습니다.');
            ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;        
END;
--------------------------------------------------------------------------------
--■■■ 15. 과정 삭제2 PRC_COURSE_DELETE_1 (트리거) ■■■--
--○ 과정 삭제 트리거
--> 과정에서 DELETE가 실행됐을 때 
--> 개설과정 테이블에서도 과정 삭제
-- ▶개설과정에서 과정 삭제
CREATE OR REPLACE TRIGGER PRC_COURSE_DELETE_1
    BEFORE
    DELETE ON COURSE
    FOR EACH ROW
BEGIN
    DELETE
    FROM OPEN_COUR
    WHERE COURSE_ID=:OLD.COURSE_ID;
END; 
--------------------------------------------------------------------------------
--■■■ 16. 과목 등록 PRC_SUBJECT_INSERT(과목명) ■■■--
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_INSERT
( V_SUBJECT_NAME IN SUBJECT.SUBJECT_NAME%TYPE
)
IS
-- 선언부
    --V_SUBJECT_ID         SUBJECT.SUBJECT_ID%TYPE;
    CHECK_SUBJECT_NAME   SUBJECT.SUBJECT_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT NVL((SELECT SUBJECT_NAME
               FROM SUBJECT
               WHERE SUBJECT_NAME = V_SUBJECT_NAME),'0') INTO CHECK_SUBJECT_NAME
    FROM DUAL;
    
    IF (CHECK_SUBJECT_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 선언한 변수에 값 담아내기
    --V_SUBJECT_ID := ('SB' || LPAD(TO_CHAR(SUBJECT_SEQ.NEXTVAL), 5, '0'));

    -- INSERT 쿼리문 수행
    INSERT INTO SUBJECT(SUBJECT_ID, SUBJECT_NAME)
    VALUES(('SB' || LPAD(TO_CHAR(SUBJECT_SEQ.NEXTVAL), 5, '0')), V_SUBJECT_NAME);
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20004, '이미 등록된 과목입니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 17. 과목 수정 PRC_SUBJECT_UPDATE(과목ID, 과목명) ■■■--
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_UPDATE
( V_SUBJECT_ID        IN SUBJECT.SUBJECT_ID%TYPE
, V_SUBJECT_NAME	  IN SUBJECT.SUBJECT_NAME%TYPE
)
IS
    CHECK_SUBJECT_NAME   SUBJECT.SUBJECT_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    
    SELECT NVL((SELECT SUBJECT_NAME
               FROM SUBJECT
               WHERE SUBJECT_NAME = V_SUBJECT_NAME),'0') INTO CHECK_SUBJECT_NAME
    FROM DUAL;
    
    IF (CHECK_SUBJECT_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 과목 이름 변경
    UPDATE SUBJECT
    SET SUBJECT_NAME = V_SUBJECT_NAME
    WHERE SUBJECT_ID = V_SUBJECT_ID;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20026, '이미 등록된 과목입니다.' );
        ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;
--------------------------------------------------------------------------------
--■■■ 18. 과목 삭제 PRC_SUBJECT_DELETE(과목ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_DELETE
(
    V_SUBJECT_ID IN SUBJECT.SUBJECT_ID%TYPE
)
IS
    NOTEXIST_ERROR EXCEPTION;
BEGIN
    DELETE
    FROM SUBJECT
    WHERE SUBJECT_ID = V_SUBJECT_ID;

    -- 결과 집합의 결과 ROW 수가 0이면 TRUE, 아니면 FALSE를 반환
    -- 조회 결과 수가 0일 경우엔 에러 발생        
    IF SQL%NOTFOUND 
    THEN RAISE NOTEXIST_ERROR;
    END IF;
    
    COMMIT;
    
    EXCEPTION 
        WHEN NOTEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005,'일치하는 데이터가 없습니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--------------------------------------------------------------------------------
--■■■ 19. 과목 삭제2 PRC_SUBJECT_DELETE_1 (트리거) ■■■--
--○ 과목 삭제 트리거
--> 과목에서 DELETE가 실행됐을 때 
--> 개설과목 테이블에서도 과목 삭제
-- ▶개설과목에서 과목 삭제
CREATE OR REPLACE TRIGGER PRC_SUBJECT_DELETE_1
    BEFORE
    DELETE ON SUBJECT
    FOR EACH ROW
BEGIN
    DELETE
    FROM OPEN_SUBJ
    WHERE SUBJECT_ID = :OLD.SUBJECT_ID;
END;
--------------------------------------------------------------------------------
--■■■ 20. 성적 입력 PRC_SCORE_INSERT(개설과정ID,수강신청ID,출결,필기,실기) ■■■-- (수정 필요)
CREATE OR REPLACE PROCEDURE PRC_SCORE_INSERT
(
    V_OPEN_SUBJ_ID      IN SCORE.OPEN_SUBJ_ID%TYPE      -- 개설과목코드 
   ,V_APP_ID            IN SCORE.APP_ID%TYPE            -- 수강신청코드
   ,V_ATTEND_SCORE      IN SCORE.ATTEND_SCORE%TYPE      -- 출결성적
   ,V_WRITE_SCORE       IN SCORE.WRITE_SCORE%TYPE       -- 필기성적
   ,V_PRACTICE_SCORE    IN SCORE.PRACTICE_SCORE%TYPE    -- 실기성적
)
IS

    V_END_DATE          OPEN_SUBJ.END_DATE%TYPE;          -- 개설과목 종료일    
    V_SCORE_DATE        SCORE.SCORE_DATE%TYPE;            -- 성적입력일    
    V_SCORE_ID          SCORE.SCORE_ID%TYPE;              -- 점수 코드
    V_FAPP_ID           SCORE.APP_ID%TYPE;                -- 수강신청코드 중복검사   
    V_FOP_SUB           SCORE.OPEN_SUBJ_ID%TYPE;          -- 개설과목코드 중복검사
    V_MID_DROP          NUMBER;                           -- 중도포기 


    MID_DROP_STU_ERROR EXCEPTION;                   -- 중도포기에러  
    APP_OVERLAP_ERROR EXCEPTION;                    -- 수강신청코드시 중복시 에러 
    SCORE_DATE_ERROR   EXCEPTION;                  -- 개설과목 진행중에 성적입력X 에러

    CURSOR CUR_CHECK_APP
    IS 
    SELECT APP_ID, OPEN_SUBJ_ID
    FROM SCORE
    WHERE APP_ID = V_APP_ID; 
    
BEGIN
    
    OPEN CUR_CHECK_APP;
        LOOP
        FETCH CUR_CHECK_APP INTO V_FAPP_ID, V_FOP_SUB;
        EXIT WHEN CUR_CHECK_APP%NOTFOUND;
        
        IF (V_OPEN_SUBJ_ID = V_FOP_SUB AND  V_APP_ID = V_FAPP_ID)
        THEN RAISE APP_OVERLAP_ERROR;
        END IF;
        END LOOP;
    CLOSE CUR_CHECK_APP;
    
    SELECT COUNT(*) INTO V_MID_DROP
    FROM DROPOUT
    WHERE APP_ID = V_APP_ID;
    
    IF (V_MID_DROP> 0)
        THEN RAISE MID_DROP_STU_ERROR;
    END IF;
    
    -- ③과목 진행 중간에 성적 입력 불가 
    -- 끝나는 날짜보다 이르면 입력 불가
    SELECT END_DATE INTO V_END_DATE 
    FROM OPEN_SUBJ
    WHERE OPEN_SUBJ_ID =  V_OPEN_SUBJ_ID;

    IF (V_END_DATE > SYSDATE)
        THEN RAISE SCORE_DATE_ERROR;
    END IF;
    --SCORE_ID + 시퀀스 번호 표기 
    V_SCORE_ID := 'S'||TO_CHAR(SYSDATE,'YY');
    
    -- 성적테이블에 INSERT
    INSERT INTO SCORE(SCORE_ID, OPEN_SUBJ_ID, APP_ID, ATTEND_SCORE, WRITE_SCORE, PRACTICE_SCORE)
    VALUES(V_SCORE_ID||LPAD(TO_CHAR(SEQ_SCORE_ID.NEXTVAL),5,'0'), V_OPEN_SUBJ_ID, V_APP_ID, 
          V_ATTEND_SCORE, V_WRITE_SCORE, V_PRACTICE_SCORE);

    -- 커밋
    COMMIT;
    
    -- 예외처리
    EXCEPTION
        WHEN MID_DROP_STU_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20007, '중도포기한 수업입니다.');
                ROLLBACK;
        WHEN APP_OVERLAP_ERROR
            THEN RAISE_APPLICATION_ERROR(-20027, '이미 성적이 등록된 학생입니다');
                ROLLBACK;
        WHEN SCORE_DATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20028, '성적입력기간이 아닙니다');
                ROLLBACK;

         WHEN OTHERS
            THEN ROLLBACK;
END;
--------------------------------------------------------------------------------
--■■■ 21. 성적 수정 PRC_SCORE_UPDATE(점수ID, 출결, 필기, 실기) ■■■--
CREATE OR REPLACE PROCEDURE PRC_SCORE_UPDATE
(
    V_SCORE_ID          IN SCORE. SCORE_ID%TYPE
   ,V_ATTEND_SCORE      IN SCORE.ATTEND_SCORE%TYPE
   ,V_WRITE_SCORE       IN SCORE.WRITE_SCORE%TYPE
   ,V_PRACTICE_SCORE    IN SCORE.PRACTICE_SCORE%TYPE
)
IS
BEGIN
    -- 출결, 필기, 실기 업데이트
    UPDATE SCORE
    SET ATTEND_SCORE = V_ATTEND_SCORE, WRITE_SCORE = V_WRITE_SCORE, PRACTICE_SCORE = V_PRACTICE_SCORE
    WHERE SCORE_ID = V_SCORE_ID;
END;
--------------------------------------------------------------------------------
--■■■ 22. 성적 삭제 PRC_SCORE_DELETE(성적ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_SCORE_DELETE
(
    V_SCORE_ID IN SCORE.SCORE_ID%TYPE
)
IS
    NOTEXIST_ERROR EXCEPTION;
BEGIN
    DELETE
    FROM SCORE
    WHERE SCORE_ID = V_SCORE_ID;
    
    -- 결과 집합의 결과 ROW 수가 0이면 TRUE, 아니면 FALSE를 반환
    -- 조회 결과 수가 0일 경우엔 에러 발생
    IF SQL%NOTFOUND
    THEN RAISE NOTEXIST_ERROR;
    END IF;
    
    COMMIT;
    
    EXCEPTION 
        WHEN NOTEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005,'일치하는 데이터가 없습니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;    
END;
--------------------------------------------------------------------------------
--■■■ 23. 배점 부여 PRC_SCORE_POINT ■■■--
CREATE OR REPLACE PROCEDURE PRC_SCORE_POINT
(
     V_OPEN_SUBJ_ID   IN OPEN_SUBJ.OPEN_SUBJ_ID%TYPE
    ,V_WRITE_POINT    IN OPEN_SUBJ.WRITE_POINT%TYPE     -- 필기배점
    ,V_PRACTICE_POINT IN OPEN_SUBJ.PRACTICE_POINT%TYPE  -- 실기배점
    ,V_ATTEND_POINT   IN OPEN_SUBJ.ATTEND_POINT%TYPE    -- 출결배점
)
IS
BEGIN
    UPDATE OPEN_SUBJ
    SET WRITE_POINT = V_WRITE_POINT, PRACTICE_POINT = V_PRACTICE_POINT, ATTEND_POINT = V_ATTEND_POINT
    WHERE OPEN_SUBJ_ID = V_OPEN_SUBJ_ID;
END;
--------------------------------------------------------------------------------
--■■■ 24. 수강과목 총점 함수 TOTAL_SCORE ■■■--
CREATE OR REPLACE FUNCTION TOTAL_SCORE
(
    --성적 SCORE,  개설과목(배점) OPEN_SUBJ 호출
    V_SCORE_ID IN SCORE.SCORE_ID%TYPE
   ,V_OPEN_SUBJ_ID IN OPEN_SUBJ.OPEN_SUBJ_ID%TYPE
)
    -- 숫자값을 리턴
    RETURN NUMBER
IS
    -- 주요 변수 선언
    RESULT NUMBER;
    
    V_P_POINT OPEN_SUBJ.PRACTICE_POINT%TYPE;
    V_W_POINT OPEN_SUBJ.WRITE_POINT%TYPE;
    V_A_POINT OPEN_SUBJ.ATTEND_POINT%TYPE;
    
    V_P_SCORE SCORE.PRACTICE_SCORE%TYPE;
    V_W_SCORE SCORE.WRITE_SCORE%TYPE;
    V_A_SCORE SCORE.ATTEND_SCORE%TYPE;
    
BEGIN
    -- 배점 받아오기
    -- NULL일 경우 0으로 치환
    SELECT NVL(PRACTICE_POINT,0), NVL(WRITE_POINT,0), NVL(ATTEND_POINT,0) INTO V_P_POINT, V_W_POINT, V_A_POINT
    FROM OPEN_SUBJ
    WHERE OPEN_SUBJ_ID = V_OPEN_SUBJ_ID;
    
    -- 점수 받아오기
    -- NULL일 경우 0으로 치환    
    SELECT NVL(PRACTICE_SCORE,0), NVL(WRITE_SCORE,0), NVL(ATTEND_SCORE,0) INTO V_P_SCORE, V_W_SCORE, V_A_SCORE
    FROM SCORE
    WHERE SCORE_ID = V_SCORE_ID;

    RESULT := (V_P_POINT*V_P_SCORE + V_W_POINT*V_W_SCORE + V_A_POINT*V_A_SCORE)/100;

    -- 최종 결과 반환
    RETURN RESULT;
END;
--------------------------------------------------------------------------------
--■■■ 25. 교재 등록 PRC_BOOK_INSERT(교재명, 출판사) ■■■--
CREATE OR REPLACE PROCEDURE PRC_BOOK_INSERT
( V_BOOK_NAME IN BOOK.BOOK_NAME%TYPE
, V_BOOK_PUB IN BOOK.BOOK_PUB%TYPE
)
IS
-- 선언부
    --V_BOOK_ID      BOOK.BOOK_ID%TYPE;
    CHECK_BOOK_NAME   BOOK.BOOK_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT NVL((SELECT BOOK_NAME
               FROM BOOK
               WHERE BOOK_NAME = V_BOOK_NAME),'0') INTO CHECK_BOOK_NAME
    FROM DUAL;
    
    IF (CHECK_BOOK_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 선언한 변수에 값 담아내기
    --V_BOOK_ID := ('BK' || LPAD(TO_CHAR(BOOK_SEQ.NEXTVAL), 3, '0'));

    -- INSERT 쿼리문 수행
    INSERT INTO BOOK(BOOK_ID, BOOK_NAME, BOOK_PUB)
    VALUES(('BK' || LPAD(TO_CHAR(BOOK_SEQ.NEXTVAL), 3, '0')), V_BOOK_NAME, V_BOOK_PUB);
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20004, '이미 등록된 교재입니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 26. 교재 수정 PRC_BOOK_UPDATE(교재ID, 교재명, 출판사) ■■■--
CREATE OR REPLACE PROCEDURE PRC_BOOK_UPDATE
( V_BOOK_ID     IN BOOK.BOOK_ID%TYPE
, NEW_BOOK_NAME   IN BOOK.BOOK_NAME%TYPE
, NEW_BOOK_PUB    IN BOOK.BOOK_PUB%TYPE
)
IS
-- 선언부
    CHECK_BOOK_NAME   BOOK.BOOK_NAME%TYPE;
    CHECK_BOOK_ID     BOOK.BOOK_ID%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
    
BEGIN
    
    -- 교재ID가 없으면 예외
    SELECT NVL((SELECT BOOK_ID
               FROM BOOK
               WHERE BOOK_ID = V_BOOK_ID),'0') INTO CHECK_BOOK_ID
    FROM DUAL;
    
    IF (CHECK_BOOK_ID = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 이미 등록된 교재명이면 예외
    SELECT NVL((SELECT BOOK_NAME
               FROM BOOK
               WHERE BOOK_NAME = NEW_BOOK_NAME),'0') INTO CHECK_BOOK_NAME
    FROM DUAL;
    
    IF (CHECK_BOOK_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- UPDATE 쿼리문 수행
    UPDATE BOOK
    SET BOOK_NAME = NEW_BOOK_NAME, BOOK_PUB = NEW_BOOK_PUB
    WHERE BOOK_ID = V_BOOK_ID;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20004, '등록되지 않은 교재ID입니다.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20004, '이미 등록된 교재입니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 27. 교재 삭제 PRC_BOOK_DELETE(교재ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_BOOK_DELETE
( V_BOOK_ID     IN BOOK.BOOK_ID%TYPE
)
IS
-- 선언부
    CHECK_BOOK_ID     BOOK.BOOK_ID%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
    
BEGIN
    
    -- 교재ID가 없으면 예외
    SELECT NVL((SELECT BOOK_ID
               FROM BOOK
               WHERE BOOK_ID = V_BOOK_ID),'0') INTO CHECK_BOOK_ID
    FROM DUAL;
    
    IF (CHECK_BOOK_ID = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 해당 교재를 이미 사용 중인 과목이 있습니다.
    SELECT NVL((SELECT BOOK_ID
               FROM OPEN_SUBJ
               WHERE BOOK_ID = V_BOOK_ID),'0') INTO CHECK_BOOK_ID
    FROM DUAL;
    
    IF (CHECK_BOOK_ID = V_BOOK_ID)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- DELETE 쿼리문 수행
    DELETE
    FROM BOOK
    WHERE BOOK_ID = V_BOOK_ID;
    
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20004, '등록되지 않은 교재입니다.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20004, '해당 교재를 이미 사용 중인 과목이 있습니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 28. 강의실 등록 PRC_CLASS_INSERT(강의실명) ■■■--
CREATE OR REPLACE PROCEDURE PRC_CLASS_INSERT
( V_CLASS_NAME IN CLASS.CLASS_NAME%TYPE
)
IS
-- 선언부
    --V_CLASS_ID      CLASS.CLASS_ID%TYPE;
    CHECK_CLASS_NAME   CLASS.CLASS_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT NVL((SELECT CLASS_NAME
               FROM CLASS
               WHERE CLASS_NAME = V_CLASS_NAME),'0') INTO CHECK_CLASS_NAME
    FROM DUAL;
    
    IF (CHECK_CLASS_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 선언한 변수에 값 담아내기
    --V_CLASS_ID := ('BK' || LPAD(TO_CHAR(CLASS_SEQ.NEXTVAL), 3, '0'));

    -- INSERT 쿼리문 수행
    INSERT INTO CLASS(CLASS_ID, CLASS_NAME)
    VALUES(('CL' || LPAD(TO_CHAR(CLASS_SEQ.NEXTVAL), 3, '0')), V_CLASS_NAME);
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20004, '이미 등록된 강의실입니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 29. 강의실 수정 PRC_CLASS_UPDATE(강의실ID, 강의실명) ■■■--
CREATE OR REPLACE PROCEDURE PRC_CLASS_UPDATE
( V_CLASS_ID IN CLASS.CLASS_ID%TYPE
, NEW_CLASS_NAME IN CLASS.CLASS_NAME%TYPE
)
IS
    -- 선언부
    CHECK_CLASS_ID   CLASS.CLASS_ID%TYPE;
    CHECK_CLASS_NAME   CLASS.CLASS_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
    
BEGIN
    
    -- 존재하는 강의실ID인지 확인
    SELECT NVL((SELECT CLASS_ID
               FROM CLASS
               WHERE CLASS_ID = V_CLASS_ID),'0') INTO CHECK_CLASS_ID
    FROM DUAL;
    
    IF (CHECK_CLASS_ID = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 이미 사용중인 강의실명인지 확인
    SELECT NVL((SELECT CLASS_NAME
               FROM CLASS
               WHERE CLASS_NAME = NEW_CLASS_NAME),'0') INTO CHECK_CLASS_NAME
    FROM DUAL;
    
    IF (CHECK_CLASS_NAME = NEW_CLASS_NAME)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- INSERT 쿼리문 수행
    UPDATE CLASS
    SET CLASS_NAME = NEW_CLASS_NAME
    WHERE CLASS_ID = V_CLASS_ID;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20004, '존재하지 않는 강의실ID 입니다.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20004, '이미 사용 중인 강의실명 입니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 30. 강의실 삭제 PRC_CLASS_DELETE(강의실ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_CLASS_DELETE
( V_CLASS_ID IN CLASS.CLASS_ID%TYPE
)
IS
-- 선언부
    CHECK_CLASS_ID      CLASS.CLASS_ID%TYPE;
    CHECK_CLASS_NAME   CLASS.CLASS_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
BEGIN
    
    -- 존재하는 강의실ID인지 확인
    SELECT NVL((SELECT CLASS_ID
               FROM CLASS
               WHERE CLASS_ID = V_CLASS_ID),'0') INTO CHECK_CLASS_ID
    FROM DUAL;
    
    IF (CHECK_CLASS_ID = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 이미 사용중인 개설과정이 있는지 확인
    SELECT NVL((SELECT CLASS_ID
               FROM OPEN_COUR
               WHERE CLASS_ID = V_CLASS_ID),'0') INTO CHECK_CLASS_ID
    FROM DUAL;
    
    IF (CHECK_CLASS_ID = V_CLASS_ID)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- DELETE 쿼리문 수행
    DELETE
    FROM CLASS
    WHERE CLASS_ID = V_CLASS_ID;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20004, '존재하지 않는 강의실ID 입니다.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20004, '해당 강의실을 사용하는 개설과정이 있습니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 31. 수강 신청 입력 PRC_APP_INSERT(개설과정ID, 학생ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_APP_INSERT
( V_OPEN_COUR_ID IN OPEN_COUR.OPEN_COUR_ID%TYPE
, V_STU_ID IN STU.STU_ID%TYPE
)
IS
-- 선언부
    --V_APP_ID          CLASS.CLASS_ID%TYPE;
    CHECK_STU_ID        STU.STU_ID%TYPE; -- 해당 개설과정코드에 학생ID가 중복으로 들어갈 수 없도록
    CHECK_OPEN_COUR_ID  OPEN_COUR.OPEN_COUR_ID%TYPE;
    CHECK_START_DATE    OPEN_COUR.START_DATE%TYPE;
    CHECK_APP_ID        APP.APP_ID%TYPE;

    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
    USER_DEFINE_ERROR3   EXCEPTION;
    
BEGIN
    
    -- 학생이 없는지 확인
    SELECT NVL((SELECT STU_ID
               FROM STU
               WHERE STU_ID = V_STU_ID),'0') INTO CHECK_STU_ID
    FROM DUAL;
    
    IF (CHECK_STU_ID = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 개설된 과정이 없는지 확인
    SELECT NVL((SELECT OPEN_COUR_ID
               FROM OPEN_COUR
               WHERE OPEN_COUR_ID = V_OPEN_COUR_ID),'0') INTO CHECK_OPEN_COUR_ID
    FROM DUAL;
    
    IF (CHECK_OPEN_COUR_ID = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 수강신청이 가능한지 확인
    SELECT START_DATE   INTO CHECK_START_DATE
    FROM OPEN_COUR
    WHERE OPEN_COUR_ID = V_OPEN_COUR_ID;
    
    IF (SYSDATE > CHECK_START_DATE)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    
    -- 이미 수강신청 했는지 확인
    SELECT NVL((SELECT STU_ID
               FROM APP
               WHERE OPEN_COUR_ID = V_OPEN_COUR_ID),'0') INTO CHECK_STU_ID
    FROM DUAL;
    
    IF (CHECK_STU_ID = V_STU_ID)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;
    
    

    -- 선언한 변수에 값 담아내기
    --V_APP_ID := ('BK' || LPAD(TO_CHAR(CLASS_SEQ.NEXTVAL), 3, '0'));

    -- INSERT 쿼리문 수행
    INSERT INTO APP(APP_ID, OPEN_COUR_ID, STU_ID) -- APP_DATE는 SYSDATE 디폴트
    VALUES(('AP' || LPAD(TO_CHAR(APP_SEQ.NEXTVAL), 5, '0')), V_OPEN_COUR_ID, V_STU_ID);
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20009, '학생이나 과정을 찾을 수 없습니다.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20010, '수강신청(수정 및 철회) 기간이 지났습니다.' );
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20011, '이미 수강신청된 과목입니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 32. 수강 신청 수정 PRC_APP_UPDATE(수강신청ID, 변경과정ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_APP_UPDATE
( V_APP_ID IN APP.APP_ID%TYPE
, NEW_OPEN_COUR_ID IN OPEN_COUR.OPEN_COUR_ID%TYPE
)
IS
-- 선언부
    V_STU_ID          STU.STU_ID%TYPE;
    V_OPEN_COUR_ID      OPEN_COUR.OPEN_COUR_ID%TYPE;
    
    CHECK_STU_ID        STU.STU_ID%TYPE;
    CHECK_OPEN_COUR_ID  OPEN_COUR.OPEN_COUR_ID%TYPE;
    CHECK_START_DATE    OPEN_COUR.START_DATE%TYPE;
    CHECK_APP_ID        APP.APP_ID%TYPE;

    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;
    USER_DEFINE_ERROR3   EXCEPTION;
    USER_DEFINE_ERROR4   EXCEPTION;
    
BEGIN
    
    -- 수강신청ID가 없는지 확인
    SELECT NVL((SELECT APP_ID
               FROM APP
               WHERE APP_ID = V_APP_ID),'0') INTO CHECK_APP_ID
    FROM DUAL;
    
    IF (CHECK_APP_ID = '0')
        THEN RAISE USER_DEFINE_ERROR4;
    END IF;
    
    
    -- 개설된 과정이 없는지 확인(변경 후 개설과정)
    SELECT NVL((SELECT OPEN_COUR_ID
               FROM OPEN_COUR
               WHERE OPEN_COUR_ID = NEW_OPEN_COUR_ID),'0') INTO CHECK_OPEN_COUR_ID
    FROM DUAL;
    
    IF (CHECK_OPEN_COUR_ID = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 변수에 값넣기
    SELECT OPEN_COUR_ID, STU_ID INTO V_OPEN_COUR_ID, V_STU_ID
    FROM APP
    WHERE APP_ID = V_APP_ID;
    
    
    -- 수강신청이 가능한지 확인 (변경 전)
    SELECT START_DATE   INTO CHECK_START_DATE
    FROM OPEN_COUR
    WHERE OPEN_COUR_ID = V_OPEN_COUR_ID;
    
    IF (SYSDATE > CHECK_START_DATE)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- 수강신청이 가능한지 확인 (변경 후)
    SELECT START_DATE   INTO CHECK_START_DATE
    FROM OPEN_COUR
    WHERE OPEN_COUR_ID = NEW_OPEN_COUR_ID;
    
    IF (SYSDATE > CHECK_START_DATE)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    
     -- 이미 수강신청 했는지 확인 (변경 후 개설과정)
    SELECT NVL((SELECT STU_ID
               FROM APP
               WHERE OPEN_COUR_ID = NEW_OPEN_COUR_ID),'0') INTO CHECK_STU_ID
    FROM DUAL;
    
    IF (CHECK_STU_ID = V_STU_ID)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;
    


    -- UPDATE 쿼리문 수행
    UPDATE APP
    SET OPEN_COUR_ID = NEW_OPEN_COUR_ID
    WHERE APP_ID = V_APP_ID;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20009, '과정을 찾을 수 없습니다.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20010, '수강신청(수정 및 철회) 기간이 지났습니다.' );
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20011, '이미 수강신청된 과목입니다.' );
    WHEN USER_DEFINE_ERROR4
    THEN RAISE_APPLICATION_ERROR(-20011, '수강신청ID를 찾을 수 없습니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 33. 수강 신청 삭제 PRC_APP_DELETE(수강신청ID) ■■■--
CREATE OR REPLACE PROCEDURE PRC_APP_DELETE
( V_APP_ID          IN APP.APP_ID%TYPE
)
IS
-- 선언부
    
    V_OPEN_COUR_ID      OPEN_COUR.OPEN_COUR_ID%TYPE;
    V_STU_ID            STU.STU_ID%TYPE;

    CHECK_STU_ID        STU.STU_ID%TYPE; -- 해당 개설과정코드에 학생ID가 중복으로 들어갈 수 없도록
    CHECK_OPEN_COUR_ID  OPEN_COUR.OPEN_COUR_ID%TYPE;
    CHECK_START_DATE    OPEN_COUR.START_DATE%TYPE;
    CHECK_APP_ID        APP.APP_ID%TYPE;

    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2   EXCEPTION;

    
BEGIN
    
    
     -- 수강신청ID가 없는지 확인
    SELECT NVL((SELECT APP_ID
               FROM APP
               WHERE APP_ID = V_APP_ID),'0') INTO CHECK_APP_ID
    FROM DUAL;
    
    IF (CHECK_APP_ID = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 변수에 값담기
    SELECT OPEN_COUR_ID INTO V_OPEN_COUR_ID
    FROM APP
    WHERE APP_ID = V_APP_ID;
    
    
    -- 수강철회가 가능한지 확인 (과정 시작날짜 이전)
    SELECT START_DATE   INTO CHECK_START_DATE
    FROM OPEN_COUR
    WHERE OPEN_COUR_ID = V_OPEN_COUR_ID;
    
    IF (SYSDATE > CHECK_START_DATE)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    
    -- DELETE 쿼리문 수행
    DELETE
    FROM APP
    WHERE APP_ID = V_APP_ID;
    
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20009, '수강신청ID를 찾을 수 없습니다.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20010, '수강신청(수정 및 철회) 기간이 지났습니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 34. 중도 탈락 사유 입력 PRC_REASONS_DROPOUT_INSERT(탈락사유) ■■■--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_INSERT
(V_REASON_DROPOUT   IN REASONS_DROPOUT.REASON_DROPOUT%TYPE)
IS
    COUNTNUM    NUMBER;
BEGIN
    
    SELECT COUNT(*) INTO COUNTNUM
    FROM REASONS_DROPOUT;
    
    -- 첫 레코드 입력이면 시퀀스 초기화
    IF (COUNTNUM = 0)
        THEN PRC_RESET_SEQ('SEQ_REASONS_DROPOUT');
    END IF;
    
    INSERT INTO REASONS_DROPOUT(REASONS_DROPOUT_ID, REASON_DROPOUT)
    VALUES(CONCAT('DR', TO_CHAR(LPAD(SEQ_REASONS_DROPOUT.NEXTVAL, 3, 0))), V_REASON_DROPOUT);  
    
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 35. 중도 탈락 사유 수정 PRC_REASONS_DROPOUT_UPDATE(중도탈락코드, 탈락사유) ■■■--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_UPDATE
( V_REASONS_DROPOUT_ID IN REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE
, V_REASON_DROPOUT    IN REASONS_DROPOUT.REASON_DROPOUT%TYPE
)
IS
BEGIN
    UPDATE REASONS_DROPOUT
    SET REASON_DROPOUT = V_REASON_DROPOUT
    WHERE REASONS_DROPOUT_ID = V_REASONS_DROPOUT_ID;
    
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 36. 중도 탈락 사유 삭제 PRC_REASONS_DROPOUT_DELETE(중도탈락코드) ■■■--
CREATE OR REPLACE PROCEDURE PRC_REASONS_DROPOUT_DELETE
( V_REASONS_DROPOUT_ID IN REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE )
IS
    CHECK_REASON_ID REASONS_DROPOUT.REASONS_DROPOUT_ID%TYPE;
    USER_DEFINE_ERROR EXCEPTION; 
    
BEGIN
    SELECT COUNT(*) INTO CHECK_REASON_ID
    FROM DROPOUT
    WHERE REASONS_DROPOUT_ID = V_REASONS_DROPOUT_ID;
    
    IF (CHECK_REASON_ID != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DELETE
    FROM REASONS_DROPOUT
    WHERE REASONS_DROPOUT_ID = V_REASONS_DROPOUT_ID;

    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20029, '중도탈락리스트에 입력된 탈락사유이므로 삭제할 수 없습니다.');
        ROLLBACK;
    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 37. 시퀀스 초기화 PRC_RESET_SEQ(시퀀스명) ■■■--  34번 보다 먼저 실행 되야 함
CREATE OR REPLACE PROCEDURE PRC_RESET_SEQ
( V_SEQ_NAME IN VARCHAR2 )
IS
    V_SEQ_VAL NUMBER;
BEGIN
    -- 다음시퀀스 값을 SEQ_VAL 변수에 저장
    EXECUTE IMMEDIATE 'SELECT ' || V_SEQ_NAME || '.NEXTVAL FROM DUAL' INTO V_SEQ_VAL;

    -- 현재의 시퀀스에서 저장된 값(SEQ_VAL)을 빼준다. 그럼 0으로 초기화 됨.
    EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || V_SEQ_NAME || ' INCREMENT BY -' || V_SEQ_VAL || ' MINVALUE 0';

    -- 0으로 초기화 된 시퀀스 값을 확인
    EXECUTE IMMEDIATE 'SELECT ' || V_SEQ_NAME || '.NEXTVAL FROM DUAL' INTO V_SEQ_VAL;

    -- 지금부터는 1씩 증가되도록 시퀀스를 변경함.
    EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || V_SEQ_NAME || ' INCREMENT BY 1 MINVALUE 0';
END PRC_RESET_SEQ;
--------------------------------------------------------------------------------
--■■■ 38. 중도탈락리스트 입력 PRC_DROPOUT_INSERT ■■■-- (수정 필요)
CREATE OR REPLACE PROCEDURE PRC_DROPOUT_INSERT
( V_APP_ID                  IN DROPOUT.APP_ID%TYPE
, V_REASONS_DROPOUT_ID      IN DROPOUT.REASONS_DROPOUT_ID%TYPE
--, V_DROPOUT_DATE            IN DROPOUT.DROPOUT_DATE%TYPE
)
IS  
    V_DROPOUT_ID   DROPOUT.DROPOUT_ID%TYPE;   -- 중도포기 코드 (시퀀스로 자동생성)
    
    V_START_DATE   OPEN_COUR.START_DATE%TYPE; -- 과정 시작일 담기
    V_END_DATE     OPEN_COUR.END_DATE%TYPE;   -- 과정 종료일 담기
    
    USER_DEFINE_ERROR EXCEPTION;              -- 중도포기일이 과정기간 안에 없으면 오류
    USER_DEFINE_ERROR2 EXCEPTION;
    
    CHECK_APP_ID   DROPOUT.APP_ID%TYPE;
BEGIN
    SELECT NVL((SELECT APP_ID
               FROM DROPOUT
               WHERE APP_ID = V_APP_ID),'0') INTO CHECK_APP_ID
    FROM DUAL;
    
    IF (CHECK_APP_ID != '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    SELECT START_DATE, END_DATE INTO V_START_DATE, V_END_DATE
    FROM OPEN_COUR
    WHERE OPEN_COUR_ID = (SELECT OPEN_COUR_ID
                          FROM APP
                          WHERE APP_ID = V_APP_ID);
    
    IF (SYSDATE NOT BETWEEN V_START_DATE AND V_END_DATE) 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    
    INSERT INTO DROPOUT(DROPOUT_ID, APP_ID, REASONS_DROPOUT_ID)
         VALUES('D' || LPAD(TO_CHAR(DROPOUT_SEQ.NEXTVAL), 5, '0'), V_APP_ID, V_REASONS_DROPOUT_ID);
          
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20025, '중도포기일이 과정기간이 아닙니다.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
        THEN RAISE_APPLICATION_ERROR(-20026, '이미 중도포기한 학생입니다.');
        ROLLBACK;

    COMMIT;
END;
--------------------------------------------------------------------------------
--■■■ 39. 중도탈락리스트 수정 PRC_DROPOUT_UPDATE ■■■--
CREATE OR REPLACE PROCEDURE PRC_DROPOUT_UPDATE
( V_DROPOUT_ID           IN DROPOUT.DROPOUT_ID%TYPE  
, V_APP_ID               IN DROPOUT.APP_ID%TYPE
, V_DROPOUT_DATE         IN DROPOUT.DROPOUT_DATE%TYPE
)
IS

    V_START_DATE   OPEN_COUR.START_DATE%TYPE; -- 과정 시작일 담기
    V_END_DATE     OPEN_COUR.END_DATE%TYPE;   -- 과정 종료일 담기
    
    USER_DEFINE_ERROR EXCEPTION;              -- 중도포기일이 과정기간 안에 없으면 오류
    
BEGIN
    
    SELECT OC.START_DATE, OC.END_DATE INTO V_START_DATE, V_END_DATE
    FROM OPEN_COUR OC JOIN APP AP  
        ON OC.OPEN_COUR_ID = AP.OPEN_COUR_ID
        JOIN DROPOUT DR
        ON DR.APP_ID = AP.APP_ID
    WHERE DR.DROPOUT_ID = V_DROPOUT_ID;
    
    IF (V_DROPOUT_DATE NOT BETWEEN V_START_DATE AND V_END_DATE)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE DROPOUT
    SET DROPOUT_DATE = V_DROPOUT_DATE, APP_ID = V_APP_ID
    WHERE DROPOUT_ID = V_DROPOUT_ID;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20025, '중도포기일이 과정기간이 아닙니다.');
        ROLLBACK;
        WHEN OTHERS
        THEN ROLLBACK;
        
    COMMIT; 
   
END;
--------------------------------------------------------------------------------
--■■■ 40. 개설과정 등록 PCR_OP_COUR_INSERT(과정시작일, 종료일, 강의실_ID,교수ID, 코스ID ) ■■■--
CREATE OR REPLACE PROCEDURE PRC_OP_COUR_INSERT
( V_ST_DATE   IN OPEN_COUR.START_DATE%TYPE
, V_END_DATE  IN OPEN_COUR.END_DATE%TYPE
, V_CLASS     IN CLASS.CLASS_ID%TYPE
, V_PROF_ID   IN PROF.PROF_ID%TYPE
, V_COURSE_ID IN COURSE.COURSE_ID%TYPE
)
IS

    V_OPEN_COUR_ID OPEN_COUR.OPEN_COUR_ID%TYPE;
    V_OLD_ST_DATE   OPEN_COUR.START_DATE%TYPE;
    V_OLD_END_DATE  OPEN_COUR.END_DATE%TYPE;
    V_OLD_PROF_ID   PROF.PROF_ID%TYPE;
    V_OLD_CLASS     CLASS.CLASS_ID%TYPE;    
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION; -- 시작날짜 > 끝난날짜 일때 발생
    
    CURSOR CUR_CHECK_DATE 
    IS 
    SELECT PROF_ID, START_DATE, END_DATE, CLASS_ID
    FROM OPEN_COUR;   
    
BEGIN

    IF  (V_END_DATE - V_ST_DATE < 0) 
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;    
    
    OPEN CUR_CHECK_DATE;
    
    LOOP 
        FETCH CUR_CHECK_DATE INTO V_OLD_PROF_ID, V_OLD_ST_DATE, V_OLD_END_DATE, V_OLD_CLASS;
        
        EXIT WHEN CUR_CHECK_DATE%NOTFOUND;
  
        IF(V_ST_DATE <= V_OLD_ST_DATE AND  V_END_DATE >= V_OLD_ST_DATE AND (V_OLD_PROF_ID = V_PROF_ID OR V_OLD_CLASS = V_CLASS))
            THEN RAISE USER_DEFINE_ERROR;
        ELSIF (V_ST_DATE <= V_OLD_END_DATE AND V_END_DATE >= V_OLD_END_DATE AND (V_OLD_PROF_ID = V_PROF_ID OR V_OLD_CLASS = V_CLASS))
            THEN RAISE USER_DEFINE_ERROR;
        ELSIF (V_ST_DATE >= V_OLD_ST_DATE AND V_END_DATE <= V_OLD_END_DATE AND (V_OLD_PROF_ID = V_PROF_ID OR V_OLD_CLASS = V_CLASS))  
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
       
  
    END LOOP;
    
    CLOSE CUR_CHECK_DATE;
    
    
    V_OPEN_COUR_ID := CONCAT('OC', TO_CHAR(SYSDATE, 'YY'));
    
    INSERT INTO OPEN_COUR(OPEN_COUR_ID, START_DATE, END_DATE, CLASS_ID, PROF_ID, COURSE_ID)
    VALUES (V_OPEN_COUR_ID || LPAD(TO_CHAR(SEQ_OPEN_COUR.NEXTVAL), 3, '0'), V_ST_DATE, V_END_DATE, V_CLASS, V_PROF_ID, V_COURSE_ID);  
    
   COMMIT;   

   EXCEPTION
    WHEN USER_DEFINE_ERROR
     THEN RAISE_APPLICATION_ERROR(-20006, '이미 진행중인 과정의 강의실 또는 교수님입니다.' );
     ROLLBACK; 
    WHEN USER_DEFINE_ERROR2
     THEN  RAISE_APPLICATION_ERROR(-20008, '시작일이 종료일보다 이후입니다.' ); 
     ROLLBACK;
    
    --WHEN OTHERS
    --THEN ROLLBACK;
END;
--------------------------------------------------------------------------------
--■■■ 41. 개설과정 수정 PRC_OP_COUR_UPDATE(개설과정코드, 과정시작일, 종료일, 강의실_ID,교수ID, 코스ID ) ■■■--
CREATE OR REPLACE PROCEDURE PRC_OP_COUR_UPDATE
( V_OPEN_COUR_ID IN OPEN_COUR.OPEN_COUR_ID%TYPE
, V_ST_DATE   IN OPEN_COUR.START_DATE%TYPE
, V_END_DATE  IN OPEN_COUR.END_DATE%TYPE
, V_CLASS     IN CLASS.CLASS_ID%TYPE
, V_PROF_ID   IN PROF.PROF_ID%TYPE
, V_COURSE_ID IN COURSE.COURSE_ID%TYPE
)
IS
    
    V_OLD_ST_DATE   OPEN_COUR.START_DATE%TYPE;
    V_OLD_END_DATE  OPEN_COUR.END_DATE%TYPE;
    V_OLD_PROF_ID   PROF.PROF_ID%TYPE;
    V_OLD_CLASS     CLASS.CLASS_ID%TYPE;    
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION; -- 시작날짜 > 끝난날짜 일때 발생
    
    CURSOR CUR_CHECK_DATE 
    IS 
    SELECT PROF_ID, START_DATE, END_DATE, CLASS_ID
    FROM OPEN_COUR;   
    
BEGIN

    IF  (V_END_DATE - V_ST_DATE < 0) 
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;    
    
    DELETE
    FROM OPEN_COUR
    WHERE OPEN_COUR_ID = V_OPEN_COUR_ID;


    OPEN CUR_CHECK_DATE;
    
    LOOP 
        FETCH CUR_CHECK_DATE INTO V_OLD_PROF_ID, V_OLD_ST_DATE, V_OLD_END_DATE, V_OLD_CLASS;
        
        EXIT WHEN CUR_CHECK_DATE%NOTFOUND;
  
        IF(V_ST_DATE <= V_OLD_ST_DATE AND  V_END_DATE >= V_OLD_ST_DATE AND (V_OLD_PROF_ID = V_PROF_ID OR V_OLD_CLASS = V_CLASS))
            THEN RAISE USER_DEFINE_ERROR;
        ELSIF (V_ST_DATE <= V_OLD_END_DATE AND V_END_DATE >= V_OLD_END_DATE AND (V_OLD_PROF_ID = V_PROF_ID OR V_OLD_CLASS = V_CLASS))
            THEN RAISE USER_DEFINE_ERROR;
        ELSIF (V_ST_DATE >= V_OLD_ST_DATE AND V_END_DATE <= V_OLD_END_DATE AND (V_OLD_PROF_ID = V_PROF_ID OR V_OLD_CLASS = V_CLASS))  
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
       
  
    END LOOP;
    
    CLOSE CUR_CHECK_DATE;
    
    
    INSERT INTO OPEN_COUR(OPEN_COUR_ID, START_DATE, END_DATE, CLASS_ID, PROF_ID, COURSE_ID)
    VALUES (V_OPEN_COUR_ID, V_ST_DATE, V_END_DATE, V_CLASS, V_PROF_ID, V_COURSE_ID);  
    
   COMMIT;   

   EXCEPTION
    WHEN USER_DEFINE_ERROR
     THEN RAISE_APPLICATION_ERROR(-20006, '이미 진행중인 과정의 강의실 또는 교수님입니다.' );
     ROLLBACK; 
    WHEN USER_DEFINE_ERROR2
     THEN  RAISE_APPLICATION_ERROR(-20008, '시작일이 종료일보다 이후입니다.' ); 
     ROLLBACK;
    
    WHEN OTHERS
    THEN ROLLBACK;
END;
--------------------------------------------------------------------------------
--■■■ 42. 개설과정 삭제 (쿼리) ■■■--
DELETE 
FROM OPEN_COUR
WHERE OPEN_COUR_ID = '???';
--------------------------------------------------------------------------------
--■■■ 43. 개설과목 등록 PRC_OP_SUBJ_INSERT (과목시작일, 과목종료일, 개설과정코드, 교재코드, 과목코드, 필기배점, 실기배점, 출결배점) ■■■--
CREATE OR REPLACE PROCEDURE PRC_OP_SUBJ_INSERT
( V_START_DATE  IN OPEN_SUBJ.START_DATE%TYPE
, V_END_DATE    IN OPEN_SUBJ.END_DATE%TYPE
, V_OP_COUR_ID  IN OPEN_COUR.OPEN_COUR_ID%TYPE
, V_BOOK_ID     IN BOOK.BOOK_ID%TYPE
, V_SUBJ_ID     IN SUBJECT.SUBJECT_ID%TYPE
, V_WRITE       IN OPEN_SUBJ.WRITE_POINT%TYPE
, V_PRACTICE    IN OPEN_SUBJ.PRACTICE_POINT%TYPE
, V_ATTEND      IN OPEN_SUBJ.ATTEND_POINT%TYPE
)
IS
    
    V_OP_SUBJ_ID  OPEN_SUBJ.OPEN_SUBJ_ID%TYPE; -- 개설과목 코드
    
    CHECK_OP_COUR OPEN_COUR.OPEN_COUR_ID%TYPE;
    -- 개설 과정 코드 존재 체크
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    USER_DEFINE_ERROR3  EXCEPTION;
    USER_DEFINE_ERROR4  EXCEPTION;
    
    COUR_START  DATE;    -- 개설 과정 시작일
    COUR_END    DATE;    -- 개설 과정 종료일
    
    OLD_START   DATE;    -- 기존 과목 시작일
    OLD_END     DATE;    -- 기존 과목 종료일 
    
    
    CURSOR CUR_CHECK_DATE 
    IS 
    SELECT START_DATE, END_DATE
    FROM OPEN_SUBJ
    WHERE OPEN_COUR_ID = V_OP_COUR_ID;   
    

BEGIN
        IF (V_WRITE + V_PRACTICE + V_ATTEND != 100)
        THEN RAISE USER_DEFINE_ERROR4;
        END IF;
        
        SELECT NVL(MAX(OPEN_COUR_ID), '0') INTO CHECK_OP_COUR
        FROM OPEN_COUR
        WHERE OPEN_COUR_ID =V_OP_COUR_ID;
        
        IF CHECK_OP_COUR = '0'
          THEN RAISE USER_DEFINE_ERROR; 
        END IF;
        
        SELECT START_DATE, END_DATE INTO  COUR_START , COUR_END
        FROM OPEN_COUR
        WHERE OPEN_COUR_ID = V_OP_COUR_ID;
                
            
       --2  내가 입력할 시작일 < 코스시작일 OR 코스종료일 < 내가 입력할 종료일  → 에러
        
        IF (V_START_DATE < COUR_START OR COUR_END  < V_END_DATE)
           THEN RAISE USER_DEFINE_ERROR2;  
        END IF; 
        
     
     --3 기존 있던 과목들과 기간이 겹치면 안됨. → 개설과정 하듯이 해아함. 
       
    OPEN CUR_CHECK_DATE;
        LOOP
            
        FETCH CUR_CHECK_DATE INTO OLD_START, OLD_END;
        
        EXIT WHEN CUR_CHECK_DATE%NOTFOUND;
  
        IF(V_START_DATE <= OLD_START AND  V_END_DATE >= OLD_START)
            THEN RAISE USER_DEFINE_ERROR3;
        ELSIF (V_START_DATE <= OLD_END AND V_END_DATE >= OLD_END)
            THEN RAISE USER_DEFINE_ERROR3;
        ELSIF (V_START_DATE >= OLD_START AND V_END_DATE <= OLD_END)  
            THEN RAISE USER_DEFINE_ERROR3;
        END IF;
       
  
        END LOOP;
    
    CLOSE CUR_CHECK_DATE;
    
    
    V_OP_SUBJ_ID := 'OS' || TO_CHAR(SYSDATE, 'YY'); 
     
    
    
    INSERT INTO OPEN_SUBJ(OPEN_SUBJ_ID, START_DATE, END_DATE, OPEN_COUR_ID, BOOK_ID, SUBJECT_ID, WRITE_POINT, PRACTICE_POINT, ATTEND_POINT)
    VALUES (V_OP_SUBJ_ID || LPAD(TO_CHAR(OP_SUBJ_SEQ.NEXTVAL), 5, '0'), V_START_DATE, V_END_DATE, V_OP_COUR_ID
          , V_BOOK_ID, V_SUBJ_ID, V_WRITE, V_PRACTICE, V_ATTEND);
       
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20020, '없는 개설과정입니다.' );
        ROLLBACK; 
        
        WHEN USER_DEFINE_ERROR2
        THEN  RAISE_APPLICATION_ERROR(-20021, '개설과목은 개설강좌보다 이전/이후일수 없습니다.' ); 
        ROLLBACK;
        
        WHEN USER_DEFINE_ERROR3
        THEN  RAISE_APPLICATION_ERROR(-20022, '입력기간중 진행중인 과목이 있습니다.' ); 
        ROLLBACK;
        
        WHEN USER_DEFINE_ERROR4
        THEN  RAISE_APPLICATION_ERROR(-20023, '배점의 총합은 100점이어야 합니다.' ); 
        ROLLBACK;
        
        WHEN OTHERS
        THEN ROLLBACK;
END; 
--------------------------------------------------------------------------------
--■■■ 44. 개설과목 수정 PRC_OP_SUBJ_UPDATE (개설과목코드, 과목시작일, 과목종료일, 개설과정코드, 교재코드, 과목코드, 필기배점, 실기배점, 출결배점) ■■■--
CREATE OR REPLACE PROCEDURE PRC_OP_SUBJ_UPDATE
( V_OP_SUBJ_ID  IN OPEN_SUBJ.OPEN_SUBJ_ID%TYPE  -- 개설과목 코드
, V_START_DATE  IN OPEN_SUBJ.START_DATE%TYPE    -- 시작일
, V_END_DATE    IN OPEN_SUBJ.END_DATE%TYPE      -- 종료일
, V_OP_COUR_ID  IN OPEN_COUR.OPEN_COUR_ID%TYPE  -- 개설과정 코드
, V_BOOK_ID     IN BOOK.BOOK_ID%TYPE            -- 책 코드 
, V_SUBJ_ID     IN SUBJECT.SUBJECT_ID%TYPE      -- 과목코드
, V_WRITE       IN OPEN_SUBJ.WRITE_POINT%TYPE   -- 필기배점
, V_PRACTICE    IN OPEN_SUBJ.PRACTICE_POINT%TYPE -- 실기배점
, V_ATTEND      IN OPEN_SUBJ.ATTEND_POINT%TYPE  -- 출석배점
)
IS
    
    CHECK_OP_COUR OPEN_COUR.OPEN_COUR_ID%TYPE;
    -- 개설 과정 코드 존재 체크
    CHECK_OP_SUBJ OPEN_SUBJ.OPEN_SUBJ_ID%TYPE;
    -- 개설 과목 코드 존재 체크
    
    USER_DEFINE_ERROR   EXCEPTION; -- 없는 개설과정 에러
    USER_DEFINE_ERROR2  EXCEPTION; -- 과목의 시작일이나 종료일이 과정의 시작일 종료일보다 이전이나 이후일때 에러
    USER_DEFINE_ERROR3  EXCEPTION; -- 기존 과목과 기간이 겹치는 에러
    USER_DEFINE_ERROR4  EXCEPTION; -- 배점 비율 에러
    USER_DEFINE_ERROR5  EXCEPTION; -- 없는 개설 과목 에러
    
    COUR_START  DATE;    -- 개설 과정 시작일
    COUR_END    DATE;    -- 개설 과정 종료일
    
    OLD_START   DATE;    -- 기존 과목 시작일
    OLD_END     DATE;    -- 기존 과목 종료일 
    
    
    CURSOR CUR_CHECK_DATE 
    IS 
    SELECT START_DATE, END_DATE
    FROM OPEN_SUBJ
    WHERE OPEN_COUR_ID = V_OP_COUR_ID;   
    

BEGIN
        SELECT NVL(MAX(OPEN_COUR_ID), '0') INTO CHECK_OP_SUBJ
        FROM OPEN_SUBJ
        WHERE OPEN_SUBJ_ID = V_OP_SUBJ_ID;
        
        -- 에러 5
        IF CHECK_OP_SUBJ = '0'
        THEN RAISE USER_DEFINE_ERROR5;
        END IF;

        -- 에러 4
        IF (V_WRITE + V_PRACTICE + V_ATTEND != 100)
        THEN RAISE USER_DEFINE_ERROR4;
        END IF;
        
        SELECT NVL(MAX(OPEN_COUR_ID), '0') INTO CHECK_OP_COUR
        FROM OPEN_COUR
        WHERE OPEN_COUR_ID =V_OP_COUR_ID;
        -- 에러 1
        IF CHECK_OP_COUR = '0'
          THEN RAISE USER_DEFINE_ERROR;  -- 과정이 존재하지 않는다면 에러
        END IF;
        
        SELECT START_DATE, END_DATE INTO  COUR_START , COUR_END
        FROM OPEN_COUR
        WHERE OPEN_COUR_ID = V_OP_COUR_ID;
                
            
       --에러 2  내가 입력할 시작일 < 코스시작일 OR 코스종료일 < 내가 입력할 종료일  → 에러
        
        IF (V_START_DATE < COUR_START OR COUR_END  < V_END_DATE)
           THEN RAISE USER_DEFINE_ERROR2;  
        END IF; 
        
     -- 입력 데이터 삭제
    DELETE
    FROM OPEN_SUBJ
    WHERE OPEN_SUBJ_ID = V_OP_SUBJ_ID;

     
     --에러 3 기존 있던 과목들과 기간이 겹치면 안됨. → 개설과정 하듯이 해아함. 
       
     OPEN CUR_CHECK_DATE;
        LOOP
            
        FETCH CUR_CHECK_DATE INTO OLD_START, OLD_END;
        
        EXIT WHEN CUR_CHECK_DATE%NOTFOUND;
  
        IF(V_START_DATE <= OLD_START AND  V_END_DATE >= OLD_START)
            THEN RAISE USER_DEFINE_ERROR3;
        ELSIF (V_START_DATE <= OLD_END AND V_END_DATE >= OLD_END)
            THEN RAISE USER_DEFINE_ERROR3;
        ELSIF (V_START_DATE >= OLD_START AND V_END_DATE <= OLD_END)  
            THEN RAISE USER_DEFINE_ERROR3;
        END IF;
       
        END LOOP;
    
    CLOSE CUR_CHECK_DATE;
        
    INSERT INTO OPEN_SUBJ(OPEN_SUBJ_ID, START_DATE, END_DATE, OPEN_COUR_ID, BOOK_ID, SUBJECT_ID, WRITE_POINT, PRACTICE_POINT, ATTEND_POINT)
    VALUES (V_OP_SUBJ_ID , V_START_DATE, V_END_DATE, V_OP_COUR_ID
          , V_BOOK_ID, V_SUBJ_ID, V_WRITE, V_PRACTICE, V_ATTEND);
       
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20020, '없는 개설과정입니다.' );
        ROLLBACK; 
        
        WHEN USER_DEFINE_ERROR2
        THEN  RAISE_APPLICATION_ERROR(-20021, '개설과목은 개설강좌보다 이전/이후일수 없습니다.' ); 
        ROLLBACK;
        
        WHEN USER_DEFINE_ERROR3
        THEN  RAISE_APPLICATION_ERROR(-20022, '입력기간중 진행중인 과목이 있습니다.' ); 
        ROLLBACK;
        
        WHEN USER_DEFINE_ERROR4
        THEN  RAISE_APPLICATION_ERROR(-20023, '배점의 총합은 100점이어야 합니다.' ); 
        ROLLBACK;
        
        WHEN USER_DEFINE_ERROR5
        THEN  RAISE_APPLICATION_ERROR(-20024, '개설된 과목 ID가 아닙니다.' ); 
        ROLLBACK;
        
        WHEN OTHERS
        THEN ROLLBACK;
END;
--------------------------------------------------------------------------------
--■■■ 45. 개설과목 삭제 (쿼리) ■■■--
DELETE
FROM OPEN_SUBJ
WHERE OPEN_SUBJ_ID = '???';