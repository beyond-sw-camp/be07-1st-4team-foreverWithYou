create table public.anniversary_category
(
    anniver_category_id bigint auto_increment
        primary key,
    name                varchar(255)                         null,
    updated_at          datetime default current_timestamp() not null,
    created_at          datetime default current_timestamp() not null
);

