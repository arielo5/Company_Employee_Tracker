DROP DATABASE IF EXISTS employee_trackerDB;
CREATE database employee_trackerDB;

USE employee_trackerDB;

CREATE TABLE department 

(
    id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT UC_name UNIQUE(name)
);

CREATE TABLE role 
(
    id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30) NOT NULL,
    salary DECIMAL(10,2) default 0,
    department_id INTEGER UNSIGNED,
    CONSTRAINT FK_department FOREIGN KEY (department_id) REFERENCES Department(id) ON DELETE CASCADE
);

CREATE TABLE employee
(
    id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    role_id INTEGER UNSIGNED,
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES Role(id) ON DELETE CASCADE,
    manager_id INTEGER UNSIGNED,
    CONSTRAINT FK_manager FOREIGN KEY (manager_id) REFERENCES Employee(id) ON DELETE SET NULL
);

SELECT * FROM employee;
SELECT * FROM role;
SELECT * FROM department;