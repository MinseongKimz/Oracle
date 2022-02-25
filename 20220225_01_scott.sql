SELECT USER
FROM DUAL;
--==>> SCOTT


--■■■ ROW_NUMBER ■■■--

SELECT ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;
/*
1	KING	5000	1981-11-17
2	FORD	3000	1981-12-03
3	SCOTT	3000	1987-07-13
4	JONES	2975	1981-04-02
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
7	ALLEN	1600	1981-02-20
8	TURNER	1500	1981-09-08
9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	 950	1981-12-03
14	SMITH	 800	1980-12-17
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP
ORDER BY ENAME;
/*
12	ADAMS	1100	1987-07-13
7	ALLEN	1600	1981-02-20
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
2	FORD	3000	1981-12-03
13	JAMES	 950	1981-12-03
4	JONES	2975	1981-04-02
1	KING	5000	1981-11-17
11	MARTIN	1250	1981-09-28
9	MILLER	1300	1982-01-23
3	SCOTT	3000	1987-07-13
14	SMITH	 800	1980-12-17
8	TURNER	1500	1981-09-08
10	WARD	1250	1981-02-22
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP
ORDER BY ENAME;
/*
1	ADAMS	1100	1987-07-13
2	ALLEN	1600	1981-02-20
3	BLAKE	2850	1981-05-01
4	CLARK	2450	1981-06-09
5	FORD	3000	1981-12-03
6	JAMES	 950	1981-12-03
7	JONES	2975	1981-04-02
8	KING	5000	1981-11-17
9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	 800	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;
/*
1	ADAMS	1100	1987-07-13
2	FORD	3000	1981-12-03
3	JONES	2975	1981-04-02
4	SCOTT	3000	1987-07-13
5	SMITH	 800	1980-12-17
*/

--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENTITY를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에 다음 번호를 가진
--   게시물이 등록되는 상황이 발생하게 된다.
--   이는... 보안성 측면이나... 미관상.. 바람직하지 않은  상황일 수 있기 때문에
--   ROW_NUMBER()의 사용을 고려해 볼 수 있다.
--   관리의 목적으로 사용할 때에는 SEQUENCE 나 IDENTITY를 사용하지만
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 바람직하다.

--○ SEQUENCE(시퀀스 : 주문번호) 생성
--   → 사전적 의미 : 1.(일련의) 연속적인 사건들, 2.(사건 행동 등의)순서

--★★★ 여기서부터 정신 차리고 다시시작
DROP SEQUENCE SEQ_BOARD;
--==> Sequence SEQ_BOARD이(가) 삭제되었습니다.

CREATE SEQUENCE SEQ_BOARD       -- 기본적인 시퀀스 생성 구문 (이 구문만 입력시 밑에서 NOCACHE빼고 동일)
START WITH 1                    -- 시작값
INCREMENT BY 1                  -- 증가값 (1씩 증가해라)
NOMAXVALUE                      -- 최대값 (무한)
NOCACHE;                        -- 캐시사용여부 
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.

--★ 기존 잘못된 데이터가 입력된 테이블 제거 (휴지통 거치지 않고 제거)
DROP TABLE TBL_BOARD;

--※ 휴지통 비우기
-- PURGE RECYCLEBIN;
-------------------------------------위 두개는 알고만 있자.. 실수하면 복원 너무 빡셈..

