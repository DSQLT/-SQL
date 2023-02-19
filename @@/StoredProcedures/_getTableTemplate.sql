

CREATE PROCEDURE [@@].[_getTableTemplate]
@Object NVARCHAR (MAX)
,@Template NVARCHAR (MAX) OUTPUT
,@ForObject NVARCHAR (MAX)=NULL
,@TableType VARCHAR (2)=NULL
AS
BEGIN
IF @ForObject IS NULL SET @ForObject=@Object
IF [@Info].[isTable](@Object) = 0 RETURN -1
IF @TableType IS NULL SET @TableType=[@Info].[getObjectType](@Object)

SET @Template='
CREATE TABLE [@Name@].[@Name@] 
(
@ColumnList@
)
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
'
IF @TableType='TT'
  BEGIN
  SET @Template='
CREATE TYPE [@Name@].[@Name@] AS TABLE
(
@ColumnList@
)
'
  END
DECLARE @Delimiter CHAR(3)=','+[@@].[CRLF]()
DECLARE @ColumnList NVARCHAR(MAX)
SELECT @ColumnList=STRING_AGG(ColumnScript,@Delimiter) WITHIN GROUP (ORDER BY [Order]) FROM [@Info].[Columns](@Object)
DECLARE @ParameterNameList NVARCHAR(MAX)='@Name@,@ColumnList@'
EXECUTE [@@].[ApplyTemplate] @Template OUTPUT,@ForObject,@ColumnList,@ParameterNameList=@ParameterNameList
END
GO

