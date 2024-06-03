-- 완료
-- 상민 파트
-- User Table
create table user
(
    user_id            bigint auto_increment primary key,
    couple_id          bigint                               null,
    email              varchar(255)                         not null unique,
    password           varchar(255)                         not null,
    phone_number       varchar(13)                          not null,
    birthday           date                                 not null,
    sex                enum ('남', '여')                      not null,
    nickname           varchar(10)                          null default  '기본이름입니다.',
    is_alarm           tinyint(1)                           not null default 1,
    status_message     varchar(255)                         not null default '상태메세지입니다.',
    profile_picture    varchar(500)                         not null default '이미지 주소URL',
    background_picture varchar(255)                         not null default '이미지 주소URL',
    lover_id           bigint                               null,
    remain_charge      int                                  not null default 0,
    is_deleted         tinyint                              not null default 0,
    deleted_at         datetime                             null,
    country            bigint                               null,
    created_at         datetime default current_timestamp() not null,
    constraint FK_user_couple
        foreign key (couple_id) references couple (couple_id)

);

-- Payment Table
create table payment
(
    payment_id         bigint auto_increment                primary key,
    user_id            bigint                               not null,
    charge             varchar(255)                         not null,
    payment_status     enum ('승인취소', '결제완료', '미결제')     not null default '미결제',
    payment_event_at   datetime default current_timestamp() not null,
    payment_success_at datetime default current_timestamp() not null,
    card_number        varchar(255)                         not null,
    bank               varchar(255)                         not null,
    cvc                tinyint(3)                           not null,
    card_password      tinyint                              not null,
    created_at         datetime default current_timestamp() not null,
    constraint FK_payment_user
        foreign key (user_id) references user (user_id)
);

--EmoticonProduct Table
create table emoticon_product
(
    emoticon_product_id bigint auto_increment primary key,
    name                varchar(255)                         not null,
    price               int                                  not null,
    created_at          datetime default current_timestamp() not null
);

-- EmoticonImage Table
create table emoticon_image
(
    emoticon_image_id  bigint auto_increment primary key,
    emoticon_product_id bigint                              not null,
    emoticon_image_url varchar(500)                         not null,
    created_at         datetime default current_timestamp() not null,
    constraint FK_emoticon_image_product
        foreign key (emoticon_product_id) references emoticon_product (emoticon_product_id)
);

-- EmoticonPurchaseHistory Table
create table emoticon_purchase_history
(
    emoticon_payment_id bigint auto_increment primary key,
    couple_id           bigint                               not null,
    emoticon_product_id bigint                               not null,
    point_event_log_id  bigint                               not null,
    created_at          datetime default current_timestamp() not null,
    user_id             bigint                               not null,
    constraint FK_emoticon_purchase_history_couple
        foreign key (couple_id) references couple (couple_id) on delete set null,
    constraint FK_emoticon_purchase_history_point_log
        foreign key (point_event_log_id) references point_log (point_event_log_id),
    constraint FK_emoticon_purchase_history_product
        foreign key (emoticon_product_id) references emoticon_product (emoticon_product_id)
);

--PointLog Table
create table point_log
(
    point_event_log_id       bigint auto_increment primary key,
    payment_id               bigint                               not null,
    user_id                  bigint                               not null,
    point_trade_request_date datetime default current_timestamp() null,
    point_success_date       datetime                             null,
    trade_user_name          varchar(255)                         not null,
    use_date                 datetime                             null,
    point_price              int                                  not null,
    created_at               datetime default current_timestamp() not null,
    constraint FK_point_log_payment
        foreign key (payment_id) references payment (payment_id),
    constraint FK_point_log_user_point
        foreign key (user_id) references user (user_id)
);


-- 예나 파트
-- Couple
create table couple
(
    couple_id    bigint auto_increment primary key,
    couple_user1 bigint                                 not null,
    couple_user2 bigint                                 not null,
    breaks_up    tinyint(2) default 0                   null,
    created_at   datetime   default current_timestamp() not null
);

create table couple_media
(
    couple_media_id bigint auto_increment
        primary key,
    couple_id       bigint                                 not null,
    user_id         bigint                                 not null,
    upload_date     datetime                               null,
    star            int                                    null,
    show_together   enum ('혼자보기', '같이보기')                  null,
    deleted_at      datetime                               null,
    is_deleted      tinyint(2) default 0                   null,
    created_at      datetime   default current_timestamp() not null,
    constraint FK_couple_media_couple
        foreign key (couple_id) references couple (couple_id),
    constraint FK_couple_media_user
        foreign key (user_id) references user (user_id)
);

-- auto-generated definition
create table couple_comment
(
    couple_reply_id bigint auto_increment
        primary key,
    couple_media_id bigint                                 not null,
    user_id         bigint                                 not null,
    contents        varchar(500)                           null,
    created_at      datetime   default current_timestamp() not null,
    deleted_at      datetime                               null,
    is_deleted      tinyint(2) default 0                   null,
    constraint FK_couple_comment_couple_media
        foreign key (couple_media_id) references couple_media (couple_media_id),
    constraint FK_couple_comment_user
        foreign key (user_id) references user (user_id)
);

create table public.anniversary
(
    anni_id      bigint auto_increment
        primary key,
    couple_id    bigint                               null,
    anni_cate_id bigint                               null,
    title        varchar(255)                         not null,
    date         date                                 not null,
    `range`      enum ('공통', '본인')                    not null,
    memo         varchar(500)                         null,
    updated_at   datetime default current_timestamp() not null,
    created_at   datetime default current_timestamp() not null,
    constraint FK_anniversary_category
        foreign key (anni_cate_id) references public.anniversary_category (anniver_category_id)
            on update cascade on delete set null,
    constraint FK_anniversary_couple
        foreign key (couple_id) references public.couple (couple_id)
            on update cascade on delete set null
);

create table public.anniversary_category
(
    anniver_category_id bigint auto_increment
        primary key,
    name                varchar(255)                         null,
    updated_at          datetime default current_timestamp() not null,
    created_at          datetime default current_timestamp() not null
);

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

