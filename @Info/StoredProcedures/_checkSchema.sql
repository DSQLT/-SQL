

-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE PROCEDURE [@Info].[_checkSchema]
(@Schema sysname
,@Database sysname=NULL
,@LinkedServer sysname=NULL
,@RaiseError BIT = 1
)
AS
BEGIN
  DECLARE @ErrorMessageID INT = [@Config].[ErrorMessageID](4)
  DECLARE @Result BIT = 0
  SET @Schema=PARSENAME(@Schema,1)  -- removes square brackets, because 
  SET @Result=IIF(ISNULL(SCHEMA_ID(@Schema),0) > 0,1,0)
  IF @LinkedServer IS NULL AND @Database IS NULL
    BEGIN
      IF @RaiseError=1 AND @Result=0 RAISERROR (@ErrorMessageID,11,1,@Schema)
	    RETURN @Result
    END
  EXECUTE @Result = [@Info].[_checkDatabase] @Database, @LinkedServer, @RaiseError
  IF @Result=0 RETURN @Result
  EXECUTE @Result = [@Info].[@isSchema] @Schema,@Database,@LinkedServer
  IF @Result=1 RETURN @Result
  IF @LinkedServer IS NULL
    BEGIN
      SET @ErrorMessageID = [@Config].[ErrorMessageID](5)
      IF @RaiseError=1 RAISERROR (@ErrorMessageID,11,1,@Schema,@Database)        
    END
  ELSE
    BEGIN
      SET @ErrorMessageID = [@Config].[ErrorMessageID](6)
      IF @RaiseError=1 RAISERROR (@ErrorMessageID,11,1,@Schema,@Database,@LinkedServer)        
    END
	RETURN @Result
END
GO

