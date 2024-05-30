-- 실행 성공
CALL RegisterUser('john@example.com', 'mypassword', '010-1234-5678', '1990-05-15', '남');


-- 프로시저
CREATE PROCEDURE RegisterUser(;
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_phone_number VARCHAR(13),
    IN p_birthday DATE,
    IN p_sex ENUM('남', '여')
)
BEGIN
    INSERT INTO public.user (
        email,
        password,
        phone_number,
        birthday,
        sex,
        nickname,
        is_alarm,
        status_message,
        profile_picture,
        background_picture,
        remain_charge
    ) VALUES (
        p_email,
        p_password,
        p_phone_number,
        p_birthday,
        p_sex,
        DEFAULT, -- nickname
        DEFAULT, -- is_alarm
        DEFAULT, -- status_message
        DEFAULT, -- profile_picture
        DEFAULT, -- background_picture
        DEFAULT  -- remain_charge
    );
END;