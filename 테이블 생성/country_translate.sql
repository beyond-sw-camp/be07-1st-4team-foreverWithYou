create table public.country_translate
(
    id          int auto_increment
        primary key,
    con_id      int                                  null,
    message_key varchar(255)                         not null,
    message     varchar(255)                         not null,
    created_at  datetime default current_timestamp() not null,
    updated_at  datetime default current_timestamp() not null,
    constraint country_translate_ibfk_1
        foreign key (con_id) references public.country (id)
            on update cascade on delete set null
);

