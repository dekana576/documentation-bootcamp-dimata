-- CRUD Admin (Manage Cars) start

	-- CRUD Types
	
	start transaction;
	
		-- create
		insert into types (type_name)
		values ('SUV'), ('MVP'), ('Seda'), ('LCGC');
		
		-- read
		select * from types order by type_id asc;
		
		-- update
		update types
		set type_name = 'Sedan'
		where type_id = '4';
	
	commit;
	
	start transaction;
	
		-- delete
		delete from types
		where type_id = '4';
	
	rollback;
	
	
	-- CRUD Brands	
	
	start transaction;
	
		-- create
		insert into brands (brand_name)
		values ('Toyota'), ('Honda'), ('Suzki'), ('Daihatsu'), ('Hyundai');
	
		-- read
		select * from brands order by brand_id asc;
		
		-- update
		update brands
		set brand_name = 'Suzuki'
		where brand_id = 4;
		
		-- delete
		delete from brands
		where brand_id = 6;
	
	commit;
	
	
	-- CRUD Cars

	start transaction;
		
		-- create
		insert into cars (car_name, plate_code, brand_id, type_id)
		values ('Honda CR-V', 'DK12345AA', 3, 2),
		('Toyota Fortuner', 'DK12345AB', 2, 2),
		('Daihatsu Xenia', 'DK12345AC', 5, 3),
		('Honda Mobilio', 'DK12345AD', 3, 3),
		('Suzuki Ertiga', 'DK12345AE', 4, 3),
		('Honda City', 'DK12345AF', 3, 4),
		('Toyota Vios', 'DK12345AG', 2, 4),
		('Toyota Agya', 'DK12345AH', 2, 5),
		('Daihatsu Ayla', 'DK12345AI', 5, 5),
		('Honda Brio', 'DK12345AJ', 3, 5);
		
		-- read
		select * from cars;
		
		-- update
		update cars
		set car_name = 'Honda Brio Satya'
		where car_id =  21;
	
	start transaction;
	
		-- delete
		delete from cars
		where car_id = 21;
		
	rollback;
		
	commit;
	
-- CRUD Admin (Manage Cars) end

	
	
	
	
-- CRUD Users Driver (Create Account) start

	start transaction;
	
		-- Create Account	
		insert into users (name, gender, address, phone_number, email, password, confirm_password, role)
		values ('Bagus', 'Male', 'Marga - Tabanan', '085738518601', 'dekana576@gmail.com', '1234', '1234', 'Driver');
		
		select * from users;
		
		-- Input Car
		insert into cars (car_name, plate_code, brand_id, type_id)
		values ('Suzuki XL7', 'DK5678GG', 4, 2);
		
		select * from cars;
		
		-- Update Account
		update users
		set car_id = 22
		where user_id = 2;
	
	commit;
	
	-- Delete Account
	
	start transaction;
	
		delete from users
		where user_id = 2;
	
	rollback;

-- CRUD Users Driver (Create Account) end
	
	

	
	
	
	
-- CRUD Simulation MVP (Client) start

	start transaction;
	
		
		-- Create Account
		insert into users (name, gender, address, phone_number, email, password, confirm_password, role)
		values ('Putri', 'Female', 'Bali', '0812345', 'putri@gmail.com', '456', '456', 'Client');
		
		select * from users;
	
		-- Order Taxi
		insert into orders (passangers, pickup_loc, destination_loc, total_price, status_order, client_id)
		values (1, 'Living World - Denpasar', 'Padang Sambian', 35000, 'Searching', 7);
		
		select * from orders;
		 
		-- Order Accepted
		update orders
		set status_order = 'Accepted',
			driver_id = 2
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
		
		select * from transactions;
		
		-- Driver Ratings
		insert into ratings (rating, comment, order_id, client_id, driver_id)
		values (5, 'Nice', 5, 7, 2);
		
		
		
		
		select
			o.order_id,
			o.order_date,
			t.payment_method as Payment_Method,
			t.payment_status as Payment_Status,
			u.name as Client,
			us.name as Driver,
			c.car_name,
			r.rating
		from ratings as r
		join orders as o on (o.order_id = r.order_id)
		join transactions as t on (t.order_id = o.order_id)
		join users as u on (r.client_id = u.user_id)
		join users as us on (r.driver_id = us.user_id)
		join cars as c on (c.car_id = us.car_id);
		

	commit;


	
-- CRUD Simulation MVP (Client) end

	
	