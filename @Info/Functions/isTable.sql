-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object is Table
-- Returns:		1 if Table, 0 else
-- =============================================

CREATE FUNCTION [@Info].[isTable]
(@objectName NVARCHAR (MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @Result bit =[@Info].[isObjectofSuperType](@objectName,'T')
	RETURN @Result
END
GO

