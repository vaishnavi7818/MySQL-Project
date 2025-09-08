/* IMPORTANT INSTRUCTIONS FOR LEARNERS
1) DO NOT CHANGE THE ORDER OF COLUMNS.
2) YOUR QUERY SHOULD DISPLAY COLUMNS IN THE SAME ORDER AS MENTIONED IN ALL QUESTIONS.
3) YOU CAN FIND THE ORDER OF COLUMNS IN QUESTION TEMPLATE SECTION OF EACH QUESTION.
4) USE ALIASING AS MENTIONED IN QUESTION TEMPLATE FOR ALL COLUMNS
5) DO NOT CHANGE COLUMN NAMES*/
                   
-- Question 1 (Marks: 2)
-- Objective: Retrieve data using basic SELECT statements
-- List the names of all customers in the database.
-- Question Template: Display CustomerName Column

-- Write your SQL solution here
SELECT 
    CustomerName
FROM
    customers;

-- Question 2 (Marks: 2)
-- Objective: Apply filtering using the WHERE clause
-- Retrieve the names and prices of all products that cost less than $15.
-- Question Template: Display ProductName Column

-- Write your SQL solution here
SELECT 
    ProductName
FROM
    products
WHERE
    price < 15;

-- Question 3 (Marks: 2)
-- Objective: Use SELECT to extract multiple fields
-- Display all employees first and last names.
-- Question Template: Display FirstName, LastName Columns

-- Write your SQL solution here
SELECT 
    FirstName, LastName
FROM
    employees;


-- Question 4 (Marks: 2)
-- Objective: Filter data using a function on date values
-- List all orders placed in the year 1997.
-- Question Template: Display OrderID, OrderDate Columns

-- Write your SQL solution here
SELECT 
    OrderID, OrderDate
FROM
    orders
WHERE
    OrderDate between '1997-01-01' and '1997-12-31';

-- Question 5 (Marks: 2)
-- Objective: Apply numeric filters
-- List all products that have a price greater than $50.
-- Question Template: Display ProductName, Price Column

-- Write your SQL solution here
SELECT 
    ProductName, Price
FROM
    products
WHERE
    Price > 50;

-- Question 6 (Marks: 3)
-- Objective: Perform multi-table JOIN operations
-- Show the names of customers and the names of the employees who handled their orders.
-- Question Template: Display CustomerName, FirstName, LastName Columns

-- Write your SQL solution here
SELECT 
    c.CustomerName, e.FirstName, e.LastName
FROM
    customers c
        JOIN
    orders o ON c.CustomerID = o.CustomerID
        JOIN
    employees e ON o.EmployeeID = e.EmployeeID;

-- Question 7 (Marks: 3)
-- Objective: Use GROUP BY for aggregation
-- List each country along with the number of customers from that country.
-- Question Template: Display Country, CustomerCount Columns

-- Write your SQL solution here
SELECT 
    Country, COUNT(CustomerName) AS CustomerCount
FROM
    customers
GROUP BY Country
ORDER BY CustomerCount;

-- Question 8 (Marks: 3)
-- Objective: Group data by a foreign key relationship and apply aggregation
-- Find the average price of products grouped by category.
-- Question Template: Display CategoryName, AvgPrice Columns

-- Write your SQL solution here
SELECT 
    c.CategoryName, ROUND(AVG(p.Price)) AS AvgPrice
FROM
    categories c
        JOIN
    products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

-- Question 9 (Marks: 3)
-- Objective: Use aggregation to count records per group
-- Show the number of orders handled by each employee.
-- Question Template: Display EmployeeID, OrderCount Columns

-- Write your SQL solution here
SELECT 
    EmployeeID, COUNT(OrderID) AS OrderCount
FROM
    orders
GROUP BY EmployeeID
ORDER BY EmployeeID;

-- Question 10 (Marks: 3)
-- Objective: Filter results using values from a joined table
-- List the names of products supplied by "Exotic Liquids".
-- Question Template: Display ProductName Column

-- Write your SQL solution here
SELECT 
    p.ProductName
FROM
    products p
        JOIN
    suppliers s ON p.SupplierID = s.SupplierID
WHERE
    SupplierName = 'Exotic Liquid';

-- Question 11 (Marks: 5)
-- Objective: Rank records using aggregation and sort
-- List the top 3 most ordered products (by quantity).
-- Question Template: Display ProductID, TotalOrdered Columns

-- Write your SQL solution here
SELECT 
    ProductID, SUM(Quantity) AS TotalOrdered
FROM
    orderdetails
GROUP BY ProductID
ORDER BY TotalOrdered DESC
LIMIT 3;

-- Question 12 (Marks: 5)
-- Objective: Use GROUP BY and HAVING to filter on aggregates
-- Find customers who have placed orders worth more than $10,000 in total.
-- Question Template: Display CustomerName, TotalSpent Columns

-- Write your SQL solution here
SELECT 
    c.CustomerName, SUM(p.price * od.Quantity) AS TotalSpent
FROM
    customers c
        JOIN
    orders o ON c.CustomerID = o.CustomerID
        JOIN
    orderdetails od ON o.OrderID = od.OrderID
        JOIN
    products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID
HAVING TotalSpent > 10000
ORDER BY TotalSpent DESC;

-- Question 13 (Marks: 5)
-- Objective: Aggregate and filter at the order level
-- Display order IDs and total order value for orders that exceed $2,000 in value.
-- Question Template: Display OrderID, OrderValue Columns

-- Write your SQL solution here
SELECT 
    o.OrderID, SUM(p.Price * o.Quantity) AS OrderValue
FROM
    products p
        JOIN
    orderdetails o ON p.ProductID = o.ProductID
GROUP BY o.OrderID
HAVING OrderValue > 2000
ORDER BY OrderValue;

-- Question 14 (Marks: 5)
-- Objective: Use subqueries in HAVING clause
-- Find the name(s) of the customer(s) who placed the largest single order (by value).
-- Question Template: Display CustomerName, OrderID, TotalValue Column

-- Write your SQL solution here
SELECT
    c.CustomerName,
    o.OrderID,
    SUM(od.Quantity * p.Price) AS TotalValue
FROM
    Customers c
JOIN
    Orders o ON c.CustomerID = o.CustomerID
JOIN
    OrderDetails od ON o.OrderID = od.OrderID
JOIN
    Products p ON od.ProductID = p.ProductID
GROUP BY
    c.CustomerName,
    o.OrderID
HAVING
    TotalValue >= ALL (
        SELECT
            SUM(od2.Quantity * p2.Price)
        FROM
            OrderDetails od2
        JOIN
            Products p2 ON od2.ProductID = p2.ProductID
        GROUP BY
            od2.OrderID
    )
ORDER BY
    TotalValue DESC;

-- Question 15 (Marks: 5)
-- Objective: Identify records using NOT IN with subquery
-- Get a list of products that have never been ordered.
-- Question Template: Display ProductName Columns

-- Write your SQL solution here
SELECT 
    ProductName
FROM
    products
WHERE
    ProductID NOT IN (SELECT DISTINCT
            ProductID
        FROM
            orderdetails);