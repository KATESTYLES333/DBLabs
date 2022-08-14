--CREATE DATABASE SchoolExams;
--GO

USE SchoolExams;
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
INSERT INTO Exams (ex_date, ex_roomNum, ex_mark, lId, stId) VALUES (CONVERT(date,'2020-08-20', 120), 12, 9, 5, 3);


