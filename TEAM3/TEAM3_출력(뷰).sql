-- TEAM3 출력(뷰)

/*
■■■ 관리자 측 요구분석(관리자) - 3.교수자 계정 관리 기능 구현 ■■■
교수자 명, 배정된 과목명, 과목 기간(시작 연월일, 끝 연월일), 교재 명, 강의실, 강의 진행 여부(강의 예정, 강의 중, 강의 종료)
*/

CREATE OR REPLACE VIEW VIEW_PROFESSORS
AS
SELECT P.PROF_NAME "교수명", C.COURSE_NAME "과정명", SJ.SUBJECT_NAME "배정된 과목명"
     , OS.START_DATE "시작일", OS.END_DATE "종료일" , BK.BOOK_NAME "교재명", CL.CLASS_NAME "강의실" 
     , CASE WHEN (OS.END_DATE - SYSDATE < 0) AND (SYSDATE - OS.START_DATE > 0)  THEN '강의 종료'
            WHEN (OS.END_DATE - SYSDATE > 0) AND (SYSDATE - OS.START_DATE > 0)  THEN '강의 진행중'
            WHEN (OS.END_DATE - SYSDATE > 0) AND (SYSDATE - OS.START_DATE < 0)  THEN '강의 예정'
            ELSE '알수없음' 
            END "강의진행여부"  
FROM PROF P JOIN OPEN_COUR OC
ON P.PROF_ID = OC.PROF_ID 
    JOIN COURSE C 
    ON OC.COURSE_ID = C.COURSE_ID
    JOIN OPEN_SUBJ OS
    ON OC.OPEN_COUR_ID = OS.OPEN_COUR_ID
    JOIN SUBJECT SJ 
    ON OS.SUBJECT_ID = SJ.SUBJECT_ID
    JOIN BOOK BK 
    ON OS.BOOK_ID = BK.BOOK_ID
    JOIN CLASS CL
    ON OC.CLASS_ID =CL.CLASS_ID;

SELECT *
FROM VIEW_PROFESSORS
WHERE 강의진행여부 = '강의 종료' 
    AND 교수명 ='홍수민';          

--------------------------------------------------------------------------------

/*
■■■ 관리자 측 요구분석(관리자) - 4.과정 관리 기능 구현 ■■■
과정명, 강의실, 과목명, 과목 기간(시작 연월일, 끝 연월일), 교재 명, 교수자 명
*/

CREATE OR REPLACE VIEW VIEW_COURSES
AS
SELECT CO.COURSE_NAME "과정명"
     , CL.CLASS_NAME "강의실명"
     , SB.SUBJECT_NAME "과목명"
     , OS.START_DATE "과목시작일"
     , OS.END_DATE "과목종료일"
     , BK.BOOK_NAME "교재명"
     , PR.PROF_NAME "교수이름"
FROM OPEN_SUBJ OS
JOIN OPEN_COUR OC
ON OS.OPEN_COUR_ID = OC.OPEN_COUR_ID
JOIN CLASS CL
ON OC.CLASS_ID = CL.CLASS_ID
JOIN COURSE CO
ON OC.COURSE_ID = CO.COURSE_ID
JOIN SUBJECT SB
ON OS.SUBJECT_ID = SB.SUBJECT_ID
JOIN BOOK BK
ON OS.BOOK_ID = BK.BOOK_ID
JOIN PROF PR
ON OC.PROF_ID = PR.PROF_ID;

SELECT *
FROM VIEW_COURSES;           

--------------------------------------------------------------------------------

/*
■■■ 관리자 측 요구분석(관리자) - 5.과목 관리 기능 구현 ■■■
학생 이름, 과정명, 수강과목, 수강과목 총점 (+ 중도 탈락 제외 사실)
*/

CREATE OR REPLACE VIEW VIEW_STUDENTS
AS
SELECT ST.STU_NAME "학생 이름", CO.COURSE_NAME "과정명", SU.SUBJECT_NAME "수강과목"
     , NVL(SC.ATTEND_SCORE * OS.ATTEND_POINT/100 + SC.WRITE_SCORE * WRITE_POINT/100 + SC.PRACTICE_SCORE * PRACTICE_POINT/100, 0) "수강과목총점"
     , (CASE WHEN AP.APP_ID = DR.APP_ID THEN '중도탈락O' ELSE '중도탈락X' END) "중도탈락"
FROM STU ST JOIN APP AP  
ON ST.STU_ID = AP.STU_ID
    JOIN OPEN_COUR OC
    ON AP.OPEN_COUR_ID = OC.OPEN_COUR_ID
	JOIN COURSE CO
        ON OC.COURSE_ID = CO.COURSE_ID     
	    JOIN OPEN_SUBJ OS
            ON OC.OPEN_COUR_ID = OS.OPEN_COUR_ID
                JOIN SUBJECT SU
                ON OS.SUBJECT_ID = SU.SUBJECT_ID
                    JOIN SCORE SC
                    ON OS.OPEN_SUBJ_ID = SC.OPEN_SUBJ_ID AND SC.APP_ID = AP.APP_ID
                        LEFT JOIN DROPOUT DR
                        ON AP.APP_ID = DR.APP_ID;

SELECT *
FROM VIEW_STUDENTS;                        
                        
--------------------------------------------------------------------------------

