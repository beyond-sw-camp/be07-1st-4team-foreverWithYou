-- 테스크 쿼리
CALL 그래사귀자('예나',  토큰값);


-- 코드
CREATE PROCEDURE `그래사귀자`(
     IN 닉네임 VARCHAR(255),
     IN 토큰값 VARCHAR(255)
 )
 BEGIN
     DECLARE u_id BIGINT;
     DECLARE c_id BIGINT;
     DECLARE country_id INT;
     DECLARE result_message VARCHAR(255);
     DECLARE user_exists INT DEFAULT 0;
     DECLARE token_exists INT DEFAULT 0;
     DECLARE user1_id BIGINT;
 
 
     SELECT COUNT(*) INTO user_exists FROM user WHERE nickname = 닉네임;
   
     SELECT COUNT(*) INTO token_exists FROM couple WHERE token = 토큰값;
 
 
     SELECT id INTO country_id 
     FROM country 
     WHERE name = (SELECT country FROM user WHERE nickname = 닉네임 LIMIT 1);
 
     IF user_exists = 0 THEN
         SELECT message INTO result_message
         FROM country_translate 
         WHERE con_id = 1 AND message_key = '4-1';
 
 
     ELSEIF token_exists = 0 THEN
         SELECT message INTO result_message
         FROM country_translate 
         WHERE con_id = country_id AND message_key = '4-2';
 
     ELSE
 
         SELECT user_id INTO u_id 
         FROM user 
         WHERE nickname = 닉네임;
         
 
         SELECT couple_id, couple_user1 INTO c_id, user1_id
         FROM couple 
         WHERE token = 토큰값;
 
 
         UPDATE couple 
         SET couple_user2 = u_id 
         WHERE token = 토큰값;
 
         UPDATE user 
         SET couple_id = c_id 
         WHERE user_id = u_id OR user_id = user1_id;
 
         SELECT message INTO result_message
         FROM country_translate 
         WHERE con_id = country_id AND message_key = '4-3';
     END IF;
 
     SELECT result_message AS message;
 END