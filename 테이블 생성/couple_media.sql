create table public.couple_media
(
    couple_media_id bigint auto_increment
        primary key,
    couple_id       bigint                                            null,
    user_id         bigint                                            null,
    star            tinyint               default 0                   null,
    show_together   enum ('혼자보기', '같이보기') default '혼자보기'              null,
    is_deleted      tinyint(2)            default 0                   null,
    deleted_at      datetime                                          null,
    created_at      datetime              default current_timestamp() not null,
    updated_at      datetime              default current_timestamp() not null,
    constraint couple_media_id_UNIQUE
        unique (couple_media_id),
    constraint FK_couple_media_couple
        foreign key (couple_id) references public.couple (couple_id)
            on update cascade on delete set null,
    constraint FK_couple_media_user
        foreign key (user_id) references public.user (user_id)
            on update cascade on delete set null
);

