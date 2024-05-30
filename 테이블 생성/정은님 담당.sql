
-- auto-generated definition
create table free_board
(
    post_id    bigint auto_increment
        primary key,
    user_id    bigint                               not null,
    title      varchar(255)                         null,
    contents   varchar(255)                         null,
    created_at datetime default current_timestamp() not null,
    updated_at datetime                             null on update current_timestamp(),
    is_deleted tinyint(2)                           null,
    deleted_at datetime                             null,
    constraint FK_free_board_user
        foreign key (user_id) references user (user_id)
);

-- auto-generated definition
create table free_board_comment
(
    reply_id   bigint auto_increment
        primary key,
    post_id    bigint                               not null,
    user_id    bigint                               not null,
    contents   varchar(255)                         null,
    created_at datetime default current_timestamp() not null,
    is_deleted tinyint(2)                           null,
    deleted_at datetime                             null,
    constraint FK_free_board_comment_free_board
        foreign key (post_id) references free_board (post_id),
    constraint FK_free_board_comment_user
        foreign key (user_id) references user (user_id)
);



-- auto-generated definition
create table board_media
(
    post_media_id bigint auto_increment
        primary key,
    post_id       bigint                               not null,
    upload_date   date                                 null,
    media_url     varchar(500)                         null,
    media_type    enum ('사진', '동영상')                   null,
    created_at    datetime default current_timestamp() not null,
    constraint FK_board_media_free_board
        foreign key (post_id) references free_board (post_id)
);






