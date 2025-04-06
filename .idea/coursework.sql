CREATE DATABASE IF NOT EXISTS HauntedShop;
USE HauntedShop;

-- Table for staff members
CREATE TABLE Employees (
    EmpID VARCHAR(10) PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    AddressLine VARCHAR(100),
    City VARCHAR(50),
    PostCode VARCHAR(20),
    ContactNumber VARCHAR(15)
);

-- Staff salaries and employment details
CREATE TABLE EmployeePay (
    EmpID VARCHAR(10) PRIMARY KEY,
    Role VARCHAR(50),
    DateHired DATE,
    Salary DECIMAL(10,2),
    Bonus DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- Customer details
CREATE TABLE Customers (
    CustID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    StreetAddress VARCHAR(100),
    Region VARCHAR(50),
    Zip VARCHAR(20),
    Mobile VARCHAR(15),
    Email VARCHAR(100)
);

-- Products in stock
CREATE TABLE Products (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

-- Orders table
CREATE TABLE Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    CustID VARCHAR(10),
    ProductID VARCHAR(10),
    Quantity INT,
    DatePurchased DATE,
    FOREIGN KEY (CustID) REFERENCES Customers(CustID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Employee records
INSERT INTO Employees VALUES
('EMP001', 'Johnson', 'Marie', '12 Elm Street', 'Derby', 'DE1 3AB', '07923451234'),
('EMP002', 'Nguyen', 'Linh', '45 West Road', 'Sheffield', 'SH5 6FD', '07823451212'),
('EMP003', 'Singh', 'Raj', '5 Maple Ave', 'Leicester', 'LE4 3GH', '07788991234'),
('EMP004', 'Taylor', 'Chris', '88 King Lane', 'Nottingham', 'NG8 2DD', '07711441122'),
('EMP005', 'Ali', 'Zara', '34 Ivy Close', 'Birmingham', 'B12 9QQ', '07856789912');

-- Salary & role data
INSERT INTO EmployeePay VALUES
('EMP001', 'Sales Rep', '2017-06-15', 35000.00, 1000.00),
('EMP002', 'Marketing Lead', '2018-03-12', 32000.00, 0.00),
('EMP003', 'Stock Manager', '2019-09-01', 28000.00, 1500.00),
('EMP004', 'Warehouse', '2020-01-10', 24000.00, 300.00),
('EMP005', 'Warehouse', '2021-05-25', 23000.00, 200.00);

-- Customer records
INSERT INTO Customers VALUES
('CUS1001', 'Ben Carter', '23 Long Road', 'Leeds', 'LS2 7JJ', '07700000111', 'bcarter88@gmail.com'),
('CUS1002', 'Fatima Kaur', '5A Nightingale St', 'Leicester', 'LE5 3PP', '07899999876', 'fkaur@outlook.com'),
('CUS1003', 'Jamal King', '99 York Ave', 'Derby', 'DE6 5FF', '07866123456', 'jamal.king@gmail.com'),
('CUS1004', 'Emily Zhou', '3B Ivy Place', 'Sheffield', 'SH2 1XZ', '07789889944', 'emilyz98@yahoo.com'),
('CUS1005', 'Owen Ford', '74 Wilton Gardens', 'Nottingham', 'NG3 5TT', '07933445566', 'owen_ford@hotmail.com');

-- Product entries
INSERT INTO Products VALUES
('PROD001', 'Glow-in-the-dark Costume', 31.50),
('PROD002', 'Mini Pumpkin Light', 8.25),
('PROD003', 'Fang Teeth Set', 1.25),
('PROD004', 'Spooky Lantern', 10.00),
('PROD005', 'Costume Set', 12.00),
('PROD006', 'Candy Bags (Pack of 10)', 3.50),
('PROD007', 'Mask Assortment', 5.20);

-- Order data
INSERT INTO Orders VALUES
('ORD1001', 'CUS1001', 'PROD001', 1, '2021-10-05'),
('ORD1002', 'CUS1004', 'PROD007', 80, '2021-10-10'),
('ORD1003', 'CUS1005', 'PROD003', 30, '2021-09-25'),
('ORD1004', 'CUS1002', 'PROD001', 2, '2021-11-01'),
('ORD1005', 'CUS1005', 'PROD004', 12, '2021-08-17'),
('ORD1006', 'CUS1005', 'PROD003', 10, '2021-07-05'),
('ORD1007', 'CUS1002', 'PROD005', 1, '2021-11-15'),
('ORD1008', 'CUS1003', 'PROD001', 3, '2021-10-30');

-- Price update
UPDATE Products SET Price = 11.00 WHERE ProductID = 'PROD004';

-- Filter employees with low bonuses, sorted by start date
SELECT e.*, ep.Role, ep.DateHired, ep.Salary, ep.Bonus
FROM Employees e
JOIN EmployeePay ep ON e.EmpID = ep.EmpID
WHERE ep.Bonus <= 500
ORDER BY ep.DateHired ASC;

-- Spending summary per customer
SELECT c.CustID, c.Name, COUNT(o.OrderID) AS OrdersPlaced,
       SUM(p.Price * o.Quantity) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustID = o.CustID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustID;

-- Customers with big orders (over 15 items)
SELECT c.*
FROM Customers c
JOIN Orders o ON c.CustID = o.CustID
GROUP BY c.CustID
HAVING SUM(o.Quantity) > 15
ORDER BY c.Name;

-- Update job role
UPDATE EmployeePay
SET Role = 'Logistics Specialist'
WHERE Role = 'Warehouse';
