-- 테스크 쿼리
call 우리의_추억보기(11, 2);	-- 커플id, 앨범id


-- 코드
CREATE DEFINER=`mariadb`@`%` PROCEDURE `우리의_추억보기`(
     IN p_couple_id BIGINT,
     IN p_couple_media_id BIGINT
 )
 BEGIN
 
     SELECT 
         cc.couple_media_id,
         cc.contents,
         cc.created_at,
         cc.updated_at
     FROM 
         couple_comment cc
     WHERE 
         cc.couple_media_id = p_couple_media_id
         AND cc.is_deleted = 0;
 END