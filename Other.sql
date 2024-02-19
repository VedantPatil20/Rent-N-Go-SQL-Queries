SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;

# stores all authority roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    _name VARCHAR(255) UNIQUE NOT NULL
);

select * from roles;

INSERT INTO roles (id, _name) VALUES (1, 'SuperAdmin');
INSERT INTO roles (id, _name) VALUES (2, 'Admin');
INSERT INTO roles (id, _name) VALUES (3, 'User');

# user and admin register table
CREATE TABLE userregistration (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    pass_word VARCHAR(255) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE userregistration (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    pass_word VARCHAR(255) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON UPDATE CASCADE
);

# users personal details with profile picture
CREATE TABLE userpersonaldetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profile_picture TEXT,
	mobile_no VARCHAR(15) NOT NULL,
	gender CHAR(1) NOT NULL,
	dob Date NOT NULL,
	emeregency_contact VARCHAR(15) NOT NULL,
	user_id INT,
	Foreign KEY (user_id) REFERENCES userregistration(id)
);

# user's address
CREATE TABLE useraddress (
	id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(500) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    pin_code VARCHAR(10) NOT NULL,
    user_id INT,
    Foreign KEY (user_id) REFERENCES userregistration(id)
);

# user's personal document
Create Table userdocument (
	id INT AUTO_INCREMENT PRIMARY KEY,
    aadhar_card TEXT,
	pan_card TEXT, 
    driving_licence TEXT,
    user_id INT,
    Foreign KEY (user_id) REFERENCES userregistration(id)
);

#-------------------------------------------#
## Car Section ##
#-------------------------------------------#

