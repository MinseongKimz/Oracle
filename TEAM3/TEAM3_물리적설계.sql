SELECT USER
FROM DUAL;
--==>> TEAM

--------------------------------------------------------------------------------

--○ 학생테이블(STU) 생성
CREATE TABLE STU
( STU_ID       VARCHAR2(10)
, STU_NAME     VARCHAR2(20) NOT NULL
, SSN          VARCHAR2(14) NOT NULL
, PASSWORD     VARCHAR2(20) NOT NULL
, REGIST_DATE  DATE  DEFAULT SYSDATE        
, CONSTRAINT STU_STU_ID_PK PRIMARY KEY(STU_ID)
);
--==>>Table STU이(가) 생성되었습니다.

-- 코멘트
COMMENT ON TABLE STU IS '학생정보테이블';
COMMENT ON COLUMN STU.STU_ID IS '학생아이디';
COMMENT ON COLUMN STU.STU_NAME IS '학생이름';
COMMENT ON COLUMN STU.SSN IS '주민번호';
COMMENT ON COLUMN STU.PASSWORD IS '비밀번호';
COMMENT ON COLUMN STU.REGIST_DATE IS '등록일(기본값 SYSDATE)';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

--○ 탈락사유(REASONS_DROPOUT) 테이블 생성
CREATE TABLE REASONS_DROPOUT
( REASONS_DROPOUT_ID    VARCHAR2(10) 
, REASON_DROPOUT        VARCHAR2(40) NOT NULL
, CONSTRAINT REASONS_DROPOUT_ID_PK PRIMARY KEY(REASONS_DROPOUT_ID)
);
--==>> Table REASONS_DROPOUT이(가) 생성되었습니다.

-- 코멘트
COMMENT ON TABLE REASONS_DROPOUT IS '탈락사유테이블';
COMMENT ON COLUMN REASONS_DROPOUT.REASONS_DROPOUT_ID IS '탈락사유코드';
COMMENT ON COLUMN REASONS_DROPOUT.REASON_DROPOUT IS '탈락사유';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- PROF (교수) 테이블 생성
CREATE TABLE PROF
( PROF_ID       VARCHAR2(10)   
, PROF_NAME     VARCHAR2(20)    NOT NULL
, SSN           VARCHAR2(14)    NOT NULL
, PASSWORD      VARCHAR2(20)    NOT NULL
, REGIST_DATE   DATE DEFAULT    SYSDATE
, CONSTRAINT PROF_PROF_ID_PK PRIMARY KEY(PROF_ID)
);
--==>> Table PROF이(가) 생성되었습니다.

-- PROF (교수) 테이블의 컬럼 코멘트 입력
COMMENT ON COLUMN PROF.PROF_ID IS '교수ID';
COMMENT ON COLUMN PROF.PROF_NAME IS '교수이름';
COMMENT ON COLUMN PROF.SSN IS '주민등록번호';
COMMENT ON COLUMN PROF.PASSWORD IS '비밀번호';
COMMENT ON COLUMN PROF.REGIST_DATE IS '등록일';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- COURSE (과정) 테이블 생성
CREATE TABLE COURSE 
( COURSE_ID     VARCHAR2(10)    
, COURSE_NAME	VARCHAR2(50)    NOT NULL
, CONSTRAINT COURSE_COURSE_ID_PK PRIMARY KEY(COURSE_ID)
);
--==>> Table COURSE이(가) 생성되었습니다.

-- COURSE (과정) 테이블의 컬럼 코멘트 입력
COMMENT ON COLUMN COURSE.COURSE_ID IS '과정코드';
COMMENT ON COLUMN COURSE.COURSE_NAME IS '과정명';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- 교재 테이블 생성
CREATE TABLE BOOK 
(
  BOOK_ID	VARCHAR2(10)	            -- 교재코드
, BOOK_NAME	VARCHAR2(30)	NOT NULL    -- 교재명
, BOOK_PUB	VARCHAR2(20)	NOT NULL        -- 출판사
, CONSTRAINT BOOK_BOOK_ID_PK PRIMARY KEY(BOOK_ID)  -- 제약조건
);
--==>> Table BOOK이(가) 생성되었습니다.

