create database taxi_online;

use taxi_online;

-- create table types

create table types(
	type_id int not null auto_increment,
	type_name varchar(50) not null,
	primary key(type_id)
) engine = InnoDB;

show tables;

desc types;

show create table types;


-- create table brands

create table brands(
	brand_id int not null auto_increment,
	brand_name varchar(50) not null,
	primary key(brand_id)
) engine = InnoDB;

show tables;

desc brands;

show create table brands;

-- create table cars

create table cars(
	car_id int not null auto_increment,
	car_name varchar(50) not null,
	plate_code varchar(20) not null,
	brand_id int not null,
	type_id int not null,
	primary key(car_id),
	unique key(plate_code),
	constraint fk_cars_brands
		foreign key (brand_id) references brands(brand_id)
		on update cascade,
	constraint fk_cars_types
		foreign key (type_id) references types(type_id)
		on update cascade
) engine = InnoDB;

show tables;

desc cars;

show create table cars;



-- create table users

create table users(

	user_id int not null auto_increment,
	name varchar(75) not null,
	gender enum('Male', 'Female') not null,
	address varchar(100) not null,
	phone_number varchar(20) not null,
	email varchar(50) not null,
	password varchar(50) not null,
	role enum('Admin', 'Driver', 'Client') not null,
	car_id int,
	wallet_id int not null,
	primary key(user_id),
	unique key(email),
	unique key(phone_number),
	unique key(car_id),
	constraint fk_users_cars
		foreign key (car_id) references cars(car_id)
		on update cascade

) engine = InnoDB;

show tables;

desc users;

show create table users;



-- create table wallet

create table wallet(
	wallet_id int not null auto_increment,
	balance int unsigned not null default 0,
	user_id int not null,
	primary key(wallet_id),
	unique key(user_id),
	constraint fk_wallet_users
		foreign key (user_id) references users(user_id)
		on update cascade
) engine = InnoDB;

show tables;

desc wallet;

show create table wallet;



-- create table orders

create table orders(
	order_id int not null auto_increment,
	passangers tinyint unsigned not null default 1,
	pickup_loc varchar(200) not null,
	destination_loc varchar(200) not null,
	total_price int unsigned not null default 0,
	status_order enum('Accepted', 'Canceled', 'Searching', 'Completed') not null,
	client_id int not null,
	driver_id int not null,
	primary key(order_id),
	constraint chk_passangers check (passangers between 1 and 4),
	constraint fk_orders_client
		foreign key (client_id) references users(user_id)
		on update cascade,
	constraint fk_orders_driver
		foreign key (driver_id) references users(user_id)
		on update cascade
		
) engine = InnoDB;

show tables;

desc orders;

show create table orders;


-- create table transaction

create table transactions(
	transaction_id int not null auto_increment,
	amount int unsigned not null,
	payment_status enum('Success', 'Pending', 'Failed') not null,
	order_id int not null,
	primary key(transaction_id),
	unique key(order_id),
	constraint fk_transactions_orders
		foreign key (order_id) references orders(order_id)
		on update cascade
) engine = InnoDB;

show tables;

desc transactions;

show create table transactions;


-- create table ratings

create table ratings(
	rating_id int not null auto_increment,
	rating tinyint unsigned null,
	comment text,
	order_id int not null,
	client_id int not null,
	driver_id int not null,
	primary key(rating_id),
	unique key(order_id),
	constraint chk_ratings check (rating <= 5 OR rating IS null),
	constraint fk_ratings_orders
		foreign key (order_id) references orders(order_id)
		on update cascade,
	constraint fk_ratings_client
		foreign key (client_id) references users(user_id)
		on update cascade,
	constraint fk_ratings_driver
		foreign key (driver_id) references users(user_id)
		on update cascade
) engine = InnoDB;

show tables;

desc ratings;

show create table ratings;





-- INSERT DATA


-- insert data types

desc types;

start transaction;

insert into types (type_name)
values ('SUV'), ('MVP'), ('Sedan'), ('LCGC');