--○ 실습 테이블 생성
CREATE TABLE TBL_BOARD           -- TBL_BOARD 테이블생성구문 → 게시판 테이블
( NO        NUMBER               -- 게시물 번호       Ⅹ
, TITLE     VARCHAR2(50)         -- 게시물 제목       ○
, CONTENTS  VARCHAR2(1000)       -- 게시물 내용       ○
, NAME      VARCHAR2(20)         -- 게시물 작성자     △  
, PW        VARCHAR2(20)         -- 게시물 패스워드   △
, CREATED   DATE DEFAULT SYSDATE -- 게시물 작성일     Ⅹ
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.

--○ 데이터 입력 → 게시판에 게시물을 작성하는 액션

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '풀숲', '전 풀숲에 있어요', '박현수', 'java006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오로라', '밤하늘 좋네요', '정은정', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '해변', '바람이 부네요', '양윤정', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '인터뷰', '인터뷰중인데, 아이가 들어오네요', '이시우', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '살려주세요', '물에 빠졌어요', '최문정', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '내가 주인공', '나만 빼고 다 블러', '김민성', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '지구정복', '지구를 정복하러 왔다', '김정용', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '당연히', '아무 이유 없다', '이아린', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
/*
1	풀숲	    전 풀숲에 있어요	            박현수	java006$	2022-02-25 10:35:13
2	오로라	    밤하늘 좋네요	                정은정	java006$	2022-02-25 10:35:15
3	해변	    바람이 부네요	                양윤정	java006$	2022-02-25 10:35:16
4	인터뷰	    인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:35:18
5	살려주세요	물에 빠졌어요	                최문정	java006$	2022-02-25 10:35:20
6	내가 주인공	나만 빼고 다 블러      	        김민성	java006$	2022-02-25 10:35:22
7	지구정복	지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:35:25
8	당연히	    아무 이유 없다	                이아린	java006$	2022-02-25 10:35:26
*/

--○ COMMIT
COMMIT;


--○ 게시물 삭제
DELETE 
FROM TBL_BOARD
WHERE NO=2;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE 
FROM TBL_BOARD
WHERE NO = 3;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE 
FROM TBL_BOARD
WHERE NO = 5;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE 
FROM TBL_BOARD
WHERE NO = 6;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_BOARD;
/*
1	풀숲	    전 풀숲에 있어요	            박현수	java006$	2022-02-25 10:35:13
4	인터뷰	    인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:35:18
7	지구정복	지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:35:25
8	당연히	    아무 이유 없다	                이아린	java006$	2022-02-25 10:35:26
*/

--○ 게시물 추가 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '형광등', '조명이 좋아요', '우수정', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
/*
1	풀숲	    전 풀숲에 있어요	            박현수	java006$	2022-02-25 10:35:13
4	인터뷰	    인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:35:18
7	지구정복	지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:35:25
8	당연히	    아무 이유 없다	                이아린	java006$	2022-02-25 10:35:26
9	형광등	    조명이 좋아요	                우수정	java006$	2022-02-25 10:40:29
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 게시판의 게시물 리스트를 보여주는 쿼리문 구성

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;

/*
5	형광등	    우수정	2022-02-25 10:40:29
4	당연히	    이아린	2022-02-25 10:35:26
3	지구정복	김정용	2022-02-25 10:35:25
2	인터뷰	    이시우	2022-02-25 10:35:18
1	풀숲	    박현수	2022-02-25 10:35:13
*/

CREATE OR REPLACE VIEW VIEW_BOARDLIST
AS
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>> View VIEW_BOARDLIST이(가) 생성되었습니다.

--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_BOARDLIST;
/*
5	형광등	    우수정	2022-02-25 10:40:29
4	당연히	    이아린	2022-02-25 10:35:26
3	지구정복	김정용	2022-02-25 10:35:25
2	인터뷰	    이시우	2022-02-25 10:35:18
1	풀숲	    박현수	2022-02-25 10:35:13
*/


------------------------------------------------------------------------------
--■■■ JOIN ■■■--

SELECT *
FROM EMP;

SELECT *
FROM DEPT;

--1. SQL 1992 CODE

-- CROSS JOIN
SELECT *
FROM EMP, DEPT;
--> 수학에서 말하는 데카르트 곱(CARTESIAN PRODUCT)
--  두 테이블을 결합한 모든 경우의 수가 다나옴 (SMITH 가 DEPT별로 다나옴 3번;)

-- EQUI JOIN : 서로 정확히 일치하는 것들 끼리 연결하여 결합시키는 결합방법

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- SMITH의 부서번호와  DEPT의 부서번호가 일치한 것만 나옴

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
-- 위와 같은 구문


-- NON EQUI JOIN : 범위 안에 적합한 것들 끼리 연결 하여 결합시키는 결합방법.
SELECT *
FROM EMP;

SELECT *
FROM SALGRADE;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- EQUI JOIN 시 (+) 를 활용한 결합방법

SELECT *
FROM TBL_EMP;
--> 사원 19명 중 부서번호를 갖지 못한 사원들은 5명

SELECT *
FROM TBL_DEPT;
--> 5개의 부서중 소속사원을 갖지 못한 부서는 2개

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 14개 나옴 (서로 연결 가능한것 끼리만 나옴)
--  즉, 부서번호를 갖지 못한 사원들(5명) 모두 누락
--  또한, 소속 사원을 갖지 못한 부서(2 부서) 모두 누락

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+); 
--> 총 19건의 데이터가 결합되어 조회된 상황
-- EMP 테이블의 모든 데이터를 다가져 온후 DEPT테이블의 정보를 가져오는데
-- EMP에서 부서번호를 안가진 5명이 있는데 DEPT테이블에서 NULL로 넣어서 5명 다 나옴
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
-- 총 16건의 데이터가 결합되어 조회된 상황
-- DEPT 테이블의 모든 데이터를 가져온후 EMP테이블의 정보를 가져옴
-- DEPT 테이블에 있는 40 50 번 부서는 EMP테이블에 해당하는 데이터가 없지만
-- NULL을 넣어서 다 출력함

