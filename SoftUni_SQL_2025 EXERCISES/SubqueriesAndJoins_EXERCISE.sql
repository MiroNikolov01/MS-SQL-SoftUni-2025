  -- Problem 01

    SELECT TOP(5)
           e.EmployeeID,
           e.JobTitle,
  	       a.AddressID,
  	       a.AddressText
      FROM Employees 
        AS e 
INNER JOIN Addresses 
	  AS a ON e.AddressID = a.AddressID
ORDER BY a.AddressID ASC

-- Problem 02

  SELECT TOP(50)
         e.FirstName,
         e.LastName,
         t.[Name],
         a.AddressText
    FROM Employees 
	  AS e
    JOIN Addresses 
	  AS a
      ON e.AddressID = a.AddressID  
    JOIN Towns 
	  AS t
      ON a.TownID = t.TownID       
ORDER BY e.FirstName,e.LastName

-- Problem 03

  SELECT e.EmployeeID,
         e.FirstName,
		 e.LastName,
		 d.[Name]
	  AS DepartmentName
    FROM Employees 
      AS e 
	JOIN Departments 
	  AS d 
	  ON e.DepartmentID = d.DepartmentID AND d.[Name] = 'Sales'
ORDER BY e.EmployeeID

-- Problem 04

    SELECT TOP(5)
           e.EmployeeID,
		   e.FirstName,
		   e.Salary,
		   d.[Name] 
	    AS DepartmentName
      FROM Employees 
	    AS e 
INNER JOIN Departments 
	    AS d 
	    ON e.DepartmentID = d.DepartmentID 
	 WHERE e.Salary > 15000
  ORDER BY d.DepartmentID

-- Problem 05

   SELECT TOP(3)
          e.EmployeeID,
          e.FirstName
     FROM Employees 
	   AS e 
LEFT JOIN EmployeesProjects 
	   AS ep 
	   ON e.EmployeeID = ep.EmployeeID
    WHERE ep.EmployeeID IS NULL
 ORDER BY e.EmployeeID

-- Problem 06

  SELECT e.FirstName,
         e.LastName,
         e.HireDate,
         d.[Name] AS DeptName
    FROM Employees 
	  AS e JOIN Departments 
	  AS d 
	  ON e.DepartmentID = d.DepartmentID
   WHERE e.HireDate > '1999/01/01' AND d.[Name] IN ('Finance','Sales')
ORDER BY HireDate ASC

-- Problem 07

  SELECT TOP(5)
         e.EmployeeID,
         e.FirstName,
         p.[Name] 
	  AS ProjectName
    FROM Employees 
      AS e JOIN EmployeesProjects
      AS ep 
	  ON e.EmployeeID = ep.EmployeeID
    JOIN Projects 
	  AS p 
	  ON ep.ProjectID = p.ProjectID
   WHERE p.StartDate > '2002/08/13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID ASC

-- Problem 08

    SELECT e.EmployeeID,
           e.FirstName,
      CASE 
		   WHEN YEAR(p.StartDate) >= 2005 THEN NULL
		   ELSE p.[Name]
	   END
      FROM Employees 
        AS e 
RIGHT JOIN EmployeesProjects
        AS ep 
		ON e.EmployeeID = ep.EmployeeID
      JOIN Projects 
	    AS p 
	    ON ep.ProjectID = p.ProjectID
     WHERE e.EmployeeID = 24

-- Problem 09

    SELECT e.EmployeeID,
           e.FirstName,
           e.ManagerID,
           m.FirstName 
        AS ManagerName
      FROM Employees 
        AS e 
INNER JOIN Employees 
        AS m 
        ON e.ManagerID = m.EmployeeID
     WHERE e.ManagerID IN (3,7)
  ORDER BY e.EmployeeID

-- Problem 10

    SELECT TOP(50)
	       e.EmployeeID,
	CONCAT (e.FirstName,' ',e.LastName) 
	    AS EmployeeName,
    CONCAT (m.FirstName,' ',m.LastName) 
	    AS ManagerName,
	       d.[Name]
		AS DepartmentName
      FROM Employees
        AS e
LEFT JOIN Employees
        AS m
        ON e.ManagerID = m.EmployeeID
LEFT JOIN Departments AS d
        ON e.DepartmentID = d.DepartmentID
  ORDER BY e.EmployeeID

-- Problem 11

  SELECT MIN(AvgSalary) AS MinAverageSalary
    FROM (
            SELECT DepartmentID, AVG(Salary) 
			    AS AvgSalary
              FROM Employees
          GROUP BY DepartmentID
         ) AS AvgSalary
  
-- Problem 12

    SELECT c.CountryCode,
	       m.MountainRange,
		   p.PeakName,
		   p.Elevation
      FROM Peaks 
        AS p
INNER JOIN Mountains 
        AS m
		ON p.MountainId = m.Id
INNER JOIN MountainsCountries 
        AS mc
		ON mc.MountainId = m.Id
INNER JOIN Countries 
        AS c
		ON mc.CountryCode = c.CountryCode
     WHERE c.CountryCode = 'BG' AND p.Elevation > 2835
  ORDER BY p.Elevation DESC

-- Problem 13

    SELECT mc.CountryCode,
	 COUNT (m.Id) AS MountainRanges
      FROM MountainsCountries 
	    AS mc
INNER JOIN Mountains 
        AS m
		ON mc.MountainId = m.Id
		WHERE mc.CountryCode IN('BG','US','RU')
		GROUP BY mc.CountryCode

-- Problem 14

    SELECT TOP(5)
	       c.CountryName,
	       r.RiverName
      FROM Countries
	    AS c
 LEFT JOIN CountriesRivers
        AS cr
		ON c.CountryCode = cr.CountryCode
 LEFT JOIN Rivers
        AS r
		ON cr.RiverId = r.Id
     WHERE c.ContinentCode = 'AF'
  ORDER BY c.CountryName

-- Problem 16
 SELECT COUNT(*) AS [Count]
 FROM (
         SELECT mc.MountainId
           FROM Countries 
     	     AS c
     LEFT JOIN MountainsCountries
             AS mc
     		 ON c.CountryCode = mc.CountryCode
     LEFT JOIN Mountains 
             AS m
     	   	 ON mc.MountainId = m.Id
     	  WHERE mc.MountainId IS NULL
      ) AS Sub

-- Problem 17

   SELECT TOP(5)
          c.CountryName,
          MAX(p.Elevation)
	   AS HighestPeakElevation,
	      MAX(r.[Length])
	   AS LongestRiverLength
	 FROM Countries 
	   AS c
LEFT JOIN MountainsCountries
       AS mc
	   ON c.CountryCode = mc.CountryCode	
LEFT JOIN CountriesRivers
       AS cr
	   ON c.CountryCode = cr.CountryCode
LEFT JOIN Peaks
       AS p
	   ON p.MountainId = mc.MountainId
LEFT JOIN Rivers 
       AS r
	   ON r.Id = cr.RiverId
 GROUP BY c.CountryName
 ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC,c.CountryName
 

