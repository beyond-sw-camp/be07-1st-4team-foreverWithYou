create table public.couple
(
    couple_id    bigint auto_increment
        primary key,
    couple_user1 bigint                                 not null,
    couple_user2 bigint                                 null,
    token        varchar(45)                            null,
    is_deleted   tinyint(2) default 0                   null,
    deleted_at   datetime                               null,
    created_at   datetime   default current_timestamp() not null,
    updated_at   datetime   default current_timestamp() not null,
    constraint couple_id_UNIQUE
        unique (couple_id)
);

create index idx_token
    on public.couple (token);

