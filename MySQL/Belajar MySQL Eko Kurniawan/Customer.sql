use belajar_mysql;
show tables;

create table customer
(
	id int not null auto_increment,
	first_name varchar(50) not null,
	last_name varchar(50),
	email varchar(50) not null,
	primary key(id),
	unique key email_unique(email)
);

desc customer;

insert into customer (first_name,last_name,email)
values ('Bagus', 'Dwikayana', 'dekana576@gmail.com');

select * from customer;