COMMENT ON TABLE BOOK IS '교재';
COMMENT ON COLUMN BOOK.BOOK_ID IS '교재코드';
COMMENT ON COLUMN BOOK.BOOK_NAME IS '교재명';
COMMENT ON COLUMN BOOK.BOOK_PUB IS '출판사';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- 과목
CREATE TABLE SUBJECT 
(
  SUBJECT_ID	VARCHAR2(10)	            -- 과목코드
, SUBJECT_NAME	VARCHAR2(20)	NOT NULL        -- 과목명
, CONSTRAINT SUBJECT_SUJECT_ID_PK PRIMARY KEY(SUBJECT_ID)   -- 제약조건
);
--==>> Table SUBJECT이(가) 생성되었습니다.

COMMENT ON TABLE SUBJECT IS '과목';
COMMENT ON COLUMN SUBJECT.SUBJECT_ID IS '과목코드';
COMMENT ON COLUMN SUBJECT.SUBJECT_NAME IS '과목명';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- ▼ 관리자 테이블, 제약조건, 코멘트
CREATE TABLE ADMIN
( ADMIN_ID      VARCHAR2(10) 
, ADMIN_NAME    VARCHAR2(20)    NOT NULL
, SSN           VARCHAR2(14)    NOT NULL
, PASSWORD      VARCHAR2(20)    NOT NULL
, REGIST_DATE   DATE DEFAULT SYSDATE
, CONSTRAINT    ADMIN_ADMIN_ID_PK       PRIMARY KEY(ADMIN_ID)
);
--==>> Table ADMIN이(가) 생성되었습니다.

COMMENT ON TABLE ADMIN IS '관리자';
COMMENT ON COLUMN ADMIN.ADMIN_ID IS '관리자ID';
COMMENT ON COLUMN ADMIN.ADMIN_NAME IS '관리자명';
COMMENT ON COLUMN ADMIN.SSN IS '주민등록번호';
COMMENT ON COLUMN ADMIN.REGIST_DATE IS '등록일';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- ▼ 강의실 테이블, 제약조건, 코멘트
CREATE TABLE CLASS
( CLASS_ID      VARCHAR2(10)  
, CLASS_NAME    VARCHAR2(20)  NOT NULL
, CONSTRAINT    CLASS_CLASS_ID_PK       PRIMARY KEY(CLASS_ID)
);
--==>> Table CLASS이(가) 생성되었습니다.

COMMENT ON TABLE CLASS IS '강의실';
COMMENT ON COLUMN CLASS.CLASS_ID IS '강의실코드';
COMMENT ON COLUMN CLASS.CLASS_NAME IS '강의실명';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- 개설 과정 (OPEN_COUR) 테이블 생성
CREATE TABLE OPEN_COUR
( OPEN_COUR_ID  VARCHAR2(10)
, START_DATE    DATE
, END_DATE      DATE
, CLASS_ID      VARCHAR2(10)
, PROF_ID       VARCHAR2(10)
, REGIST_DATE   DATE    DEFAULT SYSDATE
, COURSE_ID     VARCHAR2(10)
, CONSTRAINT OPEN_COUR_ID_PK PRIMARY KEY(OPEN_COUR_ID)
, CONSTRAINT OPEN_COUR_CLASS_ID_FK FOREIGN KEY(CLASS_ID)
             REFERENCES CLASS(CLASS_ID)
, CONSTRAINT OPEN_COUR_PROF_ID_FK FOREIGN KEY(PROF_ID)
             REFERENCES PROF(PROF_ID)
, CONSTRAINT OPEN_COUR_COURSE_ID_FK FOREIGN KEY(COURSE_ID)
             REFERENCES COURSE(COURSE_ID)
);
--==>> Table OPEN_COUR이(가) 생성되었습니다.

