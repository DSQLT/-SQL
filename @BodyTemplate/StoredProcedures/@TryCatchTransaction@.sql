


CREATE PROCEDURE [@BodyTemplate].[@TryCatchTransaction@]
AS 
BEGIN
-- Vorspann
SET NOCOUNT ON
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
  /*@03@*/
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	--EXEC DSQLT._Error @@ProcId
END CATCH
END
GO

