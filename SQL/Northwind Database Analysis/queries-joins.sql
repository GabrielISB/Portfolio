-- 1.1 A list of product names.  Beside each product name, the category that product belongs to

SELECT ProductName, CategoryName from Products
Join Categories ON Categories.CategoryID = Products.CategoryID;



-- 1.2 A list of Order IDs, Order Dates, Company Names, and Countries for orders made by North American customers, sorted by order date

SELECT OrderID, OrderDate, CompanyName, Country from Orders
Join Customers ON Customers.CustomerID = Orders.CustomerID 
where Customers.Country = 'Canada' or Customers.Country = 'USA' or Customers.Country = 'Mexico'
ORDER BY OrderDate;


-- 1.3 A list of DISTINCT names of suppliers that have products in the 'Seafood' category

Select DISTINCT CompanyName from Suppliers 
Join Products ON Products.SupplierID = Suppliers.SupplierID 
Join Categories ON Categories.CategoryID = Products.CategoryID 
WHERE Categories.CategoryName = 'Seafood'; 




-- 1.4.1 A list of Territory IDs and Descriptions.  For each row, show the ID of any Employee associated with the territory.

SELECT TerritoryID, TerritoryDescription, EmployeeID from Territories
Left Join EmployeeTerritories 
USING(TerritoryID);

-- 1.4.2 A list of IDs and Descriptions of any territories that currently have NO associated employees

SELECT TerritoryID, TerritoryDescription from Territories
Left Join EmployeeTerritories USING(TerritoryID) WHERE EmployeeID IS NULL;


-- 1.4.3 A list of IDs, Descriptions, AND REGION NAMES of any territories that currently have NO associated employees

SELECT TerritoryID, TerritoryDescription, RegionDescription from Territories
Left Join EmployeeTerritories USING(TerritoryID) 
Left Join Regions USING(RegionID) 
WHERE EmployeeID IS NULL;

-- 1.5 A list of all possible combinations of Regions and Product Categories

SELECT * from Regions
Cross Join Categories; 


-- 1.6.1 A list of Order IDs that shows the customer company name and employee name associated with that order

SELECT OrderID, CompanyName, FirstName, LastName from Orders
Left Join Customers USING(CustomerID)
Left Join Employees USING(EmployeeID);


-- 1.6.2 Same as above, but include the name of each employee's immediate superior

SELECT OrderID, CompanyName, Employees.FirstName, Employees.LastName, 
InmediateS.FirstName as SuperiorFirstName,
InmediateS.LastName as SuperiorLastName from Orders
Join Customers USING(CustomerID)
Join Employees USING(EmployeeID)
Join Employees as InmediateS ON InmediateS.EmployeeID = Employees.ReportsTo;


-- 1.6.3 Same as above, but only show orders associated with employees who report to Steven Buchanan

SELECT OrderID, CompanyName, Employees.FirstName, Employees.LastName, 
InmediateS.FirstName as SuperiorFirstName,
InmediateS.LastName as SuperiorLastName from Orders
Join Customers USING(CustomerID)
Join Employees USING(EmployeeID)
Join Employees as InmediateS ON InmediateS.EmployeeID = Employees.ReportsTo
WHERE SuperiorFirstName = 'Steven';

