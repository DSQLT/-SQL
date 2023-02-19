


CREATE PROC [@@].[_replaceTemplateParameterTable]
@Template NVARCHAR (MAX) OUTPUT
,@ParameterTable [@@].[ParameterTable] READONLY
AS

DECLARE @Cursor CURSOR ; 
SET @Cursor= CURSOR LOCAL STATIC FOR 	
	SELECT [@ID],[@Name],[@Value]
	FROM @ParameterTable

DECLARE @pos INT 
DECLARE @Parameter VARCHAR(MAX)
DECLARE @Value VARCHAR(MAX)

OPEN @Cursor
WHILE (1=1)
BEGIN
	FETCH NEXT FROM @Cursor INTO @pos,@Parameter,@Value
	IF (@@FETCH_STATUS <> 0) BREAK  -- alle Datensätze geholt
	EXEC [@@].[_replaceTemplateParameterValue] @Template OUTPUT, @Parameter, @Value
END
CLOSE @Cursor
DEALLOCATE @Cursor

RETURN 1
GO

