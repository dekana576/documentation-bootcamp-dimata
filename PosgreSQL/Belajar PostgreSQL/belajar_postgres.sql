create database belajar_postgresql;

--\c to use database

select datname from pg_database;

-- \dt to show tables
select * from pg_tables where schemaname= 'public';



--CREATE TABLE

create table barang(
	kode int,
	name varchar(100),
	harga int,
	jumlah int
);

-- \d to describe table

--ALTER TABLE

alter table barang
add column deskripsi text;

alter table barang
drop column deskripsi;

alter table barang
rename column name to nama;

