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
    SELECT userregistration.*, roles._name 
    FROM userregistration 
    INNER JOIN roles ON userregistration.role_id = roles.id;
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
# New
DELIMITER //

CREATE PROCEDURE GetRegisteredRecordByEmail(
    IN p_email VARCHAR(255)
)
BEGIN
    SELECT userregistration.*, roles._name 
    FROM userregistration 
    INNER JOIN roles ON userregistration.role_id = roles.id
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
# New
DELIMITER //
CREATE PROCEDURE GetRegisteredRecordsByRole(
        IN p_role_name varchar(50)
)
BEGIN
  SELECT * FROM userregistration 
  INNER JOIN roles ON userregistration.role_id = roles.id 
  WHERE roles._name = p_role_name;
END //
DELIMITER ;

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#
# New
DELIMITER //

CREATE PROCEDURE GetRegisteredRecordsById(
	IN p_id INT
)
BEGIN
    SELECT userregistration.*, roles._name 
    FROM userregistration 
    INNER JOIN roles ON userregistration.role_id = roles.id
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
# New
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
    SELECT cardetails.*, transmission.name 
    FROM cardetails 
    INNER JOIN transmission ON cardetails.transmission_id = transmission.id
    WHERE car_id = p_id;
END //

DELIMITER ;

call GetCarDetailsById(1);

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

DELIMITER //
CREATE PROCEDURE UpdateExistingCarDetails(
    IN p_carid INT,
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
    UPDATE cardetails
    SET 
        model = p_model,
        _year = p_year,
        mileage = p_mileage,
        _desc = p_desc,
        hourly_price = p_hourly_price,
        car_model_images = p_car_model_images,
        brand_id = p_brand_id,
        transmission_id = p_transmission_id,
        bodytype_id = p_bodytype_id,
        carfuel_id = p_carfuel_id,
        seatingcapacity_id = p_seatingcapacity_id,
        baggagecapacity_id = p_baggagecapacity_id,
        location_id = p_location_id,
        availability_status_id = p_availability_status_id
    WHERE id = p_carid;
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

DELIMITER //

CREATE PROCEDURE GetTransmissions()
BEGIN
    SELECT * FROM transmission;
END //

DELIMITER ;

call GetTransmissions();

#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

