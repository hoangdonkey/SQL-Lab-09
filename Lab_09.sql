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

