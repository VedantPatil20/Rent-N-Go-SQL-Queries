use rentngo_rentalservice_db;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

CREATE TABLE roles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL
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
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

select * from roles;

INSERT INTO roles (role_id, role_name) VALUES (1, 'SuperAdmin');
INSERT INTO roles (role_id, role_name) VALUES (2, 'Admin');
INSERT INTO roles (role_id, role_name) VALUES (3, 'User');

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