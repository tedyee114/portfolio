#region 0: import libraries and prepare environment
from flask import Flask, render_template, request
import sqlite3
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import io
import base64
import pandas as pd
import pathlib

app = Flask(__name__)
#endregion


#region 1: homepage##############################################################################################
@app.route('/')
@app.route('/homepage')
def homepage():
    return render_template('homepage.html')
#endregion


#region 2: customers##############################################################################################
@app.route('/add_customer', methods=['GET', 'POST'])
def add_customer():
    if request.method == 'POST':
        # read the form data
        customer_first_name = request.form.get('customer_first_name')
        customer_last_name = request.form.get('customer_last_name')
        customer_gender = request.form.get('customer_gender')
        customer_dob = request.form.get('customer_dob')


        db_file = 'C:/Users/tedye/Desktop/db_course/retail_app.db'  #database connection
        conn = sqlite3.connect(db_file)
        cursor = conn.cursor()
        
        # retrieve the maximum customer_id from the customer table
        cursor.execute("SELECT MAX(customer_id) FROM customer")
        max_customer_id = cursor.fetchone()[0]

        # if the table is empty, start with customer_id = 1
        if max_customer_id is None:
            customer_id = 1
        else:
            customer_id = max_customer_id + 1

        # insert a new record into the customer table
        cursor.execute("INSERT INTO customer (customer_id, customer_first_name,\
        customer_last_name, customer_gender, customer_dob)\
        VALUES (?, ?, ?, ?, ?)",\
        (customer_id, customer_first_name, customer_last_name,\
        customer_gender, customer_dob))

        # commit the transaction
        conn.commit()

        # close the database connection
        conn.close()

        # return a response to the user
        return ('<h1>Success</h1>The customer record has been \
        successfully added to the database.')

    else:
        # Render the form
        return render_template('add_customer.html')
#endregion


#region 3: products##############################################################################################
@app.route('/get_product', methods=['GET', 'POST'])

def get_product():
    if request.method == 'POST':
        product_id = request.form['product_id']     #read form data

        db_file = 'C:/Users/tedye/Desktop/db_course/retail_app.db'  #database connection
        conn = sqlite3.connect(db_file)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM product WHERE product_id=?", (product_id,))
        output = cursor.fetchall()
        cursor.close()
        conn.close()
        if output is None:
            message = 'product with id {} does not exist.'.format(product_id)
            return render_template('get_product.html', message=message)
        else:
            return render_template('get_product.html', output=output)
    else:
        return render_template('get_product.html')
#endregion


if __name__ == '__main__':
    app.run(debug=True)