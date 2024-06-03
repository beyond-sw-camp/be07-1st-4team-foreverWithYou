create
    definer = mariadb@`%` procedure 이모티콘구매(IN user_nickname varchar(255), IN EMOTICONPRODUCT_ID bigint)
BEGIN
    DECLARE my_id BIGINT;
    DECLARE u_couple_id BIGINT;
    DECLARE emoticon_price INT;
    DECLARE user_remain_charge INT;
    DECLARE new_remain_charge INT;
    DECLARE point_event_log_id BIGINT;
    DECLARE exists_purchase INT;

    -- 유저 아이디 찾기
    SELECT user_id, couple_id, remain_charge INTO my_id, u_couple_id, user_remain_charge
    FROM public.user
    WHERE nickname = user_nickname;

    -- 이모티콘 가격 찾기
    SELECT price INTO emoticon_price
    FROM public.emoticon_product
    WHERE emoticon_product_id = EMOTICONPRODUCT_ID;

    -- 이모티콘 구매 내역에 내 커플 아이디와 이모티콘 아이디가 있는지 확인
    SELECT COUNT(*) INTO exists_purchase
    FROM public.emoticon_purchase_history
    WHERE couple_id = u_couple_id AND emoticon_product_id = EMOTICONPRODUCT_ID;

    -- 구매 내역이 없을 경우에만 구매 가능
    IF exists_purchase = 0 THEN
        -- 유저의 남은 금액과 이모티콘의 가격 비교
        IF user_remain_charge >= emoticon_price THEN
            -- 포인트 로그에 추가
            INSERT INTO public.point_log (user_id, point_price, trade_user_name)
            VALUES (my_id, -emoticon_price, user_nickname);

            -- 포인트 로그 ID 가져오기
            SET point_event_log_id = LAST_INSERT_ID();

            -- 이모티콘 구매내역에 추가
            INSERT INTO public.emoticon_purchase_history (couple_id, emoticon_product_id, point_event_log_id)
            VALUES (u_couple_id, EMOTICONPRODUCT_ID, point_event_log_id);

            -- 유저의 남은 금액 업데이트
            SET new_remain_charge = user_remain_charge - emoticon_price;
            UPDATE public.user SET remain_charge = new_remain_charge WHERE user_id = my_id;
        ELSE
            -- 실패 메시지 전송
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '잔액이 부족합니다.';
        END IF;
    ELSE
        -- 실패 메시지 전송
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '이미 구매한 이모티콘입니다.';
    END IF;
END;

