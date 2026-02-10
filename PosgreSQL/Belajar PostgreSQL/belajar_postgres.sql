create database belajar_postgresql;

--\c to use database

select datname from pg_database;

-- \dt to show tables
select * from pg_tables where schemaname= 'public';



--CREATE TABLE

create table barang(
	kode int not null,
	name varchar(100) not null,
	harga int not null default 1000,
	jumlah int not null default 0,
	waktu_dibuat timestamp not null default current_timestamp
);

-- \d to describe table

--ALTER TABLE

alter table barang
add column deskripsi text;

alter table barang
drop column deskripsi;

alter table barang
rename column name to nama;


truncate barang;

drop table barang;

create table products(
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	pice int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp
);

alter table products
rename pice to price;

alter table products
add primary key(id);


--INSERT DATA

insert into products (id, name, price, quantity)
values ('P0001', 'Mie Ayam Original', 15000, 100);

insert into products (id, name, description, price, quantity)
values ('P0002', 'Mie Ayam Bakso Tahu', 'Mie Ayam Original + Bakso Tahu', 20000, 100);

insert into products (id, name, price, quantity)
values ('P0003', 'Mie Ayam Ceker', 20000, 100),
		('P0004', 'Mie Ayam Spesial', 25000, 100),
		('P0005', 'Mie Ayam Yamin', 15000, 100);



--SELECT DATA

select * from products;

select name, price, quantity from products;

select id, name, price, quantity from products
where price = 20000;


create type PRODUCT_CATEGORY as enum ('Makanan', 'Minuman', 'Lain-Lain');

alter table products
add column category PRODUCT_CATEGORY;

update products
set category = 'Makanan'
where id in ('P0001', 'P0002', 'P0003', 'P0004', 'P0005')

select * from products;

select id as kode, name as nama from products;

select * from products where name ilike '%ayam%';



create table admin(
	id serial not null,
	first_name varchar(100),
	last_name varchar(100),
	primary key(id)
);


insert into admin(first_name, last_name)
values ('Bagus', 'Dwikayana');

select * from admin;

select currval('admin_id_seq');

create sequence contoh_sequence;

create table customer(
	id serial not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(50) not null,
	primary key(id),
	unique(email)

);


select cfgname from pg_ts_config;

create index product_description_search on products using gin (to_tsvector('indonesian', description));

select * from products where description @@ to_tsquery('mie');