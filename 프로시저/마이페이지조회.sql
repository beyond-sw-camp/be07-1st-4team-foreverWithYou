create
    definer = mariadb@`%` procedure 마이페이지조회(IN 닉네임 varchar(255))
BEGIN
    DECLARE 유저아이디 BIGINT;
    DECLARE 유저나라 VARCHAR(255);
    DECLARE 커플아이디 BIGINT;
    DECLARE 애인아이디 BIGINT;
    DECLARE 애인닉네임 VARCHAR(10);

    -- 유저 정보 가져오기
    SELECT u.user_id, u.country, u.couple_id, u.couple_id, l.nickname
    INTO 유저아이디, 유저나라, 커플아이디, 애인아이디, 애인닉네임
    FROM public.user u
    LEFT JOIN public.user l ON u.couple_id = l.user_id
    WHERE u.nickname = 닉네임;

    -- 마이페이지 정보 출력
    SELECT u.name, u.nickname, u.email, u.phone_number, u.birthday, u.sex,
           u.is_alarm, u.status_message, u.profile_picture, u.background_picture,
           u.remain_charge, c.name AS country_name,
           CASE WHEN u.couple_id IS NULL THEN '솔로'
                ELSE CONCAT(애인닉네임, '와 커플')
           END AS couple_status
    FROM public.user u
    LEFT JOIN public.country c ON u.country = c.name
    WHERE u.user_id = 유저아이디;
END;

