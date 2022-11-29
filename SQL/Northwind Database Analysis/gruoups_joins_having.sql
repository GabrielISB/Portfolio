-- 1. The number of products with no units in stock
SELECT COUNT(*) from products where UnitsInStock = 0;




-- 2. The number of customers and the number of distinct company names of customers

SELECT COUNT(ContactName), COUNT(DISTINCT (CompanyName)) from customers


-- 3. The difference in age between the oldest and youngest employees

SELECT (MAX(BirthDate) - MIN(BirthDate)) from Employees 


-- 4. A list of regions, and for each region, a comma-separated list of its territories

SELECT RegionDescription as Region, 
GROUP_CONCAT(Territories.TerritoryDescription, ',') as Territory
FROM Regions JOIN Territories ON Territories.RegionID = Regions.RegionID
GROUP BY RegionDescription ;


-- 5. A list of names of categories that have more than 10 associated products

SELECT CategoryName, COUNT(*) FROM Products
JOIN Categories USING(CategoryID)
GROUP BY CategoryName 
HAVING COUNT(*) > 10;



-- 6.1 A list of order IDs and the total amount purchased on each order 

SELECT OrderID, SUM(UnitPrice * Quantity) as total 
FROM "Order Details" 
GROUP BY OrderID 

-- 6.2. A list of years, and the total amount ordered in each of those years

SELECT STRFTIME('%Y', OrderDate) as Years,
SUM(Quantity * UnitPrice)
FROM Orders 
JOIN "Order Details" USING(OrderID)
GROUP BY Years

-- 6.3 A list of order IDs and the total amount purchased IN THE SEAFOOD CATEGORY on each order

SELECT OrderID, SUM(Quantity * "Order Details".UnitPrice) FROM "Order Details"
JOIN Products USING(ProductID)
JOIN Categories USING(CategoryID)
WHERE CategoryName = 'Seafood'
GROUP BY OrderID;

-- 6.4 A list of order IDs and the total amount purchased IN THE SEAFOOD CATEGORY on each order, but only show orders that had a total of over $1000

SELECT OrderID, SUM(Quantity * "Order Details".UnitPrice) as Total FROM "Order Details"
JOIN Products USING(ProductID)
JOIN Categories USING(CategoryID)
WHERE CategoryName = 'Seafood'
GROUP BY OrderID
HAVING(Total) > 1000
