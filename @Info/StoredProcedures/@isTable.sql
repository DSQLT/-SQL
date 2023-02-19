

-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		Object Type (varchar(2)) if object exists, null else
-- =============================================

CREATE PROCEDURE [@Info].[@isTable]
@object NVARCHAR (MAX)
,@schema sysname=null
,@database sysname=null
,@linkedServer sysname=null
AS
BEGIN
	DECLARE @Result bit =0
  declare @ObjectType VARCHAR(2)
  execute [@Info].[@getObjectType] @object,@schema,@database,@linkedServer,@ObjectType=@ObjectType OUTPUT

  if @ObjectType in (select [Object_Type] from [@@].[ObjectTypes] where [Super_Type]='T')
    SET @Result=1
  RETURN @Result
END
GO

