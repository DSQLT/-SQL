-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object has given Type
-- Returns:		1 if given Type, 0 else
-- =============================================

CREATE FUNCTION [@Info].[isObjectofType]
(@objectName NVARCHAR (MAX),@objectType VARCHAR(2))
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT =0
	DECLARE @ObjectID INT=[@Info].[getObjectId](@objectName)
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = @ObjectID AND type=@objectType)
		SET @Result=1
	RETURN @Result
END
GO

