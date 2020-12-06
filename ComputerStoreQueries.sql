
drop table Products;
drop table manufacturers;

CREATE TABLE manufacturers (
   code number PRIMARY KEY NOT NULL,
   name varchar(50) NOT NULL 
);

CREATE TABLE products (
   code NUMBER PRIMARY KEY NOT NULL,
   name varchar(50) NOT NULL ,
   price real NOT NULL ,
   manufacturer number NOT NULL
      CONSTRAINT fk_manufacturers_code REFERENCES manufacturers(code)
);

INSERT INTO manufacturers(code,name) VALUES(1,'Sony');
INSERT INTO manufacturers(code,name) VALUES(2,'Creative Labs');
INSERT INTO manufacturers(code,name) VALUES(3,'Hewlett-Packard');
INSERT INTO manufacturers(code,name) VALUES(4,'Iomega');
INSERT INTO manufacturers(code,name) VALUES(5,'Fujitsu');
INSERT INTO manufacturers(code,name) VALUES(6,'Winchester');

INSERT INTO products(code,name,price,manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO products(code,name,price,manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO products(code,name,price,manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO products(code,name,price,manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO products(code,name,price,manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO products(code,name,price,manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO products(code,name,price,manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO products(code,name,price,manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO products(code,name,price,manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO products(code,name,price,manufacturer) VALUES(10,'DVD burner',180,2);

--Computer Store Answers

--1. [1pt] Select the names of the products with a price less than or equal to $200

Select A1.name From products A1 WHERE A1.price <= 200;

--2. [1pt] Select all the products with a price between $60 and $120

SELECT B1.name, b1.price FROM Products B1 WHERE B1.price BETWEEN 60 AND 120;

--3. Select the name and price in cents (i.e., the price is in dollars).

SELECT C1.name, C1.price/0.01 AS PriceInCents 
FROM Products C1 
ORDER BY C1.price;

--4. [2pt] Select the product name, price, and manufacturer name of all the products.

SELECT P.name AS Product_Name, P.price, M.name AS Manufacturer_Name
From products P, manufacturers M
Where P.Manufacturer = M.code;


--5. [3pt] Select all manufactures who currently do not have any listed products.

SELECT Name AS Manufacturer_Name
From Manufacturers
Where NOT EXISTS (SELECT * 
                    FROM Products P 
                    WHERE P.Manufacturer = manufacturers.code);
                    

--6. [3pt] Select the name of each manufacturer along with the name and price of its most expensive product.

 SELECT manufacturers.name AS manufacturer_Name, products.name AS Product_Name,products.price As Most_Expensive_Product
 From (Products JOIN Manufacturers ON Products.manufacturer = Manufacturers.code) 
 WHERE Price >= All (SELECT Price From Products where Products.manufacturer = Manufacturers.code);
 
 
 --7. [4pt] Select the names and average prices of manufacturer whose products have an average price larger than or equal to $150.
 
 SELECT manufacturers.name, AVG(price)
 FROM (Products INNER JOIN Manufacturers ON Products.manufacturer = Manufacturers.code)
 WHERE Exists(SELECT Price From Products where Products.manufacturer = Manufacturers.code)
 Group by manufacturers.name
 Having AVG(Products.Price) >= 150;
 
 
 


