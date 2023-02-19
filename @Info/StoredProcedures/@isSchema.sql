




-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if schema exists
-- Returns:		1 if schema, 0 else
-- =============================================

CREATE   PROCEDURE [@Info].[@isSchema]
@schema sysname=NULL
,@database sysname=NULL
,@linkedServer sysname=NULL
AS
BEGIN
SET NOCOUNT ON
  -- check if @database is valid
  -- check if @schema is valid

DECLARE @Result INT=0

IF @database IS NULL RETURN [@Info].[isSchema](@schema)

DECLARE @Template NVARCHAR (MAX)=''
EXECUTE [@@].[ApplyTemplateProcedure] '[@Templates].[@isSchema@]',@Template OUTPUT,@schema

DECLARE @ResultTable [@@].[ListTable]

INSERT INTO @ResultTable([@Entry])
EXECUTE [@@].[_executeSQL] @Template,@Database=@Database,@linkedserver=@linkedserver
SELECT TOP 1 @Result=CAST([@Entry] AS INT) FROM @ResultTable
RETURN @Result
END
GO

