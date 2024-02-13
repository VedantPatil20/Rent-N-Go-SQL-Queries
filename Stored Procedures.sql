use rentngo_rentalservice_db;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE RegisterNewActor(
    IN p_firstname VARCHAR(255),
    IN p_lastname VARCHAR(255),
    IN p_email VARCHAR(320),
    IN p_password VARCHAR(255),
    IN p_role_id INT
)
BEGIN
    INSERT INTO userregistration (first_name, last_name, email_address, pass_word, role_id)
    VALUES (p_firstname, p_lastname, p_email, SHA2(p_password, 256), p_role_id);
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE GetRegistrationRecords()
BEGIN
    SELECT userregistration.*, roles.role_name 
    FROM userregistration 
    INNER JOIN roles ON userregistration.role_id = roles.role_id;
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE CheckEmailExists(
    IN p_email VARCHAR(320),
    IN p_id INT
)
BEGIN
    DECLARE emailExists BOOLEAN;
    
    IF p_id IS NULL THEN
        SELECT EXISTS(
            SELECT 1 FROM userregistration WHERE email_address = p_email
        ) INTO emailExists;
    ELSE
        SELECT EXISTS(
            SELECT 1 FROM userregistration WHERE email_address = p_email AND id != p_id
        ) INTO emailExists;
    END IF;
    SELECT emailExists AS IsExists;
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE GetRegisteredRecordByEmail(
    IN p_email VARCHAR(255)
)
BEGIN
    SELECT userregistration.*, roles.role_name 
    FROM userregistration 
    INNER JOIN roles ON userregistration.role_id = roles.role_id
    WHERE userregistration.email_address = p_email;
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE VerifyPassword(
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT SHA2(p_password, 256);
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //
CREATE PROCEDURE GetRegisteredRecordsByRole(
        IN p_role_name varchar(50)
)
BEGIN
  SELECT * FROM userregistration 
  INNER JOIN roles ON userregistration.role_id = roles.role_id 
  WHERE roles.role_name = p_role_name;
END //
DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE GetRegisteredRecordsById(
	IN p_id INT
)
BEGIN
    SELECT userregistration.*, roles.role_name 
    FROM userregistration 
    INNER JOIN roles ON userregistration.role_id = roles.role_id
    WHERE userregistration.id = p_id;
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE UpdateExistingActor(
	IN p_id INT, 
    IN p_firstname VARCHAR(255), 
    IN p_lastname VARCHAR(255), 
    IN p_email VARCHAR(320), 
    IN p_role_id INT)
BEGIN
  UPDATE userregistration 
  SET first_name = p_firstname, 
      last_name = p_lastname, 
      email_address = p_email, 
      role_id = p_role_id
  WHERE id = p_id;
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //
CREATE PROCEDURE DeleteExistingActor(
        IN p_id INT
)
BEGIN
  DELETE FROM userregistration WHERE id = p_id;
END //
DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE AddNewCar(
    IN p_brand VARCHAR(255),
    IN p_model VARCHAR(255),
    IN p_year INT,
    IN p_vehicle_category VARCHAR(255),
    IN p_transmission VARCHAR(255),
    IN p_fuel VARCHAR(255),
    IN p_passenger_capacity INT,
    IN p_baggage_capacity INT,
    IN p_mileage INT,
    IN p_desc TEXT,
    IN p_daily_price DECIMAL(10, 2),
    IN p_car_model_images TEXT,
    IN p_status VARCHAR(255)
)
BEGIN
    INSERT INTO cardetails (
    brand, model, _year, vehicle_category, transmission, fuel, 
    passenger_capacity, baggage_capacity, mileage, _desc, daily_price, car_model_images, _status
) 
VALUES (
    p_brand, p_model, p_year, p_vehicle_category, p_transmission, p_fuel, 
    p_passenger_capacity, p_baggage_capacity, p_mileage, p_desc, p_daily_price, p_car_model_images, p_status
);
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE ListCarsFleet()
BEGIN
    SELECT * FROM cardetails;
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //

CREATE PROCEDURE GetCarDetailsById(
        IN p_id INT
)
BEGIN
    SELECT * FROM cardetails WHERE car_id = p_id;
END //

DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //
CREATE PROCEDURE UpdateExistingCarDetails(
    IN p_carid INT,
    IN p_brand VARCHAR(255),
    IN p_model VARCHAR(255),
    IN p_year INT,
    IN p_vehicle_category VARCHAR(255),
    IN p_transmission VARCHAR(255),
    IN p_fuel VARCHAR(255),
    IN p_passenger_capacity INT,
    IN p_mileage INT,
    IN p_desc TEXT,
    IN p_daily_price DECIMAL(10, 2),
    IN p_car_model_images TEXT,
    IN p_status VARCHAR(255)
)
BEGIN
    UPDATE cardetails
    SET 
        brand = p_brand,
        model = p_model,
        _year = p_year,
        vehicle_category = p_vehicle_category,
        transmission = p_transmission,
        fuel = p_fuel,
        passenger_capacity = p_passenger_capacity,
        mileage = p_mileage,
        _desc = p_desc,
        daily_price = p_daily_price,
        car_model_images = p_car_model_images,
        _status = p_status
    WHERE car_id = p_carid;
END //
DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //
CREATE PROCEDURE DeleteExistingCar(
    IN p_carid INT
)
BEGIN
    DELETE FROM cardetails
    WHERE car_id = p_carid;
END //
DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

call GetRegisteredRecordByEmail('vedantpatil3941@gmail.com');
