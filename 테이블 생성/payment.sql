create table public.payment
(
    payment_id         bigint auto_increment
        primary key,
    user_id            bigint                               not null,
    charge             varchar(255)                         null,
    payment_status     enum ('승인취소', '결제완료', '미결제')         null,
    payment_event_at   datetime default current_timestamp() not null,
    payment_success_at datetime default current_timestamp() null,
    card_number        varchar(255)                         not null,
    bank               varchar(255)                         null,
    cvc                int                                  not null,
    card_password      int(4)                               not null,
    created_at         datetime default current_timestamp() not null,
    updated_at         datetime default current_timestamp() not null,
    constraint payment_id_UNIQUE
        unique (payment_id),
    constraint FK_payment_user
        foreign key (user_id) references public.user (user_id)
            on update cascade
);

