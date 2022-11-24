-- understanding JOIN
------------------------------------------------------------------------------------------

CREATE DATABASE eservice;

USE eservice;

CREATE TABLE employees (
id INT PRIMARY KEY,
ename VARCHAR(255) NOT NULL,
age INT CHECK (age >= 18),
city VARCHAR(255),
num INT
);
       
ALTER TABLE employees ADD (
boss INT,
FOREIGN KEY (boss) REFERENCES employees(id)
);

INSERT INTO employees
VALUES (1, 'ankit', 19, 'Faridabad', 119),
	(2, 'rahul', 18, 'Faridabad', 118),
       (3, 'vikas', 20, 'Mumbai', 120);
       
UPDATE employees SET BOSS = 1 WHERE id = 2;
UPDATE employees SET BOSS = 1 WHERE id = 3;

CREATE TABLE clients (
id INT PRIMARY KEY,
cname VARCHAR(255) NOT NULL,
age INT CHECK (age >= 18),
city VARCHAR(255),
empid INT
);

INSERT INTO clients
VALUES (1, 'seeta', 19, 'Delhi', 2),
       (2, 'geeta', 18, 'Faridabad', 1),
       (3, 'babita', 20, 'Delhi', 1);

CREATE TABLE projects (
id INT PRIMARY KEY,
pname VARCHAR(255) NOT NULL,
eid INT,
cid INT,
FOREIGN KEY (eid) REFERENCES employees(id),
FOREIGN KEY (cid) REFERENCES clients(id)
);

INSERT INTO projects
VALUES (1, 'A', 1, 2),
	(2, 'B', 1, 3),
       (3, 'c', 2, 1);


------------------------------------------------------------------------------------------


--  INNER JOIN
SELECT e.id, e.ename, e.city, p.pname FROM employees AS e
INNER JOIN projects AS p ON e.id = p.eid;

SELECT e.ename, c.cname FROM employees AS e
INNER JOIN clients AS c ON e.id = c.empid WHERE e.city = 'Faridabad' AND c.city = 'Delhi';


-- LEFT JOIN / RIGHT JOIN
SELECT * FROM employees AS e
LEFT JOIN projects AS p ON e.id = p.eid;

SELECT * FROM employees AS e
RIGHT JOIN projects AS p ON e.id = p.eid;

-- FULL JOIN
SELECT * FROM employees AS e
LEFT JOIN projects AS p ON e.id = p.eid
UNION
SELECT * FROM employees AS e
RIGHT JOIN projects AS p ON e.id = p.eid;

-- CROSS JOIN
SELECT * FROM employees AS e
CROSS JOIN projects;

-- SELF JOIN
SELECT e.id, e.ename, b.ename FROM employees AS e
INNER JOIN employees AS b ON e.id = b.boss;

-- using join without JOIN keyword
SELECT * FROM employees, projects WHERE employees.id = projects.eid;


------------------------------------------------------------------------------------------

-- SUB QUERIES

-- WHERE clause same table
-- employees with age > 18
SELECT * FROM employees WHERE age IN (SELECT age FROM employees WHERE age > 18);

-- WHERE clause different table
-- employees working in more than 1 projects
SELECT * FROM employees WHERE id IN (SELECT eid FROM projects GROUP BY eid HAVING count(eid)>1);

-- single value sub-query
-- employees having age > avg age
SELECT * FROM employees WHERE age > (SELECT AVG(age) FROM employees);

-- FROM clause  :  derived table (use alias)
-- SELECT max age person 'k' in their name
SELECT MAX(age) FROM (SELECT * FROM employees having ename LIKE '%k%') AS temp;

-- corelated sub-query
-- find 2nd oldest employee
SELECT * FROM employees AS e1
WHERE 2 = (SELECT COUNT(e2.age) FROM employees AS e2 WHERE e1.age >= e2.age);



------------------------------------------------------------------------------------------

-- creating a VIEW
CREATE VIEW custom_view AS SELECT ename, age FROM employees;

SELECT * FROM custom_view;

ALTER VIEW custom_view AS SELECT ename, age, city FROM employees;

DROP VIEW IF EXISTS custom_view;