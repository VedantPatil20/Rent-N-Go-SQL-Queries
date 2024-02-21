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
    FOREIGN KEY (roles_id) REFERENCES roles(role_id) ON UPDATE CASCADE
);

CREATE TABLE tbl_userpersonaldetails (
    usrdtl_id INT AUTO_INCREMENT PRIMARY KEY,
    profile_picture TEXT,
	mobile_no VARCHAR(15) NOT NULL,
	gender CHAR(1) NOT NULL,
	dob Date NOT NULL,
	emeregency_contact VARCHAR(15) NOT NULL,
	auths_id INT,
	Foreign KEY (auths_id) REFERENCES userregistration(auth_id)
);

CREATE TABLE tbl_useraddress (
	usraddr_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(500) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    pin_code VARCHAR(10) NOT NULL,
    auths_id INT,
    Foreign KEY (auths_id) REFERENCES userregistration(auth_id)
);

Create Table tbl_userdocument (
	usrdoc_id INT AUTO_INCREMENT PRIMARY KEY,
    aadhar_card TEXT,
	pan_card TEXT, 
    driving_licence TEXT,
    auths_id INT,
    Foreign KEY (auths_id) REFERENCES userregistration(auth_id)
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
    FOREIGN KEY (brands_id) REFERENCES brand(brand_id),
    FOREIGN KEY (transmissions_id) REFERENCES transmission(transmission_id),
    FOREIGN KEY (bodytypes_id) REFERENCES bodytype(bodytype_id),
    FOREIGN KEY (carfuels_id) REFERENCES carfuel(carfuel_id),
    FOREIGN KEY (seatcaps_id) REFERENCES seatingcapacity(seatingcapacityid),
    FOREIGN KEY (bagcaps_id) REFERENCES baggagecapacity(baggagecapacityid),
    FOREIGN KEY (locations_id) REFERENCES location(locationid),
    FOREIGN KEY (availstatus_id) REFERENCES availability_status(availability_status_id)
);

CREATE TABLE tbl_brand (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_transmission (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transmission_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_bodytype (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transmission_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_carfuel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transmission_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_seatingcapacity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seat_capacity INT UNIQUE NOT NULL
);

CREATE TABLE tbl_baggagecapacity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bag_capacity INT UNIQUE NOT NULL
);

CREATE TABLE tbl_availabilitystatus (
    id INT AUTO_INCREMENT PRIMARY KEY,
    avail_status VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE tbl_location (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(255)
);
