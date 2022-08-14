USE SchoolExams1;
GO

DROP VIEW IF EXISTS SelectAll;
DROP VIEW IF EXISTS SelectDistrTeach;
DROP VIEW IF EXISTS SelectLessLessType;
DROP VIEW IF EXISTS SelectExStSpec;
DROP VIEW IF EXISTS SelectTchTown;
DROP VIEW IF EXISTS SelectStTownSp;
GO

CREATE VIEW SelectAll AS 
SELECT ex.ex_date AS ExamDate, ex.ex_roomNum AS RoomNumber, ex.ex_mark AS ExamMark, l.l_name AS LessonName, l.l_hours AS LessonHours, lt.lt_name AS LessonTypeName,
st.s_fio AS StudentFIO, st.s_numbook AS StudentNumbook, sp.s_name AS SpecialityName, cst.t_name AS StudentCity, d.dYear AS YearOfDistribution, 
t.tch_fio AS TeacherFIO, ct.t_name AS TeacherCity FROM Exams ex
	JOIN Lessons l ON (ex.lId = l.idl)
	JOIN LessonTypes lt ON (l.ltypeId = lt.idlt)
	JOIN Students st ON (ex.stId = st.ids)
	JOIN [Distribution] d ON (l.idl = d.lId)
	JOIN Teachers t ON (d.tchId = t.idtch)
	JOIN Towns cst ON (st.townId = cst.idt) 
	JOIN Towns ct ON (t.townId = ct.idt)
	JOIN Specialities sp ON (st.specId = sp.ids)
WHERE l.l_hours = 20 
GO
SELECT * FROM SelectAll
ORDER BY RoomNumber DESC;
GO

CREATE VIEW SelectDistTeach AS
SELECT d.dYear AS DistributionYear, tch.tch_fio AS TeacherFIO FROM [Distribution] d
	JOIN Teachers tch ON (d.tchId = tch.idtch)
WHERE tch.tch_age > 18
GO
SELECT * FROM SelectDistTeach
ORDER BY DistributionYear;
GO

CREATE VIEW SelectLessLessType AS
SELECT l.l_name AS LessonName, lt.lt_name AS LessonType FROM Lessons l
	JOIN LessonTypes lt ON (l.ltypeId = lt.idlt)
WHERE l.l_hours > 10;
GO
SELECT * FROM SelectLessLessType
ORDER BY LessonName;
GO

CREATE VIEW SelectExStSpec AS 
SELECT ex.ex_date AS ExamDate, ex.ex_mark AS ExamMark, ex.ex_roomNum AS ExamRoom, st.s_fio AS StudentFIO, sp.s_name AS SpecialityName FROM Exams ex
	JOIN Students st ON (ex.stId = st.ids)
	JOIN Specialities sp ON (st.specId = sp.ids)
WHERE ex.ex_mark > 4
GO
SELECT* FROM SelectExStSpec
ORDER BY ExamMark;
GO

CREATE VIEW SelectTchTown AS
SELECT tch.tch_fio AS TeacherFIO, tch.tch_numFlat AS Flat, tch.tch_numHouse AS House, t.t_name AS Town FROM Teachers tch
	JOIN Towns t ON (tch.townId = t.idt)
WHERE tch.tch_gender = 'æ'
GO
SELECT * FROM SelectTchTown
ORDER BY House DESC;
GO

CREATE VIEW SelectStTownSp AS
SELECT st.s_fio AS StudentFIO, st.s_numFlat AS Flat, st.s_numHouse AS House, sp.s_name AS SpecialityName, t.t_name AS Town FROM Students st
	JOIN Specialities sp ON (st.specId = sp.ids)
	JOIN Towns t ON (st.townId = t.idt)
WHERE sp.s_name = 'Programmer' OR sp.s_name = 'Technicist'
GO
SELECT * FROM SelectStTownSp
ORDER BY House;
GO





