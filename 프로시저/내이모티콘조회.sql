create
    definer = mariadb@`%` procedure 내이모티콘조회(IN 닉네임 varchar(255))
BEGIN
    DECLARE USERID BIGINT;
    DECLARE COUPLEID BIGINT;

    -- 유저 아이디와 커플 아이디 가져오기
    SELECT user_id, couple_id
    INTO USERID, COUPLEID
    FROM public.user
    WHERE nickname = 닉네임;

    -- 내 목록 조회
    SELECT p.name, ei.emoticon_image_url
    FROM emoticon_product p
    JOIN emoticon_image ei ON p.emoticon_product_id = ei.emoticon_id
    WHERE p.emoticon_product_id IN (
        SELECT emoticon_product_id
        FROM emoticon_purchase_history
        WHERE couple_id = COUPLEID
    );
END;

