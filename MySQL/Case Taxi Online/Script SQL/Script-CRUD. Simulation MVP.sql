use taxi_online;

-- CRUD Admin (Manage Cars) start

	-- CRUD Types
	
	start transaction;
	
		-- create
		insert into types (type_name)
		values ('SUV'), ('MVP'), ('Seda'), ('LCGC');
		
		-- read
		select * from types;
		
		-- update
		update types
		set type_name = 'Sedan'
		where type_id = '7';
		
		-- delete
		delete from types
		where type_id = '7';
	
	commit;
	
	
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
		where brand_id = 11;
		
		-- delete
		delete from brands
		where brand_id = 17;
	
	commit;
	
	
	-- CRUD Cars

	start transaction;
		
		-- create
		insert into cars (car_name, plate_code, brand_id, type_id)
		values ('Honda CR-V', 'DK12345AA', 14, 9),
		('Toyota Fortuner', 'DK12345AB', 13, 9),
		('Daihatsu Xenia', 'DK12345AC', 16, 10),
		('Honda Mobilio', 'DK12345AD', 14, 10),
		('Suzuki Ertiga', 'DK12345AE', 15, 10),
		('Honda City', 'DK12345AF', 14, 11),
		('Toyota Vios', 'DK12345AG', 13, 11),
		('Toyota Agya', 'DK12345AH', 13, 12),
		('Daihatsu Ayla', 'DK12345AI', 16, 12),
		('Honda Brio', 'DK12345AJ', 14, 12);
		
		-- read
		select * from cars;
		
		-- update
		update cars
		set car_name = 'Honda Brio Satya'
		where car_id =  19;
		
		-- delete
		delete from cars
		where car_id = 19;
		
	commit;
	
-- CRUD Admin (Manage Cars) end

	
	
	
	
-- CRUD Users Driver (Create Account) start

	start transaction;
	
		-- Create Account	
		insert into users (name, gender, address, phone_number, email, password, confirm_password, role)
		values ('Bagus', 'Male', 'Marga - Tabanan', '085738518601', 'dekana576@gmail.com', '1234', '1234', 'Driver');
		
		-- Input Car
		insert into cars (car_name, plate_code, brand_id, type_id)
		values ('Suzuki XL7', 'DK5678GG', 15, 9);
		
		-- Update Account
		update users
		set car_id = 20
		where user_id = 19;
	
	commit;
	
	-- Delete Account
	
	start transaction;
	
		delete from users
		where user_id = 19;
	
	rollback;

-- CRUD Users Driver (Create Account) end
	
	

	
	
	
	
-- CRUD Simulation MVP (Client) start

	start transaction;
	
		
		-- Create Account
		insert into users (name, gender, address, phone_number, email, password, confirm_password, role)
		values ('Putri', 'Female', 'Bali', '0812345', 'putri@gmail.com', '456', '456', 'Client');
		
		-- Order Taxi
		insert into orders (passangers, pickup_loc, destination_loc, total_price, status_order, client_id)
		values (1, 'Living World - Denpasar', 'Padang Sambian', 35000, 'Searching', 20);
		 
		-- Order Accepted
		update orders
		set status_order = 'Accepted',
			driver_id = 19
		where order_id = 5;
		
		-- Arrive at destination
		update orders
		set status_order = 'Completed'
		where order_id = 5;
		
		-- Display Order to Client
		select * from orders
		where order_id = 5;
		
		-- Transaction
		insert into transactions (payment_method, amount, payment_status, order_id)
		values ('Cash', 35000, 'Success', 5);
		
		-- Driver Ratings
		insert into ratings (rating, comment, order_id, client_id, driver_id)
		values (5, 'Nice', 5, 20, 19);
		
		
		
		select
			o.order_id,
			o.order_date,
			t.payment_method as 'Payment Method',
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
		join brands on (c.brand_id=brands.brand_id);

	commit;


	
-- CRUD Simulation MVP (Client) end

	
	

