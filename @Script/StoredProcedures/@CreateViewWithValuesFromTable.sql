


CREATE PROC [@Script].[@CreateViewWithValuesFromTable]
(@Table SYSNAME, @View SYSNAME, @Print BIT=0)
AS 
BEGIN
DECLARE @Delimiter SYSNAME=','+[@@].[QuoteSQ](',')+','
DECLARE @valueExpressionList VARCHAR(MAX)=(
	SELECT STRING_AGG('ISNULL('+REPLACE(T.type_to_value,'%v',o.ColumnQ)+',''NULL'')',@Delimiter) WITHIN GROUP ( ORDER BY O.[Order])
	FROM [@Info].[Columns](@Table) O
	JOIN [@@].Types T ON t.type_id=O.Type_Id
)
SET @valueExpressionList=[@@].[QuoteSQ]('(')+'+CONCAT('+@valueExpressionList+')+'+[@@].[QuoteSQ](')')

DECLARE @ValueListTemplate VARCHAR(MAX)
EXECUTE [@@].ApplyTemplateProcedure '[@Templates].[@SelectValueExpressionList@]',@ValueListTemplate OUTPUT,@Table,@valueExpressionList
DECLARE @EntryTable AS [@@].[OneEntryTable] 
INSERT INTO @EntryTable([@Entry]) EXECUTE (@ValueListTemplate)
DECLARE @Values VARCHAR(MAX)='(VALUES '+[@@].[CRLF]()+(SELECT TOP 1 [@Entry] FROM @EntryTable)+')'+[@@].[CRLF]()

DECLARE @ColumnList VARCHAR(MAX)=[@Info].[ColumnList](@Table,NULL,',')
DECLARE @Alias VARCHAR(MAX)=' V('+@ColumnList+')'

DECLARE @ViewTemplate VARCHAR(MAX)
EXECUTE [@@].[_getObjectTemplate] '[@View@].[@View@]',@ViewTemplate OUTPUT,@OnlyBeginEndBlock=0
DECLARE @ParameterNameList VARCHAR(MAX)='@View@,@Table@,@Column@,@Alias@'
EXECUTE [@@].[Add_Create_or_Alter] @ViewTemplate OUTPUT

EXECUTE [@@].ExecuteTemplate @ViewTemplate,@View,@Values,@ColumnList, @Alias,@ParameterNameList=@ParameterNameList,@Print=@Print
END
GO

