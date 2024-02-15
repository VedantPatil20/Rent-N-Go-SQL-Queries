CREATE TABLE roles (
    id INT PRIMARY KEY,
    _name VARCHAR(255) NOT NULL
);

CREATE TABLE userregistration (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    pass_word VARCHAR(255) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE personaldetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profile_picture TEXT,
	mobile_no VARCHAR(15),
	gender CHAR(1),
	dob Date,
	emeregency_contact VARCHAR(15),
	user_id INT,
	Foreign KEY (user_id) REFERENCES userregistration(id)
);

CREATE TABLE useraddress (
	id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(500),
    city VARCHAR(50),
    state VARCHAR(50),
    pin_code VARCHAR(10),
    Foreign KEY (user_id) REFERENCES userregistration(id)
);

Create Table userdocument (
	id INT AUTO_INCREMENT PRIMARY KEY,
    aadhar_card TEXT,
	pan_card TEXT, 
    driving_licence TEXT,
    Foreign KEY (user_id) REFERENCES userregistration(id)
);



