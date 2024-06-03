create
    definer = mariadb@`%` procedure 회원가입(IN p_email varchar(255), IN p_password varchar(255),
                                         IN p_phone_number varchar(13), IN p_birthday date, IN p_sex enum ('남', '여'),
                                         IN p_nickname varchar(10), IN p_country varchar(2), IN p_name varchar(255))
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
END;

