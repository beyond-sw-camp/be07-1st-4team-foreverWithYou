-- 테스트 쿼리
CALL 로그인('예남', '1234');


-- 코드
CREATE PROCEDURE `로그인`(
     IN p_nickname VARCHAR(10),
     IN p_password VARCHAR(255)
 )
 BEGIN
 
     IF EXISTS (SELECT 1 FROM user WHERE nickname = p_nickname AND password = p_password) THEN
 
         SELECT 
             CONCAT(
                 (SELECT name FROM user WHERE nickname = p_nickname AND password = p_password),
                 (SELECT message FROM country_translate 
                  WHERE con_id = (SELECT id FROM country WHERE name = 
                                  (SELECT country FROM user WHERE nickname = p_nickname AND password = p_password))
                  AND message_key = '2-1')
             )  message;
     ELSE
 
         SELECT '닉네임/비밀번호가 틀렸습니다'  message;
     END IF;
 END