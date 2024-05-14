from datetime import datetime
from sql_connection import get_sql_connection

def get_all_orders(connection):
    cursor = connection.cursor()
    query = ("SELECT * FROM ordertable ")
    cursor.execute(query)
    response = []
    for ( Order_ID, CustomerID,Freight , Ship_VIA ,OrderDate ,Quantity ,ProductID) in cursor:
        response.append({
            'Order_ID': Order_ID,
            'CustomerID': CustomerID,
            'Freight': Freight,
            'Ship_VIA': Ship_VIA,
            'OrderDate': OrderDate,
            'Quantity': Quantity,
            'ProductID': ProductID
        })
    return response


def insert_order(connection, request_payload):
    cursor = connection.cursor()

    # Extract constant order details
    order_details = request_payload['orderDetails']
    customer_id = None
    freight = None
    ship_via = None
    order_date = None

    for detail in order_details:
        if detail['name'] == 'customerID':
            customer_id = detail['value']
        elif detail['name'] == 'freight':
            freight = detail['value']
        elif detail['name'] == 'ship_VIA':
            ship_via = detail['value']
        elif detail['name'] == 'orderDate':
            order_date = detail['value']

    # Extract product details
    product_pairs = []
    current_product = {}
    for detail in order_details:
        if detail['name'] == 'productID':
            current_product['productID'] = detail['value']
        elif detail['name'] == 'quantity':
            current_product['quantity'] = detail['value']
            product_pairs.append(current_product.copy())

    # Insert order details and product details into the database
    for product in product_pairs:
        product_id = product['productID']
        quantity = product['quantity']

        # Insert product details into OrderTable
        order_query = ("INSERT INTO OrderTable "
                       "(CustomerID, Freight, Ship_VIA, OrderDate, Quantity, ProductID)"
                       "VALUES (%s, %s, %s, %s, %s, %s)")
        order_data = (customer_id, freight, ship_via, order_date, quantity, product_id)
        cursor.execute(order_query, order_data)

    connection.commit()
    return cursor.lastrowid



if __name__ == '__main__':
    # Establish a connection to the database
    connection = get_sql_connection()

    # Test case 1: Insert a single order
    order1 = {
        'CustomerID': '0123456789',
        'Freight': 10,
        'Ship_VIA': 'Shipper 1',
        'OrderDate': '2024-03-25',
        'Quantity': 1,
        'ProductID': 4
    }
    print("Testing with order1:", order1)
    order_id1 = insert_order(connection, order1)
    print("Order ID for order1:", order_id1)

    # Test case 2: Insert another order
    order2 = {
        'CustomerID': '9012345678',
        'Freight': 20,
        'Ship_VIA': 'Shipper 2',
        'OrderDate': '2024-03-26',
        'Quantity': 2,
        'ProductID': 2
    }
    print("Testing with order2:", order2)
    order_id2 = insert_order(connection, order2)
    print("Order ID for order2:", order_id2)

    # After testing, print all orders to verify if they're inserted correctly
    print(get_all_orders(connection))