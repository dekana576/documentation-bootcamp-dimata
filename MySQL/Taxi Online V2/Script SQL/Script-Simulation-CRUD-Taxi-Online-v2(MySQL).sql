use taxi_online_v2;

-- Admin (Manage cars) [start]


	-- 	CRUD types
	
		start transaction;
		
			-- create
			insert into types (type_name)
			values ('SUV'), ('MPV'), ('Seda'), ('LCGC');
			
			-- read
			select * from types;
			
			-- update
			update types
			set type_name = 'Sedan'
			where type_id = '3';
			
		commit;
		
		start transaction;
		
			-- delete
			delete from types
			where type_id = '1';
		
		rollback;
	
	-- CRUD Brands	
	
		start transaction;
		
			-- create
			insert into brands (brand_name)
			values ('Toyota'), ('Honda'), ('Suzki'), ('Daihatsu'), ('Hyundai');
		
			-- read
			select * from brands;
			
			-- update
			update brands
			set brand_name = 'Suzuki'
			where brand_id = 3;
			
		commit;
		
		start transaction;
			
			-- delete
			delete from brands
			where brand_id = 3;
		
		rollback;
		
		
	-- CRUD Cars

		start transaction;
			
			-- create
			insert into cars (car_name, plate_code, brand_id, type_id)
			values ('Honda CR-V', 'DK12345AA', 2, 1),
			('Toyota Fortuner', 'DK12345AB', 1, 1),
			('Daihatsu Xenia', 'DK12345AC', 4, 2),
			('Honda Mobilio', 'DK12345AD', 2, 2),
			('Suzuki Ertiga', 'DK12345AE', 3, 2),
			('Honda City', 'DK12345AF', 2, 3),
			('Toyota Vios', 'DK12345AG', 1, 3),
			('Toyota Agya', 'DK12345AH', 1, 4),
			('Daihatsu Ayla', 'DK12345AI', 4, 4),
			('Honda Brio', 'DK12345AJ', 2, 4);
			
			-- read
			select * from cars;
			
			-- update
			update cars
			set car_name = 'Honda Brio Satya'
			where car_id =  'e997f820-07e4-11f1-b654-4c50dd2fb965';
		
		commit;
		
		-- delete
		start transaction;
		
			delete from cars
			where car_id = 'e997f820-07e4-11f1-b654-4c50dd2fb965';
			
		rollback;
		
		
-- Admin (Manage cars) [end]
		
		
-- Admin (Manage Membership) [start]
	
	start transaction;

		-- create 
		insert into membership (membership_name, min_order)
		values ('Bronze', 750), ('Silver', 1500), ('Gold', 3000), ('Diamond', 6000);
		
		-- read
		select * from membership;
		
		-- update
		update membership
		set membership_name = 'Platinum'
		where membership_id = 4;

	commit;
	
	-- delete
	start transaction;
	
		delete from membership
		where membership_id = 1;
	
	rollback;

-- Admin (Manage Membership) [end]
	

	
-- Users Driver (Create Account) [start]
		
	start transaction;
	
		-- Create Account
		insert into users (name, gender, address, phone_number, email, password, role)
		values ('Bagus', 'Male', 'Marga - Tabanan', '085738518601', 'dekana576@gmail.com', '1234', 'Driver');
		
		-- Display Account
		select * from users
		where user_id = '683b0a18-07e7-11f1-b654-4c50dd2fb965';
		
		-- Input Car
		insert into cars (car_name, plate_code, brand_id, type_id)
		values ('Suzuki XL7', 'DK5678GG', 3, 1);
		
		-- Update Account
		update users
		set car_id = 'f549969f-07e7-11f1-b654-4c50dd2fb965'
		where user_id = '683b0a18-07e7-11f1-b654-4c50dd2fb965';
			
	
		-- Input Driver Document
		insert into driver_document (ktp_number, sim_number, stnk_number, driver_id)
		values ('54021000', '32112312', '87564312', '683b0a18-07e7-11f1-b654-4c50dd2fb965');
		
		
		-- Display Detail Account
		select 
			u.name,
			u.gender,
			u.address,
			u.phone_number,
			u.email,
			c.car_name,
			t.type_name,
			c.plate_code,
			d.ktp_number,
			d.sim_number,
			d.stnk_number,
			d.vertification_status
		from users as u
		join cars as c on (c.car_id = u.car_id)
		join types as t on (t.type_id = c.type_id)
		join driver_document as d on (d.driver_id=u.user_id)
		where u.user_id = '683b0a18-07e7-11f1-b654-4c50dd2fb965'
	
	commit;
	
	-- Delete account
	start transaction;
		
		delete from driver_document
		where driver_id = '683b0a18-07e7-11f1-b654-4c50dd2fb965';
		
		delete from users
		where user_id = '683b0a18-07e7-11f1-b654-4c50dd2fb965';

	rollback;
	
	-- Admin Approve document
	start transaction;
	
		update driver_document
		set vertification_status = 'Approved'
		where driver_id = '683b0a18-07e7-11f1-b654-4c50dd2fb965'; 

	commit;
	
