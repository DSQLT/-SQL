


CREATE PROC [@Script].[Replicate@SQL]
@Database sysname
,@LinkedServer sysname=NULL 
,@Print BIT=0
AS
DECLARE @Check int
EXECUTE @Check = [@Info].[_checkDatabase] @Database,@LinkedServer,@RaiseError=1
if @Check=0 RETURN -1

DECLARE @Cursor CURSOR ; SET @Cursor= CURSOR LOCAL STATIC FOR 
	SELECT ObjectQ,SchemaQ FROM [@Info].[Object_Dependency_Level] (null,null) -- null takes all objects of relevant schemas of @sql
	ORDER BY DependencyLevel
EXECUTE [@@].ExecuteTemplateProcedureWithCursor '[@Templates].[@CreateObject@]',@Cursor,@Database,@LinkedServer
GO

