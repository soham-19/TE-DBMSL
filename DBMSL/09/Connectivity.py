import mysql.connector;

def connect_to_database():
    connector = mysql.connector.connect(
        host = 'localhost',
        user = 'root',
        password = 'admin',
        database = 'Assignment09'
    )
    return connector

def create_table(cursor):
    query = 'create table Employee(empid int auto_increment primary key, name varchar(50), salary int);'
    cursor.execute(query)
    print('Employee table created')

def insert_record(cursor):
    name = input('Enter name: ')
    salary = input('Enter salary: ')
    query = 'insert into Employee(name, salary) values(%s, %s)'
    values = (name, salary)
    cursor.execute(query, values)
    print('Record inserted\n')

def update_record(cursor):
    id = int(input('Enter employee id:'))
    name = input('Enter new name:')
    salary = input('Enter new  salary:')
    
    query = 'update Employee set name = %s, salary = %s where empid=%s'
    values = (name, salary, id)
    cursor.execute(query, values)
    print('Record updated\n')

def delete_record(cursor):
    id = int(input('Enter employee id:'))
    query = 'delete from Employee where empid=%s'
    values = (id,)
    cursor.execute(query, values)
    print('Record deleted\n')

def displayAll(cursor):
    query = 'select * from Employee'
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)

def display(cursor):
    id = input('Enter id to be searched: ')
    query = 'select * from Employee where empid = %s'
    values = (id,)
    cursor.execute(query)
    record = cursor.fetchone()
    if record:
        print(record)
    else:
        print("Record doesn't exist\n")

def salary_constraint(cursor):
    query = 'select * from Employee where salary > 50000'
    cursor.execute(query)
    records = cursor.fetchAll()
    for record in records:
        print(record)

connection = connect_to_database()

if connection.is_connected():
    print('MySQL-Python connection established successfully')
else:
    print('MySQL-Python connection failed!')
    exit()

cursor = connection.cursor()

create_table(cursor)

while True:
    print('Employee Table Operations')
    print('1. Insert a record')
    print('2. Update a record')
    print('3. Delete a record')
    print('4. Display all records')
    print('5. Display a particular records')
    print('6. Display all employees having salary > 50000')
    print('7. Exit')
    
    choice = input('Enter your choice ')
    
    if choice == '1':
        insert_record(cursor)
    elif choice == '2':
        update_record(cursor)
    elif choice == '3':
        delete_record(cursor)
    elif choice == '4':
        displayAll(cursor)
    elif choice == '5':
        display(cursor)
    elif choice == '6':
        salary_constraint(cursor)
    elif choice == '7':
        break
    else:
        print('Invalid choice!!')
    connection.commit()

print('Program exited')

connection.close()