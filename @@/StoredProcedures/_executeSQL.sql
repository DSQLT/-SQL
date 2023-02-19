

CREATE PROC [@@].[_executeSQL]
@SQL NVARCHAR (MAX)=null
,@Database sysname=null
,@LinkedServer sysname=null
,@Print bit=0
AS
BEGIN
DECLARE @Exec NVARCHAR (MAX)

IF @Print=1
	BEGIN
	PRINT @SQL
	RETURN
	END

IF @Database is not null
	BEGIN
	SET @Database=[@@].[QuoteSB](@Database)
	SET @Exec=@Database+'.dbo.sp_executesql'
	END

IF @LinkedServer is not null
	BEGIN
	SET @LinkedServer=[@@].[QuoteSB](@LinkedServer)
  IF @Database is not null
	  BEGIN
    SET @SQL='EXECUTE ('+[@@].[QuoteSQ]('EXECUTE '+@Exec+' N'+[@@].[QuoteSQ](@SQL))+') AT '+@LinkedServer
    EXECUTE (@SQL) 
    RETURN
	  END
  ELSE
    -- Fehler !!! Bei Linked Server wird Database benötigt
	  RETURN -1
  END

IF @Database is not null
	BEGIN
	EXECUTE @Exec @SQL
	END
ELSE
	BEGIN
	EXECUTE (@SQL)
	END

END
GO