select * from types;

commit;


-- insert data brands

desc brands;

start transaction;

insert into brands (brand_name)
values ('Toyota'), ('Honda'), ('Suzuki'), ('Daihatsu');

select * from brands;

commit;

-- insert data cars

desc cars;

start transaction;

insert into cars (car_name, plate_code, brand_id, type_id)
values ('Honda CR-V', 'DK12345AA', 2, 1),
('Toyota Fortuner', 'DK12345AB', 1, 1),
('Daihatsu Xenia', 'DK12345AC', 4, 2),
('Honda Mobilio', 'DK12345AD', 2, 2),
('Suzuki Ertiga', 'DK12345AE', 3, 2),
('Honda City', 'DK12345AF', 2, 3),
('Toyota Vios', 'DK12345AG', 1, 3),
('Toyota Agya', 'DK12345AH', 1, 4),
('Daihatsu Ayla', 'DK12345AI', 4, 4);

select * from brands;

select * from types;

select * from cars;

select c.car_name, t.type_name, b.brand_name from cars as c
join types as t on (t.type_id=c.type_id)
join brands as b on (b.brand_id=c.brand_id);

commit;


-- insert data users

desc users;

start transaction;

insert into users (name, gender, address, phone_number, email, role, car_id)
values ('Kadek', 'Male', 'Tabanan', '08123', 'kadek@gmail.com', 'Admin', null),
('Bagus', 'Male', 'Denpasar', '08234', 'bagus@gmail.com', 'Driver', 3),
('Dwikayana', 'Male', 'Badung', '08345', 'dwikayan@gmail.com', 'Client', null),
('Yanti', 'Female', 'Gianyar', '085678', 'yanti@gmail.com', 'Driver', 5);

select * from users;

select u.car_id, u.name, c.car_name from users as u
join cars as c on (u.car_id=c.car_id);

commit;



-- insert data wallet

desc wallet;

start transaction;

insert into wallet (balance, user_id)
values (2000000, 14);

select * from wallet;

commit;



-- insert data orders

desc orders;

start transaction;

insert into orders (passangers, pickup_loc, destination_loc, total_price, status_order, client_id, driver_id)
values (3, 'denpasar', 'badung', 30000, 'Accepted', 15, 16),
(4, 'gianyar', 'tabanan', 40000, 'Canceled', 15, 14);

select * from orders;

select u.name, us.name, o.pickup_loc, o.destination_loc, o.total_price from orders as o
join users as u on (o.client_id=u.user_id)
join users as us on (o.driver_id=us.user_id);

commit;



-- insert data transactions

desc transactions;

select * from orders;
start transaction;

insert into transactions (amount, payment_status, order_id)
values (10000, 'Success', 1);

select * from transactions;

commit;



-- insert data ratings

desc ratings;

start transaction;

insert into ratings (rating, comment, order_id, client_id, driver_id)
values (3, 'tes', 1, 15, 16);

select * from orders;

select user_id, role from users;

select * from ratings;

commit;




-- Select data 


use taxi_online;

select o.order_id, u.name as Client, us.name as Driver, r.rating, c.car_name from orders as o
join users as u on (o.client_id=u.user_id)
join users as us on (o.driver_id=us.user_id)
join cars as c on (us.car_id=c.car_id)
join ratings as r on (o.order_id=r.order_id);

select u.name, avg(r.rating) from ratings as r
right join users as u on (r.driver_id=u.user_id) group by u.name;


select * from ratings;

select * from orders;

insert into orders (passangers, pickup_loc, destination_loc, total_price, status_order, client_id, driver_id)
values (1, 'denpasar', 'badung', 10000, 'Accepted', 13, 16);

insert into ratings (rating, comment, order_id, client_id, driver_id)
values (5, 'test2', 3, 13, 16);

show create table ratings;


-- 
alter table users
add confirm_password varchar(50) not null after password;

desc users;

alter table orders
modify column driver_id int;

alter table transactions
add column 

alter table orders
add column order_date timestamp default current_timestamp after order_id;





