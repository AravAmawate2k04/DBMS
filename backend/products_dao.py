from sql_connection import get_sql_connection

def get_all_products(connection):
    cursor = connection.cursor()
    query = ("SELECT ProductID, ProductName, ProductDescription, UnitPrice, UnitWeight, SupplierID, CategoryID FROM product")
    cursor.execute(query)
    response = []
    for (ProductID, ProductName, ProductDescription, UnitPrice, UnitWeight, SupplierID, CategoryID) in cursor:
        response.append({
            'ProductID': ProductID,
            'ProductName': ProductName,
            'ProductDescription': ProductDescription,
            'UnitPrice': UnitPrice,
            'UnitWeight': UnitWeight,
            'SupplierID': SupplierID,
            'CategoryID': CategoryID
        })

    return response

def insert_new_product(connection, product):
    cursor = connection.cursor()
    query = ("INSERT INTO product "
             "(ProductName, ProductDescription,UnitPrice,UnitWeight,SupplierID,CategoryID)"
             "VALUES (%s, %s, %s, %s, %s, %s)")
    data = (product['ProductName'], product['ProductDescription'], product['UnitPrice'], product['UnitWeight'], product['SupplierID'], product['CategoryID'])
    

    cursor.execute(query, data)
    connection.commit()

    return cursor.lastrowid

def delete_product(connection, product_id):
    cursor = connection.cursor()
    query = ("DELETE FROM product WHERE ProductID=" + str(product_id))
    cursor.execute(query)
    connection.commit()

    return cursor.rowcount

if __name__ == "__main__":
    connection = get_sql_connection()
    print( get_all_products(connection) )