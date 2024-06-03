create table public.emoticon_product
(
    emoticon_product_id bigint auto_increment
        primary key,
    name                varchar(255)                         null,
    price               int      default 0                   not null,
    created_at          datetime default current_timestamp() not null,
    updated_at          datetime default current_timestamp() not null,
    constraint emoticon_product_id_UNIQUE
        unique (emoticon_product_id)
);

