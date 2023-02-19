

CREATE PROCEDURE [@@].[_getObjectDefinition]
@Object NVARCHAR (MAX)
,@Definition NVARCHAR (MAX) OUTPUT
AS
BEGIN
SET @Definition=OBJECT_DEFINITION(OBJECT_ID(@Object))

IF [@Info].[isTable](@Object) = 1
BEGIN
  EXECUTE [@@].[_getTableTemplate] @Object,@Definition OUTPUT
END

END
GO

