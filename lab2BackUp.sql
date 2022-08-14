USE master
COMMIT TRANSACTION
ALTER DATABASE SchoolExams SET RECOVERY FUll
GO

-- ������ ��������� �����������
BACKUP DATABASE SchoolExams TO DISK = 'D:\MyFirstrep\DB\lab2\SchoolExams.bak';
-- ���������� ��������� ����������� 
BACKUP DATABASE SchoolExams TO DISK = 'D:\MyFirstrep\DB\lab2\SchoolExamsDiff.bak' WITH DIFFERENTIAL;
--��������� ����������� ������� ����������  
BACKUP LOG SchoolExams TO DISK = 'D:\MyFirstrep\DB\lab2\SchoolExams_log.bak'
--��������� ����������� �������� �����
BACKUP DATABASE SchoolExams FILEGROUP = 'filegroup' TO DISK = 'D:\MyFirstrep\DB\lab2\SchoolExamsFG.bak';

RESTORE DATABASE SchoolExams FROM DISK = 'D:\MyFirstrep\DB\lab2\SchoolExams.bak' WITH REPLACE;
--RESTORE DATABASE SchoolExams FROM DISK = 'D:\MyFirstrep\DB\lab2\SchoolExamsDiff.bak' WITH RECOVERY, REPLACE;
--RESTORE DATABASE SchoolExams FROM DISK = 'D:\MyFirstrep\DB\lab2\SchoolExams_log.bak' WITH NORECOVERY;
--RESTORE DATABASE SchoolExams FILEGROUP = 'filegroup' FROM DISK = 'D:\MyFirstrep\DB\lab2\SchoolExamsFG.bak' WITH PARTIAL, RECOVERY;

BEGIN TRANSACTION
GO