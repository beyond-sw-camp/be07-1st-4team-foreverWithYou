create table public.sigungu
(
    sigungu_id   bigint auto_increment
        primary key,
    sido_id      bigint                               null,
    sigungu_code int                                  null,
    search_name  varchar(255)                         null,
    output_name  varchar(255)                         null,
    version      varchar(255)                         null,
    created_at   datetime default current_timestamp() not null,
    updated_at   datetime default current_timestamp() not null,
    constraint sigungu_id_UNIQUE
        unique (sigungu_id),
    constraint FK_sigungu_sido
        foreign key (sido_id) references public.sido (sido_id)
            on update cascade on delete set null
);