-- Users Driver (Create Account) [end]
	

-- Users Client (Simulation MVP) [start]

	
	-- Create Account
	
	start transaction;
	
		insert into users (name, gender, address, phone_number, email, password, role)
		values ('Putri', 'Female', 'Bali', '0812345', 'putri@gmail.com', '456','Client');
		
		-- Display Account
		select * from users
		where user_id = 'df0da8e3-07eb-11f1-b654-4c50dd2fb965';
	
	commit;
	
-- Order Taxi

	start transaction;
	
		insert into location (pickup_loc, destination_loc, pick_latitude, pick_longitude, dest_latitude, dest_longitude)
		values ('Living World - Denpasar', 'Padang Sambian', -8.635022683110943, 115.2318559247654, -8.667466460618998, 115.18752239184778);
		
		insert into orders (passangers, total_price, status_order, location_id, client_id)
		values (1, 35000, 'Searching', 'd508c9ff-07ec-11f1-b654-4c50dd2fb965', 'df0da8e3-07eb-11f1-b654-4c50dd2fb965');
		
		-- Order Accepted
		update orders
		set status_order = 'Accepted',
		driver_id = '683b0a18-07e7-11f1-b654-4c50dd2fb965'
		where order_id = '66472559-07ed-11f1-b654-4c50dd2fb965';
				
		-- Arrive at destination
		update orders
		set status_order = 'Completed'
		where order_id = '66472559-07ed-11f1-b654-4c50dd2fb965';
				
		-- Display Order to Client
		select * from orders
		where order_id = '66472559-07ed-11f1-b654-4c50dd2fb965';
		
		-- Transaction
		insert into transactions (payment_method, amount, payment_status, order_id)
		values ('Cash', 35000, 'Success', '66472559-07ed-11f1-b654-4c50dd2fb965');
		
		-- Driver Ratings
		insert into ratings (rating, comment, order_id, client_id, driver_id)
		values (5, 'Nice', '66472559-07ed-11f1-b654-4c50dd2fb965', 'df0da8e3-07eb-11f1-b654-4c50dd2fb965', '683b0a18-07e7-11f1-b654-4c50dd2fb965');
		
		-- Display Details
		select
			o.order_id,
			o.order_date,
			t.payment_method as 'Payment Method',
			o.total_price,
			t.payment_status as 'Payment Status',
			u.name as 'Client',
			us.name as 'Driver',
			c.car_name as 'Car',
			types.type_name as 'Car Type',
			brands.brand_name as 'Car Brand',
			r.rating
		from ratings as r
		join orders as o on (o.order_id = r.order_id)
		join transactions as t on (t.order_id = o.order_id)
		join users as u on (r.client_id = u.user_id)
		join users as us on (r.driver_id = us.user_id)
		join cars as c on (c.car_id = us.car_id)
		join types on (c.type_id=types.type_id)
		join brands on (c.brand_id=brands.brand_id)
		where o.order_id = '66472559-07ed-11f1-b654-4c50dd2fb965';
		
	commit;

-- Users Client (Simulation MVP) [end]
	

