


-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE PROCEDURE [@Info].[@isObject]
@object NVARCHAR (MAX)
,@schema sysname=null
,@database sysname=null
,@linkedServer sysname=null
AS
BEGIN
SET NOCOUNT ON
  -- check if @linkedServer is valid
  -- check if @database is valid
  -- check if @schema is valid
  IF @schema is not null
    BEGIN
      SET @object=@schema+'.'+@object
    END
DECLARE @Result int=0

DECLARE @Template NVARCHAR (MAX)=''
EXECUTE [@@].[ApplyTemplateProcedure] '[@Templates].[@isObject@]',@Template OUTPUT,@Object

DECLARE @ResultTable [@@].[ListTable]

insert into @ResultTable([@Entry])
execute [@@].[_executeSQL] @Template,@Database=@Database,@linkedserver=@linkedserver
select Top 1 @Result=cast([@Entry] as int) from @ResultTable
RETURN @Result
END
GO

