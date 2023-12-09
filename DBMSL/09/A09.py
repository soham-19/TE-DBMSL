# pip install mysql-connector-python
import mysql.connector

# Function to establish a database connection
def connect_to_database():
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="admin",
        database="Assignment09"
    )
    return connection

# Function to create the employee table
def create_employee_table(cursor):
    cursor.execute("CREATE TABLE IF NOT EXISTS employee (empid INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), salary INT)")

# Function to insert a record into the employee table
def insert_record(cursor, name, salary):
    query = "INSERT INTO employee (name, salary) VALUES (%s, %s)"
    values = (name, salary)
    cursor.execute(query, values)
    print("Record inserted successfully.")

# Function to update values in the employee table
def update_record(cursor, empid, name, salary):
    query = "UPDATE employee SET name=%s, salary=%s WHERE empid=%s"
    values = (name, salary, empid)
    cursor.execute(query, values)
    print("Record updated successfully.")

# Function to delete a particular record from the employee table
def delete_record(cursor, empid):
    query = "DELETE FROM employee WHERE empid=%s"
    values = (empid,)
    cursor.execute(query, values)
    print("Record deleted successfully.")

# Function to display all records from the employee table
def display_all_records(cursor):
    cursor.execute("SELECT * FROM employee")
    records = cursor.fetchall()
    for record in records:
        print(record)

# Function to display employees having salary > 50000
def display_high_salary_employees(cursor):
    cursor.execute("SELECT * FROM employee WHERE salary > 50000")
    records = cursor.fetchall()
    for record in records:
        print(record)

# Function to display record for a particular employee
def display_record_for_employee(cursor, empid):
    query = "SELECT * FROM employee WHERE empid=%s"
    values = (empid,)
    cursor.execute(query, values)
    record = cursor.fetchone()
    if record:
        print(record)
    else:
        print("Employee not found.")

# Main function to implement the menu-driven program
connection = connect_to_database()
cursor = connection.cursor()

create_employee_table(cursor)

while True:
    print("\nEmployee Database Operations:")
    print("1. Insert Record")
    print("2. Update Record")
    print("3. Delete Record")
    print("4. Display All Records")
    print("5. Display Employees with Salary > 50000")
    print("6. Display Record for a particular Employee")
    print("7. Exit")

    choice = input("Enter your choice (1-7): ")

    if choice == "1":
        name = input("Enter employee name: ")
        salary = int(input("Enter employee salary: "))
        insert_record(cursor, name, salary)

    elif choice == "2":
        empid = int(input("Enter employee ID to update: "))
        name = input("Enter new name: ")
        salary = int(input("Enter new salary: "))
        update_record(cursor, empid, name, salary)

    elif choice == "3":
        empid = int(input("Enter employee ID to delete: "))
        delete_record(cursor, empid)

    elif choice == "4":
        display_all_records(cursor)

    elif choice == "5":
        display_high_salary_employees(cursor)

    elif choice == "6":
        empid = int(input("Enter employee ID to display: "))
        display_record_for_employee(cursor, empid)

    elif choice == "7":
        break

    else:
        print("Invalid choice. Please enter a number between 1 and 7.")

    # Close the database connection
connection.commit()
connection.close()
print("Program exited.")