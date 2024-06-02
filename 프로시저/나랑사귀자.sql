-- 테스트 쿼리
CALL 나랑사귀자('예남', '예나', 'test@example.com');


-- 코드
CREATE PROCEDURE `나랑사귀자`(
     IN 발신자_닉네임 VARCHAR(255),
     IN 수신자_닉네임 VARCHAR(255),
     IN 수신자_이메일 VARCHAR(255)
 )
 BEGIN
     DECLARE country_id INT;
     DECLARE ran_token VARCHAR(45);
 
     SELECT id INTO country_id 
     FROM country 
     WHERE name = (SELECT country FROM user WHERE nickname = 발신자_닉네임 LIMIT 1);
 
     IF NOT EXISTS (SELECT 1 FROM user WHERE nickname = 수신자_닉네임 AND email = 수신자_이메일) THEN
         SELECT message 
         FROM country_translate 
         WHERE con_id = country_id AND message_key = '3-1';
 
     ELSEIF NOT EXISTS (SELECT 1 FROM user WHERE nickname = 발신자_닉네임) THEN
         SELECT message 
         FROM country_translate 
         WHERE con_id = country_id AND message_key = '3-1';
 
     ELSE
 
         SET ran_token = SUBSTRING(MD5(RAND()), 1, 45);
 
         INSERT INTO couple (
             couple_user1, token
         ) VALUES (
             (SELECT user_id FROM user WHERE nickname = 발신자_닉네임), ran_token
         );
 
         SELECT message 
         FROM country_translate 
         WHERE con_id = country_id AND message_key = '3-2';
     END IF;
 END