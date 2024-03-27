from flask import Flask, request, jsonify
from flask_cors import CORS
from sql_connection import get_sql_connection
import mysql.connector
import json

import products_dao
import orders_dao


app = Flask(__name__)
CORS(app)  # This will enable CORS for all routes

connection = get_sql_connection()

def create_trigger(connection):
    cursor = connection.cursor()

    # Drop triggers if they exist
    drop_product_trigger_query = "DROP TRIGGER IF EXISTS before_product_insert;"
    drop_category_trigger_query = "DROP TRIGGER IF EXISTS before_category_insert;"
    drop_product_delete_trigger_query = "DROP TRIGGER IF EXISTS before_product_delete;"
    cursor.execute(drop_product_trigger_query)
    cursor.execute(drop_category_trigger_query)
    cursor.execute(drop_product_delete_trigger_query)

    # Create trigger for product
    create_product_trigger_query = """
    CREATE TRIGGER before_product_insert
    BEFORE INSERT ON product
    FOR EACH ROW
    BEGIN
        IF (SELECT COUNT(*) FROM supplier WHERE supplierID = NEW.supplierID) = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'SupplierID does not exist in supplier table';
        END IF;
    END;
    """
    cursor.execute(create_product_trigger_query)

    # Create trigger for category
    create_category_trigger_query = """
    CREATE TRIGGER before_category_insert
    BEFORE INSERT ON product
    FOR EACH ROW
    BEGIN
        IF (SELECT COUNT(*) FROM category WHERE CategoryID = NEW.CategoryID) = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CategoryID does not exist in category table';
        END IF;
    END;
    """
    cursor.execute(create_category_trigger_query)

    # Create trigger for product deletion
    create_product_delete_trigger_query = """
    CREATE TRIGGER before_product_delete
    BEFORE DELETE ON product
    FOR EACH ROW
    BEGIN
        IF (SELECT COUNT(*) FROM cart WHERE Product_ID = OLD.ProductID) > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Product is in the cart, cannot delete';
        END IF;
    END;
    """
    cursor.execute(create_product_delete_trigger_query)

    connection.commit()

@app.route('/getProducts', methods=['GET'])
def get_products():
    response = products_dao.get_all_products(connection)
    # print(response)
    # return jsonify({'status': 'success', 'response': response})
    response = jsonify(response)
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response

@app.route('/insertProduct', methods=['POST'])
def insert_product():
    try:
        request_payload = json.loads(request.form['data'])
        product_id = products_dao.insert_new_product(connection, request_payload)
        response = jsonify({
            'product_id': product_id
        })
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response
    except mysql.connector.Error as error:
        return jsonify({'error': str(error)})

@app.route('/deleteProduct', methods=['POST'])
def delete_product():
    try:
        return_id = products_dao.delete_product(connection, request.form['ProductID'])
        response = jsonify({
            'product_id': return_id
        })
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response
    except mysql.connector.Error as error:
        return jsonify({'error': str(error)})

@app.route('/getAllOrders', methods=['GET'])
def get_all_orders():
    response = orders_dao.get_all_orders(connection)
    response = jsonify(response)
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response

if __name__ == "__main__":
    print("Starting Python Flask Server For FlipMart")
    create_trigger(connection)
    app.run(port=5000)