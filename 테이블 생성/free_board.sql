create table public.free_board
(
    post_id    bigint auto_increment
        primary key,
    user_id    bigint                                 null,
    title      varchar(255)                           not null,
    contents   varchar(255)                           null,
    is_deleted tinyint(2) default 0                   null,
    deleted_at datetime                               null,
    updated_at datetime                               null,
    created_at datetime   default current_timestamp() not null,
    constraint post_id_UNIQUE
        unique (post_id),
    constraint FK_free_board_user
        foreign key (user_id) references public.user (user_id)
            on update cascade on delete set null
);

