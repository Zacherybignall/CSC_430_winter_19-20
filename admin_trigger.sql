CREATE DEFINER=`root`@`localhost` TRIGGER `car_sold_BEFORE_INSERT` BEFORE INSERT ON `car_sold` FOR EACH ROW BEGIN
IF (new.empl_comission <> (new.agreed_price*.02)) THEN 
	INSERT INTO admin_table VALUES (NEW.car_sold_id, NEW.customer_id, NEW.agreed_price, NEW.empl_id, NEW.empl_comission);
END IF;
END