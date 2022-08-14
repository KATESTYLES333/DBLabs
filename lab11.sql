--CREATE DATABASE SchoolExams1;
--GO

USE SchoolExams1;
GO

DROP TABLE IF EXISTS Exams;
DROP TABLE IF EXISTS Students;	
DROP TABLE IF EXISTS [Distribution];
DROP TABLE IF EXISTS Teachers;
DROP TABLE IF EXISTS Towns;
DROP TABLE IF EXISTS Lessons;
DROP TABLE IF EXISTS LessonTypes;
DROP TABLE IF EXISTS Specialities;
GO

CREATE TABLE Towns(
	idt INT UNIQUE NOT NULL IDENTITY(1, 1),
	t_name VARCHAR(20),
	CONSTRAINT PK1 PRIMARY KEY (idt)
);

CREATE TABLE LessonTypes(
	idlt INT UNIQUE NOT NULL IDENTITY(1, 1),
	CONSTRAINT PK2 PRIMARY KEY (idlt)
	--lt_name VARCHAR(25)
);

ALTER TABLE LessonTypes ADD lt_name VARCHAR (25);
GO

CREATE TABLE Lessons(
	idl INT UNIQUE NOT NULL IDENTITY(1, 1),
	l_name VARCHAR(20) NOT NULL DEFAULT (''),
	l_hours INT NOT NULL,
	ltypeId INT NOT NULL,
	CONSTRAINT PK3 PRIMARY KEY (idl),
	CONSTRAINT FK1 FOREIGN KEY (ltypeId) REFERENCES LessonTypes (idlt) ON DELETE CASCADE
);

CREATE TABLE Specialities(
	ids INT UNIQUE NOT NULL IDENTITY(1, 1),
	s_name VARCHAR(25) DEFAULT (''),
	CONSTRAINT PK4 PRIMARY KEY (ids)
);

