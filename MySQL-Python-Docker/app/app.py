from flask import Flask
import mysql.connector
app=Flask(__name__)
@app.route('/')
def index():
    try:
        conn=mysql.connector.connect(
        host= 'my-sql-container',
        user= 'root',
        password= 'root123',
        database= 'testdb',
        )
        cursor=conn.cursor()
        cursor.execute("SELECT NOW();")
        result=cursor.fetchone()
        return f"Connected to MySQL! Current time:{result[0]}"
    except mysql.connector.Error as err:
        return f";Error:{err}"
    
app.run(host='0.0.0.0', port=5000)
