SELECT USER
FROM DUAL;
--==>> SCOTT

--�� IF ��(���ǹ�)
-- IF~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �յ��� �Ѵ�.
--    TRUE �̸� THEN �� ELSE ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE �� END IF; ������ ������ �����ϰ� �ȴ�.

-- 2. ���� �� ����
/*
IF ���� 
    THEN ó����;
END IF;
*/


/*
IF ���� 
    THEN ó����;
ELSE
    ó����; (THEN ����)
END IF;
*/

/*
IF ���� 
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSE
    ó����; 
END IF;
*/
SET SERVEROUT ON;


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    GRADE CHAR;
BEGIN
    -- �����
    GRADE := 'C';
    
    DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('COOL');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
/*
C
COOL

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� CASE ��(���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1 THEN ���๮;
    WHEN ��2 THEN ���๮;
    ELSE ���๮;
END CASE;
*/

ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���'; 

DECLARE
    -- �ֿ亯�� ����
    SEL NUMBER := &NUM;                    
    RESULT VARCHAR2(10) := '����';
BEGIN
    -- �׽�Ʈ
    --DBMS_OUTPUT.PUT_LINE('SEL : '|| SEL);
   -- DBMS_OUTPUT.PUT_LINE('RESULT : '|| RESULT );
    
    -- ���� �� ó��
    /*
    CASE SEL
        WHEN 1 
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�'); 
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�');
        ELSE
             DBMS_OUTPUT.PUT_LINE('Ȯ�κҰ�');
    END CASE;*/
    
    CASE SEL
        WHEN 1
        THEN RESULT := '����';
        WHEN 2
        THEN RESULT := '����';
        ELSE 
            RESULT := 'Ȯ�κҰ�';
    END CASE;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE('ó�� ����� ' || RESULT || ' �Դϴ�.');
END;


--�� �ܺ� �Է� ó��
-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
-- ��&�ܺκ����� ���·� �����ϰ� �ȴ�.

--�� ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
--   �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.


ACCEPT NUM1 PROMPT '���� �Է� 1'; 
ACCEPT NUM2 PROMPT '���� �Է� 2';

DECLARE
    N1 NUMBER := &NUM1;
    N2 NUMBER := &NUM2;
    TOT NUMBER := 0;
BEGIN 
    TOT := N1 + N2;
    DBMS_OUTPUT.PUT_LINE(N1 || ' + ' || N2 || ' = ' || TOT);
END;
--==>> 2 + 3 = 5

--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ������� �����Ͽ� ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.\
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/

ACCEPT WON PROMPT '�ݾ� �Է� (1000�� �̸� 10�� �̻�)';

DECLARE
    WON1 NUMBER := &WON;
    WON500 NUMBER;
    WON100 NUMBER;
    WON50 NUMBER;
    WON10 NUMBER;
    
BEGIN
    --�� ���� �� ó��
    WON500  := TRUNC(WON1 / 500);
    WON100  := TRUNC(MOD(WON1,500)/100);    
    WON50   := TRUNC(MOD(MOD(WON1,500),100)/50);
    WON10   := TRUNC(MOD(MOD(MOD(WON1,500),100),50)/10);
    DBMS_OUTPUT.PUT_LINE('�Է� ���� �ݾ� : ' || WON1||'��');
    
    DBMS_OUTPUT.PUT_LINE('�����: ' || WON500 || ' ���: '|| WON100 || ' ���ʿ�: '|| WON50
                        || ' �ʿ�: '|| WON10);
END;
/*
�Է� ���� �ݾ� : 999��
�����: 1 ���: 4 ���ʿ�: 1 �ʿ�: 4

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� �⺻ �ݺ���
-- LOOP ~ END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮
    
    EXIT WHEN ����; -- ������ ���� ��� �ݺ����� ����������.
END LOOP;
*/

-- 1 ���� 10 ���� �� ��� (LOOP�� Ȱ��)
DECLARE 
    N NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N >= 10;
        
        N := N + 1;     --��N++, N+=1�� �̷� ���� ����
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10
PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵Ǵ� ������ üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE ���� LOOP
    -- ���๮;
