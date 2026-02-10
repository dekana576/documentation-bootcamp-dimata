use belajar_mysql;
show tables;


create table admin(
id int not null auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
primary key(id)
) engine = InnoDB;

desc admin;

insert into admin (first_name, last_name)
values ('Bagus', 'Dwikayana');

select * from admin;

select last_insert_id();


alter table admin
add column  email varchar(50) not null,
add unique key (email);

alter table admin
add constraint email_unique unique(email);

show create table admin;

alter table admin
drop constraint email;