



CREATE   FUNCTION [@Info].[Object]
(@Object NVARCHAR (MAX))
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
	[user_type_id] int NOT NULL
)
AS
BEGIN
DECLARE @ObjectID INT =[@Info].[getObjectId](@Object) -- because of UDTT
;WITH Objects AS
(
SELECT object_id,schema_id,name,type, 0 AS [user_type_id]
FROM sys.objects
WHERE [object_id]=@ObjectID AND [type] <> 'TT'

UNION

SELECT type_table_object_id AS object_id,schema_id,name,'TT' AS type,[user_type_id]
FROM sys.table_types
WHERE type_table_object_id = @ObjectID
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
RETURN
END
GO

