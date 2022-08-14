--Автофиксация 

INSERT INTO Specialities(s_name) VALUES ('Teacher')
INSERT INTO Specialities(s_name) VALUES ('Trainer')
INSERT INTO Specialities(s_name) VALUES ('Doctor')


--Явная транзацкия 
TRUNCATE TABLE Specialities--очищение таблицы
BEGIN TRAN
	INSERT INTO Specialities(s_name) VALUES ('Good Teacher 1')
	INSERT INTO Specialities(s_name) VALUES ('Good Trainer 2')
	INSERT INTO Specialities(s_name) VALUES ('Good Doctor 3')
COMMIT TRAN

SELECT * FROM Specialities
-- обработка ошибок с использованием TRY и CATCH
--TRUNCATE TABLE Specialities
BEGIN TRY	
    BEGIN TRAN
		INSERT INTO Specialities(s_name) VALUES ('qwertyuio')
		INSERT INTO Specialities(s_name) VALUES ('asdasdass')
    COMMIT TRAN 
END TRY
BEGIN CATCH
    RAISERROR ('!!!!!EROR!!!!!', 14, 1)
    ROLLBACK TRAN 
END CATCH

SELECT * FROM Specialities

--Неявная транзакция
SET IMPLICIT_TRANSACTIONS ON
INSERT Specialities VALUES ('изиреп')
GO

SELECT @@TRANCOUNT AS VALUE
--Вложенная транзакция
 ROLLBACK TRAN -- сперва откат транзакций
