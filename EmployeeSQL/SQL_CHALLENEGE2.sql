--  Data is from https://github.com/vrajmohan/pgsql-sample-data/tree/master/employee
CREATE TABLE employees (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      VARCHAR(1)      NOT NULL,
    hire_date   DATE NOT NULL,
    PRIMARY KEY (emp_no)
);
CREATE TABLE departments (
    dept_no     VARCHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE      (dept_name)
);
CREATE TABLE dept_manager (
   dept_no      VARCHAR(4)         NOT NULL,
   emp_no       INT             NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (emp_no,dept_no)
);
CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     VARCHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no,dept_no)
);
CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no,title, from_date)
);
CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, from_date)
);

SELECT * FROM employees

SELECT * FROM employees WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31'

SELECT dm.dept_no,
d.dept_name,
dm.emp_no,
e.last_name,
e.first_name,
dm.from_date,
dm.to_date
FROM dept_manager AS dm
INNER JOIN departments AS d
on (dm.dept_no = d.dept_no)
INNER JOIN employees AS e
ON (dm.emp_no = e.emp_no);

SELECT de.emp_no,
e.last_name,
e.first_name,
d.dept_name
FROM dept_emp AS de
INNER JOIN departments as d
on (de.dept_no = d.dept_no)
INNER JOIN employees as e
ON (de.emp_no = e.emp_no);

SELECT * FROM employees
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%';

SELECT e.emp_no, 
e.last_name,
e.first_name,
dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales';

SELECT e.emp_no,
e.last_name,
e.first_name,
dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Development'
OR dp.dept_name LIKE 'Sales';

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;







