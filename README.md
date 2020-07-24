# database-project-1
first project of database course

### Creating Tables ###

> در جدول کاربر برای نام، نام خانوادگی و شماره ملی محدودیت عدم امکان پوچ بودن را در نظر میگیریم. همچنین کلید اصلی این جدول شماره ملی میباشد. زیرا هیچ دو نفری وجود ندارند که شماره ملی یکسان داشته باشند.

```sql
create table User(
firstName varchar(20) NOT NULL,
lastName varchar(20) NOT NULL,
id varchar(10) NOT NULL,
phone varchar(10),
city varchar(20),
address varchar(255),
CONSTRAINT PK_User PRIMARY KEY (id)
);
```

> در جدول تولید کنندگان نیز برای نام، نام خانوادگی و شماره ملی محدودیت عدم امکان پوچ بودن را در نظر میگیریم. همچنین کلید اصلی این جدول شماره ملی میباشد. زیرا همانند کاربر ها هیچ دو نفری وجود ندارند که شماره ملی یکسان داشته باشند.

```sql
create table Producer(
id varchar(10) NOT NULL,
firstName varchar(20) NOT NULL,
lastName varchar(20) NOT NULL,
phone varchar(10),
CONSTRAINT PK_Producer PRIMARY KEY
(id)
);
```

> در جدول کالاها آیدی و نام کالا عدم امکان پوچ بودن هستند و کلید اصلی آن را آیدی کالا تعریف میکنیم تا هیچ دو کالایی آیدی یکسان نداشته باشند. از آنجایی که میخواهیم اطلاعات داخل ستون تولید کننده همان اطلاعات موجود در جدول تولیدکنندگان باشد، آن را کلید خارجی جدول کالاها قرار داده و آن را به شماره ملی تولید کنندگان ارجاع میدهیم.

```sql
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
```

> برای جدول فاکتور ها  آیدی و خریدار عدم امکان پوچ بودن هستند و کلید اصلی آن را آیدی کالا تعریف میکنیم تا هیچ دو فاکتوری آیدی یکسان نداشته باشند. از آنجایی که میخواهیم اطلاعات داخل ستون خریدار همان اطلاعات موجود در جدول کاربران باشد، آن را کلید خارجی جدول فاکتور ها قرار داده و آن را به شماره ملی کاربران ارجاع میدهیم.

```sql
create table Factor(
id varchar(10) NOT NULL,
buyer varchar(10) NOT NULL,
registrationDate date,
CONSTRAINT PK_Product PRIMARY KEY (id),
CONSTRAINT FK_FactorBuyer FOREIGN KEY (buyer) REFERENCES User(id)
);

```

> در این جدول فاکتور و کالا عدم امکان پوچ بودن هستند و در مورد امتیاز چک میکنیم که از ۵ بیشتر نباشد. کلید اصلی این جدول زوج مرتب (فاکتور ، کالا) بوده و کلید های خارجی آن فاکتور و کالا هستند که به ترتیب به آیدی جدول فاکتور ها و آیدی جدول کالاها ارجاع داده میشوند.

```sql
product varchar(10) NOT NULL,
number int default 0,
rate int check (rate <= 5),
CONSTRAINT PK_Product PRIMARY KEY (factor, product),
CONSTRAINT FK_factor FOREIGN KEY (factor) REFERENCES Factor(id),
CONSTRAINT FK_product FOREIGN KEY (product) REFERENCES Product(id)
);
```
<hr>

### Input Data ###
ورودی های داده شده در خود فایل گزارش قابل مشاهده هستند.
<hr>

### Quories ###

> کاربران تهرانی

```sql
SELECT * FROM user WHERE city = 'Tehran';
```
> کسانی که شماره تلفن ؟؟؟؟؟؟؟۹۱۲ دارند

```sql
SELECT * FROM user WHERE phone LIKE '912%';
```
> کالا با تولید کننده با شماره ملی ۱۲۳۴۵۶۷۸۹۰

```sql
SELECT pname, producer
FROM product, producer
WHERE producer.id = product.producer
	and producer.id = '1234567890';

```
> کالا با میانگین(وزن دار) بین ۳ و ۴

```sql
Select product,(Sum(number*rate)/sum(number)) as 'rate average'
from product_factor
group by product
having (Sum(number*rate)/sum(number)) between 3 and 4;

```
> افزایش قیمت و نمایش به ترتیب

```sql
update product 
set salesPrice = salesPrice * 1.1;

select * 
from product
order by salesPrice ;

```
> کالا با تولید کننده ۳۳۳۳۳۳۳۳۳۳ با میانگین وزندار بالای ۳

```sql
select pname , sum(rate*number)/sum(number) as 'rate_average '
from product_factor, product
where product.id = product_factor.product
	and producer='3333333333' 
group by product
having sum(rate*number)/sum(number)>3;

```
> فاکتوری ک توسط کاربر با کد ملی ۱۱۲۲۳۳۴۴۵۵۶۶ خریده شده

