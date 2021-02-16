USE pizzeria;

DELIMITER $$

CREATE TRIGGER before_order_delivery_insert
BEFORE INSERT
ON pizzeria.order FOR EACH ROW
BEGIN    
    SET @del_emp = NEW.delivery_employee_id; 
	
    IF (SELECT employee_pk FROM employee WHERE employee_pk = @del_emp) IS NULL AND NEW.is_delivery = 1 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "Order marked as delivery but no employee appointed for the delivery.";
	END IF;

	IF (NEW.is_delivery = 1 AND (SELECT occupation FROM employee WHERE employee_pk = @del_emp) = "C") THEN
		SET @name = (SELECT name FROM employee WHERE employee_pk = @del_emp);
        SET @surname1 = (SELECT surname1 FROM employee WHERE employee_pk = @del_emp);
		SET @surname2 = (SELECT surname2 FROM employee WHERE employee_pk = @del_emp);
        SET @msg = CONCAT("The appointed employee (" , @name, " ", @surname1, " ", @surname2, " ) is a cook, not deliveryperson");
        SIGNAL SQLSTATE '45000'	
			SET MESSAGE_TEXT = @msg;
    END IF; 

	IF NEW.is_delivery = 0 AND (SELECT employee_pk FROM employee WHERE employee_pk = @del_emp) IS NOT NULL THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "The order is not a delivery, no appointing of employees allowed.";
    END IF;

END $$

DELIMITER ;
