##Q.1
create table students(
student_id int primary key,
student_name varchar(400) not null,
age int check(age>18),
email varchar(50) unique
);
select * from students;
##Q.2
insert into students(student_id, student_name, age, email) values
(1, 'samiksha', 19,'ssss@gmail.com'),
(102, 'rahul', 22, 'aso@gmail.com'),
(103, 'mohan', 29, 'rgg@gmail.com');
select * from students;

##Q.3
SELECT department, COUNT(*) AS num_employees
FROM employees
WHERE name LIKE '%d'
GROUP BY department;

##Q.4
WITH RankedSalaries AS (
    SELECT 
        name,
        department,
        salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
    FROM employees
)
SELECT name, department, salary
FROM RankedSalaries
WHERE salary_rank <= 3;

##Q.5
SELECT e.name, e.salary, e.department
FROM employees e
INNER JOIN (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
) AS avg_salaries ON e.department = avg_salaries.department
WHERE e.salary > avg_salaries.avg_salary;


##Q.6
SELECT 
    department,
    COUNT(*) AS num_employees,
    location_id
FROM 
    employees
WHERE 
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 5
GROUP BY 
    department, location_id;

##Q.7
SELECT employee_id, job_title, hire_date
FROM employees
ORDER BY job_title, hire_date ASC;


##Q.8
create or replace PROCEDURE MANAGER_OF_EMPLOYEE
(
  THE_EMPLOYEEID IN NUMBER
)
AS
  TEMP VARCHAR2(20);
  TEMP2 VARCHAR2(20);
  TEMP3 VARCHAR2(20);
  TEMP4 VARCHAR2(20);
BEGIN
  SELECT MGR.FIRSTNAME, MGR.LASTNAME, EMP.FIRSTNAME, EMP.LASTNAME INTO TEMP, TEMP2, TEMP3, TEMP4
  FROM EMPLOYEE EMP
  LEFT OUTER JOIN EMPLOYEE MGR
  ON EMP.EMPLOYEEID = MGR.REPORTSTO
  WHERE EMP.EMPLOYEEID = THE_EMPLOYEEID AND EMP.REPORTSTO = MGR.EMPLOYEEID;
  DBMS_OUTPUT.PUT_LINE(TEMP || ' ' || TEMP2 || ' IS THE MANAGER OF ' || TEMP3 || ' ' || TEMP4);
END MANAGER_OF_EMPLOYEE; 
