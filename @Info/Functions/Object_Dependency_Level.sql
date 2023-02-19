





CREATE   FUNCTION [@Info].[Object_Dependency_Level]
(@ObjectName NVARCHAR (MAX)=NULL,@SchemaList NVARCHAR (MAX)=NULL) 
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
	[user_type_id] INT NOT NULL,
	[DependencyLevel] INT NOT NULL
)
AS
BEGIN

INSERT @Result
SELECT 
  [O].[Object_id]
, [O].[Object]
, [O].[ObjectQ]
, [O].[Schema_id]
, [O].[Schema]
, [O].[SchemaQ]
, [O].[SchemaObject]
, [O].[SchemaObjectQ]
, [O].[ObjectType]
, [O].[user_type_id]
, [D].[DependencyLevel]
FROM [@Info].[Objects](DEFAULT) O 
JOIN (
	SELECT referencing_id,MAX(DependencyMaxLevel) AS DependencyLevel
	FROM [@Info].[DependencyList](@ObjectName,@SchemaList) D
	GROUP BY referencing_id
) D
ON D.referencing_id=O.[Object_id]
RETURN
END
GO

