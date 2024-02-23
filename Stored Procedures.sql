################################################################################################
############################# User or Admin Registration ######################################
################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_register_register(
    IN p_firstname VARCHAR(255),
    IN p_lastname VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_role_id INT
)
BEGIN
    INSERT INTO tbl_authentications (first_name, last_name, email_address, pass_word, roles_id)
    VALUES (p_firstname, p_lastname, p_email, SHA2(p_password, 256), p_role_id);
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_register_getrecords()
BEGIN
    SELECT tbl_authentications.*, tbl_roles.role_name 
    FROM tbl_authentications 
    INNER JOIN tbl_roles ON tbl_authentications.roles_id = tbl_roles.role_id;
END //

DELIMITER ;

################################################################################################
################################## User or Admin Login #########################################
################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_login_getauthdatabyemail(
    IN p_email VARCHAR(255)
)
BEGIN
    SELECT tbl_authentications.*, tbl_roles.role_name 
    FROM tbl_authentications 
    INNER JOIN tbl_roles ON tbl_authentications.roles_id = tbl_roles.role_id
    WHERE tbl_authentications.email_address = p_email;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_login_verifypassword (
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT SHA2(p_password, 256);
END //

DELIMITER ;

################################################################################################
############################# User or Admin CRUD Operations ####################################
################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_admin_GetAuthDataByRole(
    IN p_role_name VARCHAR(50)
)
BEGIN
    SELECT * FROM tbl_authentications 
    INNER JOIN tbl_roles ON tbl_authentications.roles_id = tbl_roles.role_id 
    WHERE tbl_roles.role_name = p_role_name;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_admin_user_GetAuthDataById (
    IN p_id INT
)
BEGIN
    SELECT tbl_authentications.*, tbl_roles.role_name 
    FROM tbl_authentications 
    INNER JOIN tbl_roles ON tbl_authentications.roles_id = tbl_roles.role_id
    WHERE tbl_authentications.auth_id = p_id;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_admin_user_updateautheticationdata (
    IN p_id INT, 
    IN p_firstname VARCHAR(255), 
    IN p_lastname VARCHAR(255), 
    IN p_email VARCHAR(255), 
    IN p_role_id INT
)
BEGIN
    UPDATE tbl_authentications 
    SET first_name = p_firstname, 
        last_name = p_lastname, 
        email_address = p_email, 
        roles_id = p_role_id
    WHERE auth_id = p_id;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_admin_user_deleteauthenticationdata(
    IN p_id INT
)
BEGIN
    DELETE FROM tbl_authentications WHERE auth_id = p_id;
END //

DELIMITER ;

################################################################################################
####################################### Car CRUD Operations ####################################
################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_addnewcar (
    IN p_model VARCHAR(255),
    IN p_year INT,
    IN p_mileage INT,
    IN p_desc TEXT,
    IN p_hourly_price DECIMAL(10, 2),
    IN p_car_model_images TEXT,
    IN p_brands_id INT,
    IN p_transmissions_id INT,
    IN p_bodytypes_id INT,
    IN p_carfuels_id INT,
    IN p_seatcaps_id INT,
    IN p_bagcaps_id INT,
    IN p_locations_id INT,
    IN p_availstatus_id INT
)
BEGIN
    INSERT INTO tbl_cardetails (
    model, _year, mileage, _desc, hourly_price, car_model_images, 
    brands_id, transmissions_id, bodytypes_id, carfuels_id, seatcaps_id, 
    bagcaps_id, locations_id, availstatus_id
) 
VALUES (
    p_model, p_year, p_mileage, p_desc, p_hourly_price, p_car_model_images, 
    p_brands_id, p_transmissions_id, p_bodytypes_id, p_carfuels_id, p_seatcaps_id, 
    p_bagcaps_id, p_locations_id, p_availstatus_id
);
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_getcarsfleet()
BEGIN
SELECT 
	tbl_cardetails.car_id,
    tbl_cardetails.model,
    tbl_cardetails._year,
    tbl_cardetails.mileage,
    tbl_cardetails._desc,
    tbl_cardetails.hourly_price,
    tbl_cardetails.car_model_images,
    tbl_brand.brand,
    tbl_transmission.transmission,
    tbl_bodytype.body_type,
    tbl_carfuel.carfuel,
    tbl_seatingcapacity.seat_capacity,
    tbl_baggagecapacity.bag_capacity,
    tbl_location.location,
    tbl_availability_status.avail_status
