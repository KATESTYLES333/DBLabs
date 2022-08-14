DROP PROCEDURE IF EXISTS F1;
DROP PROCEDURE IF EXISTS F2;
DROP PROCEDURE IF EXISTS F3;
DROP PROCEDURE IF EXISTS F4;
DROP PROCEDURE IF EXISTS F5;
GO

CREATE PROCEDURE F1 @first INT, @second INT AS
BEGIN
	SELECT s_fio AS Student, s.s_name AS Speciality FROM Students
		JOIN Specialities AS s ON (specId = s.ids)
		WHERE s_numHouse = @first AND s_numFlat = @second
END
GO



CREATE PROCEDURE F2 @fyear INT, @eyear INT, @hours INT AS
BEGIN
	SELECT t.tch_fio AS Teacher, t.tch_age AS Age, d.dYear AS [Year], l.l_name AS Lesson, l.l_hours AS [Hours] FROM Teachers t
	JOIN [Distribution] d ON (d.tchId = tchId)
	JOIN Lessons l ON (d.lId = l.idl)
	WHERE l.l_hours = @hours OR d.dYear IN (@fyear, @eyear)
	ORDER BY Lesson ASC
END
GO

CREATE PROCEDURE F3 @mark INT, @hours INT AS
BEGIN 
	SELECT l.l_name AS Lesson, MAX(l.l_hours) AS MaxHours, ex.ex_mark AS Mark FROM Lessons l
		JOIN Exams ex ON (ex.lId = l.idl)
		GROUP BY l_name, ex_mark
		HAVING MAX(l_hours) > @hours AND ex.ex_mark = @mark
		
END
GO

CREATE PROCEDURE F4 @lesson VARCHAR(20), @fhours INT, @shours INT AS
BEGIN
	SELECT  l.l_name AS Lesson, lt.lt_name AS [Type], ex.ex_mark AS Mark, ex.ex_date AS [Date] FROM Lessons l
	JOIN LessonTypes lt ON (l.ltypeId = lt.idlt)
	JOIN Exams ex ON (ex.lId = l.idl)
	WHERE l.l_name LIKE @lesson AND l.l_hours BETWEEN @fhours AND @shours

END
GO

CREATE PROCEDURE F5 @speciality VARCHAR(10), @gender VARCHAR(1), @mark INT AS
BEGIN
	SELECT s.s_fio AS Student, sp.s_name AS Speciality, t.t_name AS Town FROM Students s
	JOIN Specialities sp ON (s.specId = sp.ids)
	JOIN Towns t ON (s.townId = t.idt)
	JOIN Exams ex ON (ex.stId = s.ids)
	JOIN Teachers tch ON (tch.townId = t.idt)
	WHERE sp.s_name LIKE @speciality AND tch.tch_gender LIKE @gender AND @mark > 7
END


EXEC F1 3,3;
EXEC F2 2001, 2002, 20;
EXEC F3 8, 18;
EXEC F4 'Zoology', 18, 20;
EXEC F5 'Programmer', 'ì', 9;


