create table public.user
(
    user_id            bigint auto_increment
        primary key,
    couple_id          bigint                                   null,
    country            varchar(255) default 'ko'                null,
    name               varchar(255) default ''                  not null,
    nickname           varchar(10)                              not null,
    email              varchar(255)                             not null,
    password           varchar(255)                             not null,
    phone_number       varchar(13)                              not null,
    birthday           date                                     not null,
    sex                enum ('남', '여')                          not null,
    is_alarm           tinyint(1)   default 1                   null,
    status_message     varchar(255) default '상태메세지입니다.'         not null,
    profile_picture    varchar(500) default '이미지 주소URL'         not null,
    background_picture varchar(255) default '이미지 주소URL'         not null,
    remain_charge      int          default 0                   not null,
    is_deleted         tinyint      default 0                   null,
    deleted_at         datetime                                 null,
    updated_at         datetime     default current_timestamp() not null,
    created_at         datetime     default current_timestamp() not null,
    constraint email_UNIQUE
        unique (email),
    constraint nickname_UNIQUE
        unique (nickname),
    constraint phone_number_UNIQUE
        unique (phone_number),
    constraint user_id_UNIQUE
        unique (user_id),
    constraint user_country_code_fk
        foreign key (country) references public.country (name)
            on update cascade on delete set null,
    constraint user_couple_id_fk
        foreign key (couple_id) references public.couple (couple_id)
            on update cascade on delete set null
);

create index FK_user_country_id_idx
    on public.user (country);

