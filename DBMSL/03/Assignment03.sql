insert into Dept values(3,'Computer','Main Building',104);

INSERT INTO Employees VALUES (105, 'Pritam Khare', 'Float 100, Manas Apt', 'Nashik', '1995-05-05', '2019-02-15', 'F', 55000, 3, '98765 23210');
INSERT INTO Employees VALUES (103, 'Viraj Deo', 'Flat 509, Shree Apt', 'Mumbai', '1988-08-08', '2017-03-10', 'M', 70000, 3, '11122 23333');
INSERT INTO Employees VALUES (104, 'Mitali Patel', 'Flat 202, Shrusti Apt', 'Pune', '1992-12-15', '2016-05-20', 'F', 65000, 2, '44455 56666');

select * from Employees 
where month(DOB) = 1 and DeptNo = (select DeptNo from Dept where Name = 'Computer');

-- 1. List employees having a birthday in January of the Computer department:
SELECT E.*
FROM Employees E
JOIN Dept D ON E.deptno = D.Deptno
WHERE MONTH(E.dob) = 1 AND D.Name = 'Computer';

-- 2. Find the names of all employees who work for "ERP Project":
SELECT E.name
FROM Employees E
JOIN Works W ON E.empid = W.empid
JOIN Project P ON W.Projectid = P.Projectid
WHERE P.title = 'ERP Project';

-- 3. Find the names and cities of residence of employees who work for "Banking Project":
SELECT E.name, E.city
FROM Employees E
JOIN Works W ON E.empid = W.empid
JOIN Project P ON W.Projectid = P.Projectid
WHERE P.title = 'Banking Project';

-- 4. Find time required for "Banking Project":
SELECT P.title, SUM(total_hrs_worked) AS Total_Hours
FROM Works W
JOIN Project P ON W.Projectid = P.Projectid
WHERE P.title = 'Banking Project'
GROUP BY P.title;

-- 5. Find all employees in the database who live in the same cities as the project for which they work:
SELECT E.name, E.city, P.title
FROM Employees E
JOIN Works W ON E.empid = W.empid
JOIN Project P ON W.Projectid = P.Projectid
WHERE E.city = P.city;

-- 6. Find all employees who live in the same cities and on the same streets as their managers:
SELECT E1.name AS Employee_Name, E1.city AS Employee_City, E1.address AS Employee_Address,
       E2.name AS Manager_Name, E2.city AS Manager_City, E2.address AS Manager_Address
FROM Employees E1
JOIN Employees E2 ON E1.Managerempid = E2.empid AND E1.city = E2.city AND E1.address = E2.address;

-- 7. Find all employees who do not work for "Banking Project":
SELECT *
FROM Employees
WHERE empid NOT IN (SELECT empid FROM Works WHERE Projectid IN (SELECT Projectid FROM Project WHERE title = 'Banking Project'));

-- 8. Find the average salary of each department:
SELECT deptno, AVG(salary) AS Avg_Salary
FROM Employees
GROUP BY deptno;

-- 9. Find all employees who earn more than each employee of "Testing Department":
SELECT E1.name
FROM Employees E1
WHERE salary > ALL (SELECT salary FROM Employees E2 WHERE E2.deptno = (SELECT Deptno FROM Dept WHERE Name = 'Testing'));

-- 10. Find all employees who earn more than the average salary of their department:
SELECT E.name
FROM Employees E
WHERE salary > (SELECT AVG(salary) FROM Employees WHERE deptno = E.deptno);

-- 11. Find the department that has the most employees:
SELECT deptno, COUNT(*) AS Employee_Count
FROM Employees
GROUP BY deptno
ORDER BY Employee_Count DESC
LIMIT 1;

-- 12. Find the department that has the smallest payroll:
SELECT deptno, SUM(salary) AS Total_Payroll
FROM Employees
GROUP BY deptno
ORDER BY Total_Payroll
LIMIT 1;

-- 13. Find the employees working on each project:
SELECT P.title AS Project_Title, E.name AS Employee_Name
FROM Project P
LEFT JOIN Works W ON P.Projectid = W.Projectid
LEFT JOIN Employees E ON W.empid = E.empid;

-- 14. Find the employees who are not assigned to any project:
SELECT E.name
FROM Employees E
LEFT JOIN Works W ON E.empid = W.empid
WHERE W.empid IS NULL;

-- 15. Find the employees who are not assigned to any project as well as projects with no employees:
SELECT E.name AS Employee_Name
FROM Employees E
LEFT JOIN Works W ON E.empid = W.empid
WHERE W.empid IS NULL

UNION

SELECT P.title AS Project_Title
FROM Project P
LEFT JOIN Works W ON P.Projectid = W.Projectid
WHERE W.Projectid IS NULL;

-- 16. Find the employees whose department is located in "Main Building":
SELECT E.name, D.Name AS Department_Name
FROM Employees E
JOIN Dept D ON E.deptno = D.Deptno
WHERE D.Location = 'Main Building';

-- 17. Find employees working on more than 2 projects of "Development Department":
SELECT E.name, COUNT(DISTINCT W.Projectid) AS Project_Count
FROM Employees E
JOIN Works W ON E.empid = W.empid
JOIN Dept D ON E.deptno = D.Deptno
WHERE D.Name = 'Development'
GROUP BY E.name
HAVING Project_Count > 2;

-- 18. Display the senior person of "Testing Department":
SELECT E.name, MAX(E.dob) AS Senior_DOB
FROM Employees E
JOIN Dept D ON E.deptno = D.Deptno
WHERE D.Name = 'Testing'
GROUP BY E.name;

-- 19. Create a view containing the total number of employees whose project location is "Pune":
CREATE VIEW EmployeesInPune AS
SELECT E.*
FROM Employees E
JOIN Works W ON E.empid = W.empid
JOIN Project P ON W.Projectid = P.Projectid
WHERE P.city = 'Pune';

-- 20. Calculate total traveling allowance for all using a view (1000 rs each):
CREATE VIEW TotalTravelingAllowance AS
SELECT empid, COUNT(*) * 1000 AS Total_Allowance
FROM Works
GROUP BY empid;