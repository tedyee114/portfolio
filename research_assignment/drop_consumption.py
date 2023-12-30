import csv
import sqlite3
conn = sqlite3.connect('C:\\Users\\tedye\\Desktop\\db_course\\retail_app.db')              # Establish a connection to the SQLite database
cursor = conn.cursor()                                  # Create a cursor object to execute SQL queries
cursor.execute('drop TABLE consumption;')  # Create a table in the database to store the CSV data
conn.commit()                                                  # Commit the changes to the database
cursor.close()
conn.close()