--※ (+)가 없는 쪽 테이블의 데이터를 모두 메모리에 먼저 적재한 후
--   (+)가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로
--   JOIN이 이루어지게 된다.

--   이와 같은 이유로...
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
-- 이런식에 JOIN은 존재하지 않는다.
--==>> 에러발생
--     (ORA-01468: a predicate may reference only one outer-joined table)

-- 2. SQL 1999 CODE    → 『JOIN』키워드 등장 → 『JOIN』(결합) 의 유형 명시
--                     → 『ON』  키워드 등장 →  결합 조건은 WHERE 대신 ON

-- CROSS JOIN
SELECT*
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN 
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DETPNO;   -- 1992
--------------------------------------------
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;     -- 확실히 명시된 모습 JOIN
---------------------------------------------
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- INNER JOIN 에서 INNER 는 생략 가능

-- OUTER JOIN 
SELECT *
FROM TBL_EMP, TBL_DEPT
WHERE TBL_EMP.DEPTNO = TBL_DEPT.DEPTNO(+); -- 1992 구문
---------------------------------------------
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO  = D.DEPTNO;                 -- 윗구문 (+)위치와 LEFT 확인!!

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO  = D.DEPTNO;                 --  1992 구문 (+)위치와 RIGHT 확인!!

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO  = D.DEPTNO;                 -- 1992에서 안되던 양쪽 (+) 가능해짐


--※ OUTER JOIN  에서 OUTER 생략 가능 (방향표기 필수)
--  OUTER 안쓰고 방향만 쓰면 OUTER 생략한 것
--  방향도 안쓰고 JOIN 만 달랑있으면 INNER JOIN 구문이다.
SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D
ON E.DEPTNO  = D.DEPTNO;   
-- OUTER 오른쪽 정보를 모두 불러오고 왼쪽 정보와 비교. 없는건 NULL과 합쳐서 출력

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO  = D.DEPTNO;   -- 이건 INNER JOIN임~~!!
--------------------------------------------------------------------------------
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
--> 이와 같은 방법으로 쿼리문을 구성해도
--  조회 결과를 얻는 과정에 문제는 없다.

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--> 윗 구문과 같은 결과, 하지만 아래와 같이 구성하여
--  조회하는 것을 권장한다.
--------------------------------------------------------------------------------

--○ EMP 테이블과 DEPT 테이블을 대상으로
--   직종이 MANAGER 와 CLERK인 사원들만 조회한다.
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.
--   E, D      D       E       E       E          -E = EMP, D = DEPT (존재유뮤 확인)


SELECT E.DEPTNO "부서번호", D.DNAME "부서명", E.ENAME "사원명", E.JOB "직종명", E.SAL"급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB IN ('MANAGER', 'CLERK');
/*
10	ACCOUNTING	CLARK	MANAGER	2450
10	ACCOUNTING	MILLER	CLERK	1300
20	RESEARCH	ADAMS	CLERK	1100
20	RESEARCH	JONES	MANAGER	2975
20	RESEARCH	SMITH	CLERK	 800
30	SALES	    BLAKE	MANAGER	2850
30	SALES	    JAMES	CLERK	 950
*/

