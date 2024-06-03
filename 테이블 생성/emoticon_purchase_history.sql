create table public.emoticon_purchase_history
(
    emoticon_payment_id bigint auto_increment
        primary key,
    couple_id           bigint                               not null,
    emoticon_product_id bigint                               not null,
    point_event_log_id  bigint                               not null,
    updated_id          datetime default current_timestamp() not null,
    created_at          datetime default current_timestamp() not null,
    constraint FK_emoticon_purchase_history_couple
        foreign key (couple_id) references public.couple (couple_id)
            on update cascade,
    constraint FK_emoticon_purchase_history_point_log
        foreign key (point_event_log_id) references public.point_log (point_event_log_id)
            on update cascade,
    constraint FK_emoticon_purchase_history_product
        foreign key (emoticon_product_id) references public.emoticon_product (emoticon_product_id)
            on update cascade
);

