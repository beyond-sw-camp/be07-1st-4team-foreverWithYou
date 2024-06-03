create table public.place_category
(
    reco_category_id bigint auto_increment
        primary key,
    name             varchar(255) default ''                  not null,
    created_at       datetime     default current_timestamp() not null,
    updated_at       datetime     default current_timestamp() not null,
    constraint reco_category_id_UNIQUE
        unique (reco_category_id)
);

