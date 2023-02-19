-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object is Procedure
-- Returns:		1 if Procedure, 0 else
-- =============================================

CREATE FUNCTION [@Info].[isProcedure]
(@objectName NVARCHAR (MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @Result bit =[@Info].[isObjectofSuperType](@objectName,'P')
	RETURN @Result
END
GO

