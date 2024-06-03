create
    definer = mariadb@`%` procedure 포인트충전(IN user_nickname varchar(255), IN want_charge int,
                                          IN user_card_number varchar(255), IN user_card_password int(4),
                                          IN user_bank varchar(255), IN user_cvc tinyint(3))
BEGIN
   DECLARE my_id BIGINT;
   DECLARE payment_id BIGINT;

   -- 유저 아이디 찾기
   SELECT user_id INTO my_id FROM public.user WHERE nickname = user_nickname;

   -- 결제 정보 저장
   INSERT INTO public.payment (user_id, charge, card_number, card_password, bank, cvc, payment_status)
   VALUES (my_id, want_charge, user_card_number, user_card_password, user_bank, user_cvc, '결제완료');

   -- 결제 ID 가져오기
   SET payment_id = LAST_INSERT_ID();

   -- 포인트 로그 추가
   INSERT INTO public.point_log (payment_id, user_id, trade_user_name, point_price)
   VALUES (payment_id, my_id, user_nickname, want_charge);

   -- 유저 테이블에 remain_charge 업데이트
   UPDATE public.user
   SET remain_charge = remain_charge + want_charge
   WHERE user_id = my_id;
END;

