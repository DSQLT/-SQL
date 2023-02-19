
CREATE FUNCTION [@Info].[Schemas]
(@Pattern NVARCHAR (MAX)='%')
RETURNS @Result TABLE (
	[Schema] sysname NOT NULL,
	[SchemaQ] NVARCHAR(MAX) NOT NULL
)
AS
BEGIN
INSERT @Result
	SELECT 
	S.name AS [Schema]
	,QUOTENAME(S.name) AS SchemaQ
	FROM sys.schemas S
  WHERE [schema_id] < 16384  -- suppress database Roles
	AND (QUOTENAME(S.name) LIKE @Pattern OR S.name LIKE @Pattern)
RETURN
END
GO

