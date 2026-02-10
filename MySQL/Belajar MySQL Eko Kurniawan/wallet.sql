use belajar_mysql;
show tables;

create table wallet
(
	id int not null auto_increment,
	id_customer int not null,
	balance int not null default 0,
	primary key(id),
	unique key(id_customer),
	foreign key fk_wallet_customer (id_customer) references customer(id)
) engine = InnoDB;

desc customer;

desc wallet;

select * from customer;

insert into wallet (id_customer, balance)
values (1, 1000000);

select * from wallet;

show create table wallet;

alter table wallet
drop constraint wallet_ibfk_1;

alter table wallet
add constraint fk_wallet_customer
	foreign key (id_customer) references customer(id)
		on update cascade;


select c.email, c.first_name, w.balance from wallet as w
join customer as c on (w.id_customer=c.id);