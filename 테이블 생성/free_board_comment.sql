create table public.free_board_comment
(
    reply_id   bigint auto_increment
        primary key,
    post_id    bigint                                 null,
    user_id    bigint                                 not null,
    contents   varchar(255)                           null,
    is_deleted tinyint(2) default 0                   null,
    deleted_at datetime                               null,
    updated_at datetime   default current_timestamp() not null,
    created_at datetime   default current_timestamp() not null,
    constraint reply_id_UNIQUE
        unique (reply_id),
    constraint FK_free_board_comment_free_board
        foreign key (post_id) references public.free_board (post_id)
            on update cascade on delete set null,
    constraint FK_free_board_comment_user
        foreign key (user_id) references public.user (user_id)
);

