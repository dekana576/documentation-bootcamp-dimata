use belajar_mysql;
show tables;

create table seller
(
	id int not null auto_increment,
	name varchar(100) not null,
	email varchar(50) not null,
	primary key(id),
	unique key email_unique(email),
	index name_index(name)
) engine = InnoDB;

desc seller;