-- Admin (Make Promotion) [start]
	
	-- Create Promotion
	
	start transaction;
	
		insert into promotions (promo_name, promo_code, disc_type, disc_value, start_date, expired_date, quota)
		values ('New Year Promo', 'NEWYEAR2026', 'Percentage', 20, '2026-01-01', '2026-01-31', 100);
	
	commit;
	
	-- Create Promotion for Membership
	
	start transaction;
	
		insert into promotions (promo_name, promo_code, disc_type, disc_value, start_date, expired_date, quota, membership_id)
		values ('Platinum Membership', 'THEPLATINUM2026', 'Percentage', 15, '2026-01-01', '2027-01-01', 9999, 4);
	
	commit;
	
-- Admin (Make Promotion) [end]
	
	
-- Users Client (Claim Promotion) [start]

	start transaction;
		
		insert into user_promotion (promotion_id, user_id)
		values ('a32aa9b6-07ef-11f1-b654-4c50dd2fb965', 'df0da8e3-07eb-11f1-b654-4c50dd2fb965');
		
	commit;
	
-- Users Client (Claim Promotion) [end]
	
	
	
-- Users Client (Order Taxi with Promo) [start]

	start transaction;
	
		insert into location (pickup_loc, destination_loc, pick_latitude, pick_longitude, dest_latitude, dest_longitude)
		values ('Living World - Denpasar', 'Padang Sambian', -8.635022683110943, 115.2318559247654, -8.667466460618998, 115.18752239184778);
		
		insert into orders (passangers, total_price, status_order, location_id, client_id, promotion_id)
		values (1, 35000, 'Searching', 'c3595dcc-07f1-11f1-b654-4c50dd2fb965', 'df0da8e3-07eb-11f1-b654-4c50dd2fb965', 'a32aa9b6-07ef-11f1-b654-4c50dd2fb965');

		-- Order Accepted
		update orders
		set status_order = 'Accepted',
		driver_id = '683b0a18-07e7-11f1-b654-4c50dd2fb965'
		where order_id = '25ddea97-07f2-11f1-b654-4c50dd2fb965';
				
		-- Arrive at destination
		update orders
		set status_order = 'Completed'
		where order_id = '25ddea97-07f2-11f1-b654-4c50dd2fb965';
		
		-- Display Order to Client
		select 
			o.order_date,
			o.passangers,
			o.total_price,
			o.total_price - (o.total_price * (p.disc_value/100)) as 'Total after Disc',
			o.status_order
		from orders as o
		join promotions as p on (o.promotion_id=p.promotion_id)
		where order_id = '25ddea97-07f2-11f1-b654-4c50dd2fb965';
		
		-- Transaction
		insert into transactions (payment_method, amount, payment_status, order_id)
		values ('Cash', 28000, 'Success', '25ddea97-07f2-11f1-b654-4c50dd2fb965');
		
		-- Driver Ratings
		insert into ratings (rating, comment, order_id, client_id, driver_id)
		values (4, 'Good', '25ddea97-07f2-11f1-b654-4c50dd2fb965', 'df0da8e3-07eb-11f1-b654-4c50dd2fb965', '683b0a18-07e7-11f1-b654-4c50dd2fb965');
		
		-- Display Details
		select
			o.order_id,
			o.order_date,
			t.payment_method as 'Payment Method',
			o.total_price,
			o.total_price - (o.total_price * (p.disc_value/100)) as 'Total after Disc',
			t.payment_status as 'Payment Status',
			u.name as 'Client',
			us.name as 'Driver',
			c.car_name as 'Car',
			types.type_name as 'Car Type',
			brands.brand_name as 'Car Brand',
			r.rating
		from ratings as r
		join orders as o on (o.order_id = r.order_id)
		join transactions as t on (t.order_id = o.order_id)
		join users as u on (r.client_id = u.user_id)
		join users as us on (r.driver_id = us.user_id)
		join cars as c on (c.car_id = us.car_id)
		join types on (c.type_id=types.type_id)
		join brands on (c.brand_id=brands.brand_id)
		join promotions as p on (o.promotion_id=p.promotion_id)
		where o.order_id = '25ddea97-07f2-11f1-b654-4c50dd2fb965';
	commit;
	
-- Users Client (Order Taxi with Promo) [end]??
