-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object is TableType
-- Returns:		1 if TableType, 0 else
-- =============================================

CREATE FUNCTION [@Info].[isTableType]
(@objectName NVARCHAR (MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @Result bit =[@Info].[isObjectofType](@objectName,'TT')
	RETURN @Result
END
GO

