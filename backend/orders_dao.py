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

# def insert_order( connection, order ):
#      cursor = connection.cursor()
#      order_query = 