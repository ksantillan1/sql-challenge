CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no","salary"
     )
);

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
); 
	
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT * FROM "departments" ; 
SELECT * FROM "dept_emp" ;
SELECT * FROM "dept_manager" ;
SELECT * FROM "employees" ;
SELECT * FROM "salaries" ;
SELECT * FROM "titles" ;

--1)employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name,employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries ON
employees.emp_no=salaries.emp_no;

--2. List employees who were hired in 1986
SELECT last_name , first_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = '1986' ; 

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
--OPTION 1: ALL MANAGERS IN THAT DEPARTMENT
SELECT departments.dept_no , departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, employees.hire_date, dept_manager.to_date
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
	JOIN employees ON dept_manager.emp_no = employees.emp_no 
--OPTION 2: ALL CURRENT MANAGERS IN THAT DEPARTMENT
SELECT departments.dept_no , departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, employees.hire_date, dept_manager.to_date
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
	JOIN employees ON dept_manager.emp_no = employees.emp_no 
WHERE EXTRACT(YEAR FROM dept_manager.to_date) = '9999'

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.last_name, employees.first_name, departments.dept_name 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	JOIN departments ON dept_emp.dept_no = departments.dept_no 
ORDER BY employees.emp_no

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B_%'

--6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.last_name, employees.first_name, departments.dept_name 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	JOIN departments ON dept_emp.dept_no = departments.dept_no 
WHERE departments.dept_name = 'Sales'
ORDER BY employees.emp_no

--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT employees.emp_no,employees.last_name, employees.first_name, departments.dept_name 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	JOIN departments ON dept_emp.dept_no = departments.dept_no 
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development'
ORDER BY employees.emp_no

--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
SELECT last_name, count(last_name)
FROM employees
GROUP BY last_name
ORDER BY last_name


