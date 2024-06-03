create table public.board_media
(
    post_media_id bigint auto_increment
        primary key,
    post_id       bigint                               not null,
    media_url     varchar(500)                         null,
    media_type    enum ('사진', '동영상')                   null,
    updated_at    datetime default current_timestamp() not null,
    created_at    datetime default current_timestamp() not null,
    constraint FK_board_media_free_board
        foreign key (post_id) references public.free_board (post_id)
            on update cascade
);

