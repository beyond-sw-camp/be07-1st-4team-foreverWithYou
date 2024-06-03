create
    definer = mariadb@`%` procedure 내정보수정2(IN 닉네임 varchar(255), IN 변경_상태메세지 varchar(255), IN 변경_닉네임 varchar(10),
                                           IN 새로운_알람여부 tinyint(1), IN 변경_프로필사진_주소 varchar(500),
                                           IN 변경_배경사진_주소 varchar(255))
BEGIN
    DECLARE USERID BIGINT;
    DECLARE CURRENT_STATUS_MESSAGE VARCHAR(255);
    DECLARE CURRENT_NICKNAME VARCHAR(10);
    DECLARE CURRENT_IS_ALARM TINYINT(1);
    DECLARE CURRENT_PROFILE_PICTURE VARCHAR(500);
    DECLARE CURRENT_BACKGROUND_PICTURE VARCHAR(255);

    -- 유저 아이디와 현재 정보 가져오기
    SELECT user_id, status_message, nickname, is_alarm, profile_picture, background_picture
    INTO USERID, CURRENT_STATUS_MESSAGE, CURRENT_NICKNAME, CURRENT_IS_ALARM, CURRENT_PROFILE_PICTURE, CURRENT_BACKGROUND_PICTURE
    FROM public.user
    WHERE nickname = 닉네임;

    -- 입력받은 값이 빈 문자열이면 NULL로 변환하고, COALESCE를 사용하여 기존 값으로 대체
    SET 변경_상태메세지 = COALESCE(NULLIF(변경_상태메세지, ''), CURRENT_STATUS_MESSAGE);
    SET 변경_닉네임 = COALESCE(NULLIF(변경_닉네임, ''), CURRENT_NICKNAME);
    SET 새로운_알람여부 = COALESCE(NULLIF(새로운_알람여부, 0), CURRENT_IS_ALARM);
    SET 변경_프로필사진_주소 = COALESCE(NULLIF(변경_프로필사진_주소, ''), CURRENT_PROFILE_PICTURE);
    SET 변경_배경사진_주소 = COALESCE(NULLIF(변경_배경사진_주소, ''), CURRENT_BACKGROUND_PICTURE);

    -- 닉네임 중복 확인
    IF 변경_닉네임 <> CURRENT_NICKNAME THEN
        IF EXISTS (
            SELECT 1
            FROM public.user
            WHERE nickname = 변경_닉네임 AND user_id <> USERID
        ) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 존재하는 닉네임입니다.';
        END IF;
    END IF;

    -- 내 정보 업데이트
    UPDATE public.user
    SET status_message = 변경_상태메세지,
        nickname = 변경_닉네임,
        is_alarm = 새로운_알람여부,
        profile_picture = 변경_프로필사진_주소,
        background_picture = 변경_배경사진_주소,
        updated_at = NOW()
    WHERE user_id = USERID;
END;

