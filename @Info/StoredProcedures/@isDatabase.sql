-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if database exists
-- Returns:		1 if database, 0 else
-- =============================================

CREATE PROCEDURE [@Info].[@isDatabase]
@database sysname=NULL
,@linkedServer sysname=NULL
AS
BEGIN
SET NOCOUNT ON
  -- check if @database is valid

DECLARE @Result INT=0

DECLARE @Template NVARCHAR (MAX)=''
EXECUTE [@@].[ApplyTemplateProcedure] '[@Templates].[@isDatabase@]',@Template OUTPUT,@database

DECLARE @ResultTable [@@].[ListTable]

INSERT INTO @ResultTable([@Entry])
EXECUTE [@@].[_executeSQL] @Template,@Database='master',@linkedserver=@linkedserver  -- we use master Database to check, if the queried database exists
SELECT TOP 1 @Result=CAST([@Entry] AS INT) FROM @ResultTable
RETURN @Result
END
GO

