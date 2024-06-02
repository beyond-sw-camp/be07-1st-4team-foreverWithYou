-- 테스트 쿼리
CALL 회원가입('test@example.com', '1234', '010-1234-5610', '2000-12-22', '남', '예남', 'ko', '이예남');


-- 코드
CREATE PROCEDURE `회원가입`(
     IN p_email VARCHAR(255),
     IN p_password VARCHAR(255),
     IN p_phone_number VARCHAR(13),
     IN p_birthday DATE,
     IN p_sex ENUM('남', '여'),
     IN p_nickname VARCHAR(10),
     IN p_country VARCHAR(2),
     IN p_name VARCHAR(255)
 )
 BEGIN
     DECLARE country_id INT;
 
     SELECT id INTO country_id FROM country WHERE name = p_country;
 
     IF EXISTS (SELECT 1 FROM user WHERE email = p_email) THEN
         SELECT message FROM country_translate
         WHERE con_id = country_id AND message_key = '1-3';
 
     ELSEIF EXISTS (SELECT 1 FROM user WHERE nickname = p_nickname) THEN
         SELECT message FROM country_translate
         WHERE con_id = country_id AND message_key = '1-1';
 
     ELSEIF EXISTS (SELECT 1 FROM user WHERE phone_number = p_phone_number) THEN
         SELECT message FROM country_translate
         WHERE con_id = country_id AND message_key = '1-2';
 
     ELSE
         INSERT INTO user (
             email,
             password,
             phone_number,
             birthday,
             sex,
             nickname,
             country,
             name
         ) VALUES (
             p_email,
             p_password,
             p_phone_number,
             p_birthday,
             p_sex,
             p_nickname,
             p_country,
             p_name
         );
 
         SELECT message
         FROM country_translate
         WHERE con_id = country_id AND message_key = '1-4';
     END IF;
 END