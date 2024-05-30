-- auto-generated definition
create table sido
(
    sido_id     bigint auto_increment
        primary key,
    sido_code   int                                  null,
    search_name varchar(255)                         null,
    output_name varchar(255)                         null,
    version     varchar(255)                         null,
    created_at  datetime default current_timestamp() not null
);

-- auto-generated definition
create table sigungu
(
    sigungu_id   bigint auto_increment
        primary key,
    sido_id      bigint                               not null,
    sigungu_code int                                  null,
    search_name  varchar(255)                         null,
    output_name  varchar(255)                         null,
    version      varchar(255)                         null,
    created_at   datetime default current_timestamp() not null,
    constraint FK_sigungu_sido
        foreign key (sido_id) references sido (sido_id)
);


-- auto-generated definition
create table dong
(
    dong_id     bigint auto_increment
        primary key,
    sigungu_id  bigint                               not null,
    dong_code   int                                  null,
    search_name varchar(255)                         null,
    output_name varchar(255)                         null,
    version     varchar(255)                         null,
    created_at  datetime default current_timestamp() not null,
    constraint FK_dong_sigungu
        foreign key (sigungu_id) references sigungu (sigungu_id)
);

-- auto-generated definition
create table place_category
(
    reco_category_id bigint auto_increment
        primary key,
    name             varchar(255)                         null,
    created_at       datetime default current_timestamp() not null
);



-- auto-generated definition
create table place_board
(
    reco_post_id     bigint auto_increment
        primary key,
    dong_id          bigint                               not null,
    reco_category_id bigint                               not null,
    user_id          bigint                               not null,
    title            varchar(255)                         null,
    contents         varchar(500)                         null,
    created_at       datetime default current_timestamp() not null,
    updated_at       datetime                             null on update current_timestamp(),
    deleted_at       datetime                             null,
    is_deleted       tinyint(2)                           null,
    heart            int                                  null,
    Field6           int                                  null,
    bad              int                                  null,
    constraint FK_place_board_category
        foreign key (reco_category_id) references place_category (reco_category_id),
    constraint FK_place_board_dong
        foreign key (dong_id) references dong (dong_id),
    constraint FK_place_board_user
        foreign key (user_id) references user (user_id)
);

