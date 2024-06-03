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

