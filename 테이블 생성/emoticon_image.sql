create table public.emoticon_image
(
    emoticon_image_id  bigint auto_increment
        primary key,
    emoticon_id        bigint                               not null,
    emoticon_image_url varchar(255)                         null,
    created_at         datetime default current_timestamp() not null,
    updated_at         datetime default current_timestamp() not null,
    constraint emoticon_image_id_UNIQUE
        unique (emoticon_image_id),
    constraint FK_emoticon_image_product
        foreign key (emoticon_id) references public.emoticon_product (emoticon_product_id)
            on update cascade
);

