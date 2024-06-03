-- 테스크 쿼리
call public.너와_나의_연결고리(11, '예남', 6);	-- 커플id, 닉네임, 조회 달


-- 코드
CREATE DEFINER=`mariadb`@`%` PROCEDURE `너와_나의_연결고리`(
     IN p_couple_id BIGINT,
     IN p_nickname VARCHAR(10),
     IN p_month INT
 )
 BEGIN
     SELECT 
         a.title,
         a.date,
         a.memo
     FROM 
         anniversary a
         JOIN couple c ON a.couple_id = c.couple_id
     WHERE 
         a.couple_id = p_couple_id
         AND MONTH(a.date) = p_month;
 END