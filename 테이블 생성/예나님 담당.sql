-- 지라에 완료 했다는 것들은 다됐다고 이해했어요 만약 안되신 거면 다시 CreateAllTable.sql 에서 고쳐주세요


create table anniversary
(
    anni_id       bigint auto_increment
        primary key,
    couple_id     bigint                               not null,
    anni_cate_id  bigint                               not null,
    title         varchar(255)                         not null,
    date          date                                 not null,
    `range`       enum ('공통', '본인')                    not null,
    is_all_day    tinyint(1)                           null,
    alarm_start   time                                 null,
    alarm_end     time                                 null,
    Repeatability tinyint(1)                           null,
    memo          varchar(500)                         null,
    created_at    datetime default current_timestamp() not null,
    constraint FK_anniversary_category
        foreign key (anni_cate_id) references anniversary_category (anniver_category_Id),
    constraint FK_anniversary_couple
        foreign key (couple_id) references couple (couple_id)
);

-- auto-generated definition
create table anniversary_category
(
    anniver_category_Id bigint auto_increment
        primary key,
    name                varchar(255)                         null,
    created_at          datetime default current_timestamp() not null
);
