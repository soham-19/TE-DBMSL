import mysql.connector

def connect_to_database():
    connection = mysql.connector.connect(
        user = 'root',
        host = 'localhost',
        password = 'admin',
        database = 'Assignment09'
    )
    return connection

def create_employee_table(cursor):
    query = 'drop table if exists employee'
    cursor.execute(query)

    query = 'create table if not exists employee(empid int auto_increment primary key, name varchar(50), salary int)'
    cursor.execute(query)
    print('Table created successfully.')

def insert_record(cursor, name, salary):
    query = 'insert into employee(name, salary) values(%s, %s)'
    values = (name, salary)
    cursor.execute(query, values)
    print('Record inserted successfully.')

def update_record(cursor, empid, name, salary):
    query = 'update employee set name =%s, salary=%s where empid=%s'
    values = (name, salary,empid)
    cursor.execute(query, values)
    print('Record updated successfully.')

def delete_record(cursor, empid):
    query = 'delete from employee where empid=%s'
    values = (empid,)
    cursor.execute(query, values)
    print('Record deleted successfully.')

def display_all_records(cursor):
    cursor.execute('select * from employee')
    records = cursor.fetchall()
    for record in records:
        print(record)

def display_employees_with_salary_greater_than_50000(cursor):
    cursor.execute('select * from employee where salary > 50000')
    records = cursor.fetchall()
    for record in records:
        print(record)

def display_employee(cursor, empid):
    query = 'select * from employee where empid = %s'
    values = (empid,)
    cursor.execute(query, values)
    record = cursor.fetchone()
    if record:
        print(record)
    else:
        print('Record not found.')

connection = connect_to_database()
if connection.is_connected():
    print('MySQL-Python connection established successfully!!')
else:
    exit()

cursor = connection.cursor()

create_employee_table(cursor)

while True:
    print('\nEmployee Database Operations :')
    print('1. Insert Record')
    print('2. Update REcord')
    print('3. Delete Record')
    print('4. Display All Records')
    print('5. Display Employees with Salary > 50,000')
    print('6. Display Record for a particular Employee')
    print('7. Exit')
    
    choice = input('Enter your choice (1-7): ')

    if choice == '1':
        name = input('Enter Employee Name: ')
        salary = int(input('Enter Employee Salary: '))
        insert_record(cursor, name, salary)

    elif choice == '2':
        empid = int(input('Enter EmployeeID to update: '))
        name = input('Enter New Name: ')
        salary = int(input('Enter New Salary: '))
        update_record(cursor, empid, name, salary)

    elif choice == '3':
        empid = int(input('Enter EmployeeID to delete: '))
        delete_record(cursor, empid)

    elif choice == '4':
        display_all_records(cursor)

    elif choice == '5':
        display_employees_with_salary_greater_than_50000(cursor)

    elif choice == '6':
        empid = int(input('Enter EmployeeID to display: '))
        display_employee(cursor, empid)

    elif choice == '7':
        break
    
    else:
        print('Invalid choice. Please enter a number between 1 and 7.')

    connection.commit()    
    
connection.close()
print('Program Exited')  