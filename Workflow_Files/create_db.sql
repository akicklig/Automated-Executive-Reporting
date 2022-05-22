#/SHOW GLOBAL VARIABLES LIKE 'local_infile';/#
#/Verify if loading local data is permitted/#

#/SET GLOBAL local_infile = true;/#
#/Set loading local data to true if the above was not permitted/#

#/Drop the database if it already exists#
DROP DATABASE IF EXISTS sales;

#/Create the database/#
CREATE DATABASE IF NOT EXISTS sales;

#/Set the database to the newly created `sales` db/#
USE sales;

#/Create the `customers` table/#
CREATE TABLE sales.customers
(
	cust_id INT NOT NULL UNIQUE,
    job_id INT NOT NULL,
    city_state_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(100) NOT NULL,
    credit_score INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    street_num VARCHAR(100) NOT NULL,
    street_nam VARCHAR(100) NOT NULL
    
);

#/Load the local data for the customers table via the `customers.csv` file/#
#/If the load attempt triggers an Error Code 2068 issue, refer to this stack overflow entry:/#
#/https://stackoverflow.com/questions/63264360/error-code-2068-file-requested-rejected-due-to-restrictions-on-access-with-root/#
#/Ensure the local file is in the /Uploads/ file path below/#
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE sales.customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(cust_id, job_id, city_state_id, first_name, last_name, age, gender, credit_score, email, phone, street_num, street_nam);

#/Create the `jobs` table/#
CREATE TABLE sales.jobs
(
	job_id INT NOT NULL UNIQUE,
    job_title VARCHAR(100) NOT NULL
);

#/Load the local data for the jobs table via the `jobs.csv` file/#
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/jobs.csv'
INTO TABLE sales.jobs
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(job_id, job_title);

#/Create the `city_state` table/#
CREATE TABLE sales.city_state
(
	city_state_id INT NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    city_state VARCHAR(100) NOT NULL
);

#/Load the local data for the city_state table via the `city_state.csv` file/#
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/city_state.csv'
INTO TABLE sales.city_state
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(city_state_id, city, state, city_state);

#/Create the `cars` table/#
CREATE TABLE sales.cars
(
	make_model_id INT NOT NULL UNIQUE,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    make_model VARCHAR(100) NOT NULL
);

#/Load the local data for the cars table via the `cars.csv` file/#
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cars.csv'
INTO TABLE sales.cars
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(make_model_id, make, model, make_model);

#/Create the `transactions` table/#
CREATE TABLE sales.transactions
(
	transaction_id INT NOT NULL UNIQUE,
    cust_id INT NOT NULL,
    make_model_id INT NOT NULL,
    employee_id INT NOT NULL,
    stamp date NOT NULL,
    vin VARCHAR(100) NOT NULL,
    color VARCHAR (100) NOT NULL,
    car_year VARCHAR(100) NOT NULL,
    price INT NOT NULL
);

#/Load the local data for the transactions table via the `transactions.csv` file/#
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions.csv'
INTO TABLE sales.transactions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transaction_id, cust_id, make_model_id, employee_id, stamp, vin, color, car_year, price);

#/Create the `emplyees` table/#
CREATE TABLE sales.employees
(
	employee_id INT NOT NULL UNIQUE,
    emp_fname VARCHAR(100) NOT NULL,
    emp_lname VARCHAR(100) NOT NULL,
    emp_title VARCHAR(100) NOT NULL
);

#/Load the local data for the employees table via the `employees.csv` file/#
LOAD DATA INFILE  
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employees.csv'
INTO TABLE sales.employees
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(employee_id, emp_fname, emp_lname, emp_title);

SELECT c.cust_id, t.transaction_id, c.first_name, c.last_name, c.age, c.gender, c.credit_score, c.email, c.phone,
	j.job_title, c.street_num, c.street_nam, cs.city, cs.state, t.stamp, e.emp_fname, e.emp_lname, e.emp_title,
    t.vin, cr.make, cr. model, t.color, t.car_year, t.price
FROM customers AS c
LEFT JOIN jobs AS j
ON c.job_id = j.job_id
LEFT JOIN city_state AS cs
ON c.city_state_id = cs.city_state_id
LEFT JOIN transactions AS t
ON c.cust_id = t.cust_id
LEFT JOIN cars AS cr
ON t.make_model_id = cr.make_model_id
LEFT JOIN employees AS e
ON t.employee_id = e.employee_id;