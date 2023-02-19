
CREATE PROC [@Templates].[@ForEachDatabaseSourceSearchTemplate@]
@Pattern@ NVARCHAR (MAX),@Tempname@ sysname, @Database@ sysname=DB_NAME
AS
BEGIN
IF EXISTS (SELECT object_id FROM sys.sql_modules WHERE definition LIKE '@Pattern@')
	INSERT INTO [@Database@].dbo.[@Tempname@]
	SELECT 
	@@servername AS [Server]
	,DB_NAME() AS [Database]
	,s.name AS [Schema]
	,o.name AS [Program] 
	,o.[type] 
	,o.type_desc 
	,m.definition
	FROM sys.sql_modules m
	JOIN sys.objects o ON m.object_id=o.object_id
	JOIN sys.schemas s ON o.schema_id=s.schema_id
	WHERE m.definition LIKE '@Pattern@'

IF EXISTS (SELECT object_id FROM sys.synonyms WHERE base_object_name LIKE '@Pattern@')
	INSERT INTO [@Database@].dbo.[@Tempname@]
	SELECT 
	@@servername AS [Server]
	,DB_NAME() AS [Database]
	,S.name AS [Schema]
	,O.name AS [Program] 
	,o.[type] 
	,o.type_desc 
	,O.base_object_name AS definition
	FROM sys.synonyms O
	JOIN sys.schemas S ON O.schema_id=S.schema_id
	WHERE o.base_object_name LIKE '@Pattern@'

END
GO

