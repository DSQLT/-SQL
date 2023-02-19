
CREATE FUNCTION [@Info].[ColumnList]
(@ObjectName NVARCHAR (MAX)
,@Alias sysname=null
,@Delimiter sysname=null
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
SET @Delimiter=ISNULL(@Delimiter,',')
SET @Alias=ISNULL(@Alias,'')
IF LEN(@Alias) > 0 SET @Alias=[@@].[QuoteSB](@Alias)+'.'

DECLARE @ColumnList NVARCHAR(MAX)
select @ColumnList=STRING_AGG(@Alias+[ColumnQ],@Delimiter) WITHIN GROUP (ORDER BY [Order]) from [@Info].[Columns](@ObjectName)

RETURN @ColumnList
END
GO

