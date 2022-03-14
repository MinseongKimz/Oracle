SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_상품;
/*
H001	바밤바	 600	30
H002	죠스바	 500	20
H003	메로나	 500	30
H004	보석바	 600	70
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	50
C002	빵빠레	1700	10
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

--○ 확인
SELECT *
FROM TBL_출고;
/*
1	H001	2022-03-11	20	 600
2	H002	2022-03-11	 5	 500
3	H003	2022-03-11	 5	 500
4	H004	2022-03-11	 5	 600
5	C001	2022-03-11	10	1600
6	C002	2022-03-11	10	1600
*/

--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인 → 프로시저 호출
EXEC PRC_출고_UPDATE(6, 20);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ 프로시저 호출 후 다시 테이블 확인
SELECT *
FROM TBL_출고;
/*
1	H001	2022-03-11	20	 600
2	H002	2022-03-11	 5	 500
3	H003	2022-03-11	 5	 500
4	H004	2022-03-11	 5	 600
5	C001	2022-03-11	10	1600
6	C002	2022-03-11	20	1600    ← 빵빠레 출고가 바뀌였다~
*/

SELECT *
FROM TBL_상품;
/*
H001	바밤바	 600	30
H002	죠스바	 500	20
H003	메로나	 500	30
H004	보석바	 600	70
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	50
C002	빵빠레	1700	0   ← 빵빠레 재고도 잘 줄어들었다..
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

--○ 월드콘 (C001)를 70개출고로 바꿔보자..
EXEC PRC_출고_UPDATE(5, 70);
--==>> 에러발생
--     (ORA-20003: 재고부족)
SELECT *
FROM TBL_상품;
--==>> C001	월드콘	1600	50   ← 변경되지 않았다~
SELECT *
FROM TBL_출고;
/*
1	H001	2022-03-11	20	 600
2	H002	2022-03-11	 5	 500
3	H003	2022-03-11	 5	 500
4	H004	2022-03-11	 5	 600
5	C001	2022-03-11	10	1600 ← 변경되지 않았다~
6	C002	2022-03-11	20	1600
*/


/*
1	H001	2022-03-11	30	400
2	H001	2022-03-11	20	500
3	H002	2022-03-11	25	450
4	H003	2022-03-11	35	450
5	H004	2022-03-11	75	520
6	C001	2022-03-11	20	1500
7	C001	2022-03-11	20	1500
8	C001	2022-03-11	20	1500
9	C002	2022-03-11	10	1500
10	C002	2022-03-11	10	1500
기존 입고 량 →  H001 바꿀꺼임 20으로 
H001	바밤바	 600	30
*/
SELECT *
FROM TBL_입고;


-- 1. PRC_입고_UPDATE(입고번호, 입고수량) 만든거 확인
EXEC PRC_입고_UPDATE(1, 20);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_입고;
--==>> 1	H001	2022-03-11	20	400
SELECT *
FROM TBL_상품;
--==>> 1	H001	2022-03-11	20	400 잘바꼇다.. (H001은 20개 출고한상태)


SELECT *
FROM TBL_입고;

SELECT *
FROM TBL_상품;

-- 현재 보석바 H004 입고번호 5는 75개 입고 했고
-- 출고를 5개 해 현재 재고는 70개
-- 만약 이 입고를 1개로 바꾸면 - 4 개가 되서 에러다..

EXEC PRC_입고_UPDATE(5, 1);
--==>> ORA-20004: 입고 수량 변경 불가능!

EXEC PRC_입고_UPDATE(2, 30);

SELECT *
FROM TBL_입고;
--==>> 2	H001	2022-03-11	30	500

SELECT *
FROM TBL_상품;
--==>> H001	바밤바	600	10






-- 2. PRC_입고_DELETE(입고번호) 만든거 확인
--    1번 삭제해봄... 그러면 이제 바밤바는 0개가 되야 맞음
EXEC PRC_입고_DELETE(1);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_입고;
/*
2	H001	2022-03-11	20	500  ← 1번 사라짐
3	H002	2022-03-11	25	450
4	H003	2022-03-11	35	450
5	H004	2022-03-11	75	520
6	C001	2022-03-11	20	1500
7	C001	2022-03-11	20	1500
8	C001	2022-03-11	20	1500
9	C002	2022-03-11	10	1500
10	C002	2022-03-11	10	1500
*/

