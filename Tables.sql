/*" user " table: */
create table User(
firstName varchar(20) NOT NULL,
lastName varchar(20) NOT NULL,
id varchar(10) NOT NULL,
phone varchar(10),
city varchar(20),
address varchar(255),
CONSTRAINT PK_User PRIMARY KEY (id)
);

/*" producer " table: */
create table Producer(
id varchar(10) NOT NULL,
firstName varchar(20) NOT NULL,
lastName varchar(20) NOT NULL,
phone varchar(10),
CONSTRAINT PK_Producer PRIMARY KEY (id)
);

/*" product " table: */
create table Product(
id varchar(10) NOT NULL,
PName varchar(20) NOT NULL,
currentBalance int default 0,
salesPrice int,
purchasedPrice int,
producer varchar(10),
CONSTRAINT PK_Product PRIMARY KEY (id),
CONSTRAINT FK_ProductProducer FOREIGN KEY (producer) REFERENCES Producer(id)
);

/*" factor " table: */
create table Factor(
id varchar(10) NOT NULL,
buyer varchar(10) NOT NULL,
registrationDate date,
CONSTRAINT PK_Product PRIMARY KEY (id),
CONSTRAINT FK_FactorBuyer FOREIGN KEY (buyer) REFERENCES User(id)
);

/*" product_factor " table: */
create table Product_Factor(
factor varchar(10) NOT NULL,
product varchar(10) NOT NULL,
number int default 0,
rate int check (rate <= 5),
CONSTRAINT PK_Product PRIMARY KEY (factor, product),
CONSTRAINT FK_factor FOREIGN KEY (factor) REFERENCES Factor(id),
CONSTRAINT FK_product FOREIGN KEY (product) REFERENCES Product(id)
);
