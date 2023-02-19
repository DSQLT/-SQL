-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object has given SuperType
-- Returns:		1 if given SuperType, 0 else
-- =============================================

CREATE FUNCTION [@Info].[isObjectofSuperType]
(@objectName NVARCHAR (MAX),@SuperType NCHAR(1))
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT =0
	DECLARE @ObjectID INT=[@Info].[getObjectId](@objectName)
	IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = @ObjectID AND type IN (SELECT [Object_Type] FROM [@@].[ObjectTypes] WHERE [Super_Type]=@SuperType))
		SET @Result=1
	RETURN @Result
END
GO

