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
	order_date timestamp default current_timestamp,
	passangers tinyint unsigned not null default 1,
	pickup_loc varchar(200) not null,
	destination_loc varchar(200) not null,
	total_price int unsigned not null default 0,
	status_order enum('Accepted', 'Canceled', 'Searching', 'Completed') not null,
	client_id int not null,
	driver_id int,
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
	payment_method enum('Cash', 'Bank', 'E-Wallet') not null,
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