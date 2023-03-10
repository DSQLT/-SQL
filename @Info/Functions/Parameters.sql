

CREATE FUNCTION [@Info].[Parameters]
(@Pattern NVARCHAR (MAX)='')
RETURNS TABLE 
AS
RETURN 
    (
select 
S.name+'.'+O.name as SchemaProcedure
,QUOTENAME(S.name)+'.'+QUOTENAME(O.name) as SchemaProcedureQ
,S.name as [Schema]
,QUOTENAME(S.name) as [SchemaQ]
,O.name as [Procedure] 
,QUOTENAME(O.name) as [ProcedureQ] 
,P.*
from sys.objects O
join sys.schemas S on O.schema_id=S.schema_id
join sys.parameters P on o.object_id=p.object_id
WHERE 
--type in (N'P', N'PC')
--and 
(	S.name+'.'+O.name LIKE @Pattern
	or  QUOTENAME(S.name)+'.'+QUOTENAME(O.name) LIKE @Pattern
	or QUOTENAME(S.name)+'.'+QUOTENAME(O.name)= @Pattern
)
)
GO

