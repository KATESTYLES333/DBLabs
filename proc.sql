------------------------DROPS------------------------
DROP PROCEDURE IF EXISTS InsertCountries;
DROP PROCEDURE IF EXISTS InsertDevelopers;
DROP PROCEDURE IF EXISTS InsertGames;
DROP PROCEDURE IF EXISTS InsertClients;
DROP PROCEDURE IF EXISTS InsertOrders;
DROP PROCEDURE IF EXISTS InsertReports;
DROP PROCEDURE IF EXISTS DelCountries;
DROP PROCEDURE IF EXISTS DelDevelopers;
DROP PROCEDURE IF EXISTS DelGames;

GO
---------------------INSERTS-------------------------
CREATE PROCEDURE InsertCountries (
	@name NVARCHAR
)
AS
BEGIN
	INSERT INTO Countries([name]) 
	VALUES (@name)
END
GO

CREATE PROCEDURE InsertDevelopers (
	@name NVARCHAR(100),
	@foundation INT
)
AS
BEGIN
	INSERT INTO Developers([name], foundation)
	VALUES (@name, @foundation)
END
GO

CREATE PROCEDURE InsertGames (
	@name NVARCHAR(10),
	@category NVARCHAR(10),
	@price DECIMAL,
	@genre NVARCHAR(10),
	@description NVARCHAR(10)
)
AS
BEGIN
	INSERT INTO Games([name], category, price, genre, [description]) 
	VALUES (@name, @category, @price, @genre, @description)
END
GO

CREATE PROCEDURE InsertClients (
	@name NVARCHAR(10),
	@surname NVARCHAR(10),
	@patronymic NVARCHAR(10),
	@deliveryAddress NVARCHAR(10),
	@email VARCHAR(50)
)
AS
BEGIN
	INSERT INTO Clients([name], surname, patronymic, deliveryAddress, email) 
	VALUES (@name, @surname, @patronymic, @deliveryAddress, @email)
END
GO

CREATE PROCEDURE InsertOrders (
	@count INT,
	@amount INT
)
AS
BEGIN
	INSERT INTO Orders([count], amount) 
	VALUES (@count, @amount)
END
GO

CREATE PROCEDURE InsertReports (
	@amount INT,
	@idOrder INT,
	@idGame INT
)
AS
BEGIN
	INSERT INTO Reports(amount, idOrder, idGame) 
	VALUES (@amount, @idOrder, @idGame)
END
GO


INSERT INTO Countries([name]) VALUES ('aaa');
INSERT INTO Developers([name], foundation, idCountry) VALUES ('bbb', 20202, 1);
INSERT INTO Games([name],category, price, genre, idDeveloper, [description] ) VALUES ('qqq', 'asd', 12, 'ddd', 1, 'afasfs asfafa');
INSERT INTO Clients([name], surname, patronymic, deliveryAddress, email) VALUES('asd', 'qqq', 'fff', 'adfa dfaffa dd', 'asfsafsf@faf');
INSERT INTO Orders([count], amount, idClient) VALUES (12, 2, 1);
INSERT INTO Reports(amount, idOrder, idGame) VALUES (12, 1, 1);
GO
----------------------DELS-------------------------
CREATE PROCEDURE DelCountries(
	@Name NVARCHAR(10)
	)
AS
	DELETE Countries WHERE @Name = Countries.[name]
RETURN 0
GO

CREATE PROCEDURE DelDevelopers(
	@name NVARCHAR(100),
	@foundation INT,
	@idCountry INT
	)
AS
	DELETE Developers WHERE @name = Developers.[name] AND @foundation = Developers.foundation AND @idCountry = Developers.idCountry
RETURN 0
GO

CREATE PROCEDURE DelGames(
	@Name NVARCHAR(100),
	@category NVARCHAR(100),
	@price DECIMAL,
	@genre NVARCHAR(100),
	@idDeveloper INT,
	@description NVARCHAR(100)
	)
AS
	DELETE Games WHERE
	@Name = Games.[name] AND @category = Games.category AND @price = Games.price 
	AND @genre = Games.genre AND @idDeveloper = Games.idDeveloper AND @description = Games.[description]
RETURN 0
GO

