
-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		
-- =============================================

CREATE   PROCEDURE [@Script].[@DropObject]
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
EXECUTE @Result = [@Info].[@isObject] @Object, @Database=@Database,@linkedserver=@linkedserver
IF @Result=1
BEGIN
  DECLARE @TypeName sysname
  DECLARE @ObjectType NCHAR(2)
  EXECUTE [@Info].[@getObjectType] @object = @object,@database = @database,@linkedServer = @linkedServer,@ObjectType = @ObjectType OUTPUT
  SELECT @TypeName=[Type_Name] FROM [@@].[ObjectTypes] WHERE [Object_Type]=@ObjectType
  IF @TypeName IS NOT NULL
  BEGIN
    DECLARE @Template NVARCHAR (MAX)='DROP @TypeName@ [@Object@].[@Object@]'
    DECLARE @ParameterNameList NVARCHAR (MAX)='@TypeName@,@Object@'
    EXECUTE [@@].[ExecuteTemplate] @Template,@TypeName,@object,@ParameterNameList=@ParameterNameList,@Database=@Database,@linkedserver=@linkedserver,@Print=@Print
  END
END

END
GO

