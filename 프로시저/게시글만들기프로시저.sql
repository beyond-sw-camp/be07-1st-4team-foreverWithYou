create
    definer = mariadb@`%` procedure public.게시글만들기(IN 동이름 varchar(255), IN 카테고리이름 varchar(255), IN 닉네임 varchar(255),
                                                  IN 제목 varchar(255), IN 내용 varchar(500))
BEGIN
    DECLARE 변수카테고리아이디 bigint;
    DECLARE 변수유저아이디 bigint;
    DECLARE 변수동아이디 bigint;
    
    select reco_category_id into 변수카테고리아이디  from place_category where name = 카테고리이름;
    select user_id into 변수유저아이디 from user where nickname = 닉네임;
    select dong_id into 변수동아이디 from dong where  search_name = 동이름;

    INSERT INTO public.place_board (
        dong_id, reco_category_id, user_id, title, contents, created_at, updated_at
    ) VALUES (
        변수동아이디, 변수카테고리아이디, 변수유저아이디, 제목, 내용, NOW(), NOW()
    );
END;

