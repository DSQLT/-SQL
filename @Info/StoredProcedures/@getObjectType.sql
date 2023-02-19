-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		Object Type (varchar(2)) if object exists, null else
-- =============================================

CREATE PROCEDURE [@Info].[@getObjectType]
@object NVARCHAR (MAX)
,@schema sysname=null
,@database sysname=null
,@linkedServer sysname=null
,@ObjectType VARCHAR(2)=null OUTPUT
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

DECLARE @Template NVARCHAR (MAX)=''
EXECUTE [@@].[ApplyTemplateProcedure] '[@Templates].[@getObjectType@]',@Template OUTPUT,@Object

DECLARE @ResultTable [@@].[ListTable]

insert into @ResultTable([@Entry])
execute [@@].[_executeSQL] @Template,@Database=@Database,@linkedserver=@linkedserver
select Top 1 @ObjectType=[@Entry] from @ResultTable
END
GO

