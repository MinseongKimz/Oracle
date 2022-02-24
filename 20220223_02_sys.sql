SELECT USER
FROM DUAL;
--==>> SYS

--○ SCOTT계정에 VIEW를 생성할 수 있는 권한 부여 
                 --------------------------
                   -- CREATE VIEW
GRANT CREATE VIEW TO SCOTT;
--==>> Grant을(를) 성공했습니다.

--○ SCOTT계정에 VIEW를 생성할 수 있는 권한 박탈
REVOKE CREATE VIEW FROM SCOTT;