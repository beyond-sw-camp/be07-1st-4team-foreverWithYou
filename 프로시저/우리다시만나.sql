-- 테스크 쿼리
call 우리다시만나('예남', '예나');


-- 코드
CREATE PROCEDURE `우리다시만나`(
     IN 발신자_닉네임 VARCHAR(255),
     IN 수신자_닉네임 VARCHAR(255)
)
BEGIN
    DECLARE 발신자_id BIGINT;
    DECLARE 수신자_id BIGINT;
    DECLARE 커플_id BIGINT;
    DECLARE 토큰 VARCHAR(45);

    SELECT user_id INTO 발신자_id 
    FROM user 
    WHERE nickname = 발신자_닉네임;

    SELECT user_id INTO 수신자_id 
    FROM user 
    WHERE nickname = 수신자_닉네임;

    SELECT couple_id, token INTO 커플_id, 토큰
    FROM couple
    WHERE (couple_user1 = 발신자_id AND couple_user2 = 수신자_id)
       OR (couple_user1 = 수신자_id AND couple_user2 = 발신자_id)
    LIMIT 1;

    IF 커플_id IS NOT NULL THEN

        UPDATE couple
        SET is_deleted = 0
        WHERE couple_id = 커플_id;

        UPDATE couple_media
        SET is_deleted = 0
        WHERE couple_id = 커플_id;

        UPDATE couple_comment
        SET is_deleted = 0
        WHERE couple_media_id IN (SELECT couple_media_id FROM couple_media WHERE couple_id = 커플_id);

        SELECT 토큰 AS token;
    ELSE
        SELECT '커플 정보를 찾을 수 없습니다.' AS message;
    END IF;
END