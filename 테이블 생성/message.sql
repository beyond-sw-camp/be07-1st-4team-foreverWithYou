create table public.message
(
    mess_id    bigint auto_increment
        primary key,
    couple_id  bigint                                 not null,
    user_id    bigint                                 not null,
    contents   varchar(500)                           null,
    is_deleted tinyint(2) default 0                   null,
    deleted_at datetime   default current_timestamp() null,
    created_at datetime   default current_timestamp() not null,
    updated_at datetime   default current_timestamp() not null,
    constraint mess_id_UNIQUE
        unique (mess_id),
    constraint FK_message_couple
        foreign key (couple_id) references public.couple (couple_id)
            on update cascade,
    constraint FK_message_user
        foreign key (user_id) references public.user (user_id)
            on update cascade
);

