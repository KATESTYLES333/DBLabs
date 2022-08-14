USE master
COMMIT TRANSACTION
ALTER DATABASE SchoolExams SET RECOVERY FUll
GO

-- полное резервное копирование
BACKUP DATABASE SchoolExams TO DISK = 'D:\MyFirstrep\DB\lab2\SchoolExams.bak';
-- разностное резервное копирование 
BACKUP DATABASE SchoolExams TO DISK = 'D:\MyFirstrep\DB\lab2\SchoolExamsDiff.bak' WITH DIFFERENTIAL;
--Резервное копирование журнала транзакций  
BACKUP LOG SchoolExams TO DISK = 'D:\MyFirstrep\DB\lab2\SchoolExams_log.bak'
--Резервное копирование файловых групп
BACKUP DATABASE SchoolExams FILEGROUP = 'filegroup' TO DISK = 'D:\MyFirstrep\DB\lab2\SchoolExamsFG.bak';

RESTORE DATABASE SchoolExams FROM DISK = 'D:\MyFirstrep\DB\lab2\SchoolExams.bak' WITH REPLACE;
--RESTORE DATABASE SchoolExams FROM DISK = 'D:\MyFirstrep\DB\lab2\SchoolExamsDiff.bak' WITH RECOVERY, REPLACE;
--RESTORE DATABASE SchoolExams FROM DISK = 'D:\MyFirstrep\DB\lab2\SchoolExams_log.bak' WITH NORECOVERY;
--RESTORE DATABASE SchoolExams FILEGROUP = 'filegroup' FROM DISK = 'D:\MyFirstrep\DB\lab2\SchoolExamsFG.bak' WITH PARTIAL, RECOVERY;

BEGIN TRANSACTION
GO