create table public.country
(
    id         int auto_increment
        primary key,
    name       varchar(255)                         not null,
    created_at datetime default current_timestamp() not null,
    updated_at datetime default current_timestamp() not null,
    constraint name_UNIQUE
        unique (name)
);

