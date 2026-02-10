use belajar_mysql;
show tables;

desc products;

select * from products;

show create table products;

insert into products (name, description, price, quantity)
values ("Mie Ayam", "Mie Ayam + Es Teh", 15000, 100);

select * from products
where price > 1000000;

-- Other Operator : between, not between, in, not in

select category from products;

select distinct category from products;

select name, price div 1000 as 'price in K' from products;

select LAST_INSERT_ID();

-- String function dev.mysql.com

select id, name, lower(name), length(name) from products;


-- date and time function

select id,created_at, 
	extract(year from created_at) as year, 
	extract(month from created_at) as month 
from products;

select id, created_at,
	year(created_at) as year,
	month(created_at) as month
from products;

-- flow control function

select * from products;

insert into products (name, category, description, price, quantity)
values ('Ms. Office', 'Lain-Lain', 'Ms. word - Ms. Excel - Ms. Powerpoint', 1000000, 200),
('Adobe Master', 'Lain-Lain', 'Photoshop - Ilustrator - Premiere', 2000000, 250);

select name, category,
	case category
		when 'Peripheral' then 'Hardware tambahan'
		when 'Sparepart' then 'Hardware Inti'
		else 'software'
		end as 'Keterangan'
from products;

select name, price,
	if (price > 1000000, 'Mahal', 'Murah') as 'Keterangan'
from products;

-- agregate function

select count(id) as 'Total Produk' from products;

select max(price) as 'Produk Termahal' from products;

select min(price) as 'Produk Termurah' from products;

select avg(price) as 'Rata-Rata Harga' from products;

select sum(price) as 'Total Harga' from products;


-- Group by function

select category, 
	max(price) as 'Produk Termahal' 
from products 
group by category;

select category, 
	max(price) as Produk 
from products 
group by category
having Produk > 2000000;

-- constraint

alter table products
add constraint price_check check(price >= 1000000);

-- index b tree - optimization indexes
-- Seller Script

-- full text search

alter table products
add fulltext product_search (name, description);

show create table products;

select * from products;

insert into products (name, category, description, price, quantity)
values ('AIO Xiaomi', 'Peripheral', 'AIO + Keyboard + Monitor', 15000000, 10),
('Keyboard DAXA', 'Peripheral', 'Keyboard Mechanical', 250000, 23);

select * from products
where match(name, description)
	against ('Monitor' in natural language mode);

select * from products
where match(name, description)
	against ('+Monitor -Keyboard' in boolean mode);

select * from products
where match(name, description)
	against ('Keyboard' with query expansion);


-- Table Relationship
	
create table wishlist
(
	id int not null auto_increment,
	id_product int not null,
	description text,
	primary key(id),
	constraint fk_wishlist_product
		foreign key (id_product) references products(id)

) engine = InnoDB;

desc wishlist;

show create table wishlist;

alter table wishlist
drop constraint fk_wishlist_product;

alter table wishlist
add constraint fk_wishlist_product
	foreign key (id_product) references products(id)
		on update cascade;

insert into wishlist (id_product, description)
values (10, 'Produk Kesukaan');

update products
set id = 10
where id = 2;

-- JOIN

select w.id as 'Wishlist ID', p.id as 'Product ID', p.name as 'Product Name', w.description as 'Wishlist Description' 
from wishlist as w
inner join products as p on (w.id_product=p.id);

select w.id as 'Wishlist ID', p.id as 'Product ID', p.name as 'Product Name', w.description as 'Wishlist Description' 
from wishlist as w
right join products as p on (w.id_product=p.id);

select w.id as 'Wishlist ID', p.id as 'Product ID', p.name as 'Product Name', w.description as 'Wishlist Description' 
from wishlist as w
left join products as p on (w.id_product=p.id);

select * from products
cross join wishlist;


desc customer;

alter table wishlist
add column id_customer int not null;

alter table wishlist
modify column id_customer int;

alter table wishlist
add constraint fk_wishlist_customer
	foreign key (id_customer) references customer(id);

select * from wishlist;

desc wishlist;

delete from wishlist
where id = 1;

update wishlist
set id_customer = 1
where id = 3;

select p.id, p.name, w.description, c.first_name from wishlist as w
join products as p on (p.id=w.id_product)
join customer as c on (c.id=w.id_customer);

select * from products;

select * from products
where price > (select avg(price) from products);

select max(price) from products;

select max(cp.price) from (select price from wishlist
join products on (products.id = wishlist.id)) as cp;

-- Set Operator
-- UNION, UNION ALL, INTERSECT, MINUS

select * from customer;


-- TRANSACTION & LOCKING

start transaction;

insert into products (name, description, price, quantity)
values ('SSD', 'SSD 1TB', 2500000, 100);

select * from products;

commit;


start transaction;

delete from products
where id = 11;

select * from products;

rollback;


start transaction;

select * from products;

select * from products where id = 11 for update;

update products
set quantity = quantity - 25
where id = 11;

commit;

-- LOCK Tables READ, WRITE, LOCKING INSTANCE (NO DDL)

lock tables products read;

unlock tables;

lock tables products write;

unlock tables;

lock instance for backup;

unlock instance;

-- Hak Akses User (grant.html)

-- mysql dump for backup

-- mysqldump belajar_mysql --user root --password --result-file=\belajar_mysql.sql (in CLI)
-- mysql --user root --password belajar_mysql_import < /belajar_mysql.sql (in CLI) 

create database belajar_mysql_import_source;

show databases;
use belajar_mysql_import_source;

show tables;

-- source /belajar_mysql.sql; (in CLI)

