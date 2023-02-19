-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		
-- =============================================

CREATE   PROCEDURE [@Script].[@CreateObject]
@object NVARCHAR (MAX)
,@schema sysname=NULL
,@database sysname=NULL
,@linkedServer sysname=NULL
,@Print BIT=0
AS
BEGIN
SET NOCOUNT ON
  -- check if @linkedServer is valid
  -- check if @database is valid
  -- check if @schema is valid
  IF @schema IS NOT NULL
    BEGIN
      SET @object=@schema+'.'+@object
    END
  ELSE
    BEGIN
      SET @schema=PARSENAME(@object,2)
    END

DECLARE @Result INT=0
DECLARE @Template NVARCHAR (MAX)=''

EXECUTE [@@].[_getObjectDefinition] @Object,@Template OUTPUT

EXECUTE [@Script].[@CreateSchema] @schema = @schema,@Database=@Database,@linkedserver=@linkedserver,@Print=@Print  -- Creates only if not exists


EXECUTE @Result = [@Info].[@isObject] @Object, @Database=@Database,@linkedserver=@linkedserver
IF @Result=1
BEGIN
  EXECUTE [@Script].[@DropObject] @Object, @Database=@Database,@linkedserver=@linkedserver,@Print=@Print
END

EXECUTE [@@].[_executeSQL] @Template,@Database=@Database,@linkedserver=@linkedserver,@Print=@Print
END
GO