SELECT *
FROM TBL_상품;
--==>> H001	바밤바	600	0 << 0 개로 바뀜./.
-- 추가로 현재 C002 빵빠레가 상품에선 0개다. 
-- 그 상태에서 입고번호 10번을 삭제하면? → ERROR..
EXEC PRC_입고_DELETE(10);
--==>> 에러발생
--     (ORA-20005: 삭제할 입고량보다 현재 재고가 작습니다.)



--○  Procedure PRC_출고_DELETE 테스트
SELECT *
FROM TBL_출고;
/*
1	H001	2022-03-11	20	600
2	H002	2022-03-11	5	500
3	H003	2022-03-11	5	500
4	H004	2022-03-11	5	600
5	C001	2022-03-11	10	1600
6	C002	2022-03-11	20	1600
*/

-- 현재 빵빠래 는 0개 존재
-- 6번 COO2를 삭제함으로 써 재고에 빵빠레(C002)는 20개가 되어야함;
EXEC PRC_출고_DELETE(6);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
SELECT *
FROM TBL_출고;
/*
1	H001	2022-03-11	20	600
2	H002	2022-03-11	5	500
3	H003	2022-03-11	5	500
4	H004	2022-03-11	5	600
5	C001	2022-03-11	10	1600
*/

SELECT *
FROM TBL_상품;
--==>> C002	빵빠레	1700	20 잘 늘어나 있다..


--■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■
--※ DML 작업에 대한 이벤트 기록

--○ 실습을 위한 준비 → 실습 테이블 생성
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID) 
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

--○ 실습을 위한 준비 → 테이블 생성
CREATE TABLE TBL_EVENTLOG
( MEMO VARCHAR2(200)
, ILJA DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG이(가) 생성되었습니다.

--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>> 조회결과 없음


--○ 생성한 TRIGGER 작동 여부 확인
-- → TBL_TEST1 테이블을 대상으로 INSERT, UPDATE, DELETE 수행

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '홍은혜', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '이호석', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '임소민', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다.


UPDATE TBL_TEST1
SET NAME = '임대민'
WHERE ID = 3;
--==>> 1 행 이(가) 업데이트되었습니다.

UPDATE TBL_TEST1
SET NAME = '임중민'
WHERE ID = 3;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> 1 행 이(가) 삭제되었습니다.

COMMIT;
--==>> 커밋 완료.


--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회결과 없음.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT *
FROM TBL_EVENTLOG;


--■■■ BEFORE STATMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업 수행 전에 작업에 대한 가능 여부 확인

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '한충희', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다.


INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '최선하', '010-5555-5555');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(6, '정은정', '010-6666-6666');
--==>> 1 행 이(가) 삽입되었습니다.

UPDATE TBL_TEST1
SET NAME ='정금정'
WHERE ID = 6;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID= 5;
--==>> 1 행 이(가) 삭제되었습니다.

------------[오라클 서버의 시스템 시간 변경(16시 → 19시 )]---------------------


INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(7, '이연주', '010-7777-7777');
--==>> 에러 발생
--     (ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다.)


UPDATE TBL_TEST1
SET NAME = '정은정'
WHERE ID = 6;
--==>> 에러 발생
--     (ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다.)

DELETE
FROM TBL_TEST1
WHERE ID =4;
--==>> 에러 발생
--     (ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다

--■■■ BEFORE ROW TRIGGER 상황 실습 ■■■
--※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델

--○ 실습 환경 구성을 위한 테이블 생성 → TBL_TEST2
CREATE TABLE TBL_TEST2
( CODE NUMBER
, NAME VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.

--○ 실습 환경 구성을 위한 테이블 생성 → TBL_TEST3
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
             REFERENCES TBL_TEST2(CODE)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.

--○ 실습 관련 데이터 입력 TEST_2
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '텔레비전');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '냉장고');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '세탁기');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(4, '건조기');
--==>> 1 행 이(가) 삽입되었습니다. * 4

