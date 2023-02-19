
CREATE FUNCTION [@@].[_getProcedureParameters]
(@Procedure NVARCHAR (MAX))
RETURNS TABLE 
AS
RETURN 
(
SELECT parameter_id,P.name as parameter_name,[@@].[TypeDefinition](user_type_id,max_length,[precision],scale) as parameter_type
FROM sys.parameters P
WHERE P.object_id=OBJECT_ID(@Procedure)
)
GO

