
-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE PROCEDURE [@Info].[_checkDatabase]
(@Database sysname
,@LinkedServer sysname=null
,@RaiseError BIT = 1
)
AS
BEGIN
  DECLARE @ErrorMessageID INT = [@Config].[ErrorMessageID](2)
	DECLARE @Result BIT =IIF(ISNULL(DB_ID(@Database),0) > 0,1,0)
  IF @LinkedServer IS NULL
    BEGIN
      IF @RaiseError=1 AND @Result=0 RAISERROR (@ErrorMessageID,11,1,@Database)
    END
  ELSE
    BEGIN
      EXECUTE @Result = [@Info].[_checkLinkedServer] @LinkedServer, @RaiseError
      IF @Result=1
      BEGIN
        EXECUTE @Result = [@Info].[@isDatabase] @Database,@LinkedServer
        SET @ErrorMessageID = [@Config].[ErrorMessageID](3)
        IF @RaiseError=1 AND @Result=0 RAISERROR (@ErrorMessageID,11,1,@Database,@LinkedServer)        
      END
    END
	RETURN @Result
END
GO

