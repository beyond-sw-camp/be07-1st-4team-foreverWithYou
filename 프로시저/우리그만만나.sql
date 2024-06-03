-- 테스크 쿼리
CALL 우리그만만나('예남','예나', 토큰값);


-- 코드
CREATE PROCEDURE `우리그만만나`(
    IN 발신자_닉네임 VARCHAR(255),
    IN 수신자_닉네임 VARCHAR(255),
    IN 토큰값 VARCHAR(255)
)
BEGIN
    DECLARE country_id INT;
    DECLARE c_id BIGINT;
    DECLARE user1_id BIGINT;
    DECLARE user2_id BIGINT;
    DECLARE result_message VARCHAR(255);

    SELECT id INTO country_id 
    FROM country 
    WHERE name = (SELECT country FROM user WHERE nickname = 발신자_닉네임 LIMIT 1);

 
    IF NOT EXISTS (SELECT 1 FROM user WHERE nickname = 수신자_닉네임 OR nickname = 발신자_닉네임) THEN
        SELECT message INTO result_message
        FROM country_translate 
        WHERE con_id = 1 AND message_key = '3-1';


    ELSEIF NOT EXISTS (SELECT 1 FROM couple WHERE token = 토큰값) THEN
        SELECT message INTO result_message
        FROM country_translate 
        WHERE con_id = country_id AND message_key = '4-2';

    ELSE

        SELECT couple_id, couple_user1, couple_user2 INTO c_id, user1_id, user2_id
        FROM couple 
        WHERE token = 토큰값;

        UPDATE couple 
        SET is_deleted = 1 
        WHERE token = 토큰값;

        UPDATE couple_media 
        SET is_deleted = 1, deleted_at = NOW() 
        WHERE couple_id = c_id;

        UPDATE couple_comment
        SET is_deleted = 0
        WHERE couple_media_id IN (SELECT couple_media_id FROM couple_media WHERE couple_id = c_id);

        UPDATE user 
        SET couple_id = NULL 
        WHERE user_id = user1_id OR user_id = user2_id;



        SELECT message INTO result_message
        FROM country_translate 
        WHERE con_id = country_id AND message_key = '5-1';
    END IF;


    SELECT result_message AS message;
END