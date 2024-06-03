create table public.dong
(
    dong_id     bigint auto_increment
        primary key,
    sigungu_id  bigint                               not null,
    dong_code   int                                  null,
    search_name varchar(255)                         null,
    output_name varchar(255)                         null,
    version     varchar(255)                         null,
    created_at  datetime default current_timestamp() not null,
    updated_at  datetime default current_timestamp() not null,
    constraint dong_id_UNIQUE
        unique (dong_id)
);

create index FK_dong_sigungu
    on public.dong (sigungu_id);

