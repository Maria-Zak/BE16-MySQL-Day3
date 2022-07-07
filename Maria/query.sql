--show sum all rows in the database
SELECT SUM(TABLE_ROWS) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'employees';
-- show rows sumber in each table !!
SELECT table_name, table_rows FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'employees';
-- count rows in a table
SELECT COUNT(*) FROM departments;
-- find amount of employees with the name
select count(*) from employees where employees.first_name = 'Mark';
select first_name, last_name from employees where employees.first_name = 'Mark';
-- amount of employees with a name and last name starting with a letter can also do '%A' for ending with the letter
select count(*) from employees where employees.first_name = 'Eric' and employees.last_name LIKE 'A%';
select count(*) from employees where first_name = 'Eric' and last_name LIKE 'A%';
-- return the data from employees starting from a certain year
SELECT first_name, last_name from employees WHERE hire_date>'1985-01-01';
-- count employees starting from a certain year
SELECT COUNT(*)from employees WHERE hire_date>'1985-01-01';
-- count from date to date
SELECT COUNT(*)from employees WHERE hire_date BETWEEN'1990-01-01' AND '1997-01-01';
SELECT first_name, last_name from employees WHERE hire_date BETWEEN'1990-01-01' AND '1997-01-01';
-- two different tables connected with emp_no
SELECT last_name, first_name FROM employees WHERE employees.emp_no IN (SELECT salary FROM salaries WHERE salary>70000);

SELECT last_name, first_name FROM employees WHERE employees.emp_no IN (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no IN (SELECT dept_emp.dept_no FROM departments WHERE departments.dept_name = 'Research'));

SELECT last_name, first_name FROM employees WHERE employees.emp_no IN (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no IN (SELECT dept_emp.dept_no FROM departments WHERE departments.dept_name = 'Research'))AND hire_date >'1991-12-31';
-- mine
SELECT last_name, first_name FROM employees 
WHERE (employees.emp_no IN (SELECT dept_emp.emp_no FROM dept_emp 
                    WHERE dept_emp.dept_no IN (
                        SELECT dept_emp.dept_no FROM departments 
                        WHERE departments.dept_name = 'Finance')
                        ))
AND (employees.emp_no IN (SELECT emp_no FROM salaries WHERE salary>75000 and salaries.to_date>CURRENT_DATE))
AND hire_date>= '1985-01-01'
-- Manuel's
select em.first_name, em.last_name from employees em
where (em.emp_no in (select distinct de.emp_no from dept_emp de
                    where de.dept_no IN (
                        select dep.dept_no from departments dep
                        where dep.dept_name = "Finance")
                   ))
AND (em.emp_no in (select distinct emp_no from salaries sa
                    where sa.salary > 75000 and sa.to_date > CURRENT_DATE))
AND em.hire_date >= "1985-01-01";

SELECT employees.first_name, employees.last_name, employees.gender, employees.hire_date, employees.birth_date, titles.title, salaries.salary FROM employees 
JOIN titles ON employees.emp_no = titles.emp_no
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE salaries.to_date > CURRENT_DATE
GROUP BY salaries.salary ASC

SELECT employees.first_name, employees.last_name, employees.gender, employees.hire_date, employees.birth_date, titles.title, departments.dept_name, salaries.salary FROM employees 
JOIN titles ON employees.emp_no = titles.emp_no
JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_manager on employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE employees.emp_no IN (SELECT dept_manager.emp_no FROM dept_manager WHERE dept_manager.to_date>CURRENT_DATE)
GROUP by employees.emp_no

-- show all data from all tables
SELECT * FROM employees
JOIN titles ON employees.emp_no = titles.emp_no
JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_manager on employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no




