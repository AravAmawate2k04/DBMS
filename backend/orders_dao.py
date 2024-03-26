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


def insert_order(connection, order):
    cursor = connection.cursor()
    order_query = ("INSERT INTO OrderTable "
                   "(CustomerID, Freight, Ship_VIA, OrderDate, Quantity, ProductID)"
                   "VALUES (%s, %s, %s, %s, %s, %s)")
    order_data = (order['CustomerID'], order['Freight'], order['Ship_VIA'], order['OrderDate'],
                  order['Quantity'], order['ProductID'])

    cursor.execute(order_query, order_data)
    order_id = cursor.lastrowid
    
    connection.commit()

    return order_id

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

