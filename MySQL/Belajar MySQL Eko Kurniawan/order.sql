use belajar_mysql;

show tables;

create table orders
(
	id int not null auto_increment,
	total int not null,
	order_date datetime not null default current_timestamp,
	primary key(id)
	
) engine = InnoDB;

desc orders;

create table order_detail
(
	id_product int not null ,
	id_order int not null,
	quantity int not null,
	price int not null,
	primary key (id_product, id_order)
) engine = InnoDB;

desc order_detail;

alter table order_detail
add constraint fk_order_detail_product
	foreign key (id_product) references products(id)
		on update cascade,
add constraint fk_order_detail_order
	foreign key (id_order) references orders(id)
		on update cascade;

show create table order_detail;

select * from orders;

insert into orders (total) values (1000000);
	
insert into order_detail (id_product, id_order, quantity, price)
values (6, 1, 1, 1000000);

select * from products;