```sql
SELECT * FROM factor WHERE buyer = '1122334455';
```
> تولید ﮐﻨﻨﺪﮔﺎﻧﯽ ﮐﻪ ﮐﺎﻻﻫﺎي آﻧﻬﺎ ﺗﻮﺳﻂ ﮐﺎرﺑﺮ ﺑﺎ ﺷﻤﺎره ﮐﺪ ﻣﻠﯽ 5544332211 ﺧﺮﯾﺪاری ﺷﺪه

```sql
SELECT DISTINCT producer.id, producer.firstName, producer.lastName
FROM producer, product, product_factor, factor, user 
WHERE producer.id = product.producer
	and product.id = product_factor.product
	and product_factor.factor = factor.id
	and factor.buyer = '1122334455';

```
> کالاهایی که بعد از ۱/۱/۲۰۲۰ خریداری شده اند

```sql
SELECT DISTINCT product
FROM factor natural join product_factor
WHERE factor.registrationDate > '20200101';

```
> کالا های با سود فروش بیش از سی درصد

```sql
SELECT id, pname, (100 - purchasedPrice / salesPrice * 100) as 'profit > 30%'
FROM product
WHERE  (100 - purchasedPrice / salesPrice * 100) > 30;

```
> کسانی که تا الان کالای p1 که چای است را خریداری کرده اند

```sql
select distinct factor.buyer
from product_factor 
join factor on product_factor.factor = factor.id
where product_factor.product = 'p1';

```
> کالاهایی با امتیاز بیشتز ار میانگین کل

```sql
select product , sum(rate*number)/sum(number) as 'rate average > total average'
from  product_factor 
group by product 
having sum(rate*number)/sum(number)>(select sum(number*rate)/sum(number) from product_factor);

``` 
> بیشترین میانگین کالا

```sql
select product , sum(rate*number)/sum(number) as 'max average'
from product_factor  
group by product 
having sum(rate*number)/sum(number) >= all(select sum(rate*number)/sum(number) from product_factor group by product );

```
> نمایش کالا ها به ترتیب میزان فروش

```sql
select product, sum(number)
from product_factor
group by product
order by sum(number);

```
> کسانی که جنس تکراری خریده اند

```sql
select user.id, user.firstName, user.lastName, product_factor.product,count(*) as '#'
from user, factor, product_factor
where user.id = buyer
	and factor.id = product_factor.factor
group by user.id, product_factor.product
having count(*)>1;

```
> کالا هایی که چند بار خریداری شده اند

```sql
select  product_factor.product, user.id as 'purchased by', count(*) as '#'
from user, factor, product_factor
where user.id = buyer
	and factor.id = product_factor.factor
group by product_factor.product, user.id
having count(*)>1;

``` 
> نمایش به ترتیب تعداد کالا های تولید شده ی تولید کنندگان و تعداد کالاهای فروخته شده ی بعد از ۱/۱/۲۰۲۰ آنها

```sql
select producer.firstName , producer.lastName, sum(number) as 'total sales'
from producer, product, product_factor, factor
where producer.id = product.producer
	and product.id = product_factor.product
	and factor.id = product_factor.factor
	and factor.registrationDate > '20200101'
group by firstname
order by sum(number);

```
> لیست فاکتور ها به ترتیب قیمت کل

```sql
select factor.id, sum(product.salesprice * product_factor.number) as 'total price'
from factor, product, product_factor
where factor.id = product_factor.factor
	and product.id = product_factor.product
group by factor.id
order by sum(product.salesprice * product_factor.number);

```
> کالا ها و سود آنها به ترتیب

```sql
select product_factor.factor, sum( number * ( salesprice - purchasedprice ) ) as'shop profit'
from product_factor join product on product_factor.product = product. id
group by factor
order by  sum( number * ( salesprice - purchasedprice ) );


```
<hr>

### Views ###

> ﻧﺎم ﮐﺎﻻ، ﻧﺎم ﺗﻮﻟﯿﺪ ﮐﻨﻨﺪه ﮐﺎﻻ و ﺗﻌﺪاد ﮐﺎرﺑﺮاﻧﯽ ﮐﻪ اﯾﻦ ﮐﺎﻻ را ﺧﺮﯾﺪه اند

```sql
create view product_total_sales as
(select product.pname, producer.firstname, producer.lastname,count(distinct(factor.buyer)) as '#' 
from product, factor, product_factor, producer
where product.id = product_factor.product
	and factor.id = product_factor.factor
	and producer.id = product.producer
group by product)
union
(select product.pname, producer.firstname, producer.lastname,0 as '#' 
from product join producer on product.producer = producer.id
where product.id <> all(select product from product_factor));


```
> ﻧﺎم ﺗﻮﻟﯿﺪ ﮐﻨﻨﺪه ﻫﺎﯾﯽ ﮐﻪ ﺑﯿﺶ از ﯾﮏ ﮐﺎﻻ ﺗﻮﻟﯿﺪ ﮐﺮدهاﻧﺪ ﺑﻪ ﻫﻤﺮاه ﮐﺪﻣﻠﯽ ﺗﻮﻟﯿﺪ ﮐﻨﻨﺪه

```sql
create view producers_with_more_than_one_product as
select producer.firstname, producer.lastname, producer.id, count(product.id) as 'number'
from producer join product on producer.id = product.producer
group by firstname
having count(product.id) > 1;

```








