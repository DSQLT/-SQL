


CREATE   FUNCTION [@Info].[DependencyList]
(@ObjectName NVARCHAR(MAX)=NULL,@SchemaList NVARCHAR (MAX)=NULL)
RETURNS @Result TABLE (
[referencing_id] INT NOT NULL,
[referenced_id] INT NOT NULL,
[DependencyMinLevel] INT NOT NULL,
[DependencyMaxLevel] INT NOT NULL
)
AS
BEGIN
IF @SchemaList IS NULL SET @SchemaList='@@,@SQL,@BodyTemplate,@Templates,@Info,@Script,@Config'
DECLARE @ObjectID INT = [@Info].[getObjectId](@ObjectName)

declare @Objects Table([object_id] int NOT NULL, [expression_referencing_id] int NOT NULL)

;WITH Schemas AS
(
SELECT s.[schema_id]
FROM STRING_SPLIT(@SchemaList, ',') L
JOIN sys.[schemas] S ON s.[name] =L.value
)
,Objects AS
(
SELECT [object_id], IIF([user_type_id]=0,[object_id],[user_type_id]) AS [expression_referencing_id]
FROM [@Info].[Objects](DEFAULT) O
WHERE [Schema_id] IN (SELECT [schema_id] FROM [Schemas]) OR @SchemaList=''
)
insert into @Objects([object_id],[expression_referencing_id])
select [object_id],[expression_referencing_id] from Objects 

;WITH Dependencies AS
(
SELECT [O].[object_id] AS [referencing_id], R.Object_id AS [referenced_id]
FROM sys.sql_expression_dependencies D
JOIN @Objects O ON [O].[expression_referencing_id] = D.[referencing_id]
JOIN @Objects R ON [R].[expression_referencing_id] = D.[referenced_id]
)
, Recursion AS
(
SELECT [object_id] AS [referencing_id],[object_id] AS [referenced_id],0 AS level
FROM @Objects 

UNION ALL

SELECT D.[referencing_id],N.[referenced_id], N.level+1 AS level
FROM Recursion N
JOIN Dependencies D ON N.[referencing_id]=D.[referenced_id] AND n.[referencing_id] <> d.referencing_id
)
,List AS (
SELECT [referencing_id],[referenced_id],MIN([level]) AS [DependencyMinLevel],MAX([level]) AS [DependencyMaxLevel]
FROM Recursion
GROUP BY [referencing_id],[referenced_id]
)
INSERT @Result
SELECT 
L.referencing_id,
L.referenced_id,
L.DependencyMinLevel,
L.DependencyMaxLevel
FROM List L
WHERE @ObjectID IS NULL OR @ObjectID IN (L.referencing_id,L.referenced_id)
RETURN
END
GO

