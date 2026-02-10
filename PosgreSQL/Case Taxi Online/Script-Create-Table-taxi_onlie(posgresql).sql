-- \c for use database (CLI)
-- \dt for show tables (CLI)


select * from pg_tables where schemaname= 'public';


--create table types

	create table types(
		type_id serial primary key,
		type_name varchar(50) not null
	);
	
	--\d for describe table (CLI)



--create table brands

	create table brands (
	    brand_id serial primary key,
	    brand_name VARCHAR(50) not null
	);


--create table cars

	create table cars (
		car_id serial primary key,
		car_name varchar(50) not null,
		plate_code varchar(20) not null unique,
		brand_id int not null,
		type_id int not null,
		constraint fk_cars_brands
			foreign key (brand_id) references brands(brand_id)
			on update cascade,
		constraint fk_cars_types
			foreign key (type_id) references types(type_id)
			on update cascade
	);
	
	
--create table cars
	
	create type users_gender as enum ('Male', 'Female');
	
	create type users_role as enum ('Admin', 'Client', 'Driver');
	
	create table users(
		user_id serial primary key,
		name varchar(75) not null,
		gender users_gender not null,
		address varchar(100) not null,
		phone_number varchar(20) not null unique,
		email varchar(50) not null unique,
		password varchar(50) not null,
		confirm_password varchar(50) not null,
		role users_role not null,
		car_id int unique,
		constraint fk_users_cars
			foreign key (car_id) references cars(car_id)
			on update cascade
	);


	
--create table wallet
	
	create table wallet(
		wallet_id serial primary key,
		balance int not null default 0,
		user_id int not null unique,
		constraint chk_wallet_balance check (balance >= 0),
		constraint fk_wallet_users
			foreign key (user_id) references users(user_id)
			on update cascade
	);
	

--create table orders
	
	create type orders_status as enum ('Accepted', 'Canceled', 'Searching', 'Completed');
	
	create table orders(
		order_id serial primary key,
		order_date timestamp default current_timestamp,
		passangers smallint not null default 1,
		pickup_loc varchar(200) not null,
		destination_loc varchar(200) not null,
		total_price int not null default 0,
		status_order orders_status not null,
		client_id int not null,
		driver_id int,
		constraint chk_passangers check(passangers between 1 and 4),
		constraint chk_total_price check(total_price >= 0),
		constraint fk_orders_client
			foreign key(client_id) references users(user_id)
			on update cascade,
		constraint fk_orders_driver
			foreign key(driver_id) references users(user_id)
			on update cascade
	);


--create table transactions
	
	create type transactions_payment_method as enum ('Cash', 'Bank', 'E-Wallet');
	
	create type transactions_payment_status as enum ('Success', 'Pending', 'Failed');
	
	create table transactions(
		transaction_id serial primary key,
		payment_method transactions_payment_method not null,
		amount int not null,
		payment_status transactions_payment_status not null,
		order_id int not null unique,
		constraint chk_amount check(amount >= 0),
		constraint fk_transactions_orders
			foreign key(order_id) references orders(order_id)
			on update cascade
	);

	
--create table ratings
	
	create table ratings(
		rating_id serial primary key,
		rating smallint,
		comment text,
		order_id int not null unique,
		client_id int not null,
		driver_id int not null,
		constraint chk_rating check((rating >=0 and rating <=5) or (rating is null)),
		constraint fk_ratings_orders
			foreign key(order_id) references orders(order_id)
			on update cascade,
		constraint fk_ratings_client
			foreign key(client_id) references users(user_id)
			on update cascade,
		constraint fk_ratings_driver
			foreign key(driver_id) references users(user_id)
			on update cascade	
	);
	

