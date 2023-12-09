-- mysql -u root -p

create database Assignment;

use Assignment;

-- DDL to implement the schema:

create table Dept(
    DeptNo int primary key,
    Name varchar(100),
    Location varchar(100),
    Manager_EmpID int
);

create table Employees(
    EmpID int primary key,
    Name varchar(100),
    Address varchar(500),
    City varchar(100),
    DOB date,
    Date_Of_Joining date,
    gender char(1) check (gender in ('M', 'F')),
    salary int,
    DeptNo int,
    foreign key(DeptNo) references Dept(DeptNo)
);

create table Project(
    ProjectID int primary key,
    Title varchar(100),
    City varchar(100)
);

create table Works(
    EmpID int,
    ProjectID int,
    Total_Hrs_Worked int,
    foreign key(EmpID) references Employees(EmpID),
    foreign key(ProjectID) references Project(ProjectID)
);

create table Dependent(
    EmpID int,
    Name_Of_Dependent varchar(100),
    Age int check(Age > 0),
    Relation varchar(100),
    foreign key(EmpID) references Employees(EmpID)
);

-- Insert data:

insert into Dept 
values (1, 'Development', 'Building 1', 101);
insert into Dept 
values (2, 'Testing', 'Building 2', 102);

insert into Employees values (
    101, 
    'Rahul Jain', 
    'Flat No 408, Shree Apt', 
    'Nashik', 
    '1999-12-10', 
    '2019-11-09', 
    'M',
    85000,
    1
);

insert into Employees values (
    102, 
    'Preeti Shah', 
    'Flat No 104, Gangotri Apt', 
    'Pune', 
    '2001-02-10', 
    '2021-01-09', 
    'F',
    45000,
    2
);

insert into Project
values (1, 'Banking Project', 'Pune');

insert into Project
values (2, 'Testing Project', 'Mumbai');

insert into Works 
values(101, 1, 45);

insert into Works 
values(102, 1, 45);

insert into Dependent
values(101, 'Nisha Awasthi', 31, 'Spouse');

insert into Dependent
values(102, 'Nikhil Luthra', 35, 'Spouse');

-- Add column Mobile number in the employee table:

alter table Employees
add column MobileNo varchar(15);

-- Update mobile numbers for each employee:

update Employees
set MobileNo = '83293 10531'
where EmpID = 101;

update Employees
set MobileNo = '82463 10101'
where EmpID = 101;

-- Delete the "Testing Project" entry:

delete from Project
where Title like "%Testing%";

-- List employees with names starting with 'S':

select * from Employees
where Name like 'R%';

-- List departments with location 'Building 1':

select * from Dept
where Location = 'Building 1';

-- List employees joining in the year 2019 to 2020:

select * from Employees
where year(Date_Of_Joining) between 2019 and 2020;

-- Display employees with a salary greater than 50000:

select * from Employees 
where salary > 50000;

-- Display all projects in "Pune":

select * from Project
where City = 'Pune';

-- Display all dependants of an employee:

select * from Dependent
where EmpID = 102;

-- Display all manager names:

select distinct EmpId as ID, E.name as ManagerName
from Employees E
where E.EmpID in (select Manager_EmpID from Dept);

-- Find the age of all employees:

select EmpID, Name, 
timestampdiff(year, dob, curdate()) as Age
From Employees;

-- Display all employees in descending order of age:

select EmpID, Name, 
timestampdiff(year, dob, curdate()) as Age
From Employees
order by Age Asc;