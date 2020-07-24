/*1*/
SELECT * FROM user WHERE city = 'Tehran';

/*2*/
SELECT * FROM user WHERE phone LIKE '912%';

/*3*/
SELECT pname, producer
FROM product, producer
WHERE producer.id = product.producer
	and producer.id = '1234567890';

/*4*/

Select product,(Sum(number*rate)/sum(number)) as 'rate average'
FROM product_factor
group by product
HAVING (Sum(number*rate)/sum(number)) between 3 and 4;


/*5*/
update product 
set salesPrice = salesPrice * 1.1;

SELECT * 
FROM product
ORDER BY salesPrice ;

/*6*/
SELECT pname , sum(rate*number)/sum(number) as 'rate_average '
FROM product_factor, product
WHERE product.id = product_factor.product
	and producer='3333333333' 
group by product
HAVING sum(rate*number)/sum(number)>3;


/*7*/
SELECT * FROM factor WHERE buyer = '1122334455';


/*8*/
SELECT DISTINCT producer.id, producer.firstName, producer.lastName
FROM producer, product, product_factor, factor, user 
WHERE producer.id = product.producer
	and product.id = product_factor.product
	and product_factor.factor = factor.id
	and factor.buyer = '1122334455'; 


/*9*/
SELECT DISTINCT product
FROM factor natural join product_factor
WHERE factor.registrationDate > '20200101';


/*10*/
SELECT id, pname, (100 - purchasedPrice / salesPrice * 100) as 'profit > 30%'
FROM product
WHERE  (100 - purchasedPrice / salesPrice * 100) > 30;


/*11*/
SELECT distinct factor.buyer
FROM product_factor 
join factor on product_factor.factor = factor.id
WHERE product_factor.product = 'p1';


/*12*/
SELECT product , sum(rate*number)/sum(number) as 'rate average > total average'
FROM  product_factor 
group by product 
HAVING sum(rate*number)/sum(number)>(SELECT sum(number*rate)/sum(number) FROM product_factor);


/*13*/
SELECT product , sum(rate*number)/sum(number) as 'max average'
FROM product_factor  
group by product 
HAVING sum(rate*number)/sum(number) >= all(SELECT sum(rate*number)/sum(number) FROM product_factor group by product );


/*14*/
SELECT product, sum(number)
FROM product_factor
group by product
ORDER BY sum(number);


/*15*/
SELECT user.id, user.firstName, user.lastName, product_factor.product,count(*) as '#'
FROM user, factor, product_factor
WHERE user.id = buyer
	and factor.id = product_factor.factor
group by user.id, product_factor.product
HAVING count(*)>1;


/*16*/
SELECT  product_factor.product, user.id as 'purchased by', count(*) as '#'
FROM user, factor, product_factor
WHERE user.id = buyer
	and factor.id = product_factor.factor
group by product_factor.product, user.id
HAVING count(*)>1;


/*17*/
SELECT producer.firstName , producer.lastName, sum(number) as 'total sales'
FROM producer, product, product_factor, factor
WHERE producer.id = product.producer
	and product.id = product_factor.product
	and factor.id = product_factor.factor
	and factor.registrationDate > '20200101'
group by firstname
ORDER BY sum(number);


/*18*/
SELECT factor.id, sum(product.salesprice * product_factor.number) as 'total price'
FROM factor, product, product_factor
WHERE factor.id = product_factor.factor
	and product.id = product_factor.product
group by factor.id
ORDER BY sum(product.salesprice * product_factor.number);
	

/*19*/
SELECT product_factor.factor, sum( number * ( salesprice - purchasedprice ) ) as'shop profit'
FROM product_factor join product on product_factor.product = product. id
group by factor
ORDER BY  sum( number * ( salesprice - purchasedprice ) );


/*view1*/
create view product_total_sales as
(SELECT product.pname, producer.firstname, producer.lastname,count(distinct(factor.buyer)) as '#' 
FROM product, factor, product_factor, producer
WHERE product.id = product_factor.product
	and factor.id = product_factor.factor
	and producer.id = product.producer
group by product)
union
(SELECT product.pname, producer.firstname, producer.lastname,0 as '#' 
FROM product join producer on product.producer = producer.id
WHERE product.id <> all(SELECT product FROM product_factor));


/*view2*/
create view producers_with_more_than_one_product as
SELECT producer.firstname, producer.lastname, producer.id, count(product.id) as 'number'
FROM producer join product on producer.id = product.producer
group by firstname
HAVING count(product.id) > 1;
