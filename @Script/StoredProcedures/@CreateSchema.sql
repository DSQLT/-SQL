-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		
-- =============================================

CREATE PROCEDURE [@Script].[@CreateSchema]
@schema sysname=NULL
,@database sysname=NULL
,@linkedServer sysname=NULL
,@Print BIT=0
AS
BEGIN
SET NOCOUNT ON
  -- check if @linkedServer is valid
  -- check if @database is valid
  -- check if @schema is valid

DECLARE @Result INT=0
EXECUTE @Result=[@Info].[@isSchema] @schema = @schema,@Database=@Database,@linkedserver=@linkedserver
IF @Result=0
BEGIN
  DECLARE @Template NVARCHAR (MAX)='CREATE SCHEMA [@Schema@]'
  DECLARE @ParameterNameList NVARCHAR (MAX)='@Schema@'
  EXECUTE [@@].[ExecuteTemplate] @Template,@schema,@ParameterNameList=@ParameterNameList,@Database=@Database,@linkedserver=@linkedserver,@Print=@Print
END

END
GO

