--CREATE DATABASE BOOKKEEPING
--GO

USE BOOKKEEPING
GO

DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Workers;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Positions;
DROP PROCEDURE IF EXISTS ChangeSalary;
DROP PROCEDURE IF EXISTS F2;
DROP PROCEDURE IF EXISTS GetSalary3;
GO

--отдел
CREATE TABLE Departments (
	id INT UNIQUE NOT NULL IDENTITY(1, 1),
	[name] VARCHAR(20),
	CONSTRAINT PK1 PRIMARY KEY (id)
);
--должность
CREATE TABLE Positions (
	id INT UNIQUE NOT NULL IDENTITY(1, 1),
	[name] NVARCHAR(20),
	salary MONEY NOT NULL,
	CONSTRAINT PK2 PRIMARY KEY (id)
);
--сотруднкик
CREATE TABLE Workers (
	id INT UNIQUE NOT NULL IDENTITY(1, 1),
	[name] NVARCHAR(20) NOT NULL, 
	surname NVARCHAR(20) NOT NULL, 
	patronymic NVARCHAR(20) NOT NULL,
	inn INT UNIQUE NOT NULL,
	gender NVARCHAR(1) NOT NULL DEFAULT N'м',
	bday DATE NOT NULL, 
	department INT NOT NULL,
	position INT NOT NULL, 
	dateIn DATE NOT NULL,
	experience INT NOT NULL DEFAULT 0,
	CONSTRAINT PK3 PRIMARY KEY (id),
	CONSTRAINT FK1 FOREIGN KEY (department) REFERENCES Departments(id) ON DELETE CASCADE, 
	CONSTRAINT FK2 FOREIGN KEY (position) REFERENCES Positions(id) ON DELETE CASCADE, 
);

CREATE TABLE Book (
	id INT UNIQUE NOT  NULL IDENTITY(1, 1),
	worker INT NOT NULL,
	dateIn DATE NOT NULL,
	CONSTRAINT PK4 PRIMARY KEY(id),
	CONSTRAINT FK3 FOREIGN KEY(worker) REFERENCES Workers(id) ON DELETE CASCADE
);

INSERT INTO Departments ([name]) VALUES ('Разработки');
INSERT INTO Departments ([name]) VALUES ('Кадров');

INSERT INTO Positions ([name], salary) VALUES (N'Программист', 20.2);
INSERT INTO Positions ([name], salary) VALUES (N'Эконоимист', 50);
INSERT INTO Positions ([name], salary) VALUES (N'Бухгалтер', 18.55);

INSERT INTO Workers ([name], surname, patronymic, inn, gender, bday, department, position, dateIn, experience) 
			VALUES (N'Михаил', N'Зубенко', N'Петрович', 100000, N'м', CONVERT(DATE,'1990-09-09', 120), 1, 1, CONVERT(DATE,'2020-02-02', 120), 5);
INSERT INTO Workers ([name], surname, patronymic, inn, gender, bday, department, position, dateIn, experience) 
			VALUES (N'Василина', N'', N'Игоревнаа', 4543464, N'ж', CONVERT(DATE,'1980-10-10', 120), 2, 1, CONVERT(DATE,'2010-02-02', 120), 3);

GO

CREATE PROCEDURE ChangeSalary @min INT, @salary INT, @moneyy MONEY AS
BEGIN
	IF @salary < @min
		SET @moneyy = 1.5
	ELSE IF @salary > 1.5 AND @salary < 100000
		SET @moneyy = (@salary*10)/100
	SELECT @moneyy
END
GO

CREATE PROCEDURE F2 @namee NVARCHAR AS
BEGIN
	SELECT w.[name] AS N'Имя', w.surname AS 'Фамилия', w.patronymic AS N'Отчество' FROM Workers w
	JOIN Book b ON(b.worker = w.id)
	WHERE CONCAT(w.[name], w.surname, w.patronymic) = @namee
END
GO

CREATE PROCEDURE GetSalary3 @size INT, @experience INT AS
BEGIN
	DECLARE @salary INT
	IF @experience >= 1 AND @experience <= 5
		SET @salary = (@size*5)/100
	ELSE IF @experience >= 5 AND @experience <= 10
		SET @salary = (@size*10)/100
	ELSE IF @experience >= 10 AND @experience <= 20
		SET @salary = (@size*30)/100
	ELSE IF @experience >= 20 AND @experience <= 30
		SET @salary = (@size*50)/100
	ELSE IF @experience >= 30
		SET @salary = @size
	SELECT @salary
END
GO

EXEC ChangeSalary 20, 1000, 300;
EXEC F2 N' Зубенко Петрович';
EXEC GetSalary3 450, 3;