-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE   FUNCTION [@Info].[isObject]
(@objectName NVARCHAR (MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @Result bit =0
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@objectName))
		SET @Result=1
	RETURN @Result
END
GO