# Master table for Car Brand (Tata, Maruti Suzuki, Mahindra)
CREATE TABLE brand (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO brand (name) VALUES
('Tata'),
('Jeep'),
('Ford'),
('Volkswagen'),
('Skoda'),
('Mahindra'),
('Suzuki'),
('Hyundai'),
('Nissan'),
('Kia'),
('Toyota'),
('Honda'),
('Renault'),
('MG'),
('Citroen');

DELIMITER //

CREATE PROCEDURE GetBrand ()
BEGIN
    SELECT * FROM brand;
END //

DELIMITER ;

call GetBrand();

#-------------------------------------------------------------#

# Master table for Car Transmission Type (Automatic, Manual, IMT)
CREATE TABLE transmission (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO transmission (name) VALUES
('Automatic'),
('Manual'),
('Intelligent Manual Transmission');

select * from transmission;

DELIMITER //

CREATE PROCEDURE GetTransmissions()
BEGIN
    SELECT * FROM transmission;
END //

DELIMITER ;

call GetTransmissions();

#-------------------------------------------------------------#

# Master table for Car Type (SUV, Minivans, Compact SUV)
CREATE TABLE bodytype (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO bodytype (name) VALUES
('SUV'),
('Sedan'),
('Hatchback'),
('MUV'),
('Compact SUV');

DELIMITER //

CREATE PROCEDURE GetBodyTypes()
BEGIN
    SELECT * FROM bodytype;
END //

DELIMITER ;

call GetBodyTypes();

#-------------------------------------------------------------#

# Master table for Car Fuel (Petrol, Diesel, CNG)
CREATE TABLE carfuel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO carfuel (name) VALUES
('Petrol'),
('Diesel'),
('CNG');

DELIMITER //

CREATE PROCEDURE GetCarFuel()
BEGIN
    SELECT * FROM carfuel;
END //

DELIMITER ;

call GetCarFuel();

# Master table for Car Seating Capacity (5, 7)
CREATE TABLE seatingcapacity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seat_capacity INT UNIQUE NOT NULL
);

INSERT INTO seatingcapacity (seat_capacity) VALUES
(5),
(7);

DELIMITER //

CREATE PROCEDURE GetSeatingCapacity()
BEGIN
    SELECT * FROM seatingcapacity;
END //

DELIMITER ;

call GetSeatingCapacity();

# Master table for Car baggage Capacity (2, 3)
CREATE TABLE baggagecapacity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bag_capacity INT UNIQUE NOT NULL
);

INSERT INTO baggagecapacity (bag_capacity) VALUES
(2),
(3);

DELIMITER //

CREATE PROCEDURE GetBaggageCapacity()
BEGIN
    SELECT * FROM baggagecapacity;
END //

DELIMITER ;

call GetBaggageCapacity();

# Master table for availability status (Available, Rented, Reserved, Maintenance)
CREATE TABLE availability_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO availability_status (name) VALUES
('Available'),
('Requested'),
('Rented');

DELIMITER //

CREATE PROCEDURE GetAvailabilityStatus()
BEGIN
    SELECT * FROM availability_status;
END //

DELIMITER ;

call GetAvailabilityStatus();

CREATE TABLE location (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO location (name) VALUES
('Mumbai'),
('Thane'),
('Navi Mumbai'),
('Panvel');

DELIMITER //

CREATE PROCEDURE GetLocation()
BEGIN
    SELECT * FROM location;
END //

DELIMITER ;

call GetLocation();

CREATE TABLE pickupanddroplocation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE bookingstatus (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

# All Car Details
CREATE TABLE cardetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(255),
    _year INT,
    mileage INT,
    _desc TEXT,
    hourly_price DECIMAL(10, 2),
    car_model_images TEXT,
    brand_id INT,
    transmission_id INT,
    bodytype_id INT,
    carfuel_id INT,
    seatingcapacity_id INT,
    baggagecapacity_id INT,
    location_id INT,
    availability_status_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (transmission_id) REFERENCES transmission(id),
    FOREIGN KEY (bodytype_id) REFERENCES bodytype(id),
    FOREIGN KEY (carfuel_id) REFERENCES carfuel(id),
    FOREIGN KEY (seatingcapacity_id) REFERENCES seatingcapacity(id),
    FOREIGN KEY (baggagecapacity_id) REFERENCES baggagecapacity(id),
    FOREIGN KEY (location_id) REFERENCES location(id),
    FOREIGN KEY (availability_status_id) REFERENCES availability_status(id)
);

DELIMITER //

CREATE PROCEDURE AddNewCar(
    IN p_model VARCHAR(255),
    IN p_year INT,
    IN p_mileage INT,
    IN p_desc TEXT,
    IN p_hourly_price DECIMAL(10, 2),
    IN p_car_model_images TEXT,
    IN p_brand_id INT,
    IN p_transmission_id INT,
    IN p_bodytype_id INT,
    IN p_carfuel_id INT,
    IN p_seatingcapacity_id INT,
    IN p_baggagecapacity_id INT,
    IN p_location_id INT,
    IN p_availability_status_id INT
)
BEGIN
    INSERT INTO cardetails (
    model, _year, mileage, _desc, daily_price, car_model_images, 
    brand_id, transmission_id, bodytype_id, carfuel_id, seatingcapacity_id, 
    baggagecapacity_id, location_id, availability_status_id
) 
VALUES (
    p_model, p_year, p_mileage, p_desc, p_daily_price, p_car_model_images, 
    p_brand_id, p_transmission_id, p_bodytype_id, p_carfuel_id, p_seatingcapacity_id, 
    p_baggagecapacity_id, p_location_id, p_availability_status_id
);
END //

DELIMITER ;

# All car booking details table
CREATE TABLE carbooking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT,
    pickup_location_id INT,
    pickup_date VARCHAR(255),
    pickup_time VARCHAR(255),
    dropoff_location_id INT,
    dropoff_date VARCHAR(255),
    dropoff_time VARCHAR(255),
    rental_charges DECIMAL(10, 2),
    gst DECIMAL(10, 2),
    refundable_deposit DECIMAL(10, 2),
    total_amount DECIMAL(10, 2),
    booking_status_id INT,
    car_id INT,
    user_id INT,
    booking_date VARCHAR(255),
    FOREIGN KEY (location_id) REFERENCES location(id),
    FOREIGN KEY (pickup_location_id) REFERENCES pickupanddroplocation(id),
    FOREIGN KEY (dropoff_location_id) REFERENCES pickupanddroplocation(id),
    FOREIGN KEY (booking_status_id) REFERENCES bookingstatus(id),
    FOREIGN KEY (car_id) REFERENCES cardetails(id),
    FOREIGN KEY (user_id) REFERENCES userregistration(id)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1) CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255),
    content TEXT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    response_from_business TEXT,
    car_id INT,
    user_id INT,
    FOREIGN KEY (car_id) REFERENCES cardetails(id),
    FOREIGN KEY (user_id) REFERENCES userregistration(id)
);