CREATE TABLE Teachers(
	idtch INT UNIQUE NOT NULL IDENTITY(1, 1),
	tch_fio VARCHAR(100) NOT NULL,
	tch_numOfPassport NVARCHAR(20) NOT NULL,
	tch_bday DATE NOT NULL,
	tch_gender VARCHAR (10) NOT NULL,
	tch_numFlat INT NOT NUll,
	tch_numHouse VARCHAR(100) NOT NUll,
	tch_age INT NOT NULL,
	townId INT NOT NULL,
	CONSTRAINT CK_np CHECK ([tch_numOfPassport] LIKE '[A-Z]%[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT CK_Age CHECK ([tch_age] BETWEEN 18 AND 80),
	CONSTRAINT PK5 PRIMARY KEY (idtch),
	CONSTRAINT FK2 FOREIGN KEY (townId) REFERENCES Towns (idt) ON DELETE CASCADE
);

CREATE TABLE Students(
	ids INT UNIQUE NOT NULL IDENTITY(1, 1),
	s_fio VARCHAR(100) NOT NULL, 
	s_numbook INT NOT NULL,
	s_numFlat INT NOT NUll,
	s_numHouse VARCHAR(100) NOT NUll,
	townId INT NOT NULL,
	specId INT NOT NULL,
	CONSTRAINT CK_nb CHECK ([s_numbook] > 10),
	CONSTRAINT PK6 PRIMARY KEY (ids),
	CONSTRAINT FK3 FOREIGN KEY (townId) REFERENCES Towns (idt) ON DELETE CASCADE,
	CONSTRAINT FK4 FOREIGN KEY (specId) REFERENCES Specialities (ids) ON DELETE CASCADE
);

CREATE TABLE [Distribution](
	iddist INT UNIQUE NOT NULL IDENTITY(1, 1),
	dYear INT NOT NULL,
	tchId INT NOT NULL,
	lId INT NOT NULL,
	CONSTRAINT CK_d CHECK ([dYear] > 0),
	CONSTRAINT PK7 PRIMARY KEY (iddist),
	CONSTRAINT FK5 FOREIGN KEY (tchId) REFERENCES Teachers (idtch) ON DELETE CASCADE,
	CONSTRAINT FK6 FOREIGN KEY (lId) REFERENCES Lessons (idl) ON DELETE CASCADE
);

CREATE TABLE Exams(
	idex INT UNIQUE NOT NULL IDENTITY(1, 1),
	ex_date DATE NOT NULL,
	ex_roomNum INT NOT NULL,
	ex_mark INT NOT NULL,
	lId INT NOT NULL,
	stId INT NOT NULL,
	CONSTRAINT CK_ex CHECK ([ex_mark] BETWEEN 0 AND 10),
	CONSTRAINT PK8 PRIMARY KEY (idex),
	CONSTRAINT FK7 FOREIGN KEY (lId) REFERENCES Lessons (idl) ON DELETE CASCADE,
	CONSTRAINT FK8 FOREIGN KEY (stId) REFERENCES Students (ids) ON DELETE CASCADE
);

INSERT INTO Towns (t_name) VALUES ('Catolina');
INSERT INTO Towns (t_name) VALUES ('Nepal');
INSERT INTO Towns (t_name) VALUES ('LosAngeles');
INSERT INTO Towns (t_name) VALUES ('California');
INSERT INTO Towns (t_name) VALUES ('New York');

INSERT INTO LessonTypes (lt_name) VALUES ('Special');
INSERT INTO LessonTypes (lt_name) VALUES ('Base');

INSERT INTO Lessons (l_hours, l_name, ltypeId) VALUES (20, 'Zoology', 1);
INSERT INTO Lessons (l_hours, l_name, ltypeId) VALUES (24, 'Biology', 2);
INSERT INTO Lessons (l_hours, l_name, ltypeId) VALUES (20, 'Chemistry', 2);
INSERT INTO Lessons (l_hours, l_name, ltypeId) VALUES (24, 'Mathematics', 2);
INSERT INTO Lessons (l_hours, l_name, ltypeId) VALUES (20, 'Physics', 1);

INSERT INTO Specialities (s_name) VALUES ('Programmer');
INSERT INTO Specialities (s_name) VALUES ('Technicist');
INSERT INTO Specialities (s_name) VALUES ('Engineer');

INSERT INTO Teachers (tch_age, tch_bday, tch_fio, tch_gender, tch_numFlat, tch_numHouse, tch_numOfPassport, townId) VALUES (25, CONVERT(date,'1995-08-27', 120), 'Василина Ивания Петровна', 'ж', 32, 3, 'TH0055535', 3);
INSERT INTO Teachers (tch_age, tch_bday, tch_fio, tch_gender, tch_numFlat, tch_numHouse, tch_numOfPassport, townId) VALUES (52, CONVERT(date,'1968-10-17', 120), 'Петрова Зинаида Павловна', 'ж', 23, 7, 'MP1356952', 2);
INSERT INTO Teachers (tch_age, tch_bday, tch_fio, tch_gender, tch_numFlat, tch_numHouse, tch_numOfPassport, townId) VALUES (30, CONVERT(date,'1990-04-05', 120), 'Зубенко Михаил Петрович', 'м', 3, 5, 'PP8807889', 4);
INSERT INTO Teachers (tch_age, tch_bday, tch_fio, tch_gender, tch_numFlat, tch_numHouse, tch_numOfPassport, townId) VALUES (32, CONVERT(date,'1988-04-05', 120), 'Пупкин Василий Игоревич', 'м', 2, 3, 'PC8252359', 3);
INSERT INTO Teachers (tch_age, tch_bday, tch_fio, tch_gender, tch_numFlat, tch_numHouse, tch_numOfPassport, townId) VALUES (36, CONVERT(date,'1974-04-05', 120), 'Веселая Анастасия Руслановна', 'ж', 32, 2, 'MC8071395', 3);

INSERT INTO Students (s_fio, s_numbook, s_numFlat, s_numHouse, specId, townId) VALUES ('Порыв Анна Ивановна', 1275965, 3, 3, 1, 1);
INSERT INTO Students (s_fio, s_numbook, s_numFlat, s_numHouse, specId, townId) VALUES ('Залат Анастасия Георгиевна', 1658975, 4, 9, 2, 2);
INSERT INTO Students (s_fio, s_numbook, s_numFlat, s_numHouse, specId, townId) VALUES ('Самак Петр Иванович', 1958765, 3, 3, 1, 4);
INSERT INTO Students (s_fio, s_numbook, s_numFlat, s_numHouse, specId, townId) VALUES ('Веселов Максим Петрович', 1284556, 4, 9, 2, 5);
INSERT INTO Students (s_fio, s_numbook, s_numFlat, s_numHouse, specId, townId) VALUES ('Сумелая Анна Ильина', 1865964, 3, 8, 3, 2);

INSERT INTO [Distribution] (dYear, lId, tchId) VALUES (2000, 1, 1);
INSERT INTO [Distribution] (dYear, lId, tchId) VALUES (2001, 5, 2);
INSERT INTO [Distribution] (dYear, lId, tchId) VALUES (2000, 2, 3);
INSERT INTO [Distribution] (dYear, lId, tchId) VALUES (2001, 4, 4);
INSERT INTO [Distribution] (dYear, lId, tchId) VALUES (2010, 3, 5);

INSERT INTO Exams (ex_date, ex_roomNum, ex_mark, lId, stId) VALUES (CONVERT(date,'2020-02-20', 120), 22, 7, 1, 1);
INSERT INTO Exams (ex_date, ex_roomNum, ex_mark, lId, stId) VALUES (CONVERT(date,'2020-02-20', 120), 5, 7, 3, 5);
INSERT INTO Exams (ex_date, ex_roomNum, ex_mark, lId, stId) VALUES (CONVERT(date,'2020-03-20', 120), 2, 8, 2, 4);
INSERT INTO Exams (ex_date, ex_roomNum, ex_mark, lId, stId) VALUES (CONVERT(date,'2020-08-20', 120), 82, 8, 2, 2);
INSERT INTO Exams (ex_date, ex_roomNum, ex_mark, lId, stId) VALUES (CONVERT(date,'2020-08-20', 120), 12, 10, 5, 3);

--ROUND - возвращает число, округленное до указанной длины.
SELECT tch.tch_fio AS FIO, tch_age AS Age, ROUND(SQRT(l.l_hours), 2) AS [hours], l.l_name AS lesson FROM Lessons l
	JOIN [Distribution] d ON (d.lId = l.idl)
	JOIN Teachers tch ON (d.tchId = tch.idtch)
	ORDER BY l_name


--DATEDIFF - возращает разницу между датами
SELECT s.s_fio AS FIO, l.l_name AS Lesson, DATEDIFF(DAY, ex.ex_date, GETDATE()) AS 'days have passed after exams', ex.ex_roomNum AS ExamRoom, MIN(ex.ex_mark) AS MinMark FROM Exams ex
	JOIN Lessons l ON (ex.lId = l.idl)
	JOIN Students s ON (ex.stId = s.ids) 
	GROUP BY s_fio, l_name, ex_date, ex_roomNum
	HAVING MIN(ex_mark) < 8
	ORDER BY s_fio


--UPPER - возращает	строку где все буквы - UPPER CASE	
SELECT UPPER(t.tch_fio) AS FIO, t.tch_numOfPassport AS Passport, MIN(d.dYear) AS [Year] FROM Teachers t
	JOIN [Distribution] d ON (d.tchId = t.idtch)
	JOIN Towns tw ON (t.townId = tw.idt)
	JOIN Lessons s ON (d.lId = s.idl)
	WHERE tch_gender = 'ж' AND (tch_age BETWEEN 20 AND 50)
	GROUP BY tch_fio, tch_numOfPassport
	HAVING MIN(dYear) < 2010
	

--LEFT - Возвращает указанное число символов символьного выражения слева, LEN - Возвращает количество символов указанного строкового выражения 
SELECT ex.ex_date AS ExamDate, ex.ex_roomNum AS RoomNumber, ex.ex_mark AS ExamMark, l.l_name AS LessonName, l.l_hours AS LessonHours, LEN(lt.lt_name) AS LessonTypeName,
LEFT(UPPER(st.s_fio), 10) AS StudentFIO, st.s_numbook AS StudentNumbook, sp.s_name AS SpecialityName, cst.t_name AS StudentCity, d.dYear AS YearOfDistribution, 
LEFT(UPPER(t.tch_fio), 10) AS TeacherFIO, ct.t_name AS TeacherCity FROM Exams ex
	JOIN Lessons l ON (ex.lId = l.idl)
	JOIN LessonTypes lt ON (l.ltypeId = lt.idlt)
	JOIN Students st ON (ex.stId = st.ids)
	JOIN [Distribution] d ON (l.idl = d.lId)
	JOIN Teachers t ON (d.tchId = t.idtch)
	JOIN Towns cst ON (st.townId = cst.idt) 
	JOIN Towns ct ON (t.townId = ct.idt)
	JOIN Specialities sp ON (st.specId = sp.ids)


--REVERSE - Возвращает строковое значение, где символы переставлены в обратном порядке справа налево.
SELECT ex.ex_date AS [Date], ex.ex_roomNum AS Room, (ex.ex_mark) AS Mark, st.s_fio AS Student, REVERSE(sp.s_name) AS [Name] FROM Exams ex 
	JOIN Students st ON (ex.stId = st.ids)
	JOIN Specialities sp ON (st.specId = sp.ids)
	ORDER BY ex_date DESC


--SIGN-если число положительное, то возвращает 1. Если отрицательное - -1, а если 0 - то 0
SELECT tch.tch_fio AS FIO, SIGN(d.dYear) AS [distribution year], l.l_hours AS [hours], l.l_name AS lesson FROM Lessons l
    JOIN [Distribution] d ON (d.lId = l.idl)
    JOIN Teachers tch ON (d.tchId = tch.idtch)
	WHERE l_hours < 24 AND l_name LIKE '%y';


--LOG - Возвращает натуральный логарифм указанного выражения.
SELECT LOG(MAX(ex.ex_mark)) AS Mark, l.l_name AS Lesson, lt.lt_name AS [Type] FROM Exams ex
	JOIN Lessons l ON (ex.lId = l.idl)
	JOIN LessonTypes lt ON (l.ltypeId = lt.idlt)
	GROUP BY l_name, lt_name
	HAVING MAX(ex_mark) > 7
	ORDER BY l.l_name DESC


--DATENAME - возвращает часть даты переданной первым аргументом
SELECT s.s_fio AS student, s.s_numbook AS numbook, l.l_name AS lesson, DATENAME(day, ex.ex_date) AS 'Exam day', ex.ex_roomNum AS ExamRoom, ex.ex_mark AS mark FROM Exams ex
	JOIN Lessons l ON (ex.lId = l.idl)
	JOIN Students s ON (ex.stId = s.ids) 
	WHERE ex_mark = 8 OR ex_mark = 10 
	ORDER BY s.s_numbook;


--YEAR - возращает год указанной даты
SELECT tch.tch_fio AS FIO, YEAR(tch.tch_bday) AS bdayYear, d.dYear AS [distribution year], l.l_name AS lesson, DAY(ex.ex_date) AS [exam date] FROM Lessons l
    JOIN [Distribution] d ON (d.lId = l.idl)
    JOIN Teachers tch ON (d.tchId = tch.idtch)
	JOIN Exams ex ON (ex.lId = l.idl)
	WHERE l_name LIKE '%s';


--@@CPU_BUSY - возвращает время, которое sql server тратит на выполнении операции
SELECT @@CPU_BUSY AS [Time], st.s_numHouse AS PeopleInHouse, s.s_name AS Speciality, COUNT(tw.t_name) AS [Town] FROM Students st
	JOIN Specialities s ON (st.specId = s.ids)
	JOIN Towns tw ON(st.townId = tw.idt)
	GROUP BY s_numHouse, s_name
	HAVING COUNT(t_name) > 0
	ORDER BY s_name


--@@TOTAL_ERRORS - возвращает количество ошибок
SELECT @@TOTAL_ERRORS AS ErrorsCount, t.tch_fio AS FIO, t.tch_numOfPassport AS Passport, d.dYear AS distYear, tw.t_name AS Town, l.l_name AS Lesson FROM Teachers t
	JOIN [Distribution] d ON (d.tchId = t.idtch)
	JOIN Towns tw ON (t.townId = tw.idt)
	JOIN Lessons l ON (d.lId = l.idl)
	WHERE l_hours > 20 AND t_name LIKE '%a%'


--@@TOTAL_WRITE - возвращает число операций записи 
SELECT @@TOTAL_WRITE AS TotalWrite, ex.ex_date AS ExDate, l.l_name AS Lesson, l.l_hours AS [Hours], lt.lt_name AS [Type] FROM Exams ex
	JOIN Lessons l ON (ex.lId = l.idl)
	JOIN LessonTypes lt ON (l.ltypeId = lt.idlt)
	WHERE lt_name LIKE 'Special'
