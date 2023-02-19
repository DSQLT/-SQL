


-- =============================================
-- Author:		Henrik Bauer
-- Description:	List of remaining Parameters (Parameters not classified for Template Replacement)
-- Returns:		Commaseparated List of Parameters (which are not surrounded with @-Char). Empty Char, if none.
-- =============================================
CREATE   FUNCTION [@@].[_getRemainingParameters]
(@Procedure NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
BEGIN
DECLARE @Result nvarchar(max)=''

select @Result=STRING_AGG(parameter_name+' ' + parameter_type,',')
from [@@].[_getProcedureParameters](@Procedure) 
where parameter_name not like '@%@'

SET @Result=ISNULL(@Result,'')

RETURN @Result
END
GO

