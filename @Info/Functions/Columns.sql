

CREATE FUNCTION [@Info].[Columns]
(@Object NVARCHAR (MAX)='')
RETURNS @Result TABLE (
	[Column] [sysname] NOT NULL,
	[ColumnQ] [NVARCHAR](MAX) NOT NULL,
	[ObjectColumn] [NVARCHAR](MAX) NOT NULL,
	[ObjectColumnQ] [NVARCHAR](MAX) NOT NULL,
	[SchemaObjectColumn] [NVARCHAR](MAX) NOT NULL,
	[SchemaObjectColumnQ] [NVARCHAR](MAX) NOT NULL,
	[SchemaObject] [NVARCHAR](MAX) NOT NULL,
	[SchemaObjectQ] [NVARCHAR](MAX) NOT NULL,
	[Type] [sysname] NOT NULL,
	[Type_Id] [TINYINT] NOT NULL,
	[is_primary_key] [INT] NOT NULL,
	[is_nullable] [BIT] NOT NULL,
	[Length] [SMALLINT] NOT NULL,
	[Precision] [TINYINT] NOT NULL,
	[Scale] [TINYINT] NOT NULL,
	[Order] [INT] NOT NULL,
	[collation_name] [sysname] NULL,
  TypeDefinition [sysname] NOT NULL,
  CollationClause [sysname] NULL,
  NullableClause [sysname] NOT NULL,
  IdentityClause [sysname] NULL,
  ColumnScript [NVARCHAR](MAX) NULL
)
AS
BEGIN
declare @Collation varchar(max) =cast(DATABASEPROPERTYEX(DB_NAME(),'collation') as varchar(max))
INSERT @Result
	SELECT 
	C.name AS [Column]
	,QUOTENAME(C.name) AS ColumnQ
	,O.[Object]+'.'+C.name AS ObjectColumn
	,o.[ObjectQ]+'.'+QUOTENAME(C.name) AS ObjectColumnQ
	,o.[SchemaObject]+'.'+C.name AS SchemaObjectColumn
	,o.[SchemaObjectQ]+'.'+QUOTENAME(C.name) AS SchemaObjectColumnQ
	,o.[SchemaObject] AS SchemaObject
	,o.[SchemaObjectQ] AS SchemaObjectQ
  ,TYPE_NAME(c.system_type_id) AS [Type] 
  ,c.system_type_id AS [Type_Id] 
	,CASE WHEN Y.index_id IS NULL THEN 0 ELSE 1 END AS is_primary_key
	,C.is_nullable
	,C.max_length AS Length
	,C.precision AS Precision
	,C.scale AS Scale
	,C.column_id AS [Order] 
  ,c.collation_name
  ,[@@].[TypeDefinition](c.user_type_id,c.max_length,c.precision,c.scale) AS TypeDefinition
  ,IIF(ISNULL(c.collation_name,@Collation) <> @Collation,'COLLATE '+c.collation_name,'') AS CollationClause
  ,IIF(c.is_nullable=1,'NULL','NOT NULL') AS NullableClause
  ,IIF(c.is_identity=1,'IDENTITY('+FORMAT(CAST(x.[seed_value] AS INT),'#')+','+FORMAT(CAST(x.[increment_value] AS INT),'#')+')','') AS IdentityClause
  ,QUOTENAME(C.name) + ' ' +
   [@@].[TypeDefinition](c.user_type_id,c.max_length,c.precision,c.scale) + ' ' +
   IIF(ISNULL(c.collation_name,@Collation) <> @Collation,'COLLATE '+c.collation_name,'')  + ' ' +
   IIF(c.is_nullable=1,'NULL','NOT NULL') + ' ' +
   IIF(c.is_identity=1,'IDENTITY('+FORMAT(CAST(x.[seed_value] AS INT),'#')+','+FORMAT(CAST(x.[increment_value] AS INT),'#')+')','')
   AS ColumnScript
	FROM [@Info].[Object](@Object) O
	JOIN sys.columns C ON C.object_id=O.object_id 
	LEFT OUTER JOIN sys.indexes I ON I.object_id=O.object_id AND I.is_primary_key=1
	LEFT OUTER JOIN sys.index_columns Y ON Y.object_id = I.object_id AND Y.index_id = I.index_id AND Y.column_id = C.column_id
	LEFT OUTER JOIN sys.identity_columns X ON X.object_id = O.object_id AND X.column_id = C.column_id

  -- don#t use IDENT_SEED and IDENT_INCR because they don't work with Table Types
  -- used sys.identity_columns instead
  -- by courtesy of https://www.sqlservercentral.com/forums/topic/how-to-find-seed-and-increment-for-an-identity-column-of-a-user-type-table

RETURN
END
GO

