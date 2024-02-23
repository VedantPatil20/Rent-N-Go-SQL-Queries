CREATE TABLE tbl_roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_authentications (
    auth_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    pass_word VARCHAR(255) NOT NULL,
    roles_id INT,
    FOREIGN KEY (roles_id) REFERENCES tbl_roles(role_id) ON UPDATE CASCADE
);

CREATE TABLE tbl_userpersonaldetails (
    usrdtl_id INT AUTO_INCREMENT PRIMARY KEY,
    profile_picture TEXT,
	mobile_no VARCHAR(15) NOT NULL,
	gender CHAR(1) NOT NULL,
	dob Date NOT NULL,
	emeregency_contact VARCHAR(15) NOT NULL,
	auths_id INT,
	Foreign KEY (auths_id) REFERENCES tbl_authentications(auth_id) on update cascade on delete cascade
);

CREATE TABLE tbl_useraddress (
	usraddr_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(500) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    pin_code VARCHAR(10) NOT NULL,
    auths_id INT,
    Foreign KEY (auths_id) REFERENCES tbl_authentications(auth_id) on update cascade on delete cascade
);

Create Table tbl_userdocument (
	usrdoc_id INT AUTO_INCREMENT PRIMARY KEY,
    aadhar_card TEXT,
	pan_card TEXT, 
    driving_licence TEXT,
    auths_id INT,
    Foreign KEY (auths_id) REFERENCES tbl_authentications(auth_id) on update cascade on delete cascade
);

CREATE TABLE tbl_brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_transmission (
    transmission_id INT AUTO_INCREMENT PRIMARY KEY,
    transmission VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_bodytype (
    bodytype_id INT AUTO_INCREMENT PRIMARY KEY,
    body_type VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_carfuel (
    carfuel_id INT AUTO_INCREMENT PRIMARY KEY,
    carfuel VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_seatingcapacity (
    seatcap_id INT AUTO_INCREMENT PRIMARY KEY,
    seat_capacity INT UNIQUE NOT NULL
);

CREATE TABLE tbl_baggagecapacity (
    bagcap_id INT AUTO_INCREMENT PRIMARY KEY,
    bag_capacity INT UNIQUE NOT NULL
);

CREATE TABLE tbl_availability_status (
    avail_stat_id INT AUTO_INCREMENT PRIMARY KEY,
    avail_status VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_location (
    loc_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(255)
);

CREATE TABLE tbl_cardetails (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(255),
    _year INT,
    mileage INT,
    _desc TEXT,
    hourly_price DECIMAL(10, 2),
    car_model_images TEXT,
    brands_id INT,
    transmissions_id INT,
    bodytypes_id INT,
    carfuels_id INT,
    seatcaps_id INT,
    bagcaps_id INT,
    locations_id INT,
    availstatus_id INT,
    FOREIGN KEY (brands_id) REFERENCES tbl_brand(brand_id) ON UPDATE CASCADE,
    FOREIGN KEY (transmissions_id) REFERENCES tbl_transmission(transmission_id) ON UPDATE CASCADE,
    FOREIGN KEY (bodytypes_id) REFERENCES tbl_bodytype(bodytype_id) ON UPDATE CASCADE,
    FOREIGN KEY (carfuels_id) REFERENCES tbl_carfuel(carfuel_id) ON UPDATE CASCADE,
    FOREIGN KEY (seatcaps_id) REFERENCES tbl_seatingcapacity(seatcap_id) ON UPDATE CASCADE,
    FOREIGN KEY (bagcaps_id) REFERENCES tbl_baggagecapacity(bagcap_id) ON UPDATE CASCADE,
    FOREIGN KEY (locations_id) REFERENCES tbl_location(loc_id) ON UPDATE CASCADE,
    FOREIGN KEY (availstatus_id) REFERENCES tbl_availability_status(avail_stat_id) ON UPDATE CASCADE
);

CREATE TABLE tbl_pickupanddroplocation (
    pickdroploc_id INT AUTO_INCREMENT PRIMARY KEY,
    pickupanddroplocation VARCHAR(255)
);

CREATE TABLE tbl_bookingstatus (
    bookstat_id INT AUTO_INCREMENT PRIMARY KEY,
    bookingstatus VARCHAR(255)
);

CREATE TABLE tbl_carbooking (
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
    cars_id INT,
    auths_id INT,
    booking_date VARCHAR(255),
    FOREIGN KEY (location_id) REFERENCES tbl_location(loc_id) ON UPDATE CASCADE,
    FOREIGN KEY (pickup_location_id) REFERENCES tbl_pickupanddroplocation(pickdroploc_id) ON UPDATE CASCADE,
    FOREIGN KEY (dropoff_location_id) REFERENCES tbl_pickupanddroplocation(pickdroploc_id) ON UPDATE CASCADE,
    FOREIGN KEY (booking_status_id) REFERENCES tbl_bookingstatus(bookstat_id) ON UPDATE CASCADE,
    FOREIGN KEY (cars_id) REFERENCES tbl_cardetails(car_id) ON UPDATE CASCADE,
    FOREIGN KEY (auths_id) REFERENCES tbl_authentications(auth_id) ON UPDATE CASCADE
);

CREATE TABLE tbl_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1) CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255),
    content TEXT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    response_from_business TEXT,
    cars_id INT,
    auths_id INT,
    FOREIGN KEY (cars_id) REFERENCES tbl_cardetails(car_id) ON UPDATE CASCADE,
    FOREIGN KEY (auths_id) REFERENCES tbl_authentications(auth_id) ON UPDATE CASCADE
);