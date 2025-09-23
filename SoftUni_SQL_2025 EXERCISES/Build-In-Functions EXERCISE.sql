-- Problem 01
SELECT 
FirstName,
LastName
  FROM Employees
 WHERE LEFT(FirstName,2) IN ('Sa')

-- Problem 02

SELECT 
FirstName,
LastName
  FROM Employees
 WHERE LastName LIKE '%ei%'

-- Problem 03

SELECT 
FirstName 
  FROM Employees
 WHERE DepartmentID IN (3,10) AND 
  YEAR(HireDate) BETWEEN 1995 AND 2005

-- Problem 04

SELECT 
FirstName,
LastName
  FROM Employees
 WHERE JobTitle NOT LIKE '%engineer%'

-- Problem 05

SELECT 
[Name]
  FROM Towns
 WHERE LEN([Name]) >= 5 AND LEN([NAME]) <= 6
ORDER BY [NAME]

-- Problme 06

SELECT 
TownID,
[Name]
  FROM Towns
 WHERE LEFT([Name],1) IN ('M','K','B','E')
ORDER BY [NAME]

-- Problme 07

SELECT 
TownID,
[Name]
  FROM Towns
 WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name]

-- Problem 08

GO

CREATE VIEW V_EmployeesHiredAfter2000
    AS
SELECT
FirstName,
LastName
  FROM Employees
 WHERE DATEPART(YYYY,HireDate) > 2000

GO

-- Problem 09

SELECT 
FirstName,
LastName
  FROM Employees
 WHERE [LastName] LIKE '_____'

-- Problem 10

SELECT 
EmployeeID,
FirstName,
LastName,
Salary,
DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

-- Problem 11

SELECT *
  FROM (
        SELECT
        EmployeeID,
        FirstName,
        LastName,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
        FROM Employees
        WHERE Salary BETWEEN 10000 AND 50000
       ) AS [Ranked Employees]
 WHERE [Rank] = 2
ORDER BY Salary DESC

-- Problem 12

SELECT 
       CountryName AS [Country Name],
           IsoCode AS [ISO CODE]
  FROM Countries
 WHERE LEN(CountryName) - LEN(REPLACE(CountryName,'a','')) >= 3
ORDER BY IsoCode

-- Problem 13

SELECT 
        PeakName,
        RiverName,
LOWER(CONCAT(PeakName,SUBSTRING(RiverName,2,LEN(RiverName)))) AS Mix
  FROM Peaks
CROSS JOIN Rivers
 WHERE LOWER(RIGHT(PeakName,1)) = LOWER(LEFT(RiverName,1))
ORDER BY Mix

-- Problem 14

SELECT TOP(50)
[Name],
FORMAT([Start],'yyyy-MM-dd') AS StartDate
FROM Games 
WHERE YEAR([Start]) IN(2011,2012)
ORDER BY [StartDate],[Name]

-- Problem 15

SELECT
UserName AS Username,
SUBSTRING(Email,CHARINDEX('@',Email) + 1,LEN(Email)) AS [Email Provider]
  FROM Users
ORDER BY [Email Provider],Username

-- Problem 16

SELECT 
Username,
IpAddress
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

-- Problem 17

SELECT 
[Name],
CASE
WHEN DATEPART(Hour,[Start]) >= 0 AND DATEPART(Hour,[Start]) < 12 THEN 'Morning'
WHEN DATEPART(Hour,[Start]) >= 12 AND DATEPART(Hour,[Start]) < 18 THEN 'Afternoon'
ELSE 'Evening'
END AS [Part of the day],
CASE
WHEN Duration <= 3 THEN 'Extra Short'
WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
WHEN Duration > 6 THEN 'Long'
WHEN DURATION IS NULL THEN 'Extra Long'
END AS [Duration]
FROM Games
ORDER BY [Name] ASC,[Duration] ASC,[Part of the day] ASC

-- Problem 18

SELECT 
ProductName,
OrderDate,
DATEADD(DAY,3,OrderDate) AS [Pay Due],
DATEADD(MONTH,1,OrderDate) AS [Deliver Due]
  FROM Orders

-- Problem 19

CREATE TABLE People(
Id INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
Birthdate DATETIME2 NOT NULL
)

INSERT INTO People([Name],Birthdate)
VALUES
('Victor','2000-12-07 00:00:00.000'),
('Steven','1992-09-10 00:00:00.000'),
('Stephen','1910-09-19 00:00:00.000'),
('John','2010-01-06 00:00:00.000')

SELECT 
[Name],
DATEDIFF(YEAR,Birthdate,GETDATE()) AS [Age in Years],
DATEDIFF(MONTH,Birthdate,GETDATE()) AS [Age in Months],
DATEDIFF(DAY,Birthdate,GETDATE()) AS [Age in Days],
DATEDIFF(MINUTE,Birthdate,GETDATE()) AS [Age in Minutes]
  FROM People