FROM 
    tbl_cardetails
JOIN 
    tbl_brand ON tbl_cardetails.brands_id = tbl_brand.brand_id
JOIN 
    tbl_transmission ON tbl_cardetails.transmissions_id = tbl_transmission.transmission_id
JOIN 
    tbl_bodytype ON tbl_cardetails.bodytypes_id = tbl_bodytype.bodytype_id
JOIN 
    tbl_carfuel ON tbl_cardetails.carfuels_id = tbl_carfuel.carfuel_id
JOIN 
    tbl_seatingcapacity ON tbl_cardetails.seatcaps_id = tbl_seatingcapacity.seatcap_id
JOIN 
    tbl_baggagecapacity ON tbl_cardetails.bagcaps_id = tbl_baggagecapacity.bagcap_id
JOIN 
    tbl_location ON tbl_cardetails.locations_id = tbl_location.loc_id
JOIN 
    tbl_availability_status ON tbl_cardetails.availstatus_id = tbl_availability_status.avail_stat_id;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_getcardetailsbyid(
        IN p_id INT
)

BEGIN
    SELECT tbl_cardetails.*
    FROM tbl_cardetails
    WHERE car_id = p_id;
END //

DELIMITER ;

################################################################################################

DELIMITER //
CREATE PROCEDURE sp_rng_cars_updatecardetails(
    IN p_id INT,
    IN p_model VARCHAR(255),
    IN p_year INT,
    IN p_mileage INT,
    IN p_desc TEXT,
    IN p_hourly_price DECIMAL(10, 2),
    IN p_car_model_images TEXT,
    IN p_brands_id INT,
    IN p_transmissions_id INT,
    IN p_bodytypes_id INT,
    IN p_carfuels_id INT,
    IN p_seatcaps_id INT,
    IN p_bagcaps_id INT,
    IN p_locations_id INT,
    IN p_availstatus_id INT
)
BEGIN
    UPDATE tbl_cardetails
    SET 
        model = p_model,
        _year = p_year,
        mileage = p_mileage,
        _desc = p_desc,
        hourly_price = p_hourly_price,
        car_model_images = p_car_model_images,
        brands_id = p_brands_id,
        transmissions_id = p_transmissions_id,
        bodytypes_id = p_bodytypes_id,
        carfuels_id = p_carfuels_id,
        seatcaps_id = p_seatcaps_id,
        bagcaps_id = p_bagcaps_id,
        locations_id = p_locations_id,
        availstatus_id = p_availstatus_id
    WHERE car_id = p_id;
END //
DELIMITER ;

################################################################################################

DELIMITER //
CREATE PROCEDURE sp_rng_cars_deletecar(
    IN p_carid INT
)
BEGIN
    DELETE FROM tbl_cardetails
    WHERE car_id = p_carid;
END //
DELIMITER ;

################################################################################################
####################################### All Master Table #######################################
################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_GetBrandData()
BEGIN
    SELECT * FROM tbl_brand;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_GetTransmissionData()
BEGIN
    SELECT * FROM tbl_transmission;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_GetBodytypeData()
BEGIN
    SELECT * FROM tbl_bodytype;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_GetCarfuelData()
BEGIN
    SELECT * FROM tbl_carfuel;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_GetSeatingcapacityData()
BEGIN
    SELECT * FROM tbl_seatingcapacity;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_GetBaggagecapacityData()
BEGIN
    SELECT * FROM tbl_baggagecapacity;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_GetAvailabilityStatusData()
BEGIN
    SELECT * FROM tbl_availability_status;
END //

DELIMITER ;

################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_cars_GetLocationData()
BEGIN
    SELECT * FROM tbl_location;
END //

DELIMITER ;

################################################################################################
############################## Common Stored Procedures ########################################
################################################################################################

DELIMITER //

CREATE PROCEDURE sp_rng_common_checkemailexistence(
    IN p_email VARCHAR(255),
    IN p_id INT
)
BEGIN
    DECLARE emailExists BOOLEAN;
    
    IF p_id IS NULL THEN
        SELECT EXISTS(
            SELECT 1 FROM tbl_authentications WHERE email_address = p_email
        ) INTO emailExists;
    ELSE
        SELECT EXISTS(
            SELECT 1 FROM tbl_authentications WHERE email_address = p_email AND auth_id != p_id
        ) INTO emailExists;
    END IF;
    
    SELECT emailExists AS IsExists;
END //

DELIMITER ;