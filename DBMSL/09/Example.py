# pip install mysql-connector-python
import mysql.connector as mc

con = mc.connect(host='localhost', password = 'admin', user = 'root')

if con.is_connected():
    print("Python-MySQL connection established successfully !!")