SELECT *
FROM TBL_TEST2;
/*
1	텔레비전
2	냉장고
3	세탁기
4	건조기
*/
COMMIT;
--==>> 커밋 완료.

--○ 실습 관련 데이터 입력 TEST_3
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 1, 50);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 1, 60);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 3, 30);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 2, 30);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(10, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(11, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(12, 3, 30);
--==>> 1 행 이(가) 삽입되었습니다. * 12

SELECT *
FROM TBL_TEST3;
/*
1	1	30
2	1	50
3	1	60
4	1	30
5	2	20
6	3	30
7	2	30
8	2	20
9	2	30
10	3	30
11	3	20
12	3	30
*/

COMMIT;
--==>> 커밋 완료.


--○ 부모테이블(TBL_TEST2)의 데이터 삭제 시도
DELETE
FROM TBL_TEST2
WHERE CODE =1;
--==>> 에러 발생
--     (ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found)

DELETE
FROM TBL_TEST2
WHERE CODE =2;
--==>> 에러 발생
--     (ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found)

DELETE
FROM TBL_TEST2
WHERE CODE =3;
--==>> 에러 발생
--     (ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found)

DELETE
FROM TBL_TEST2
WHERE CODE =4;
--==>> 1 행 이(가) 삭제되었습니다.


--○ TRIGGER(트리거) 생성 이후 실습

SELECT *
FROM TBL_TEST2;
--==>> 
/*
1	텔레비전
2	냉장고
3	세탁기
*/

SELECT  *
FROM TBL_TEST3;
/*
1	1	30
2	1	50
3	1	60
4	1	30
5	2	20  ◀ 냉장고 
6	3	30
7	2	30  ◀ 냉장고 
8	2	20  ◀ 냉장고 
9	2	30  ◀ 냉장고 
10	3	30
11	3	20
12	3	30
*/

DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2; -- 원래는 삭제가 안되지만(TEST3때문에) TRIGGER 생성해서 
/*              -- 삭제할 수 있게 만들었다 (TEST3먼저 삭제 시킴.)
1	텔레비전
3	세탁기
*/
SELECT  *
FROM TBL_TEST3; -- 냉장고를 부모로 갖던 컬럼들이 다 삭제되었다..
/*
1	1	30
2	1	50
3	1	60
4	1	30
6	3	30
10	3	30
11	3	20
12	3	30
*/

--------------------------------------------------------------------------------

--■■■ AFTER ROW TRIGGER 상황 실습 ■■■--
--※ 참조 테이블 관련 트랜잭션 처리

UPDATE TBL_상품
SET 재고수량 = 0;
--==>>  18개 행 이(가) 업데이트되었습니다.

TRUNCATE TABLE TBL_입고;
--==>> Table TBL_입고이(가) 잘렸습니다.

TRUNCATE TABLE TBL_출고;
--==>> Table TBL_출고이(가) 잘렸습니다.

SELECT *
FROM TBL_상품;
/*
H001	바밤바	 600	0
H002	죠스바	 500	0
H003	메로나	 500	0
H004	보석바	 600	0
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	0
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

SELECT *
FROM TBL_출고;
--==>> 조회결과 없음

SELECT *
FROM TBL_입고;
--==>> 조회결과 없음

--○ 트리거(TRG_IBGO) 생성 이후 실습 테스트
INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1, 'H001', SYSDATE, 40, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(2, 'H001', SYSDATE, 60, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(3, 'H002', SYSDATE, 50, 1000);
--==>> 1 행 이(가) 삽입되었습니다.




SELECT *
FROM TBL_입고;
/*
1	H001	2022-03-14 17:41:17	40	1000
2	H001	2022-03-14 17:41:48	60	1000
3	H002	2022-03-14 17:42:06	50	1000
*/

SELECT *
FROM TBL_상품;
/*
H001	바밤바	 600	100
H002	죠스바	 500	50
H003	메로나	 500	0
H004	보석바	 600	0
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	0
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

























