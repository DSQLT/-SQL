

CREATE   PROC [@@].[_getCursorColumnCount]
@Cursor CURSOR VARYING OUTPUT
,@Cursorname sysname  
AS
BEGIN
DECLARE @column_count INT 

SELECT @column_count=sc.column_count
FROM sys.syscursorrefs scr
join sys.syscursors sc on scr.cursor_handl=sc.cursor_handle
where scr.reference_name=@Cursorname

RETURN @column_count
END
GO

