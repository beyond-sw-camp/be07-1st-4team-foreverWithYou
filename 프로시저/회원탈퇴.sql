create
    definer = mariadb@`%` procedure 회원탈퇴(IN 닉네임 varchar(255))
BEGIN
    -- Update the user record to mark as deleted
    UPDATE public.user
    SET is_deleted = 1,
        deleted_at = NOW()
    WHERE nickname = 닉네임;

END;