SELECT DEPTNO "부서번호", DNAME "부서명", ENAME "사원명", JOB "직종명", SAL"급여"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 에러발생
--     (ORA-00918: column ambiguously defined)
--     DEPTNO 는 EMP 테이블 DEPT 테이블 둘다 있는 컬럼이라 에러 발생
--     두 테이블 간 중복되는 컬럼(DEPTNO)에 대한
--     소속 테이블을 정해줘야(명시해야)한다.

SELECT E.DEPTNO "부서번호", DNAME "부서명", ENAME "사원명", JOB "직종명", SAL"급여"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
/*
10	ACCOUNTING	CLARK	MANAGER	    2450
10	ACCOUNTING	KING	PRESIDENT	5000
10	ACCOUNTING	MILLER	CLERK	    1300
20	RESEARCH	JONES	MANAGER	    2975
20	RESEARCH	FORD	ANALYST	    3000
20	RESEARCH	ADAMS	CLERK	    1100
20	RESEARCH	SMITH	CLERK	     800
20	RESEARCH	SCOTT	ANALYST	    3000
30	SALES	    WARD	SALESMAN	1250
30	SALES	    TURNER	SALESMAN	1500
30	SALES	    ALLEN	SALESMAN	1600
30	SALES	    JAMES	CLERK	     950
30	SALES	    BLAKE	MANAGER	    2850
30	SALES	    MARTIN	SALESMAN	1250
*/

SELECT D.DEPTNO "부서번호", DNAME "부서명", ENAME "사원명", JOB "직종명", SAL"급여"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
/*
10	ACCOUNTING	CLARK	MANAGER	    2450
10	ACCOUNTING	KING	PRESIDENT	5000
10	ACCOUNTING	MILLER	CLERK	    1300
20	RESEARCH	JONES	MANAGER	    2975
20	RESEARCH	FORD	ANALYST	    3000
20	RESEARCH	ADAMS	CLERK	    1100
20	RESEARCH	SMITH	CLERK	     800
20	RESEARCH	SCOTT	ANALYST	    3000
30	SALES	    WARD	SALESMAN	1250
30	SALES	    TURNER	SALESMAN	1500
30	SALES	    ALLEN	SALESMAN	1600
30	SALES	    JAMES	CLERK	     950
30	SALES	    BLAKE	MANAGER	    2850
30	SALES	    MARTIN	SALESMAN	1250
*/

--※ 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--   부모 테이블의 컬럼을 참조할 수 있도록 처리해야 한다.
SELECT *
FROM EMP;  -- 자식 테이블

SELECT *
FROM DEPT; -- 부모 테이블 
-- 두 테이블의 DEPTNO가 공통으로 연결고리인데
-- DEPT 테이블은 DEPTNO가 중복되지 않지만
-- EMP의 DEPTNO는 중복되고 또 중복되게 더 만들수 도 있다.
-- DEPT가 부모 테이블이다.

--※ 두 테이블에 모두 포함되어 있는 중복된 컬럼이 아니더라도
--   조인하는 과정에서 컬럼의 소속 테이블을 명시해 줄 수 있도록 권장한다. 

--○ SELF JOIN (자기 조인)

-- EMP 테이블의 데이터를 다음과 같이 조회할 수 있도록 
-- 쿼리문을 구성한다.
------------------------------------------------------------------
-- 사원번호  사원명  직종명   관리자번호   관리자명  관리자직종명
------------------------------------------------------------------
--    7369    SMITH   CLERK        7902        FORD       ANALYST

-- 1. 92'S
SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E1.MGR "관리자번호" -- E2.EMPNO "관리자번호"
     , E2.ENAME "관리자명", E2.JOB "관리자 직종명" 
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);

-- 2. 99'S
SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E1.MGR "관리자번호" -- E2.EMPNO "관리자번호"
     , E2.ENAME "관리자명", E2.JOB "관리자 직종명" 
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT	(NULL)	(NULL)	(NULL)
*/


