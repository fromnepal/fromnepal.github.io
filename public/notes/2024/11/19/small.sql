create table contacts (
    id serial primary key,
    uuid uuid default gen_random_uuid() not null,
    name varchar(255) not null,
    type varchar(50) check (type in ('person', 'company')) not null,
    created_by varchar(255) not null,
    created_at timestamp default current_timestamp not null,
    modified_by varchar(255),
    modified_at timestamp
);

create table phone_numbers (
    id serial primary key,
    uuid uuid default gen_random_uuid() not null,
    contact_id integer references contacts(id) on delete cascade,
    country_code varchar(5),
    number varchar(20) not null,
    label varchar(50),
    created_by varchar(255) not null,
    created_at timestamp default current_timestamp not null,
    modified_by varchar(255),
    modified_at timestamp
);

create table addresses (
    id serial primary key,
    uuid uuid default gen_random_uuid() not null,
    contact_id integer references contacts(id) on delete cascade,
    address_line1 varchar(255) not null,
    address_line2 varchar(255),
    city varchar(100),
    state varchar(100),
    postal_code varchar(20),
    country varchar(100) not null,
    label varchar(50),
    created_by varchar(255) not null,
    created_at timestamp default current_timestamp not null,
    modified_by varchar(255),
    modified_at timestamp
);

create table email_addresses (
    id serial primary key,
    uuid uuid default gen_random_uuid() not null,
    contact_id integer references contacts(id) on delete cascade,
    email varchar(255) not null,
    label varchar(50),
    created_by varchar(255) not null,
    created_at timestamp default current_timestamp not null,
    modified_by varchar(255),
    modified_at timestamp
);

create table social_media_links (
    id serial primary key,
    uuid uuid default gen_random_uuid() not null,
    contact_id integer references contacts(id) on delete cascade,
    platform varchar(50) not null,
    url varchar(255) not null,
    label varchar(50),
    created_by varchar(255) not null,
    created_at timestamp default current_timestamp not null,
    modified_by varchar(255),
    modified_at timestamp
);

create table phone_numbers_history (
    id serial primary key,
    phone_number_id integer not null,
    uuid uuid not null,
    contact_id integer,
    country_code varchar(5),
    number varchar(20),
    label varchar(50),
    created_by varchar(255),
    created_at timestamp,
    modified_by varchar(255),
    modified_at timestamp,
    changed_at timestamp default current_timestamp not null
);

create or replace function log_phone_number_changes() returns trigger as $$
begin
    if tg_op = 'update' then
        insert into phone_numbers_history (phone_number_id, uuid, contact_id, country_code, number, label, created_by, created_at, modified_by, modified_at)
        values (old.id, old.uuid, old.contact_id, old.country_code, old.number, old.label, old.created_by, old.created_at, old.modified_by, old.modified_at);
    end if;
    return new;
end;
$$ language plpgsql;

create trigger phone_number_changes
after update on phone_numbers
for each row execute function log_phone_number_changes();

create table addresses_history (
    id serial primary key,
    address_id integer not null,
    uuid uuid not null,
    contact_id integer,
    address_line1 varchar(255),
    address_line2 varchar(255),
    city varchar(100),
    state varchar(100),
    postal_code varchar(20),
    country varchar(100),
    label varchar(50),
    created_by varchar(255),
    created_at timestamp,
    modified_by varchar(255),
    modified_at timestamp,
    changed_at timestamp default current_timestamp not null
);

create or replace function log_address_changes() returns trigger as $$
begin
    if tg_op = 'update' then
        insert into addresses_history (address_id, uuid, contact_id, address_line1, address_line2, city, state, postal_code, country, label, created_by, created_at, modified_by, modified_at)
        values (old.id, old.uuid, old.contact_id, old.address_line1, old.address_line2, old.city, old.state, old.postal_code, old.country, old.label, old.created_by, old.created_at, old.modified_by, old.modified_at);
    end if;
    return new;
end;
$$ language plpgsql;

create trigger address_changes
after update on addresses
for each row execute function log_address_changes();

create table email_addresses_history (
    id serial primary key,
    email_address_id integer not null,
    uuid uuid not null,
    contact_id integer,
    email varchar(255),
    label varchar(50),
    created_by varchar(255),
    created_at timestamp,
    modified_by varchar(255),
    modified_at timestamp,
    changed_at timestamp default current_timestamp not null
);

create or replace function log_email_address_changes() returns trigger as $$
begin
    if tg_op = 'update' then
        insert into email_addresses_history (email_address_id, uuid, contact_id, email, label, created_by, created_at, modified_by, modified_at)
        values (old.id, old.uuid, old.contact_id, old.email, old.label, old.created_by, old.created_at, old.modified_by, old.modified_at);
    end if;
    return new;
end;
$$ language plpgsql;

create trigger email_address_changes
after update on email_addresses
for each row execute function log_email_address_changes();

create table social_media_links_history (
    id serial primary key,
    social_media_link_id integer not null,
    uuid uuid not null,
    contact_id integer,
    platform varchar(50),
    url varchar(255),
    label varchar(50),
    created_by varchar(255),
    created_at timestamp,
    modified_by varchar(255),
    modified_at timestamp,
    changed_at timestamp default current_timestamp not null
);

create or replace function log_social_media_link_changes() returns trigger as $$
begin
    if tg_op = 'update' then
        insert into social_media_links_history (social_media_link_id, uuid, contact_id, platform, url, label, created_by, created_at, modified_by, modified_at)
        values (old.id, old.uuid, old.contact_id, old.platform, old.url, old.label, old.created_by, old.created_at, old.modified_by, old.modified_at);
    end if;
    return new;
end;
$$ language plpgsql;

create trigger social_media_link_changes
after update on social_media_links
for each row execute function log_social_media_link_changes();