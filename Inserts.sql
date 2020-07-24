/* user inputs: */
INSERT INTO user (firstName, lastName, id, phone, city, address) VALUES ('Amirhossein', 'Alibakhshi', '0022615261', '9129334535', 'Tehran', 'aaaaaaaaaaaaaaaa');
INSERT INTO user (firstName, lastName, id, phone, city, address) VALUES ('Hamid', 'Nemati', '1122334455', '9339566267', 'Ghazvin', 'bbbbbbbbbbbbbb');
INSERT INTO user (firstName, lastName, id, phone, city, address) VALUES ('Taher', 'Saba', '0099887766', '9121880628', 'London', 'cccccccccccccccccccc');
INSERT INTO user (firstName, lastName, id, phone, city, address) VALUES ('Daryoush', 'Rajaei', '2244668800', '9199070925', 'Tehran', 'dddddddddddddd');
INSERT INTO user (firstName, lastName, id, phone, city, address) VALUES ('Rostam', 'Sattarpour', '6666666666', '9197245414', 'Tehran', 'eeeeeeeeeeeeeee');

/* producer inputs: */
INSERT INTO producer (id, firstName, lastName, phone) VALUES ('1234567890', 'f1', 'l1', NULL);
INSERT INTO producer (id, firstName, lastName, phone) VALUES ('2222222222', 'f2', 'l2', '9123456789');
INSERT INTO producer (id, firstName, lastName, phone) VALUES ('3333333333', 'f3', 'l3', NULL);
INSERT INTO producer (id, firstName, lastName, phone) VALUES ('4444444444', 'f4', 'l4', '9987654321');

/* product inputs: */
INSERT INTO product (id, PName, currentBalance, salesPrice, purchasedPrice, producer) VALUES ('p1', 'Tea', '100', '100', '70', '1234567890');
INSERT INTO product (id, PName, currentBalance, salesPrice, purchasedPrice, producer) VALUES ('p2', 'Tea-gold', '0', '110', '80', '1234567890');
INSERT INTO product (id, PName, currentBalance, salesPrice, purchasedPrice, producer) VALUES ('p3', 'hibye', '500', '5', '3', '3333333333');
INSERT INTO product (id, PName, currentBalance, salesPrice, purchasedPrice, producer) VALUES ('p4', 'water', '50', '2', '1', '4444444444');
INSERT INTO product (id, PName, currentBalance, salesPrice, purchasedPrice, producer) VALUES ('p5', 'milk', '60', '5', '4', '2222222222');

/* factor inputs: */
INSERT INTO factor (id, buyer, registrationDate) VALUES ('f1', '0022615261', '2020-01-01');
INSERT INTO factor (id, buyer, registrationDate) VALUES ('f2', '1122334455', '2020-04-21');
INSERT INTO factor (id, buyer, registrationDate) VALUES ('f3', '6666666666', '2019-10-15');
INSERT INTO factor (id, buyer, registrationDate) VALUES ('f4', '0099887766', '2020-04-22');
INSERT INTO factor (id, buyer, registrationDate) VALUES ('f5', '6666666666', '2019-08-20');
INSERT INTO factor (id, buyer, registrationDate) VALUES ('f6', '2244668800', '2020-04-19');

/* product_factor inputs: */
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f1', 'p1', '2', '3');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f2', 'p4', '3', '4');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f2', 'p3', '15', '5');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f2', 'p5', '3', '2');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f3', 'p4', '4', '4');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f4', 'p1', '12', '1');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f4', 'p3', '4', '3');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f4', 'p5', '6', '0');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f5', 'p4', '7', '2');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f6', 'p3', '8', '1');
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f6', 'p5', '0', NULL);
INSERT INTO product_factor (factor, product, number, rate) VALUES ('f6', 'p1', '9', '4');