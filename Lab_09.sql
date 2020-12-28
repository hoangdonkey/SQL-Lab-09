USE master
GO

IF EXISTS(SELECT * FROM sys.databases WHERE NAME = 'Lab11')
	DROP DATABASE Lab11
GO

CREATE DATABASE Lab11
GO

USE Lab11
GO

CREATE TABLE Customers (
	CustomerID int IDENTITY,
	CustomerName varchar(50),
	Address varchar(100),
	Phone varchar(12),
	CONSTRAINT PK_CusID PRIMARY KEY (CustomerID)
)

CREATE TABLE Books (
	BookCode int,
	Category varchar(50),
	Author varchar(50),
	Publisher varchar(50),
	Title varchar(100),
	Price int,
	InStore int,
	CONSTRAINT PK_BookID PRIMARY KEY (BookCode)
)

CREATE TABLE BookSold (
	BookSoldID int IDENTITY,
	CustomerID int,
	BookCode int,
	SoldDate Datetime,
	Price int,
	Amount int,
	CONSTRAINT PK_BookSold PRIMARY KEY (BookSoldID),
	CONSTRAINT FK_CusID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
	CONSTRAINT FK_BookID FOREIGN KEY (BookCode) REFERENCES Books(BookCode)
)

GO
 INSERT INTO Customers VALUES
 	('A','Ha Noi','0123456789'),
 	('B','Hoa Binh','0123456788'),
 	('C','Ha Nam','0123456787'),
 	('D','Bac Ninh','0123456786'),
 	('E','Bac Giang','0123456785')
 GO

 INSERT INTO Books VALUES
 	(1,'Cat A','L','A','Book A',100000,50),
 	(2,'Cat B','J','B','Book B',200000,40),
 	(3,'Cat C','J','A','Book C',300000,30),
 	(4,'Cat D','L','B','Book D',400000,20),
 	(5,'Cat E','I','A','Book E',500000,10)
 GO

INSERT INTO BookSold VALUES
	(1,2,'04/22/2020',200000,1),
	(2,1,'08/02/2020',100000,2),
	(3,4,'03/26/2020',300000,4),
	(2,5,'11/15/2020',100000,1),
	(5,2,'03/08/2020',200000,2),
	(4,3,'05/01/2020',300000,1),
	(4,5,'11/20/2020',200000,4),
	(2,2,'02/10/2020',200000,1),
	(3,1,'05/10/2020',300000,3),
	(5,4,'11/21/2020',400000,1)
GO
CREATE VIEW V_BookSold AS
SELECT BookSold.BookCode,Books.Title,BookSold.Price,BookSold.Amount FROM BookSold
JOIN Books ON Books.BookCode = BookSold.BookCode
GO

SELECT * FROM V_BookSold
GO

CREATE VIEW V_Customers AS
SELECT Customers.CustomerID,Customers.CustomerName,Customers.Address,SUM(BookSold.Amount) AS 'TotalAmount' FROM Customers
JOIN BookSold ON BookSold.CustomerID = Customers.CustomerID GROUP BY Customers.CustomerID,Customers.CustomerName,Customers.Address
GO

SELECT * FROM V_Customers
GO

CREATE VIEW V_LastMonth AS
SELECT Customers.CustomerName,Customers.Address,Books.Title FROM Customers
JOIN BookSold ON BookSold.CustomerID = Customers.CustomerID
JOIN Books ON Books.BookCode = BookSold.BookCode
WHERE DATEDIFF(month,SoldDate,getdate()) = 1
GO

SELECT * FROM V_LastMonth
GO
