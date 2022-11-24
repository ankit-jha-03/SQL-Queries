-- SET Operations
-----------------------------------------------------------------------------------

CREATE DATABASE edept;

USE edept;

CREATE TABLE dept1 (
empid INT PRIMARY KEY,
ename VARCHAR(1),
role VARCHAR(255)
);

CREATE TABLE dept2 (
empid INT PRIMARY KEY,
ename VARCHAR(1),
role VARCHAR(255)
);

INSERT INTO dept1
VALUES (1, 'A', 'engineer'),
	   (2, 'B', 'salesman'),
       (3, 'C', 'manager'),
       (4, 'D', 'salesman'),
       (5, 'E', 'engineer');
       
INSERT INTO dept2
VALUES (3, 'C', 'manager'),
	   (6, 'F', 'marketing'),
       (7, 'G', 'salesman');


-- SET OPERATIONS

-- UNION
-- list out all the employees in company
SELECT * FROM dept1
UNION
SELECT * FROM dept2;

-- list out all the employees working as salesman
SELECT * FROM dept1 WHERE role = 'salesman'
UNION
SELECT * FROM dept2 WHERE role = 'salesman';

-- INTERSECTION
-- list out all the employees who have worked for both departments
SELECT dept1.* FROM dept1 INNER JOIN dept2 USING (empid);

-- MINUS
-- list out all employees working on dept1 but not on dept2
SELECT dept1.* FROM dept1 LEFT JOIN dept2 USING (empid)
WHERE dept2.empid IS NULL;			-- in JOIN second column will also exist