create
    definer = mariadb@`%` procedure 로그인(IN p_nickname varchar(10), IN p_password varchar(255))
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
END;