-- 코멘트 입력
COMMENT ON TABLE OPEN_COUR IS '개설 과정';
COMMENT ON COLUMN OPEN_COUR.OPEN_COUR_ID IS '개설과정코드';
COMMENT ON COLUMN OPEN_COUR.START_DATE IS '과정 시작일';
COMMENT ON COLUMN OPEN_COUR.END_DATE IS '과정 종료일';
COMMENT ON COLUMN OPEN_COUR.CLASS_ID IS '강의실테이블 강의실코드 참조키';
COMMENT ON COLUMN OPEN_COUR.PROF_ID IS '교수테이블 교수ID 참조키';
COMMENT ON COLUMN OPEN_COUR.REGIST_DATE IS '등록일 기본값 SYSDATE';
COMMENT ON COLUMN OPEN_COUR.COURSE_ID IS '과정테이블 과정코드 참조키';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- APP (수강신청) 테이블 생성
CREATE TABLE APP 
( APP_ID        VARCHAR2(10)    	
, OPEN_COUR_ID  VARCHAR2(10)
, STU_ID	    VARCHAR2(10)
, APP_DATE	    DATE    DEFAULT SYSDATE	
, CONSTRAINT APP_APP_DATE_PK PRIMARY KEY(APP_ID)
, CONSTRAINT APP_OPEN_COUR_ID_FK FOREIGN KEY(OPEN_COUR_ID)
             REFERENCES OPEN_COUR(OPEN_COUR_ID)
, CONSTRAINT APP_STU_ID_FK FOREIGN KEY(STU_ID)
             REFERENCES STU(STU_ID)
);
--==>> Table APP이(가) 생성되었습니다.

-- 코멘트 입력
COMMENT ON TABLE APP IS '수강신청';
COMMENT ON COLUMN APP.APP_ID IS '수강신청코드';
COMMENT ON COLUMN APP.OPEN_COUR_ID IS '개설과정 테이블 개설과정코드 참조 외래키';
COMMENT ON COLUMN APP.STU_ID IS '학생 테이블 학생ID 참조 외래키';
COMMENT ON COLUMN APP.APP_DATE IS '수강신청일';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

--○ 중도탈락리스트
CREATE TABLE DROPOUT 
( DROPOUT_ID	        VARCHAR2(10)	
, APP_ID	            VARCHAR2(10)	
, REASONS_DROPOUT_ID	VARCHAR2(10)	
, DROPOUT_DATE          DATE    DEFAULT SYSDATE
, CONSTRAINT DROPOUT_DROPOUT_ID_PK PRIMARY KEY(DROPOUT_ID)
, CONSTRAINT DROPOUT_REASONS_DROPOUT_ID_FK FOREIGN KEY(REASONS_DROPOUT_ID) 
                                           REFERENCES REASONS_DROPOUT(REASONS_DROPOUT_ID)
);
--==>> Table DROPOUT이(가) 생성되었습니다.

-- APP 생성 후에 추가(FK)
ALTER TABLE DROPOUT ADD CONSTRAINT DROPOUT_APP_ID_FK FOREIGN KEY(APP_ID) 
                                                     REFERENCES APP(APP_ID);
--==>> Table DROPOUT이(가) 변경되었습니다.

-- 코멘트
COMMENT ON TABLE DROPOUT IS '중도탈락리스트';
COMMENT ON COLUMN DROPOUT.DROPOUT_ID IS '중도탈락코드';
COMMENT ON COLUMN DROPOUT.APP_ID IS '수강신청코드 FK';
COMMENT ON COLUMN DROPOUT.REASONS_DROPOUT_ID IS '탈락사유코드 FK';
COMMENT ON COLUMN DROPOUT.DROPOUT_DATE IS '중도탈락일자';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- 개설과목 테이블 생성
CREATE TABLE OPEN_SUBJ
( OPEN_SUBJ_ID      VARCHAR2(10)
, START_DATE        DATE
, END_DATE          DATE
, OPEN_COUR_ID      VARCHAR2(10)
, BOOK_ID           VARCHAR2(10)
, SUBJECT_ID        VARCHAR2(10)
, WRITE_POINT       NUMBER(4,2)
, PRACTICE_POINT    NUMBER(4,2)
, ATTEND_POINT      NUMBER(4,2)

, CONSTRAINT OPEN_SUBJ_ID_PK            PRIMARY KEY(OPEN_SUBJ_ID)
, CONSTRAINT OPEN_SUBJ_OPEN_COUR_ID_FK  FOREIGN KEY(OPEN_COUR_ID)
                                        REFERENCES OPEN_COUR(OPEN_COUR_ID)
, CONSTRAINT OPEN_SUBJ_BOOK_ID_FK       FOREIGN KEY(BOOK_ID)
                                        REFERENCES BOOK(BOOK_ID)
, CONSTRAINT OPEN_SUBJ_SUBJECT_ID_FK    FOREIGN KEY(SUBJECT_ID)
                                        REFERENCES SUBJECT(SUBJECT_ID)
);
--==>> Table OPEN_SUBJ이(가) 생성되었습니다.

