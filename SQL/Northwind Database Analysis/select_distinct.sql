-- 1. A list of the distinct countries where customers are located, sorted alphabetically

SELECT DISTINCT Country from Customers order by Country ASC;


-- 2. The NUMBER of distinct countries where customers are located

SELECT COUNT(DISTINCT Country) as Numcountries from Customers;  


-- 3. The NUMBER of orders that have been made by the customer with id 'FRANK'

SELECT COUNT(OrderID) from Orders where CustomerID = 'FRANK';


-- 4. The id and name of products that are NOT discontinued but ARE out of stock

SELECT productID, productName from Products where UnitsInStock = 0 AND Discontinued = 0;

-- 5. The id, name, units in stock, and units on order of products that are
--    NOT discontinued, and: either not in stock or have more units on order than are in stock 

SELECT productID, ProductName, UnitsInStock, UnitsOnOrder from Products where Discontinued != 1 and UnitsInStock < UnitsOnOrder;



-- 6. A list of DISTINCT ids of customers who made orders in December

SELECT DISTINCT customerID from Orders 
WHERE (OrderDate BETWEEN '1996-12-01' and '1997-01-01') 
or (OrderDate BETWEEN '1997-12-01' and '1998-01-01')
or (OrderDate BETWEEN '1998-12-01' and '1999-01-01');

-- 7. The company, name, title, and phone number of North American customers

SELECT CompanyName, ContactName, ContactTitle, Phone from Customers 
WHERE Country = 'USA' 
or Country = 'Mexico' 
or Country = 'Canada';


-- 8. The name of companies with NO fax number

SELECT CompanyName from Customers WHERE Fax ISNULL;

-- 9. The id, name, and unit price of the 5 most expensive products.
--    The unit price must be displayed with the heading 'Price',
--    it must show and dollar sign, and be rounded to the nearest dollar.

SELECT productID, productName, '$' || Round(UnitPrice,0) as Price from Products 
order by UnitPrice DESC LIMIT 5;


-- 10. Using a single statement, insert at least two new Categories with no pictures

INSERT INTO Categories (CategoryName, Description) 
values ('Mexicana', 'Spicy and the best'), ('Japanese', 'Fish and Sushi');


-- 11. Make an update to one of the categories you inserted above

UPDATE Categories SET CategoryName = 'Mexican' WHERE CategoryID = 11; 



-- 12. In a single statement, delete all (and only) the categories you inserted above

DELETE FROM Categories WHERE CategoryID >= 11;
