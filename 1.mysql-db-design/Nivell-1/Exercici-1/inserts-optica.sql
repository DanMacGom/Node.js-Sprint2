USE optica;

-- DUMMY DATA
-- customer
-- Insert fails correctly if recommended_by_id does not exist in the same table as customer_pk or if phone_number is duplicate.
-- A customer can recommend multiple other customers.
INSERT INTO customer (name, postal_code, phone_number, email, registration_date, recommended_by_id) 
VALUES ("Pepe", 08203, 999333222, "a@a.com", "2015-03-01 14:05:00", NULL);
INSERT INTO customer (name, postal_code, phone_number, email, registration_date, recommended_by_id) 
VALUES ("María", 08203, 999333223, "a@a.com", "2015-03-01 14:07:00", 1);
INSERT INTO customer (name, postal_code, phone_number, email, registration_date, recommended_by_id) 
VALUES ("Domingo", 08203, 999333224, "a@a.com", "2015-03-01 14:15:00", 1);
INSERT INTO customer (name, postal_code, phone_number, email, registration_date, recommended_by_id) 
VALUES ("Ana", 08203, 999333225, "a@a.com", "2015-03-01 14:50:00", 2);

-- employee
INSERT INTO employee (name, surname1, surname2, NIF) 
VALUES ("Ramón", "Pérez", "Gómez", "12354328N"),
("Sancho", "Panza", "Galdós", "83754368T"),
("Juan", "García", "Capdevila","18234758M");

-- sales_order
INSERT INTO sales_order (customer_id, employee_id, dt_order_placed) 
VALUES (1, 1, "2015-03-12 15:00:00"),
(1, 1, "2021-02-12 15:55:00"),
(1, 2, "2021-02-12 15:55:00"),
(2, 3, "2021-02-12 15:55:00");

-- provider
INSERT INTO provider (name) 
VALUES ("Proveedor de gafas"),
("Proveedor Pepe"),
("Gafas para todos"),
("Gafas Marina");

-- provider may have more than one direction
-- provider_info
INSERT INTO provider_info (provider_id, street_type, street_name, street_number, floor, door, city, postal_code, country, phone_number, fax, NIF) 
VALUES (1, "Ronda", "Australia", 85, 5, "B", "Sabadell", 59093, "Spain", 283743123, 987123456, "87654678T"),
(1, "Calle", "Francia", 33, 2, "C", "Terrassa", 12312, "Spain", 123843723, 989321234, "98321345D"),
(2, "Carrer", "Alemania", 123, 5, "A", "Manchester", 76345, "Spain", 987098432, 567432567, "98045678D"),
(3, "Calle", "Suecia", 12, 3, "D", "Tarragona", 90873, "Spain", 908435678, 123333456, "98098234F"),
(4, "Calle", "Finlandia", 5, 3, "A", "Lleida", 98733, "Spain", 789989345, 563432345, "78645678D");

-- brand
-- A provider can sell multiple brands, but a brand can only be assigned to one provider. 
INSERT INTO brand (provider_id, name) 
VALUES (1, "Oakley"), (1, "Dolce & Gabbana"), (2, "Ray-Ban"), (3, "Glasses Brand"),
(3, "Brand2"), (4, "Brand3"), (4, "Brand4");

-- product
INSERT INTO product (
brand_id, left_lens_prescription, right_lens_prescription, frame_type, frame_color, right_lens_color, 
left_lens_color, price_per_unit, quantity
)
VALUES (1, 12.3, 4.3, "Metallic", "Brown", "Blue", "Green", 80, 100),
(2, 0.4, 10.0, "Floating", "Red","Purple", "Grey", 300, 23),
(3, 1.87, 22.34, "Acetate", "Red", "Red", "Red", 200, 12),
(4, 12.3, 4.3, "Metallic", "Brown", "Blue", "Green", 90, 1);

-- purchases_order
INSERT INTO purchases_order (provider_id, dt_order_placed)
VALUES (1, "2021-05-13 23:00:00"), 
(2, "2020-03-12 11:03:55"),
(3, "1998-03-11 10:03:55"),
(4, "2008-05-04 13:03:33");

-- purchases_order_line
-- Inserting a row updates correctly the quantity of product corresponding to that product_id.
-- The composite foreign key with brand and provider makes sure that a prohibited combination of prov and brand cannot occur.
-- Not necessary to specify total_price. A trigger makes the join and multiplies by quantity.
INSERT INTO purchases_order_line (purchases_order_id, product_id, provider_id, brand_id, quantity) VALUES (1, 1, 1, 1, 5);
INSERT INTO purchases_order_line (purchases_order_id, product_id, provider_id, brand_id, quantity) VALUES (1, 2, 2, 3, 1);
INSERT INTO purchases_order_line (purchases_order_id, product_id, provider_id, brand_id, quantity) VALUES (1, 3, 3, 5, 1);
INSERT INTO purchases_order_line (purchases_order_id, product_id, provider_id, brand_id, quantity) VALUES (1, 4, 4, 6, 2);

-- sales_order_line
-- Not necessary to specify total_price. A trigger makes the join and multiplies by quantity.
INSERT INTO sales_order_line (product_id, sales_order_id, quantity)
VALUES (1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1);