/*
■■■ 사용자 측 요구분석(교수자) - 3.성적 출력 기능 구현 ■■■
과목명, 과목 기간(시작 연월일, 끝 연월일), 교재 명, 학생 명, 출결, 실기, 필기, 총점, 등수 
*/

CREATE OR REPLACE VIEW VIEW_PROFESSOR_GRADE
AS
SELECT T.과목명, T.과목기간, T.교재명, T.학생명, T.출결, T.실기, T. 필기, T.총점
     , RANK() OVER(PARTITION BY T.개설과목코드 ORDER BY T.총점 DESC) "등수"
     , T.중도탈락여부
FROM
(
    SELECT SJ.SUBJECT_NAME "과목명", OS.START_DATE || ' - ' || OS.END_DATE "과목기간"
         , B.BOOK_NAME "교재명", S.STU_NAME "학생명" 
         , NVL(SC.ATTEND_SCORE * OS.ATTEND_POINT, 0) / 100 "출결"
         , NVL(SC.PRACTICE_SCORE * OS.PRACTICE_POINT, 0) / 100 "실기"
         , NVL(SC.WRITE_SCORE * OS.WRITE_POINT, 0) / 100 "필기"
         , NVL(SC.ATTEND_SCORE * OS.ATTEND_POINT, 0) / 100 + NVL(SC.PRACTICE_SCORE * OS.PRACTICE_POINT, 0) / 100 
           + NVL(SC.WRITE_SCORE * OS.WRITE_POINT, 0) / 100 "총점"
         , OS.OPEN_SUBJ_ID "개설과목코드"
         , CASE WHEN A.APP_ID = DR.APP_ID THEN '○' ELSE 'Ⅹ' END "중도탈락여부"
    FROM OPEN_COUR OC JOIN PROF P
    ON OC.PROF_ID = P.PROF_ID
        JOIN OPEN_SUBJ OS
        ON OC.OPEN_COUR_ID = OS.OPEN_COUR_ID
        JOIN SUBJECT SJ
        ON OS.SUBJECT_ID = SJ.SUBJECT_ID
        JOIN BOOK B
        ON OS.BOOK_ID = B.BOOK_ID
        JOIN APP A
        ON OC.OPEN_COUR_ID = A.OPEN_COUR_ID
        JOIN STU S
        ON A.STU_ID = S.STU_ID
        JOIN SCORE SC
        ON OS.OPEN_SUBJ_ID = SC.OPEN_SUBJ_ID AND SC.APP_ID = A.APP_ID
        LEFT JOIN DROPOUT DR
        ON A.APP_ID = DR.APP_ID
) T;

SELECT *
FROM VIEW_PROFESSOR_GRADE
ORDER BY 과목기간 , 등수; 

--------------------------------------------------------------------------------

/*
■■■ 사용자 측 요구분석(학생) - 2.성적 출력 기능 구현 ■■■
학생 이름, 과정명, 과목명, 교육 기간(시작 연월일, 끝 연월일), 교재 명, 출결, 실기, 필기, 총점, 등수 
아직 안끝난 과목은 출력 불가
과정 쪽도 약간 오류..

*/
CREATE OR REPLACE VIEW VIEW_STUDENT_GRADE  
AS 
SELECT DISTINCT T1.학생이름
    , T1.과정명
    , T1.과목명
    , T1.과목시작일
    , T1.과목종료일
    , T1.교재명
    , T1.출결성적
    , T1.필기성적
    , T1.실기성적
    , T1.총점
    , T1.등수
FROM(    
    SELECT S.STU_NAME 학생이름
    , C.COURSE_NAME 과정명
    , SUB.SUBJECT_NAME 과목명
    , OS.START_DATE 과목시작일
    , OS.END_DATE 과목종료일
    , B.BOOK_NAME 교재명
    , NVL(SC.ATTEND_SCORE * OS.ATTEND_POINT, 0) / 100 출결성적
    , NVL(SC.PRACTICE_SCORE * OS.PRACTICE_POINT, 0) / 100 실기성적
    , NVL(SC.WRITE_SCORE * OS.WRITE_POINT, 0) / 100 필기성적 
    , NVL(SC.ATTEND_SCORE * OS.ATTEND_POINT, 0) / 100 + NVL(SC.PRACTICE_SCORE * OS.PRACTICE_POINT, 0) / 100 
    + NVL(SC.WRITE_SCORE * OS.WRITE_POINT, 0) / 100 "총점"
    , S.STU_ID 학생코드
    ,SUB.SUBJECT_ID 과목코드
    , RANK() OVER(PARTITION BY OS.SUBJECT_ID||OC.START_DATE||OC.PROF_ID ORDER BY SC.ATTEND_SCORE + SC.WRITE_SCORE + SC.PRACTICE_SCORE DESC) 등수
    FROM OPEN_COUR OC, COURSE C, STU S, SUBJECT SUB, OPEN_SUBJ OS, APP A, BOOK B, SCORE SC
    WHERE S.STU_ID = A.STU_ID
    AND OC.COURSE_ID = C.COURSE_ID
    AND OS.OPEN_COUR_ID = OC.OPEN_COUR_ID
    AND OS.SUBJECT_ID = SUB.SUBJECT_ID
    AND OS.BOOK_ID = B.BOOK_ID
    AND SC.APP_ID = A.APP_ID
    AND OS.OPEN_SUBJ_ID = SC.OPEN_SUBJ_ID) T1;   
SELECT *
FROM VIEW_STUDENT_GRADE
WHERE 학생이름 = '김민성5';
