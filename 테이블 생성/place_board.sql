create table public.place_board
(
    reco_post_id     bigint auto_increment
        primary key,
    dong_id          bigint                                 not null,
    reco_category_id bigint                                 not null,
    user_id          bigint                                 not null,
    title            varchar(255)                           not null,
    contents         varchar(500)                           null,
    great            int        default 0                   null,
    bad              int        default 0                   null,
    is_deleted       tinyint(2) default 0                   null,
    deleted_at       datetime                               null,
    created_at       datetime   default current_timestamp() not null,
    updated_at       datetime   default current_timestamp() not null,
    constraint reco_post_id_UNIQUE
        unique (reco_post_id),
    constraint FK_place_board_dong
        foreign key (dong_id) references public.dong (dong_id)
            on update cascade
);

create index FK_place_board_category
    on public.place_board (reco_category_id);

create index FK_place_board_user
    on public.place_board (user_id);

