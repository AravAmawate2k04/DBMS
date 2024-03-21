-- Create a new database named 'filpmart'
CREATE DATABASE IF NOT EXISTS filpmart;

-- Switch to the 'filpmart' database
USE filpmart;

-- Create tables and insert data
CREATE TABLE Admin (
    AdminID INTEGER PRIMARY KEY AUTO_INCREMENT,
    AdminPassword TEXT NOT NULL,
    AdminFName TEXT NOT NULL,
    AdminLName TEXT NOT NULL
);
CREATE TABLE ShoppingWebsite (
    WebsiteURL VARCHAR(255) PRIMARY KEY,
    ContactNumber BIGINT,
    WebsiteName TEXT NOT NULL,
    AdminId INTEGER,
    FOREIGN KEY (AdminId) REFERENCES Admin(AdminID)
);
CREATE TABLE Category (
    CategoryID INTEGER PRIMARY KEY AUTO_INCREMENT,
    CategoryDescription TEXT,
    CategoryName TEXT NOT NULL,
    Picture TEXT,
 WebsiteURL VARCHAR(255) ,
    FOREIGN KEY (WebsiteURL) REFERENCES ShoppingWebsite(WebsiteURL)
);
CREATE TABLE personalinfo (
    Phone VARCHAR(20) PRIMARY KEY,
    Email TEXT,
    Address TEXT,
    PostalCode INTEGER,
    City TEXT,
    Country TEXT
);
CREATE TABLE Customer (
    CustomerID VARCHAR(20) PRIMARY KEY,
    FirstName TEXT NOT NULL,
    MiddleName TEXT,
    LastName TEXT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES personalinfo(Phone)
);
CREATE TABLE Supplier (
    supplierID VARCHAR(20) PRIMARY KEY,
    ContactName TEXT NOT NULL,
    ContactNumber BIGINT,
    FOREIGN KEY (supplierID) REFERENCES personalinfo(Phone)
);
CREATE TABLE Product (
    ProductID INTEGER PRIMARY KEY AUTO_INCREMENT,
    ProductName TEXT NOT NULL,
    ProductDescription TEXT,
    UnitPrice INTEGER,
    UnitWeight FLOAT,
    Picture TEXT,
    SupplierID VARCHAR(20),
    CategoryID INTEGER,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(supplierID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);


CREATE TABLE OrderTable(
    Order_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    CustomerID VARCHAR(20),
    Freight INTEGER,
    Ship_VIA TEXT,
    OrderDate DATE,
    Quantity INTEGER,
    ProductID INTEGER,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);









CREATE TABLE Payment (
    BillingID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Bill_Date DATE,
    CreditCardID INTEGER,
    BillingAddress TEXT,
    CreditCard_ExpDate DATE,
    CreditCard_PIN INTEGER,
    CreditCardNo BIGINT,
    OrderID INTEGER,
    FOREIGN KEY (OrderID) REFERENCES OrderTable(Order_ID)
);

CREATE TABLE Billing_Info (
    ShipperID INTEGER PRIMARY KEY AUTO_INCREMENT,
    CompanyName TEXT,
    PhoneNo BIGINT,
    OrderID INTEGER,
    FOREIGN KEY (OrderID) REFERENCES OrderTable(Order_ID)
);



CREATE TABLE Cart (
    No_Of_Products INTEGER,
    Total_Price INTEGER,
    Product_ID INTEGER,
    CustomerID VARCHAR(20),
    PRIMARY KEY (Product_ID, CustomerID),
    FOREIGN KEY (Product_ID) REFERENCES Product(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Tracking (
    TrackingId INTEGER PRIMARY KEY AUTO_INCREMENT,
    RequiredDate DATE,
    ShippedDetails DATE,
    OrderID INTEGER,
    FOREIGN KEY (OrderID) REFERENCES OrderTable(Order_ID)
);

-- Data Population --
-- Inserting data into Admin table
INSERT INTO Admin (AdminPassword, AdminFName, AdminLName) 
VALUES 
('adminpass1', 'John', 'Doe'),
('adminpass2', 'Jane', 'Smith'),
('adminpass3', 'Alice', 'Johnson'),
('adminpass4', 'Bob', 'Williams'),
('adminpass5', 'Charlie', 'Brown'),
('adminpass6', 'David', 'Lee'),
('adminpass7', 'Emily', 'Davis'),
('adminpass8', 'Frank', 'Wilson'),
('adminpass9', 'Grace', 'Martinez'),
('adminpass10', 'Henry', 'Anderson');

-- Inserting data into ShoppingWebsite table
INSERT INTO ShoppingWebsite (WebsiteURL, ContactNumber, WebsiteName, AdminId) 
VALUES 
('http://www.amazon.com', 1234567890, 'Amazon', 1),
('http://www.newegg.com', 2345678901, 'Newegg', 2),
('http://www.bestbuy.com', 3456789012, 'Best Buy', 3),
('http://www.microcenter.com', 4567890123, 'Micro Center', 4),
('http://www.bhphotovideo.com', 5678901234, 'B&H Photo Video', 5),
('http://www.walmart.com', 6789012345, 'Walmart', 6),
('http://www.target.com', 7890123456, 'Target', 7),
('http://www.costco.com', 8901234567, 'Costco', 8),
('http://www.staples.com', 9012345678, 'Staples', 9),
('http://www.officedepot.com', 0123456789, 'Office Depot', 10);

-- Inserting data into Category table
INSERT INTO Category (CategoryDescription, CategoryName, Picture) 
VALUES 
('Electronics', 'Electronics', 'electronics.jpg'),
('Computers', 'Computers', 'computers.jpg'),
('Accessories', 'Accessories', 'accessories.jpg'),
('Peripherals', 'Peripherals', 'peripherals.jpg'),
('Storage', 'Storage', 'storage.jpg'),
('Software', 'Software', 'software.jpg'),
('Office Supplies', 'Office Supplies', 'office_supplies.jpg'),
('Furniture', 'Furniture', 'furniture.jpg'),
('Appliances', 'Appliances', 'appliances.jpg'),
('Home Decor', 'Home Decor', 'home_decor.jpg');

-- Inserting data into personalinfo table
INSERT INTO personalinfo (Phone, Email, Address, PostalCode, City, Country) 
VALUES 
('1234567890', 'john.doe@example.com', '123 Main St', 12345, 'Anytown', 'USA'),
('2345678901', 'jane.smith@example.com', '456 Oak Ave', 23456, 'Sometown', 'USA'),
('3456789012', 'alice.johnson@example.com', '789 Elm Blvd', 34567, 'Othertown', 'USA'),
('4567890123', 'bob.williams@example.com', '101 Pine Rd', 45678, 'Smalltown', 'USA'),
('5678901234', 'charlie.brown@example.com', '222 Maple Dr', 56789, 'Bigtown', 'USA'),
('6789012345', 'david.lee@example.net', '333 Cedar Ct', 67890, 'Largetown', 'USA'),
('7890123456', 'emily.davis@example.com', '444 Oak St', 78901, 'Hometown', 'USA'),
('8901234567', 'frank.wilson@example.com', '555 Elm Ave', 89012, 'Anycity', 'USA'),
('9012345678', 'grace.martinez@example.com', '666 Pine Ln', 90123, 'Sometown', 'USA'),
('0123456789', 'harry.anderson@example.com', '777 Maple Rd', 01234, 'Othertown', 'USA');

-- Inserting data into personalinfo table for suppliers
INSERT INTO personalinfo (Phone, Email, Address, PostalCode, City, Country) 
VALUES 
('1111111111', 'supplier1@example.com', '123 Supplier St', 11111, 'Supplier City 1', 'USA'),
('2222222222', 'supplier2@example.com', '456 Supplier Ave', 22222, 'Supplier City 2', 'USA'),
('3333333333', 'supplier3@example.com', '789 Supplier Blvd', 33333, 'Supplier City 3', 'USA'),
('4444444444', 'supplier4@example.com', '101 Supplier Rd', 44444, 'Supplier City 4', 'USA'),
('5555555555', 'supplier5@example.com', '222 Supplier Dr', 55555, 'Supplier City 5', 'USA'),
('6666666666', 'supplier6@example.com', '333 Supplier Ct', 66666, 'Supplier City 6', 'USA'),
('7777777777', 'supplier7@example.com', '444 Supplier St', 77777, 'Supplier City 7', 'USA'),
('8888888888', 'supplier8@example.com', '555 Supplier Ave', 88888, 'Supplier City 8', 'USA'),
('9999999999', 'supplier9@example.com', '666 Supplier Ln', 99999, 'Supplier City 9', 'USA'),
('1010101010', 'supplier10@example.com', '777 Supplier Rd', 10101, 'Supplier City 10', 'USA');

-- Inserting data into Customer table
INSERT INTO Customer (CustomerID, FirstName, MiddleName, LastName) 
VALUES 
('1234567890', 'John', NULL, 'Doe'),
('2345678901', 'Jane', NULL, 'Smith'),
('3456789012', 'Alice', NULL, 'Johnson'),
('4567890123', 'Bob', NULL, 'Williams'),
('5678901234', 'Charlie', NULL, 'Brown'),
('6789012345', 'David', NULL, 'Lee'),
('7890123456', 'Emily', NULL, 'Davis'),
('8901234567', 'Frank', NULL, 'Wilson'),
('9012345678', 'Grace', NULL, 'Martinez'),
('0123456789', 'Henry', NULL, 'Anderson');

-- Inserting data into Supplier table
INSERT INTO Supplier (supplierID, ContactName, ContactNumber) 
VALUES 
('1111111111', 'Supplier 1 Contact', 1111111111),
('2222222222', 'Supplier 2 Contact', 2222222222),
('3333333333', 'Supplier 3 Contact', 3333333333),
('4444444444', 'Supplier 4 Contact', 4444444444),
('5555555555', 'Supplier 5 Contact', 5555555555),
('6666666666', 'Supplier 6 Contact', 6666666666),
('7777777777', 'Supplier 7 Contact', 7777777777),
('8888888888', 'Supplier 8 Contact', 8888888888),
('9999999999', 'Supplier 9 Contact', 9999999999),
('1010101010', 'Supplier 10 Contact', 1010101010);


-- Inserting data into Product table
INSERT INTO Product (ProductName, ProductDescription, UnitPrice, UnitWeight, Picture, SupplierID, CategoryID) 
VALUES 
('Laptop', 'High performance laptop', 1200, 2, 'laptop.jpg', 1111111111, 1),
('Smartphone', 'Latest smartphone model', 900, 1, 'smartphone.jpg', 2222222222, 1),
('Headphones', 'Noise-canceling headphones', 150, 0.5, 'headphones.jpg', 3333333333, 2),
('Camera', 'Digital camera with advanced features', 800, 1.5, 'camera.jpg', 4444444444, 2),
('Printer', 'Wireless all-in-one printer', 300, 5, 'printer.jpg', 5555555555, 3),
('Tablet', '10-inch tablet with HD display', 500, 1.2, 'tablet.jpg', 6666666666, 3),
('Mouse', 'Ergonomic wireless mouse', 50, 0.2, 'mouse.jpg', 7777777777, 4),
('Keyboard', 'Mechanical gaming keyboard', 100, 1, 'keyboard.jpg', 8888888888, 4),
('Monitor', '27-inch LED monitor', 250, 7, 'monitor.jpg', 9999999999, 5),
('External Hard Drive', '1TB portable external hard drive', 80, 0.3, 'hard_drive.jpg', 1010101010, 5);


-- Inserting data into Order table
INSERT INTO OrderTable (CustomerID, Freight, Ship_VIA, OrderDate, Quantity, ProductID) 
VALUES 
('1234567890', 10, 'Shipper 1', 20240101, 1, 1),
('2345678901', 20, 'Shipper 2', 20240102, 2, 2),
('3456789012', 30, 'Shipper 3', 20240103, 3, 3),
('4567890123', 40, 'Shipper 4', 20240104, 4, 4),
('5678901234', 50, 'Shipper 5', 20240105, 5, 5),
('6789012345', 60, 'Shipper 6', 20240106, 6, 6),
('7890123456', 70, 'Shipper 7', 20240107, 7, 7),
('8901234567', 80, 'Shipper 8', 20240108, 8, 8),
('9012345678', 90, 'Shipper 9', 20240109, 9, 9),
('0123456789', 100, 'Shipper 10', 20240110, 10, 10);















-- Inserting data into Payment table
INSERT INTO Payment (Bill_Date, CreditCardID, BillingAddress, CreditCard_ExpDate, CreditCard_PIN, CreditCardNo, OrderID) 
VALUES 
(20240101, 123, 'Billing Address 1', 20240101, 1234, 1234567890123456, 1),
(20240102, 456, 'Billing Address 2', 20240102, 5678, 2345678901234567, 2),
(20240103, 789, 'Billing Address 3', 20240103, 9012, 3456789012345678, 3),
(20240104, 1011, 'Billing Address 4', 20240104, 1112, 4567890123456789, 4),
(20240105, 1314, 'Billing Address 5', 20240105, 1415, 5678901234567890, 5),
(20240106, 1617, 'Billing Address 6', 20240106, 1718, 6789012345678901, 6),
(20240107, 1920, 'Billing Address 7', 20240107, 2021, 7890123456789012, 7),
(20240108, 2223, 'Billing Address 8', 20240108, 2324, 8901234567890123, 8),
(20240109, 2526, 'Billing Address 9', 20240109, 2627, 9012345678901234, 9),
(20240110, 2829, 'Billing Address 10', 20240110, 2930, 0123456789012345, 10);

-- Inserting data into Billing_Info table
INSERT INTO Billing_Info (CompanyName, PhoneNo, OrderID) 
VALUES 
('Company 1', 1234567890, 1),
('Company 2', 2345678901, 2),
('Company 3', 3456789012, 3),
('Company 4', 4567890123, 4),
('Company 5', 5678901234, 5),
('Company 6', 6789012345, 6),
('Company 7', 7890123456, 7),
('Company 8', 8901234567, 8),
('Company 9', 9012345678, 9),
('Company 10', 0123456789, 10);


-- Inserting data into Cart table
INSERT INTO Cart (No_Of_Products, Total_Price, Product_ID, CustomerID) 
VALUES 
(1, 50, 1, '1234567890'),
(2, 100, 2, '2345678901'),
(3, 150, 3, '3456789012'),
(4, 200, 4, '4567890123'),
(5, 250, 5, '5678901234'),
(6, 300, 6, '6789012345'),
(7, 350, 7, '7890123456'),
(8, 400, 8, '8901234567'),
(9, 450, 9, '9012345678'),
(10, 500, 10, '0123456789');

-- Inserting data into Tracking table
INSERT INTO Tracking (RequiredDate, ShippedDetails, OrderID) 
VALUES 
('2024-01-15', '2024-01-10', 1),
('2024-01-16', '2024-01-11', 2),
('2024-01-17', '2024-01-12', 3),
('2024-01-18', '2024-01-13', 4),
('2024-01-19', '2024-01-14', 5),
('2024-01-20', '2024-01-15', 6),
('2024-01-21', '2024-01-16', 7),
('2024-01-22', '2024-01-17', 8),
('2024-01-23', '2024-01-18', 9),
('2024-01-24', '2024-01-19', 10);