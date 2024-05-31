-- 커플 등록 프로시저
call RegistCouple('jenny@example.com','john@example.com');

CREATE PROCEDURE RegistCouple(
    IN my_email VARCHAR(255),
    IN lover_email VARCHAR(255)
)
BEGIN
    DECLARE my_id BIGINT;
    DECLARE lover_id BIGINT;

    -- 내 이메일을 통해 유저 아이디 값 찾기
    SELECT user_id INTO my_id FROM public.user WHERE email = my_email;
    SELECT user_id INTO lover_id FROM public.user WHERE email = lover_email;

    -- couple 테이블에 새로운 커플 정보 삽입
    INSERT INTO public.couple (couple_user1, couple_user2, breaks_up)
    VALUES (my_id, lover_id, 0);

    -- 유저 테이블에 역정규화
    UPDATE public.user SET lover_id = lover_id WHERE user_id = my_id;
    UPDATE public.user SET lover_id = my_id WHERE user_id = lover_id;
END;