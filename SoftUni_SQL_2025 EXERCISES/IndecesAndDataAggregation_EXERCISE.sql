USE Gringotts

GO

-- Problem 01

SELECT COUNT(*)
  FROM (
			SELECT *
		      FROM WizzardDeposits
	   ) AS CountRecrods


-- Problem 02

SELECT MAX(MagicWandSize)
    AS LongestMagicWand
  FROM WizzardDeposits

-- Problem 03

  SELECT DepositGroup,
         MAX(MagicWandSize)
      AS LongestMagicWand
    FROM WizzardDeposits
GROUP BY DepositGroup

-- Problem 04

  SELECT TOP(2) 
         DepositGroup,
         AVG(MagicWandSize)
      AS AverageWandSize
    FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AverageWandSize 

-- Problem 05

  SELECT DepositGroup,
         SUM(DepositAmount) 
      AS DepositSum
    FROM WizzardDeposits
GROUP BY DepositGroup

-- Problem 06

  SELECT DepositGroup,
         SUM(DepositAmount) 
      AS TotalSum
    FROM WizzardDeposits
   WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

-- Problem 07

  SELECT DepositGroup,
         SUM(DepositAmount)
      AS TotalSum
    FROM WizzardDeposits
   WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
  HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

-- Problem 08

  SELECT DepositGroup,
         MagicWandCreator,
	     MIN(DepositCharge)
      AS MinDepositCharge
    FROM WizzardDeposits
GROUP BY DepositGroup,MagicWandCreator


-- Problem 09

 SELECT AgeGroup,
        COUNT(*)
   FROM  (
		  SELECT CASE
				   WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
				   WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
				   WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
				   WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
				   WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
				   WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
				   WHEN Age > 60 THEN '[61+]'
				 END
			  AS AgeGroup
			FROM WizzardDeposits
	     ) AS Sub
GROUP BY AgeGroup

-- Problem 10

  SELECT LEFT(MagicWandCreator,1)
      AS FirstLetter
    FROM WizzardDeposits
   WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(MagicWandCreator,1) 
ORDER BY FirstLetter

-- Problem 11

  SELECT DepositGroup,
         IsDepositExpired,
	     AVG(DepositInterest)
      AS AverageInterest
    FROM WizzardDeposits
   WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup,IsDepositExpired
ORDER BY DepositGroup DESC,IsDepositExpired

-- Problem 12

SELECT SUM(DepositAmount - NextDeposit) 
    AS SumDifference
  FROM (
		SELECT DepositAmount,
			   LEAD(DepositAmount) OVER (ORDER BY Id) 
			AS NextDeposit
		  FROM WizzardDeposits
       ) AS Sub
 WHERE NextDeposit IS NOT NULL

-- Problem 13

USE SoftUni

GO

  SELECT DepartmentID,
         SUM(Salary)
      AS TotalSalary
    FROM Employees
GROUP BY DepartmentID
 
-- Problem 14

  SELECT DepartmentID,
         MIN(Salary)
      AS MinimumSalary
    FROM Employees
   WHERE DepartmentID IN (2,5,7) AND HireDate > '2000-01-01'
GROUP BY DepartmentID

-- Problem 15

SELECT *
  INTO #TempTable
  FROM Employees
 WHERE Salary > 30000

DELETE 
  FROM #TempTable
 WHERE ManagerID = 42

UPDATE #TempTable
   SET Salary += 5000
 WHERE DepartmentID = 1

  SELECT DepartmentID,
         AVG(Salary)
	  AS AverageSalary
    FROM #TempTable
GROUP BY DepartmentID

-- Problem 16

  SELECT DepartmentID,
         MAX(Salary)
      AS MaxSalary
    FROM Employees
GROUP BY DepartmentID
  HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

-- Problem 17

SELECT COUNT(*)
    AS [Count]
  FROM (
		SELECT * 
		  FROM Employees
		 WHERE ManagerID IS NULL
	   ) AS Sub

-- Problem 18

 SELECT DepartmentID,
        MAX(Salary)
     AS ThirdHighestSalary
   FROM    (
		   SELECT DepartmentID,
				  Salary,
				  DENSE_RANK() OVER (PARTITION BY DepartmentID  ORDER BY Salary DESC)
			   AS [Rank]
			 FROM Employees
		   ) AS Sub
   WHERE [Rank] = 3
GROUP BY DepartmentID

-- Problem 19

SELECT TOP(10)
	   FirstName,
	   LastName,
	   DepartmentID
 FROM
(
    SELECT
		   FirstName,
		   LastName,
		   DepartmentID,
		   Salary,
		   AVG(Salary) OVER(PARTITION BY DepartmentID) AS DepartmentAverage
     FROM   Employees
) AS Sub
   WHERE Salary > DepartmentAverage
ORDER BY DepartmentID 


