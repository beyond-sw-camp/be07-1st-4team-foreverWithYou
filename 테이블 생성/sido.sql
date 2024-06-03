create table public.sido
(
    sido_id     bigint auto_increment
        primary key,
    sido_code   int                                  null,
    search_name varchar(255)                         null,
    output_name varchar(255)                         null,
    version     varchar(255)                         null,
    created_at  datetime default current_timestamp() not null,
    updated_at  datetime default current_timestamp() not null
);

