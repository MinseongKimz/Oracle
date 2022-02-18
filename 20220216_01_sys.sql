
--1줄 주석문 처리 (단일행 주석문 처리)

/*
여려줄
(다중행)
주석문
처리  → java와 동일
*/


--○ 현재 오라클 서버에 접속한 자신의 계정 조회
show user
--==>> USER이(가) "SYS"입니다.
--> sqlplus 상태일 때 사용하는 명령어.. 


select user 
from dual;
--==>> SYS

SELECT USER
FROM DUAL;
--==>>SYS      대소문자 구분 x

select 1 + 2
from dual;
--==> 3

SELECT 1 + 2
FROM DUAL;
--==> 3

SELECT              2 + 4
FROM               DUAL;
--==>>6

SELECT 1 + 5
FROMDUAL;
--==>> 에러발생
--ORA-00923: FROM keyword not found where expected

Select 쌍용강북교육센터 F강의장
from dual;
--==>> 에러발생
--ORA-00923: FROM keyword not found where expected

SElect "쌍용강북교육센터 F강의장"
from dual;
--==>> 에러발생
--ORA-00972: identifier is too long

SElect '쌍용강북교육센터 F강의장'
from dual;
--==>> 쌍용강북교육센터 F강의장

select '한 발 한 발 힘겨운 오라클 수업'
from dual;
--==>> 한 발 한 발 힘겨운 오라클 수업


select 3.14 + 3.14 
from dual;
--==>> 6.28

select 10 * 5
from dual;
--==>> 50

select 10 * 5.0
from dual;
--==>> 50

select 4/2
from dual;
--==>> 2

select 4.0/2
from dual;
--==>> 2

select 4.0/2.0
from dual;
--==>> 2

select 5/2
from dual;
--==>> 2.5

select 100 -23
from dual;
--==>> 77

