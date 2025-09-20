
-- Problem 01
CREATE TABLE [Passports] (
PassportID INT PRIMARY KEY IDENTITY(101,1),
PassportNumber VARCHAR(8) NOT NULL
)

CREATE TABLE [Persons] (
PersonID INT PRIMARY KEY IDENTITY,
FirstName VARCHAR(50) NOT NULL,
Salary DECIMAL(15,2) NOT NULL,
PassportID INT FOREIGN KEY REFERENCES Passports(PassportID) UNIQUE
)

INSERT INTO Passports(PassportID,PassportNumber)
VALUES
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2')

INSERT INTO Persons(PersonID,FirstName,Salary,PassportID) 
VALUES
(1,'Roberto',43300.00,102),
(2,'Tom',56100.00,103),
(3,'Yana',60200.00,101)

-- Problem 02

CREATE TABLE Manufacturers (
    ManufacturerID INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(50) NOT NULL,
    EstablishedON DATE NOT NULL
);

CREATE TABLE Models (
    ModelID INT PRIMARY KEY IDENTITY(101,1),
    [Name] VARCHAR(50) NOT NULL,
    ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
);

INSERT INTO Manufacturers([Name], EstablishedON)
VALUES
('BMW','1916-03-07'),
('TESLA','2003-01-01'),
('LADA','1966-05-01');

INSERT INTO Models([Name], ManufacturerID)
VALUES
('X1',1),
('i6',1),
('Model S',2),
('Model X',2),
('Model 3',2),
('Nova',3);

-- Problem 03

CREATE TABLE Students (
StudentID INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
)

CREATE TABLE Exams (
ExamID INT PRIMARY KEY IDENTITY(101,1),
[Name] VARCHAR(50) NOT NULL,
)

CREATE TABLE StudentsExams (
StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
ExamID INT FOREIGN KEY REFERENCES Exams(ExamID)
CONSTRAINT PK_StudentsExams PRIMARY KEY (StudentID, ExamID)
)

INSERT INTO Students([Name])
VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT INTO Exams([Name])
VALUES
('Mila'),
('Toni'),
('Ron')

INSERT INTO StudentsExams(StudentID,ExamID)
VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)

-- Problem 04

CREATE TABLE Teachers (
TeacherID INT PRIMARY KEY IDENTITY(101,1),
[Name] VARCHAR(50) NOT NULL,
ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID) NULL
)


INSERT INTO Teachers([Name])
VALUES
('John')


INSERT INTO Teachers([Name],ManagerID)
VALUES
('Maya',106),
('Silvia',106),
('Ted',105),
('Mark',101),
('Greta',101)

-- Problem 05

CREATE DATABASE OnlineStore

USE OnlineStore

CREATE TABLE Cities (
CityID INT PRIMARY KEY,
[Name] VARCHAR(80) NOT NULL
)

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
[Name] VARCHAR(80) NOT NULL,
BirthDay DATE NOT NULL,
CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes (
ItemTypeID INT PRIMARY KEY,
[Name] VARCHAR(80) NOT NULL,
)

CREATE TABLE Items (
ItemID INT PRIMARY KEY,
[Name] VARCHAR(80) NOT NULL,
ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems (
OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
CONSTRAINT PK_ItemsAndOrders PRIMARY KEY (OrderID,ItemID)
)

-- Problem 06

CREATE TABLE Majors (
    MajorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
)

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentNumber VARCHAR(50) NOT NULL,
    StudentName VARCHAR(100) NOT NULL,
    MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY,
    SubjectName VARCHAR(100) NOT NULL
)

CREATE TABLE Agenda (
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
    CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID)
)

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10,2) NOT NULL,
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)

--Problem 09

SELECT
  m.MountainRange,
  p.PeakName,
  p.Elevation
  FROM Mountains AS m JOIN Peaks AS p ON m.Id = p.MountainId
  WHERE m.MountainRange = 'Rila'
  ORDER BY p.Elevation DESC