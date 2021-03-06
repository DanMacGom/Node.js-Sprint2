-- MySQL Script generated by MySQL Workbench
-- mar 16 feb 2021 20:07:26
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
drop database optica;
CREATE SCHEMA IF NOT EXISTS `optica` ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`provider` (
  `provider_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`provider_pk`),
  INDEX `idx_n` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`brand` (
  `brand_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`brand_pk`, `provider_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_brand_provider1_idx` (`provider_id` ASC) VISIBLE,
  INDEX `idx_n` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_brand_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `optica`.`provider` (`provider_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Description:\nA provider can have multiple brands but the shop can only buy a certain brand from a certain provider.\nUnique:\nprovider_id and brand name.\n';


-- -----------------------------------------------------
-- Table `optica`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`product` (
  `product_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `brand_id` INT UNSIGNED NOT NULL,
  `left_lens_prescription` DECIMAL(5,2) NOT NULL,
  `right_lens_prescription` DECIMAL(5,2) NOT NULL,
  `frame_type` ENUM("Floating", "Acetate", "Metallic") NOT NULL,
  `frame_color` VARCHAR(20) NOT NULL,
  `right_lens_color` VARCHAR(20) NOT NULL,
  `left_lens_color` VARCHAR(20) NOT NULL,
  `price_per_unit` DECIMAL(6,2) NOT NULL,
  `quantity` SMALLINT NULL,
  PRIMARY KEY (`product_pk`, `brand_id`),
  INDEX `fk_product_brand1_idx` (`brand_id` ASC) VISIBLE,
  INDEX `idx_price` (`price_per_unit` ASC) VISIBLE,
  INDEX `idx_q` (`quantity` ASC) VISIBLE,
  CONSTRAINT `fk_product_brand1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `optica`.`brand` (`brand_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`customer` (
  `customer_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `postal_code` VARCHAR(5) NOT NULL,
  `phone_number` VARCHAR(9) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `registration_date` DATETIME NOT NULL,
  `recommended_by_id` INT NULL,
  PRIMARY KEY (`customer_pk`),
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  INDEX `idx_n` (`name` ASC) VISIBLE,
  INDEX `idx_reg` (`registration_date` ASC) VISIBLE,
  INDEX `idx_phone` (`phone_number` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Unique:\nAssume that each customer will have a different phone_number.\n';


-- -----------------------------------------------------
-- Table `optica`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`employee` (
  `employee_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `surname1` VARCHAR(20) NOT NULL,
  `surname2` VARCHAR(20) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`employee_pk`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  INDEX `idx_n_s1_s2` (`name` ASC, `surname1` ASC, `surname2` ASC) VISIBLE,
  INDEX `idx_n_s1` (`name` ASC, `surname1` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`purchases_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`purchases_order` (
  `purchases_order_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_id` INT UNSIGNED NOT NULL,
  `dt_order_placed` DATETIME NOT NULL,
  PRIMARY KEY (`purchases_order_pk`),
  INDEX `fk_purchases_order_provider1_idx` (`provider_id` ASC) VISIBLE,
  INDEX `idx_dt` (`dt_order_placed` ASC) VISIBLE,
  CONSTRAINT `fk_purchases_order_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `optica`.`provider` (`provider_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`purchases_order_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`purchases_order_line` (
  `purchases_order_line_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchases_order_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `provider_id` INT UNSIGNED NOT NULL,
  `brand_id` INT UNSIGNED NOT NULL,
  `quantity` MEDIUMINT UNSIGNED NOT NULL,
  `total_price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`purchases_order_line_pk`, `purchases_order_id`, `product_id`),
  INDEX `fk_purchases_order_line_purchases_order1_idx` (`purchases_order_id` ASC) VISIBLE,
  INDEX `fk_purchases_order_line_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_purchases_order_line_brand1_idx` (`provider_id` ASC, `brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_purchases_order_line_purchases_order1`
    FOREIGN KEY (`purchases_order_id`)
    REFERENCES `optica`.`purchases_order` (`purchases_order_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_purchases_order_line_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `optica`.`product` (`product_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_purchases_order_line_brand1`
    FOREIGN KEY (`provider_id` , `brand_id`)
    REFERENCES `optica`.`brand` (`provider_id` , `brand_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Description:\nNot necessary to specify total_price. \nA trigger makes the join and multiplies by quantity.';


-- -----------------------------------------------------
-- Table `optica`.`sales_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`sales_order` (
  `sales_order_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` INT UNSIGNED NOT NULL,
  `employee_id` INT UNSIGNED NOT NULL,
  `dt_order_placed` DATETIME NOT NULL,
  PRIMARY KEY (`sales_order_pk`, `customer_id`, `employee_id`),
  INDEX `fk_sales_order_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_sales_order_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `idx_dt` (`dt_order_placed` ASC) VISIBLE,
  CONSTRAINT `fk_sales_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `optica`.`customer` (`customer_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sales_order_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `optica`.`employee` (`employee_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`sales_order_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`sales_order_line` (
  `sales_order_line_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` INT UNSIGNED NOT NULL,
  `sales_order_id` INT UNSIGNED NOT NULL,
  `quantity` SMALLINT NOT NULL,
  `total_price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`sales_order_line_pk`, `product_id`, `sales_order_id`),
  INDEX `fk_sales_order_line_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_sales_order_line_sales_order1_idx` (`sales_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_order_line_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `optica`.`product` (`product_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sales_order_line_sales_order1`
    FOREIGN KEY (`sales_order_id`)
    REFERENCES `optica`.`sales_order` (`sales_order_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`provider_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`provider_info` (
  `provider_info_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_id` INT UNSIGNED NOT NULL,
  `street_type` VARCHAR(20) NOT NULL,
  `street_name` VARCHAR(20) NOT NULL,
  `street_number` VARCHAR(4) NOT NULL,
  `floor` VARCHAR(4) NOT NULL,
  `door` VARCHAR(2) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  `postal_code` VARCHAR(5) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `fax` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provider_info_pk`, `provider_id`),
  INDEX `fk_provider_info_provider1_idx` (`provider_id` ASC) VISIBLE,
  UNIQUE INDEX `idx_str_n_numb_cit` (`street_name` ASC, `street_number` ASC, `floor` ASC, `door` ASC, `city` ASC, `postal_code` ASC, `country` ASC, `phone_number` ASC) VISIBLE,
  INDEX `idx_city` (`city` ASC) VISIBLE,
  INDEX `idx_str_name` (`street_name` ASC) VISIBLE,
  CONSTRAINT `fk_provider_info_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `optica`.`provider` (`provider_pk`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `optica`;

DELIMITER $$
USE `optica`$$
CREATE DEFINER = CURRENT_USER TRIGGER `optica`.`customer_BEFORE_INSERT` BEFORE INSERT ON `customer` FOR EACH ROW
BEGIN
	SET @recom_cust_id = NEW.recommended_by_id;
    SET @msg = CONCAT("Recommendation by customer_id (", @recom_cust_id, ") could not be made.");
		
    IF @recom_cust_id IS NOT NULL AND (SELECT customer_pk FROM customer WHERE customer_pk = @recom_cust_id) IS NULL THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = @msg;
    END IF;
END$$

USE `optica`$$
CREATE DEFINER = CURRENT_USER TRIGGER `optica`.`purchases_order_line_BEFORE_INSERT` BEFORE INSERT ON `purchases_order_line` FOR EACH ROW
BEGIN
	SET NEW.total_price = (SELECT price_per_unit * NEW.quantity FROM product WHERE product_pk = NEW.product_id);
END$$

USE `optica`$$
CREATE DEFINER = CURRENT_USER TRIGGER `optica`.`purchases_order_line_AFTER_INSERT` AFTER INSERT ON `purchases_order_line` FOR EACH ROW
BEGIN
	SET @prod_id = NEW.product_id;
	
	UPDATE product SET quantity = quantity + NEW.quantity WHERE product_pk = @prod_id;
END$$

USE `optica`$$
CREATE DEFINER = CURRENT_USER TRIGGER `optica`.`sales_order_line_BEFORE_INSERT` BEFORE INSERT ON `sales_order_line` FOR EACH ROW
BEGIN
	SET @prod_id = NEW.product_id; 
	
    IF (SELECT quantity FROM product WHERE product_pk = @prod_id) < NEW.quantity THEN
		SET @msg = CONCAT("There is not enough stock for product id :", @prod_id, " to allow sale.");
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = @msg;
	END IF;
    
    SET NEW.total_price = (SELECT price_per_unit * NEW.quantity FROM product WHERE product_pk = NEW.product_id);
END$$

USE `optica`$$
CREATE DEFINER = CURRENT_USER TRIGGER `optica`.`sales_order_line_AFTER_INSERT` AFTER INSERT ON `sales_order_line` FOR EACH ROW
BEGIN
	SET @prod_id = NEW.product_id;
    
    UPDATE product SET quantity = quantity - NEW.quantity WHERE product_pk = @prod_id;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
