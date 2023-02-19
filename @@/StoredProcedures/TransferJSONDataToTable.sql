

CREATE PROC [@@].[TransferJSONDataToTable] 
@Table AS NVARCHAR(MAX)
,@Json AS NVARCHAR(MAX)
,@Print BIT =0
AS
BEGIN
SET NOCOUNT ON
SET XACT_ABORT ON
BEGIN TRY
	   DECLARE @ParameterTable [@@].[ParameterTable] 
       INSERT INTO @ParameterTable ([@ID],[@Name],[@Value]) 
       SELECT [@ID],[@Name],[@Value]
       FROM OPENJSON(@json) WITH([@ID] INT,[@Name] NVARCHAR(MAX),[@Value] NVARCHAR(MAX))

       DECLARE @FieldSeparator NVARCHAR(5)=[@@].[CRLF]()+','
       DECLARE @JOINSeparator NVARCHAR(5)=[@@].[CRLF]()
       DECLARE @FieldList NVARCHAR(MAX)
       DECLARE @JoinList NVARCHAR(MAX)
       DECLARE @SQL NVARCHAR(MAX)

       SELECT 
       @FieldList=STRING_AGG(CONCAT('TRY_CAST(D',FORMAT(C.[Order],'0'),'.[@Value] AS ',[@@].[TypeDefinition](C.Type_Id,C.Length,C.Precision,C.Scale),') AS ',C.ColumnQ),@FieldSeparator)
       WITHIN GROUP(ORDER BY C.[Order]) ,
       @JoinList=STRING_AGG(CONCAT('LEFT JOIN @ParameterTable D',FORMAT(C.[Order],'0'),' ON D',FORMAT(C.[Order],'0'),'.[@ID] = D0.[@ID] AND D',FORMAT(C.[Order],'0'),'.[@Name]=',[@@].QuoteSQ(C.[Column])),@JOINSeparator)
       WITHIN GROUP(ORDER BY C.[Order]) 
       FROM [@Info].[Columns](@Table) C

       SET @SQL=N'INSERT INTO '+@Table+'('+[@Info].[ColumnList](@Table,'',',')+')'+[@@].CRLF()+
	   'SELECT '+[@@].CRLF()+
       @FieldList+[@@].CRLF()+
       'FROM (SELECT DISTINCT [@ID] AS [@ID] FROM @ParameterTable) D0'+[@@].CRLF()+
       @JoinList+[@@].CRLF()+
       'ORDER BY D0.[@ID]'

       EXECUTE [@@].[ExecuteTemplate] 'TRUNCATE TABLE @01@',@Table,@Print=@Print
	
	   IF @Print=0
		EXEC sp_executesql @SQL, N'@ParameterTable [@@].[ParameterTable] READONLY',@ParameterTable
	   ELSE
         PRINT @SQL

       EXECUTE [@@].[ExecuteTemplate] 'SELECT *,GETDATE() AS [@Aktualisiert_am], SUSER_NAME() AS [@Aktualisert_von] FROM @01@',@Table,@Print=@Print
END TRY
BEGIN CATCH
       THROW
END CATCH
END
GO

