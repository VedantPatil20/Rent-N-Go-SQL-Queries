
# stores all authority roles
CREATE TABLE roles (
    id INT PRIMARY KEY,
    _name VARCHAR(255) UNIQUE NOT NULL
);

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
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# Master table for Car Transmission Type (Automatic, Manual, IMT)
CREATE TABLE transmission (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# Master table for Car Type (SUV, Minivans, Compact SUV)
CREATE TABLE bodytype (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# Master table for Car Fuel (Petrol, Diesel, CNG)
CREATE TABLE carfuel (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# Master table for Car DriveTrain (AWD, FWD, RWD, 4WD)
CREATE TABLE drivetrain (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# Master table for Car Seating Capacity (5, 7)
CREATE TABLE seatingcapacity (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# Master table for Car baggage Capacity (2, 3)
CREATE TABLE baggagecapacity (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# Master table for availability status (Available, Rented, Reserved, Maintenance)
CREATE TABLE availability_status (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# Master table for availability status (Black, White, Red, Blue, Green)
CREATE TABLE colours (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE location (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE pickupanddroplocation (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    charges DECIMAL(10, 2)
);

CREATE TABLE bookingstatus (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

# Master table for Bike Fuel (Petrol, Electric)
CREATE TABLE bikefuel (
    id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

# All Car Details
CREATE TABLE cardetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(255),
    _year INT,
    mileage INT,
    _desc TEXT,
    daily_price DECIMAL(10, 2),
    car_model_images TEXT,
    brand_id INT,
    transmission_id INT,
    bodytype_id INT,
    carfuel_id INT,
    drivetrain_id INT,
    seatingcapacity_id INT,
    baggagecapacity_id INT,
    location_id INT,
    availability_status_id INT,
    colours_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (transmission_id) REFERENCES transmission(id),
    FOREIGN KEY (bodytype_id) REFERENCES bodytype(id),
    FOREIGN KEY (carfuel_id) REFERENCES fueltype(id),
    FOREIGN KEY (drivetrain_id) REFERENCES drivetrain(id),
    FOREIGN KEY (seatingcapacity_id) REFERENCES seatingcapacity(id),
    FOREIGN KEY (baggagecapacity_id) REFERENCES baggagecapacity(id),
    FOREIGN KEY (location_id) REFERENCES location(id),
    FOREIGN KEY (availability_status_id) REFERENCES availability_status(id),
    FOREIGN KEY (colours_id) REFERENCES colours(id)
);

# All car booking details table
CREATE TABLE carbooking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
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
    booking_date DATE DEFAULT NOW(),
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

#-------------------------------------------#
## Bike Section ##
#-------------------------------------------#

# All Bike Details
CREATE TABLE bikedetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(255),
    _year INT,
    mileage INT,
    _desc TEXT,
    daily_price DECIMAL(10, 2),
    bike_model_images TEXT,
    brand_id INT,
    transmission_id INT,
    bodytype_id INT,
    fueltype_id INT,
    drivetrain_id INT,
    seatingcapacity_id INT,
    baggagecapacity_id INT,
    location_id INT,
    availability_status_id INT,
    colours_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (transmission_id) REFERENCES transmission(id),
    FOREIGN KEY (bodytype_id) REFERENCES bodytype(id),
    FOREIGN KEY (fueltype_id) REFERENCES fueltype(id),
    FOREIGN KEY (drivetrain_id) REFERENCES drivetrain(id),
    FOREIGN KEY (seatingcapacity_id) REFERENCES seatingcapacity(id),
    FOREIGN KEY (baggagecapacity_id) REFERENCES baggagecapacity(id),
    FOREIGN KEY (location_id) REFERENCES location(id),
    FOREIGN KEY (availability_status_id) REFERENCES availability_status(id),
    FOREIGN KEY (colours_id) REFERENCES colours(id)
);

# All motorcycle booking details table
CREATE TABLE motorcyclebooking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
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
    bike_id INT,
    user_id INT,
    booking_date DATE DEFAULT NOW(),
    FOREIGN KEY (pickup_location_id) REFERENCES pickupanddroplocation(id),
    FOREIGN KEY (dropoff_location_id) REFERENCES pickupanddroplocation(id),
    FOREIGN KEY (booking_status_id) REFERENCES bookingstatus(id),
    FOREIGN KEY (car_id) REFERENCES cardetails(id),
    FOREIGN KEY (user_id) REFERENCES userregistration(id)
);