-- 실행 전 C드라이브에 TEAM3DATA 폴더 만들어 놓기

-- 테이블스페이스 생성
CREATE TABLESPACE TBS_TEAM3
DATAFILE 'C:\TEAM3DATA\TBS_TEAM3.DBF' 
SIZE 4M 
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;
--==>> TABLESPACE TBS_TEAM3이(가) 생성되었습니다.


-- 사용 가능한 용량을 무제한으로 변경
ALTER USER TEAM3
QUOTA UNLIMITED ON TBS_TEAM3;
--==>> User TEAM3이(가) 변경되었습니다.

-- TEAM3 계정 생성
CREATE USER TEAM3 IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_TEAM3;
--==>> User TEAM3이(가) 생성되었습니다.


-- TEAM3 권한 부여 (관리자 계정에서 실행)
GRANT CREATE SESSION TO TEAM3; -- 세션
--==>> Grant을(를) 성공했습니다.
GRANT CREATE TABLE TO TEAM3; -- 테이블
--==>> Grant을(를) 성공했습니다.
GRANT CREATE PROCEDURE TO TEAM3; -- 프로시저
--==>> Grant을(를) 성공했습니다.
GRANT CREATE VIEW TO TEAM3; -- 뷰
--==>> Grant을(를) 성공했습니다.
GRANT CREATE SEQUENCE TO TEAM3; -- 시퀀스
--==>> Grant을(를) 성공했습니다.
