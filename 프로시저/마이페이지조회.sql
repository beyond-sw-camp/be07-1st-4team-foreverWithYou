DELIMITER $$

CREATE PROCEDURE 마이페이지조회(IN 닉네임 varchar(255))
BEGIN
    DECLARE 유저아이디 BIGINT;
    DECLARE 유저나라 VARCHAR(255);
    DECLARE 커플아이디 BIGINT;
    DECLARE 애인아이디 BIGINT;
    DECLARE 애인닉네임 VARCHAR(10);

    -- 유저 정보 가져오기
    SELECT u.user_id, u.country, u.couple_id
    INTO 유저아이디, 유저나라, 커플아이디
    FROM public.user u
    WHERE u.nickname = 닉네임;

    -- 애인 정보 가져오기
    IF 커플아이디 IS NOT NULL THEN
        SELECT CASE
                   WHEN c.couple_user1 = 유저아이디 THEN c.couple_user2
                   ELSE c.couple_user1
               END AS 애인아이디
        INTO 애인아이디
        FROM public.couple c
        WHERE c.couple_id = 커플아이디;

        SELECT u.nickname
        INTO 애인닉네임
        FROM public.user u
        WHERE u.user_id = 애인아이디;
    ELSE
        SET 애인닉네임 = NULL;
    END IF;

    -- 마이페이지 정보 출력
    SELECT u.name, u.nickname, u.email, u.phone_number, u.birthday, u.sex,
           u.is_alarm, u.status_message, u.profile_picture, u.background_picture,
           u.remain_charge, c.name AS country_name,
           IF(u.couple_id IS NULL, '솔로', CONCAT(애인닉네임, '와 커플')) AS couple_status
    FROM public.user u
    LEFT JOIN public.country c ON u.country = c.name
    WHERE u.user_id = 유저아이디;
END $$

DELIMITER ;
