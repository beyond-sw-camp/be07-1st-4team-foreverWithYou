create
    definer = mariadb@`%` procedure 이모티콘상점목록조회()
BEGIN
    SELECT p.emoticon_product_id,
           p.name,
           p.price,
           i.emoticon_image_url

    FROM emoticon_product p join emoticon_image i on p.emoticon_product_id = i.emoticon_id
    ;
END;