-- 코멘트 입력
COMMENT ON TABLE OPEN_SUBJ IS '개설과목';
COMMENT ON COLUMN OPEN_SUBJ.OPEN_SUBJ_ID IS '개설과목코드';
COMMENT ON COLUMN OPEN_SUBJ.START_DATE IS '과목시작일';
COMMENT ON COLUMN OPEN_SUBJ.END_DATE IS '과목종료일';
COMMENT ON COLUMN OPEN_SUBJ.OPEN_COUR_ID IS '개설과정테이블 개설과정코드 참조키';
COMMENT ON COLUMN OPEN_SUBJ.BOOK_ID IS '교재테이블 교재코드 참조키';
COMMENT ON COLUMN OPEN_SUBJ.SUBJECT_ID IS '과목테이블 과목코드 참조키';
COMMENT ON COLUMN OPEN_SUBJ.WRITE_POINT IS '필기배점';
COMMENT ON COLUMN OPEN_SUBJ.PRACTICE_POINT IS '실기배점';
COMMENT ON COLUMN OPEN_SUBJ.ATTEND_POINT IS '출결배점';
--==>> Comment이(가) 생성되었습니다.

--------------------------------------------------------------------------------

-- 성적 테이블 생성
CREATE TABLE SCORE 
( SCORE_ID       VARCHAR2(10)
, OPEN_SUBJ_ID   VARCHAR2(10)
, APP_ID         VARCHAR2(10)
, ATTEND_SCORE   NUMBER   
, WRITE_SCORE    NUMBER
, PRACTICE_SCORE NUMBER
, SCORE_DATE     DATE DEFAULT SYSDATE    
, CONSTRAINT SCORE_SCORE_ID_PK PRIMARY KEY(SCORE_ID)
);
--==>> Table SCORE이(가) 생성되었습니다.

-- (FK 나머지 추가)
ALTER TABLE SCORE 
ADD ( CONSTRAINT SCORE_OPEN_SUBJ_ID_FK FOREIGN KEY(OPEN_SUBJ_ID) 
                                       REFERENCES  OPEN_SUBJ(OPEN_SUBJ_ID)
    , CONSTRAINT SCORE_APP_ID_FK  FOREIGN KEY(APP_ID)
                                       REFERENCES APP(APP_ID));
--==>> Table SCORE이(가) 변경되었습니다.

-- 코멘트 
COMMENT ON TABLE SCORE IS '성적테이블';
COMMENT ON COLUMN SCORE.SCORE_ID IS '성적코드 PK'; 
COMMENT ON COLUMN SCORE.OPEN_SUBJ_ID IS '개설과목테이블 개설과목코드 참조키';
COMMENT ON COLUMN SCORE.APP_ID IS '수강신청테이블 수강신청코드 참조키';
COMMENT ON COLUMN SCORE.ATTEND_SCORE IS '출결에 대한 성적';
COMMENT ON COLUMN SCORE.WRITE_SCORE IS '필기에 대한 성적';
COMMENT ON COLUMN SCORE.PRACTICE_SCORE IS '실기에 대한 성적';
COMMENT ON COLUMN SCORE.SCORE_DATE IS '성적 등록 날짜';
--==>> Comment이(가) 생성되었습니다.
