-- DDL / DML / DRL
----------------------------------------------------------------------------------------------

CREATE DATABASE ecom;

SHOW databases;

USE ecom;

CREATE TABLE customers (
id INT PRIMARY KEY,
cname VARCHAR(255) UNIQUE,
gender VARCHAR(2) NOT NULL,
age INT,
city VARCHAR(255),
pincode INT CONSTRAINT CHECK (pincode BETWEEN 100000 AND 999999)
);

SELECT * FROM customers;

-- INSERT
INSERT INTO customers (id, cname, gender, age, city, pincode)
VALUES (1, 'ankit', 'M', 19, 'Faridabad', 121007),
	   (2, 'rahul', 'M', 20, 'Faridabad', 121006);
       
INSERT INTO customers
VALUES (3, 'komal', 'F', 18, 'Lucknow', 151011);

INSERT INTO customers (id, cname, gender)
VALUES (4, 'soni', 'F');

-- UPDATE
UPDATE customers SET age = 17, city = 'BANARAS', pincode = NULL WHERE id = 4;

-- UPDATE (multiple rows)
SET SQL_SAFE_UPDATES = 0;
UPDATE customers SET pincode = pincode + 1;
UPDATE customers SET pincode = pincode - 1;
SET SQL_SAFE_UPDATES = 1;

CREATE TABLE orders (
id INT PRIMARY KEY,
order_date DATE NOT NULL DEFAULT '2022-10-20',
cid INT,
FOREIGN KEY (cid) REFERENCES customers(id) ON DELETE SET NULL		-- or ON DELETE CASCADE
);

SELECT * FROM orders;

INSERT INTO orders
VALUES (1, '2022-10-20', 1),
	   (3, '2022-10-21', 2),
       (4, '2022-10-22', 3);

INSERT INTO orders (id, cid)
VALUES (2, 1);

-- REPLACE
REPLACE INTO customers SET id = 3, cname = 'preeti', gender = 'F';

REPLACE INTO customers (id, cname, gender, city)
VALUES (3, 'vikas', gender = 'M', city = 'Faridabad');

-- DELETE
DELETE FROM customers WHERE id = 3;

-- # ALTER Operations  : ->

-- ADD  (add new column in structure)
ALTER TABLE customers ADD bal INT;

-- MODIFY  (change datatype of column)
ALTER TABLE customers MODIFY bal FLOAT;

-- CHANGE COLUMN  (rename column in structure)
ALTER TABLE customers CHANGE COLUMN bal balance DOUBLE;

-- DROP COLUMN
ALTER TABLE customers DROP COLUMN balance;

-- RENAME TO  (rename table)
ALTER TABLE customers RENAME TO customer;
ALTER TABLE customer RENAME TO customers;


----------------------------------------------------------------------------------------------

-- SELECT
SELECT cname, age FROM customer;
SELECT 44 + 11;
SELECT now();
SELECT ucase('Ankit');		-- also lcase()


-- WHERE
SELECT cname FROM customers WHERE age>18;


-- BETWEEN \ AND \ OR \ IN \ NOT \ IS NULL
SELECT cname FROM customers WHERE age BETWEEN 18 AND 20;
SELECT cname FROM customers WHERE age = 17 or pincode = 121006;
SELECT cname FROM customers WHERE city IN ('banaras');
SELECT cname FROM customers WHERE city NOT IN ('faridabad', 'lucknow');
SELECT cname FROM customers WHERE pincode IS NOT NULL;


-- Pattern Searching \ Wildcard ( % , _ )   :  LIKE
	--  %  :  any number of aphabets
    --  _  :  exectly _ alphabets
SELECT * FROM customers WHERE cname LIKE '%u_';


-- ORDER BY  (sorting)
SELECT * FROM customers ORDER BY cname;			-- ASC
SELECT * FROM customers ORDER BY age DESC;		-- DESC


-- DISTINCT
SELECT DISTINCT(city) FROM customers;
SELECT city FROM customers GROUP BY city;


-- GROUP BY  (with aggregation functions)
SELECT city, COUNT(city) FROM customers GROUP BY city;
SELECT city, AVG(age) FROM customers GROUP BY city;


-- GROUP BY HAVING
SELECT city, COUNT(city) FROM customers GROUP BY city HAVING COUNT(city)>1;


----------------------------------------------------------------------------------------------

SHOW TABLES;

DROP TABLE orders;
DROP TABLE customer;

DROP DATABASE ecom;