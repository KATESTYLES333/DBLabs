DROP TRIGGER GetPrice
go

CREATE TRIGGER GetPrice on [Order]
FOR INSERT
AS
BEGIN
	DECLARE @a int
	SET @a = (select km from inserted)
	DECLARE @b nchar(15)
	SET @b = (select statusName from [Status] where id = (select idSt from Car join inserted on Car.id = inserted.idC))
	
	IF @b = 'Good'
		UPDATE [Order]
		SET Price = @a*5
		WHERE id = (SELECT id FROM inserted)
	ELSE
	IF @b = 'Normal'
		UPDATE [Order]
		SET Price = @a*4
		WHERE id = (SELECT id FROM inserted)
	ELSE
	IF @b = 'Critical'
		UPDATE [Order]
		SET Price = @a*3
		WHERE id = (SELECT id FROM inserted)
	ELSE
	IF @b = 'Updated'
		UPDATE [Order]
		SET Price = @a*2
		WHERE id = (SELECT id FROM inserted)
	ELSE
		UPDATE [Order]
		SET Price = 0
		WHERE id = (SELECT id FROM inserted)
END
GO

DROP TRIGGER GetSalary
GO

CREATE TRIGGER GetSalary on Worker
FOR INSERT
AS
BEGIN
	DECLARE @a nchar
	SET @a = (select categoryName from Category where id = (select idK from inserted))
	
	IF @a = 'z'
		UPDATE Worker
		SET Salary = 100
		WHERE id = (SELECT id FROM inserted)
	ELSE
	IF @a = 'b'
		UPDATE Worker
		SET Salary = 200
		WHERE id = (SELECT id FROM inserted)
	ELSE
	IF @a = 'c'
		UPDATE Worker
		SET Salary = 300
		WHERE id = (SELECT id FROM inserted)
	
END

GO
CREATE TABLE DeleteLog 
(
    Id INT IDENTITY PRIMARY KEY,
    ProductId INT NOT NULL,
    Operation NVARCHAR(200) NOT NULL,
    CreateAt DATETIME NOT NULL DEFAULT GETDATE(),
);
GO

DROP TRIGGER DeleteLog_Trigger
GO

CREATE TRIGGER DeleteLog_Trigger on [Order]
FOR DELETE
AS
BEGIN
	
	INSERT INTO DeleteLog (ProductId, Operation)
	VALUES((SELECT id from deleted), (SELECT 'Удален заказ ' + CAST(oNumber AS NCHAR(200)) FROM deleted))
	
END

DROP TRIGGER DeleteLogMark_Trigger
GO

CREATE TRIGGER DeleteLogMark_Trigger on Mark
FOR DELETE
AS
BEGIN
	
	INSERT INTO DeleteLog (ProductId, Operation)
	VALUES((SELECT id from deleted), (SELECT 'Удаленa марка ' + CAST(markName AS NCHAR(200)) FROM deleted))
		
END

DROP TRIGGER UpdatePrice
go

CREATE TRIGGER UpdatePrice on [Order]
AFTER UPDATE
AS
BEGIN
	DECLARE @a int
	SET @a = (select km from inserted)
	DECLARE @b nchar(15)
	SET @b = (select statusName from [Status] where id = (select idSt from Car join inserted on Car.id = inserted.idC))
	
	IF @b = 'Good'
		UPDATE [Order]
		SET Price = @a*5
		WHERE id = (SELECT id FROM inserted)
	ELSE
	IF @b = 'Normal'
		UPDATE [Order]
		SET Price = @a*4
		WHERE id = (SELECT id FROM inserted)
	ELSE
	IF @b = 'Critical'
		UPDATE [Order]
		SET Price = @a*3
		WHERE id = (SELECT id FROM inserted)
	ELSE
	IF @b = 'Updated'
		UPDATE [Order]
		SET Price = @a*2
		WHERE id = (SELECT id FROM inserted)
	ELSE
		UPDATE [Order]
		SET Price = 0
		WHERE id = (SELECT id FROM inserted)
END
GO

INSERT INTO Worker(fName, lName, phoneNumber, idK, idP, Salary)
VALUES('sss', 'sss', '2222222', 3, 2, 2)
INSERT INTO Worker(fName, lName, phoneNumber, idK, idP, Salary)
VALUES('aaa1', 'aaa1', '11112', 2, 1, 7)
select * from Worker

INSERT INTO [Order](idC, idW, km, oNumber, price, endTime, startTime)
VALUES(3, 2, 11, 1121, 10, '10:00', '9:00' )

DELETE FROM [Order]
WHERE id = 35

DELETE FROM Mark
WHERE id = 8
select * from DeleteLog


UPDATE [Order] SET km =100 WHERE id = 36
select * from [Order]

GO
DROP TRIGGER hui;
GO
CREATE TRIGGER hui ON Exams
AFTER INSERT
AS 
	BEGIN
	DECLARE @mark INT
	DECLARE @id INT
	SET @id = (SELECT idex FROM inserted)
	SET @mark = (SELECT ex_mark FROM inserted)
		IF @mark > 4 
		UPDATE Exams
		SET ex_mark = @mark -2
		WHERE @id = idex
	END

INSERT INTO Exams(ex_date, ex_mark, lId, stId, ex_roomNum) VALUES ('01.03.2001', 6, 1, 2, 33);

SELECT * FROM Exams;