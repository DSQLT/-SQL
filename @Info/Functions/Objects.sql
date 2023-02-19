
CREATE FUNCTION [@Info].[Objects]
(@Pattern NVARCHAR (MAX)= NULL)
RETURNS @Result TABLE (
	[Object_id] INT NOT NULL,
	[Object] sysname NOT NULL,
	[ObjectQ] sysname NOT NULL,
	[Schema_id] INT NOT NULL,
	[Schema] sysname NOT NULL,
	[SchemaQ] sysname NOT NULL,
	[SchemaObject] [NVARCHAR](MAX) NOT NULL,
	[SchemaObjectQ] [NVARCHAR](MAX) NOT NULL,
	[ObjectType] [NCHAR](2) NOT NULL,
	[user_type_id] INT NOT NULL
)
AS
BEGIN
;WITH Objects AS
(
SELECT object_id,schema_id,name,type, 0 AS [user_type_id]
FROM sys.objects
WHERE [type] <> 'TT'

UNION

SELECT type_table_object_id AS object_id,schema_id,name,'TT' AS type,[user_type_id]
FROM sys.table_types
)
INSERT @Result
	SELECT 
  O.object_id 
	,O.name AS [Object]
	,QUOTENAME(O.name) AS ObjectQ
  ,O.[schema_id] 
	,S.name AS [Schema]
	,QUOTENAME(S.name) AS SchemaQ
	,S.name+'.'+O.name AS SchemaObject
	,QUOTENAME(S.name)+'.'+QUOTENAME(O.name) AS SchemaObjectQ
  ,o.type AS [ObjectType]
  ,o.[user_type_id]
	FROM objects O
	JOIN sys.schemas S ON S.schema_id=O.schema_id
	WHERE @Pattern IS NULL
  OR  QUOTENAME(S.name)+'.'+QUOTENAME(O.name) LIKE @Pattern
  OR  QUOTENAME(S.name)+'.'+O.name LIKE @Pattern
  OR  S.name+'.'+QUOTENAME(O.name) LIKE @Pattern
  OR  S.name+'.'+O.name LIKE @Pattern
RETURN
END
GO

