--             
INSERT INTO Specialities(s_name) VALUES ('TEST')
INSERT INTO Specialities (s_name) VALUES ('TEST')
--                                 
BEGIN TRAN
	INSERT INTO Specialities(s_name) VALUES ('TEST21')
	INSERT INTO Specialities (s_name) VALUES ('asdasdssaddasdsdsadasdasd')
COMMIT TRAN
--                                   TRY   CATCH
BEGIN TRY	
    BEGIN TRAN
		INSERT INTO Specialities(s_name) VALUES ('TEST31')
		INSERT Specialities VALUES ('alsfamslflasfkaskfkaslfkalskflkaslfklaskflkal;skfl;akslfkal;skf;lkasl;kfl;askfl;kasl;f')
    COMMIT TRAN
END TRY
BEGIN CATCH
    RAISERROR ('!!!!!EROR!!!!!', 14, 1)
    ROLLBACK TRAN
END CATCH
--                  
SET implicit_transactions ON
INSERT Specialities VALUES (10,'AAA')
GO 
SELECT @@TRANCOUNT AS VALUE
--                    
 ROLLBACK TRAN --     
 
