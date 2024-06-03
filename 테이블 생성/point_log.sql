create table public.point_log
(
    point_event_log_id       bigint auto_increment
        primary key,
    payment_id               bigint                               null,
    user_id                  bigint                               not null,
    trade_user_name          varchar(255)                         not null,
    point_price              int                                  not null,
    use_date                 datetime                             null,
    point_trade_request_date datetime default current_timestamp() null,
    created_at               datetime default current_timestamp() not null,
    updated_at               datetime default current_timestamp() not null,
    constraint payment_id_UNIQUE
        unique (payment_id),
    constraint FK_point_log_payment_id
        foreign key (payment_id) references public.payment (payment_id)
            on update cascade,
    constraint FK_point_log_user_id
        foreign key (user_id) references public.user (user_id)
            on update cascade
);