END LOOP;
*/

-- 1 ���� 10 ���� ��� (WHILE LOOP�� Ȱ��)
DECLARE 
    N NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N:= N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10
PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. �����ۼ������� 1�� �����Ͽ�
--    ������������ �� �� ���� �ݺ� �����Ѵ�.

-- 2. ���� �� ����
/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
    -- ���๮;
END LOOP;
*/

-- 1 ���� 10 ���� ��� (FOR LOOP�� Ȱ��) 

DECLARE
    N NUMBER;
BEGIN
    FOR  N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : 2

2*1 = 2
2*2 = 4
    :
2*9 = 18    
*/

-- 1. LOOP ���� ���

ACCEPT INPUT PROMPT '���� �Է��ϼ��� : ';

DECLARE 
    DAN NUMBER := &INPUT;
    NUM NUMBER := 1;
BEGIN
    LOOP
        EXIT WHEN NUM > 9;
        DBMS_OUTPUT.PUT_LINE (DAN ||  ' * ' || NUM ||' = ' || DAN*NUM);        
        NUM := NUM + 1;
    END LOOP;
END;


-- 2. WHILE LOOP �� ���

ACCEPT INPUT PROMPT '���� �Է��ϼ��� : ';

DECLARE 
    DAN NUMBER := &INPUT;
    NUM NUMBER := 1; 
BEGIN 
    WHILE NUM <= 9 LOOP 
            DBMS_OUTPUT.PUT_LINE (DAN ||  ' * ' || NUM ||' = ' || DAN*NUM);
            NUM := NUM+1;
    END LOOP;
END;


-- 3. FOR LOOP
    
ACCEPT INPUT PROMPT '���� �Է��ϼ��� : ';

DECLARE 
    DAN NUMBER := &INPUT;
    NUM NUMBER; 
BEGIN 
    FOR NUM IN 1 .. 9 
    LOOP
        DBMS_OUTPUT.PUT_LINE (DAN ||  ' * ' || NUM ||' = ' || DAN*NUM);                
    END LOOP;
END;
/*
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� ������ ��ü (2~9����) ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   ��, 2�� �ݺ��� ������ Ȱ���Ѵ�,.
/*
���� ��)
==[2��]==
2 * 1 = 2
    :
==[9��]==    

*/
--  FOR LOOP ����---------------------------------------------------------------
DECLARE 
    DAN NUMBER ;
    NUM NUMBER ;
    
BEGIN
    FOR DAN IN 2 .. 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('==[' || DAN || '��]==');
        FOR NUM IN 1 .. 9
        LOOP 
            DBMS_OUTPUT.PUT_LINE(DAN ||' * '||NUM ||' = ' || (DAN*NUM));  
        END LOOP;
    END LOOP;  
END;

--  WHILE LOOP ����-------------------------------------------------------------
DECLARE 
    DAN NUMBER := 2;
    NUM NUMBER := 1;
BEGIN 
    WHILE DAN <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==[' || DAN || '��]==');
        
        WHILE NUM <=9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN ||' * '||NUM ||' = ' || (DAN*NUM));
            NUM := NUM + 1;
        END LOOP;
       NUM := 1; 
       DAN := DAN + 1; 
    END LOOP;
END;

-- LOOP ����--------------------------------------------------------------------
DECLARE 
    DAN NUMBER := 2;
    NUM NUMBER := 1;    
BEGIN 
    LOOP
         DBMS_OUTPUT.PUT_LINE('==[' || DAN || '��]==');
         LOOP
           DBMS_OUTPUT.PUT_LINE(DAN ||' * '||NUM ||' = ' || (DAN*NUM));
           NUM := NUM + 1;
           EXIT WHEN NUM > 9;
         END LOOP;
         NUM := 1;
         DAN := DAN +1;
         EXIT WHEN DAN > 9;
    END LOOP;
END;
/*
==[2��]==
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
==[3��]==
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
==[4��]==
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36
==[5��]==
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
==[6��]==
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54
==[7��]==
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63
==[8��]==
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72
==[9��]==
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/
--------------------------------------------------------------------------------

