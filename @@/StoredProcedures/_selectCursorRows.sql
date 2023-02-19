



CREATE PROC [@@].[_selectCursorRows]
@Cursor CURSOR VARYING OUTPUT
--,@Cursorname sysname  
,@Count INT -- 20.11.22
AS
BEGIN
--DECLARE @count INT    

--SELECT @count=sc.column_count
--FROM sys.syscursorrefs scr
--JOIN sys.syscursors sc ON scr.cursor_handl=sc.cursor_handle
--WHERE scr.reference_name=@Cursorname



DECLARE @FetchTemplate AS NVARCHAR(MAX)
DECLARE @declare VARCHAR(MAX)
DECLARE @fetchList VARCHAR(MAX)
DECLARE @valueList VARCHAR(MAX)
DECLARE @delim1 CHAR(2)=[@@].[CRLF]()
DECLARE @delim2 CHAR(1)=','
DECLARE @delim3 CHAR(4)='), ('

SELECT 
@declare=STRING_AGG('DECLARE @c'+LTRIM(STR(number))+' VARCHAR(max)=NULL',@delim1) WITHIN GROUP (ORDER BY number)
,@fetchList=STRING_AGG('@c'+LTRIM(STR(number)),@delim2) 
,@valueList=STRING_AGG('@i,'+LTRIM(STR(number))+',@c'+LTRIM(STR(number)),@delim3) 
FROM [@SQL].[Numbers](1,@Count) 

SET @valueList=SUBSTRING(@valueList,6,LEN(@valueList))  -- die ersten beiden Parameter wieder weg, stehen schon im Template
-- dies ist nötig, da im Template [@@].[@FetchCursor@] der Values Clause verwendet wird und 3 Einträge benötigt:    
-- so stehts im Template ::  insert into @table values (@i,1,@03@)   -- @03@ erzeugt dann passende Iterationen

DECLARE @ParameterTable [@@].[ParameterTable]
INSERT INTO @ParameterTable VALUES (1,'@01@',@declare),(2,'@02@',@fetchList),(3,'@03@',@valueList)

EXECUTE [@@].[_getObjectTemplate] '[@@].[@FetchCursor@]', @FetchTemplate OUTPUT
EXECUTE [@@].[_replaceTemplateParameterTable] @FetchTemplate OUTPUT,@ParameterTable
EXECUTE sys.sp_executesql @FetchTemplate ,N'@Cursor CURSOR',@Cursor 

END
GO

