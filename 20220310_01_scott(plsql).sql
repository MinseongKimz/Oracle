SELECT USER
FROM DUAL;
--==>> SCOTT


-- �� ����� ���� �Լ�(������ �Լ�)��
--    IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--    �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--    FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.

--�� TLB_INSA ���̺� ���� ���� Ȯ��  �Լ� ���� (����)
-- �Լ��� : FN_GENDER()
--                   �� SSN(�ֹε�Ϲ�ȣ) �� '771212-1022432' �� 'YYMMDD-NNNNNNN'       

CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2 ) -- �Ű�����   : �ڸ���(����) ���� ����
RETURN VARCHAR2                                       -- ��ȯ�ڷ��� : �ڸ���(����) ���� ����
IS
    -- ����� �� �ֿ� ���� ����
    V_RESULT VARCHAR2(20);
BEGIN
    -- �����(���Ǻ�) �� ���� �� ó��
    IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
        THEN V_RESULT := '����';
    ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
        THEN V_RESULT := '����';
    ELSE  
        V_RESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- ����� ��ȯ CHECK~!!
    RETURN V_RESULT;
    
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.

--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� �� (A,B)
--   A �� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��ϳ�.
--   �Լ��� : FN_POW()
/*
��� ��)
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
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�

--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� ��(�⺻��*12)+���硻 ������� ������ �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)


CREATE OR REPLACE FUNCTION FN_PAY(BASIC NUMBER, SU NUMBER)
RETURN NUMBER
IS 
    PAY NUMBER;
BEGIN
    PAY := (NVL(BASIC,0)*12)+NVL(SU, 0);
    RETURN PAY;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.

--�� TBL_INSA ���̺��� �Ի����� �������� ���������
--   �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ��� : FN_WORKYEAR(�Ի���)

CREATE OR REPLACE FUNCTION FN_WORKYEAR(V_HIREDATE DATE)
RETURN NUMBER
IS
    YEARS NUMBER;
BEGIN
    YEARS := TRUNC(MONTHS_BETWEEN(SYSDATE, V_HIREDATE)/12, 1);
    RETURN YEARS;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML ���� (Data Manipulation Language)
--     COMMIT / ROLLBACK�� �ʿ��� ����~ 

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL ���� (Data Definition Language)
--     �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE 
--==>> DCL ���� (Data Control Language)
--     �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 4. COMMIT, ROLLBACK
--==>> TCL ����(Transaction Control Language)

-- ���� pl/sql�� �� DML��, TCL���� ����Ѵ�.
-- ���� pl/sql�� �� DML��, DDL��, DCL��, TCL�� ��� ������

--------------------------------------------------------------------------------

--���� PROCEDURE(���ν���) ����--

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS
    [-- �ֿ� ���� ����]
BEGIN 
    -- ���� ����;
    ...
    
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/


-- �� FUNCTION �� ������ �� ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--    ��RETURN���� ��ü�� �������� ������,
--    ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--    IN(�Է�), OUT(���), INOUT(�����) ���� ���еȴ�.

-- 3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2, ...)];
*/

--�� ���ν��� �ǽ��� ���� ���̺� ������
--   ��20220310_02_scott.sql�� ����

--�� ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( ���̵�
, �н�����
, �̸�
, ��ȭ
, �ּ�
)
IS
BEGIN
END;

-- �����~
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_STUDENT_INSERT��(��) �����ϵǾ����ϴ�.


--�� ���ν��� �ǽ��� ���� ���̺� ������
--   ��20220310_02_scott.sql�� ����

--�� ������ �Է� �� Ư�� �׸��� �����͸� �Է��ϸ�
                    --------
--                  (�й�, �̸�, ��, ��, �� ����)                    
--   ���������� �ٸ� �߰��׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
                    ---------
--                  (����, ���, ���)                    
--   ���ν����� �ۼ��Ѵ�. (�����Ѵ�.)
--   ���ν��� �� : PRC_SUNJUK_INSERT()

/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '�ּ���', 90, 80, 70);

���ν��� ȣ��� ó���� ���
�й�   �̸�     ��������   ��������  ��������  ���� ��� ���
  1    �ּ���      90         80       70       240  80   B
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS 
    -- �ֿ� ������ ����
    V_TOT TBL_SUNGJUK.TOT%TYPE;
    V_AVG TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �ֿ� ������ ���� �� ����
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    CASE WHEN V_AVG >= 90 THEN V_GRADE := 'A';
         WHEN V_AVG >= 80 THEN V_GRADE := 'B';
         WHEN V_AVG >= 70 THEN V_GRADE := 'C';
         WHEN V_AVG >= 60 THEN V_GRADE := 'D';
         
         ELSE V_GRADE := 'F';
         END CASE;
    
    --INSERT ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    --Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.

--�� ��20220310_02_scott.sql�� ���� ������ ���� 


--�� TBL_SUNGJUK ���̺��� Ư�� �л��� ����
-- (�й�, ��������, ��������, ��������) ������ ������
-- ����, ���, ��ޱ��� �Բ� �����Ǵ� ���ν����� �����Ѵ�.
-- ���ν��� �� : PRC_SUNGJUK_UPDATE()

/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);

���ν��� ȣ��� ó���� ���
�й�   �̸�     ��������   ��������  ��������  ���� ��� ���
  2    ������      50        50       50       150   50    F
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
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.

-- ������ �Է��� ��20220310_02_scott.sql�� ����




--�� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�) 
--   ���ν����� �ۼ��Ѵ�.
--   ��, ID��PW�� �Ѱܹ޾� ��ġ�ϴ� ��쿡�� ������ �����Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE()

/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('happy', 'java006', '010-9999-9999', '������ Ⱦ��');
--==>> ������ ���� ���� (��й�ȣ ����)

EXEC PRC_STUDENTS_UPDATE('happy', 'java006$', '010-9999-9999', '������ Ⱦ��');
--==>> ������ ���� ����
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
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

-- ������ �Է��� ��20220310_02_scott.sql�� ����...

--------- �ٸ� ��� Ǯ�� (FLAG ���)

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


--------- �ٸ� ��� Ǯ�� (JOIN �̿�)
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














