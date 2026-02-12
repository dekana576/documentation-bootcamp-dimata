create database taxi_online_v2;

use taxi_online_v2;

show tables;

-- create table types

	create table types(
		type_id int not null auto_increment,
		type_name varchar(50) not null,
		primary key(type_id)
	) engine = InnoDB;
	
	desc types;

-- create table brands
	
	create table brands(
		brand_id int auto_increment not null,
		brand_name varchar(50) not null,
		primary key(brand_id)
	) engine = InnoDB;
	
	desc brands;
	
-- create table cars
	
	create table cars(
		car_id char(36) not null default (uuid()),
		car_name varchar(50) not null,
		plate_code varchar(20) not null,
		brand_id int not null,
		type_id int not null,
		primary key(car_id),
		unique(plate_code),
		constraint fk_cars_brands
			foreign key(brand_id) references brands(brand_id),
		constraint fk_cars_types
			foreign key(type_id) references types(type_id)
	) engine = InnoDB;
	
	desc cars;

-- create table membership
	
	create table membership(
		membership_id int not null auto_increment,
		membership_name varchar(25) not null ,
		min_order int not null,
		primary key(membership_id)
	) engine = InnoDB;
	
	desc membership;

	
-- create table users

	create table users(
		user_id char(36) not null default (uuid()),
		name varchar(75) not null,
		gender enum('Male', 'Female') not null,
		address varchar(100) not null,
		phone_number varchar(20) not null,
		email varchar(50) not null,
		password varchar(50) not null,
		role enum('Admin', 'Client', 'Driver') not null,
		car_id char(36),
		membership_id int,
		primary key(user_id),
		unique(phone_number),
		unique(email),
		constraint fk_users_cars
			foreign key(car_id) references cars(car_id),
		constraint fk_users_membership
			foreign key(membership_id) references membership(membership_id)
	) engine = InnoDB;

	desc users;
	

-- create table driver_document
	
	create table driver_document(
		document_id char(36) not null default (uuid()),
		ktp_number varchar(20) not null,
		sim_number varchar(20) not null,
		stnk_number varchar(10) not null,
		vertification_status enum('Pending', 'Approved', 'Rejected') default 'Pending',
		driver_id char(36) not null,
		primary key(document_id),
		unique(ktp_number),
		unique(sim_number),
		unique(stnk_number),
		unique(driver_id),
		constraint fk_driver_document_driver_id
			foreign key (driver_id) references users(user_id)
	) engine = InnoDB;
	
	desc driver_document;
	

-- create table promotions
	
	create table promotions(
		promotion_id char(36) not null default (uuid()),
		promo_name varchar(25) not null,
		promo_code varchar(20) not null,
		disc_type enum('Percentage', 'Fixed') not null,
		disc_value int not null,
		start_date date not null,
		expired_date date not null,
		quota int not null,
		is_active boolean not null default true,
		created_at timestamp not null default current_timestamp,
		membership_id int,
		primary key(promotion_id),
		unique(promo_code),
		constraint fk_promotions_membership
			foreign key(membership_id) references membership(membership_id)
			
	) engine = InnoDB;
	
	desc promotions;
	
	
-- create table user promotion
	
	create table user_promotion(
		promotion_id char(36) not null,
		user_id char(36) not null,
		created_at timestamp not null default current_timestamp,
		primary key(promotion_id, user_id),
		constraint fk_user_promotion_promotions
			foreign key (promotion_id) references promotions(promotion_id),
		constraint fk_user_promotion_users
			foreign key (user_id) references users(user_id)
		
	) engine = InnoDB;
	
	desc user_promotion;
	
	

-- create table location
	
	create table location(
		location_id char(36) not null default (uuid()),
		pickup_loc varchar(200) not null,
		destination_loc varchar(200) not null,
		pick_latitude double not null,
		pick_longitude double not null,
		dest_latitude double not null,
		dest_longitude double not null,
		primary key(location_id)
		
	) engine = InnoDB;
	
	desc location;
	
-- create table orders
	
	create table orders(
		order_id char(36) not null default (uuid()),
		order_date timestamp not null default current_timestamp,
		passangers int not null default 1,
		total_price int unsigned not null default 0,
		status_order enum('Accepted', 'Canceled', 'Searching', 'Completed') not null,
		location_id char(36) not null,
		client_id char(36) not null,
		driver_id char(36),
		promotion_id char(36),
		primary key(order_id),
		unique(location_id),
		constraint chk_passangers check(passangers between 1 and 4),
		constraint fk_orders_location
			foreign key(location_id) references location(location_id),
		constraint fk_orders_client
			foreign key(client_id) references users(user_id),
		constraint fk_orders_driver
			foreign key(driver_id) references users(user_id),
		constraint fk_orders_promotion
			foreign key(promotion_id) references promotions(promotion_id)
	) engine = InnoDB;
	
	desc orders;
	

-- create table transactions
	
	create table transactions(
		transaction_id char(36) not null default (uuid()),
		payment_method enum('Cash', 'Bank', 'E-Wallet') not null,
		amount int unsigned not null,
		payment_status enum('Success', 'Pending', 'Failed') not null,
		paid_at timestamp not null default current_timestamp,
		order_id char(36) not null,
		primary key(transaction_id),
		unique(order_id),
		constraint fk_transactions_orders
			foreign key(order_id) references orders(order_id)
	) engine = InnoDB;
	
	desc transactions;
	

-- create table ratings
	
	create table ratings(
		rating_id char(36) not null default (uuid()),
		rating tinyint unsigned,
		comment text,
		order_id char(36) not null,
		client_id char(36) not null,
		driver_id char(36) not null,
		primary key(rating_id),
		unique(order_id),
		constraint chk_rating check((rating between 0 and 5) or (rating is null) ),
		constraint fk_ratings_orders
			foreign key(order_id) references orders(order_id),
		constraint fk_ratings_client
			foreign key(client_id) references users(user_id),
		constraint fk_ratings_driver
			foreign key(driver_id) references users(user_id)
			
	) engine = InnoDB;
	
	desc ratings;
	
