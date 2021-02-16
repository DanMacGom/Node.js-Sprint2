USE pizzeria;

-- DUMMY DATA --
-- province
INSERT INTO province (name) 
VALUES ("Tarragona"), ("Barcelona"), ("Girona"), ("Lleida");

-- locality
INSERT INTO locality (province_id, name) 
VALUES (1, "Reus"), (2, "Barcelona"), (2, "Sabadell"), (3, "Figueres"), (4, "Tremp");

-- shop
INSERT INTO shop (province_id, locality_id, street_type, street_name, street_number, postal_code) 
VALUES (1, 1, "Carrer", "de Sant Lluís", 5, "43201"), (2, 2, "Avinguda", "Diagonal", 325, "08009"), 
(2, 3, "Carrer", "de Sant Cugat", 25, "08201"), (3, 3, "Carrer", "de Muntaner", 10, "17600"),
(4, 4, "Carrer", "del Riu Ebre", 2, "25001");

-- employee
INSERT INTO employee (shop_id, name, surname1, surname2, NIF, phone_number, occupation) 
VALUES (1, "Michael", "Jackson", "Five", "99999999M", 985894123, "C"),
(1, "Michael", "Jordan", "Six", "99999998M", 938456123, "D"),
(2, "Jeff", "Bezos", "Amazon", "23123123J", 138456987, "C"),
(2, "Bill", "Gates", "Microsoft", "47809832B", 893421345, "D"),
(3, "Amancio", "Ortega", "Zara", "50654976Y", 383475698, "C"),
(3, "Werner", "Heisenberg", "Quantum", "95093736Y", 857431245, "D"),
(4, "Erwin", "Schrödinger", "Quantum", "99169989S", 899888555, "C"),
(4, "Albert", "Einstein", "Relativity", "83283791D", 998456432, "D"),
(5, "Satyendra", "Nath", "Bose", "92228793N", 888777444, "C"),
(5, "Carl", "Friederich", "Gauss", "72599055S", 873213456, "D");

-- customer
INSERT INTO customer (province_id, locality_id, name, surname1, surname2, street_type, street_name, street_number, floor, door, postal_code)
VALUES (1, 1, "Pepe", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), 
(1, 1, "Maria", "Gómez", "García", "Carrer", "un de Reus", 13, 3, "A", 29384);

-- order
-- testing order-employee logic.
-- INSERT INTO pizzeria.order (customer_id, shop_id, delivery_employee_id, dt_order_placed, is_delivery)
-- VALUES (1, 1, 1, "2015-03-01 15:00:00", 0);
-- INSERT INTO pizzeria.order (customer_id, shop_id, delivery_employee_id, dt_order_placed, is_delivery)
-- VALUES (1, 1, 1, "2015-03-01 15:00:00", 1);
-- INSERT INTO pizzeria.order (customer_id, shop_id, delivery_employee_id, dt_order_placed, is_delivery)
-- VALUES (1, 1, NULL, "2015-03-01 15:00:00", 1);
INSERT INTO pizzeria.order (customer_id, shop_id, delivery_employee_id, dt_order_placed, is_delivery)
VALUES (1, 1, NULL, "2015-03-01 15:00:00", 0),
(1, 1, 2, "2018-05-01 12:32:45", 1);

-- category_pizza
INSERT INTO pizza_category (name)
VALUES ("Summer"), ("Autumn"), ("Winter"), ("Spring");

-- product
INSERT INTO product (category_id, type, name, description, image, price)
VALUES (NULL, "H", "Perfect Hamburger", 
"Cheese, bacon, salad, tomato, onion.",
"https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
13),
(NULL, "D", "Coca-cola", 
"Sugary drink.",
"https://www.drinksupermarket.com/media/catalog/product/cache/1/image/600x/9df78eab33525d08d6e5fb8d27136e95/c/o/coca-cola-original-330ml.jpg",
3),
(4, "P", "Margarita",
"San Marzano tomatoes, mozzarella cheese, fresh basil, salt and extra-virgin olive oil.",
"https://upload.wikimedia.org/wikipedia/commons/c/c8/Pizza_Margherita_stu_spivack.jpg",
10),
(3, "P", "Viennese",
"Vienna sausage, mozzarella cheese, tomato sauce.",
"https://cdn.tasteatlas.com/images/dishes/68c124f623744be39fa5130d9a96d28b.jpg",
11),
(2, "P", "Carrettiera",
"Olive oil, pepperoncini, salsiccia, rapini, smoked provolone cheese, tomato sauce.",
"https://cdn.tasteatlas.com/images/dishes/15092eec34e849f18b3c917ea75f3564.jpg",
14),
(1, "P", "Marinara",
"Olive oil, oregano, garlic, tomato.",
"https://cdn.tasteatlas.com/images/dishes/ac34ba94ddb84c8eb529ac7ba9d70f72.jpg",
16);

-- order_line
INSERT INTO order_line (order_id, product_id, quantity, total_price)
VALUES (1, 1, 3, 39),
(1, 6, 2, 32),
(2, 4, 1, 11);
