use rentngo_rentalservice_db;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    _name VARCHAR(255) UNIQUE NOT NULL
);

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

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
    Foreign KEY (user_id) REFERENCES userregistration(id) ON UPDATE CASCADE ON DELETE CASCADE
);

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

CREATE TABLE cardetails (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(255),
    model VARCHAR(255),
    _year INT,
    transmission_id INT,
    vehicle_category VARCHAR(255),
    fuel VARCHAR(255),
    passenger_capacity INT,
    baggage_capacity INT,
    mileage INT,
    _desc TEXT,
    daily_price DECIMAL(10, 2),
    car_model_images TEXT,
    _status VARCHAR(255),
    FOREIGN KEY (transmission_id) REFERENCES transmission(id) ON UPDATE CASCADE
);

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

CREATE TABLE transmission (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO transmission (id, name) VALUES
(1, 'Automatic'),
(2, 'Manual'),
(3, 'Intelligent Manual Transmission');

select * from transmission;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

CREATE TABLE carbooking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT,
    user_id INT,
    pickup_date VARCHAR(255),
    pickup_time VARCHAR(255),
    return_date VARCHAR(255),
    return_time VARCHAR(255),
    location VARCHAR(255),
    gst DECIMAL(10, 2),
    refundable_deposit DECIMAL(10, 2),
    FOREIGN KEY (car_id) REFERENCES cardetails(car_id),
    FOREIGN KEY (user_id) REFERENCES userregistration(id)
);

select * from carbooking;