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
		SET @msg_text = CAST(@del_emp as CHAR);
        -- SET @msg_text = "PROVA";
        SIGNAL SQLSTATE '45000'		
			SET MESSAGE_TEXT = "The appointed employee is a cook, not deliveryperson";
    END IF; 

END $$

DELIMITER ;
