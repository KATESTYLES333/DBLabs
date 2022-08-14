USE SchoolExams;
GO

DROP INDEX IF EXISTS TownIndex ON Towns;
DROP INDEX IF EXISTS LessonsIndex ON Lessons;

ALTER TABLE Towns DROP PK1;
CREATE CLUSTERED INDEX TownIndex ON Towns (idt ASC);

ALTER TABLE Lessons DROP PK3;
CREATE CLUSTERED INDEX LessonsIndex ON Lessons (idl ASC);

DROP INDEX IF EXISTS NIndex ON Towns;
DROP INDEX IF EXISTS NILessons ON Lessons;
DROP INDEX IF EXISTS NISpecialities ON Specialities;
DROP INDEX IF EXISTS NITeachers ON Teachers;
DROP INDEX IF EXISTS NIStudents ON Students;
DROP INDEX IF EXISTS NIExams ON Exams;

CREATE UNIQUE NONCLUSTERED INDEX NIndex ON Towns(idt);
CREATE UNIQUE NONCLUSTERED INDEX NILessons ON Lessons(l_name);
CREATE UNIQUE NONCLUSTERED INDEX NISpecialities ON Specialities(s_name);
CREATE UNIQUE NONCLUSTERED INDEX NITeachers ON Teachers(tch_fio);
CREATE UNIQUE NONCLUSTERED INDEX NIStudents ON Students(s_fio);
CREATE UNIQUE NONCLUSTERED INDEX NIExams ON Exams (ex_date);

DROP INDEX IF EXISTS SosIndex ON Towns;
DROP INDEX IF EXISTS SosILessons ON Lessons;
DROP INDEX IF EXISTS SosISpecialities ON Specialities;
DROP INDEX IF EXISTS SosITeachers ON Teachers;
DROP INDEX IF EXISTS SosIStudents ON Students;
DROP INDEX IF EXISTS SosIExams ON Exams;

CREATE UNIQUE NONCLUSTERED INDEX SosIndex ON Towns(idt, t_name);
CREATE UNIQUE NONCLUSTERED INDEX SosILessons ON Lessons(idl, l_name);
CREATE UNIQUE NONCLUSTERED INDEX SosISpecialities ON Specialities(ids, s_name);
CREATE UNIQUE NONCLUSTERED INDEX SosITeachers ON Teachers(idtch, tch_fio);
CREATE UNIQUE NONCLUSTERED INDEX SosIStudents ON Students(ids, s_fio);
CREATE UNIQUE NONCLUSTERED INDEX SosIExams ON Exams(idex, ex_date);
