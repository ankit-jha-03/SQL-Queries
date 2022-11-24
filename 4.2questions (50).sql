-- L-1 :
-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT first_name AS WORKER_NAME FROM worker;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT ucase(first_name) FROM worker;			-- upper()

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT department FROM worker;			-- can use GROUP BY also

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.    [substring()]
SELECT substring(first_name, 1, 3) FROM worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.    [instr()]
SELECT instr(first_name, 'B') FROM worker WHERE first_name = 'Amitabh';

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.    [rtrim()]
SELECT rtrim(first_name) FROM worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT LTRIM(first_name) FROM worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.    [length()]	
SELECT DISTINCT department, LENGTH(department) from worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.    [replace(,,)]
SELECT replace(first_name, 'a', 'A')  FROM worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.    [concat(,,...)]
-- A space char should separate them.
SELECT concat(first_name, ' ', last_name) AS COMPLETE_NAME FROM worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * from worker ORDER BY first_name;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by 
-- FIRST_NAME Ascending and DEPARTMENT Descending.			(# useful if two name is same)
SELECT * FROM worker ORDER BY first_name, department DESC;

-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE first_name IN ('Vipul', 'Satish');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE first_name NOT IN ('Vipul', 'Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin*”.
SELECT * FROM worker WHERE department LIKE 'Admin%';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM worker WHERE first_name LIKE '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM worker WHERE first_name LIKE '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM worker WHERE first_name LIKE '_____h';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM worker WHERE salary between 100000 AND 500000;

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.    [year(), month(), date()]
SELECT * FROM worker WHERE YEAR(joining_date) = 2014 AND MONTH(joining_date) = 02;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT department, count(*) FROM worker WHERE department = 'Admin';			-- no GROUP BY need, coz.. only 1 dept stats needed.

-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
SELECT concat(first_name, ' ', last_name) FROM worker
WHERE salary between 50000 and 100000;

-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT department, count(worker_id) AS no_of_worker FROM worker group by department
ORDER BY no_of_worker DESC;


-- L-2 :
-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT w.* FROM worker AS w inner join title as t on w.worker_id = t.worker_ref_id WHERE t.worker_title = 'Manager';
SELECT * FROM worker WHERE worker_id IN (SELECT worker_ref_id FROM title WHERE worker_title = 'Manager');

-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
SELECT worker_title, count(*) AS count FROM title group by worker_title HAVING count > 1;

-- Q-26. Write an SQL query to show only odd rows from a table.    [mod(,)]
SELECT * from worker WHERE mod(WORKER_ID, 2) != 0;		-- (!=) == (<>)

-- Q-27. Write an SQL query to show only even rows from a table. 
SELECT * FROM worker WHERE mod(WORKER_ID, 2) = 0;


-- L-3 :
-- Q-28. Write an SQL query to clone a new table from another table.    (cloning table)
CREATE TABLE worker_clone LIKE worker;
INSERT INTO worker_clone SELECT * from worker;
SELECT * FROM worker_clone;

-- Q-29. Write an SQL query to fetch intersecting records of two tables.
SELECT worker.* FROM worker inner join worker_clone using(worker_id);

-- Q-30. Write an SQL query to show records from one table that another table does not have.
-- MINUS
SELECT worker.* FROM worker left join worker_clone using(worker_id) WHERE worker_clone.worker_id is NULL;

-- Q-31. Write an SQL query to show the current date and time.
-- DUAL
SELECT curdate();
SELECT now();


-- L-4 :
-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.    [ LIMIT ]
SELECT * FROM worker ORDER BY salary DESC LIMIT 5;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.   [ LIMIT n-1, 1]
SELECT * FROM worker ORDER BY salary DESC LIMIT 4,1;

-- Q-34. Write an SQL query to ((determine)) the 5th highest salary without using LIMIT keyword.  : same salary can't be included
SELECT salary from worker w1
WHERE 4 = (
SELECT COUNT(DISTINCT (w2.salary))		-- DISTINCT used to eliminate persons with same salary;
FROM worker w2
WHERE w2.salary >= w1.salary
);

-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT w1.* FROM worker w1, worker w2 WHERE w1.salary = w2.salary and w1.worker_id != w2.worker_id;

-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
SELECT max(salary) from worker
WHERE salary not in (SELECT max(salary) FROM worker);

-- Q-37. Write an SQL query to show one row twice in results from a table.
SELECT * from worker
UNION ALL									-- UNION ALL : distinct also allow
SELECT * from worker ORDER BY worker_id;	-- ORDER BY : to eliminate problem of table after table

-- Q-38. Write an SQL query to list worker_id who does not get bonus.
SELECT worker_id FROM worker WHERE worker_id not in (SELECT worker_ref_id FROM bonus);

-- Q-39. Write an SQL query to fetch the first 50% records from a table.
SELECT * FROM worker WHERE worker_id <= ( SELECT count(worker_id)/2 FROM worker);

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
SELECT department, count(department) AS depCount FROM worker group by department HAVING depCount < 4;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
SELECT department, count(department) AS depCount FROM worker group by department;

-- Q-42. Write an SQL query to show the last record from a table.
SELECT * FROM worker WHERE worker_id = (SELECT max(worker_id) FROM worker);

-- Q-43. Write an SQL query to fetch the first row of a table.
SELECT * FROM worker WHERE worker_id = (SELECT min(worker_id) FROM worker);


-- L-5 :
-- Q-44. Write an SQL query to fetch the last five records from a table.
(SELECT * FROM worker ORDER BY worker_id DESC limit 5) ORDER BY worker_id;

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT w.department, w.first_name, w.salary FROM
(SELECT max(salary) as maxsal, department FROM worker group by department) temp			-- derived table
inner join worker w on temp.department = w.department and temp.maxsal = w.salary;

-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
SELECT DISTINCT salary FROM worker w1
WHERE 3 >= (SELECT count(DISTINCT salary) FROM worker w2 WHERE w1.salary <= w2.salary) ORDER BY w1.salary DESC;

SELECT DISTINCT salary FROM worker ORDER BY salary DESC limit 3;

-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
SELECT DISTINCT salary FROM worker w1
WHERE 3 >= (SELECT count(DISTINCT salary) FROM worker w2 WHERE w1.salary >= w2.salary) ORDER BY w1.salary DESC;

-- Q-48. Write an SQL query to fetch nth max salaries from a table.
SELECT DISTINCT salary FROM worker w1
WHERE n >= (SELECT count(DISTINCT salary) FROM worker w2 WHERE w1.salary <= w2.salary) ORDER BY w1.salary DESC;

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT department , sum(salary) AS depSal FROM worker group by department ORDER BY depSal DESC;

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT first_name, salaFROM worker WHERE salary = (SELECT max(Salary) FROM worker);