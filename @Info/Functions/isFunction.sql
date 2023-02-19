-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object is Function
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE   FUNCTION [@Info].[isFunction]
(@objectName NVARCHAR (MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT =[@Info].[isObjectofSuperType](@objectName,'F')
	RETURN @Result
END
GO

