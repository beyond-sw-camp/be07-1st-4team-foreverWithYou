create
    definer = mariadb@`%` procedure 게시글조회(IN 제목 varchar(255), IN 내용 varchar(255), IN 닉네임 varchar(255))
BEGIN
    
	IF 제목 IS NULL AND 내용 IS NOT NULL AND 닉네임 IS NOT NULL THEN
		SELECT 
			u.nickname, 
			pb.title, 
			pb.contents, 
			pb.great, 
			pb.bad, 
			pb.created_at, 
			pb.updated_at, 
			pb.is_deleted
		FROM 
			place_board pb
		JOIN 
			user u ON pb.user_id = u.user_id
		WHERE 
			pb.contents LIKE CONCAT('%', 내용, '%')
			AND u.nickname LIKE CONCAT('%', 닉네임, '%');
	ELSEIF 내용 IS NULL AND 제목 IS NOT NULL AND 닉네임 IS NOT NULL THEN
		SELECT 
			u.nickname, 
			pb.title, 
			pb.contents, 
			pb.great, 
			pb.bad, 
			pb.created_at, 
			pb.updated_at, 
			pb.is_deleted
		FROM 
			place_board pb
		JOIN 
			user u ON pb.user_id = u.user_id
		WHERE 
			pb.title LIKE CONCAT('%', 제목, '%')
			AND u.nickname LIKE CONCAT('%', 닉네임, '%');
	ELSEIF 닉네임 IS NULL AND 제목 IS NOT NULL AND 내용 IS NOT NULL THEN
		SELECT 
			u.nickname, 
			pb.title, 
			pb.contents, 
			pb.great, 
			pb.bad, 
			pb.created_at, 
			pb.updated_at, 
			pb.is_deleted
		FROM 
			place_board pb
		JOIN 
			user u ON pb.user_id = u.user_id
		WHERE 
			pb.title LIKE CONCAT('%', 제목, '%')
			AND pb.contents LIKE CONCAT('%', 내용, '%');
	ELSEIF 제목 IS NULL AND 내용 IS NULL AND 닉네임 IS NOT NULL THEN
		SELECT 
			u.nickname, 
			pb.title, 
			pb.contents, 
			pb.great, 
			pb.bad, 
			pb.created_at, 
			pb.updated_at, 
			pb.is_deleted
		FROM 
			place_board pb
		JOIN 
			user u ON pb.user_id = u.user_id
		WHERE 
			u.nickname LIKE CONCAT('%', 닉네임, '%');
	ELSE
		SELECT 
			u.nickname, 
			pb.title, 
			pb.contents, 
			pb.great, 
			pb.bad, 
			pb.created_at, 
			pb.updated_at, 
			pb.is_deleted
		FROM 
			place_board pb
		JOIN 
			user u ON pb.user_id = u.user_id
		WHERE 
			(pb.title LIKE CONCAT('%', 제목, '%') OR 제목 IS NULL)
			AND (pb.contents LIKE CONCAT('%', 내용, '%') OR 내용 IS NULL)
			AND (u.nickname LIKE CONCAT('%', 닉네임, '%') OR 닉네임 IS NULL);
	END IF;
END;

