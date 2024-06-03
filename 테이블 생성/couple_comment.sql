create table public.couple_comment
(
    couple_reply_id bigint auto_increment
        primary key,
    couple_media_id bigint                                 null,
    user_id         bigint                                 null,
    contents        varchar(500)                           null,
    is_deleted      tinyint(2) default 0                   null,
    deleted_at      datetime                               null,
    created_at      datetime   default current_timestamp() not null,
    updated_at      datetime   default current_timestamp() not null,
    constraint couple_reply_id_UNIQUE
        unique (couple_reply_id),
    constraint FK_couple_comment_couple_media
        foreign key (couple_media_id) references public.couple_media (couple_media_id)
            on update cascade on delete set null,
    constraint FK_couple_comment_user
        foreign key (user_id) references public.user (user_id)
            on update cascade on delete set null
);

