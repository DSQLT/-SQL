-- =============================================
-- Author:		Henrik Bauer
-- Description:	get Object Type
-- Returns:		Object Type
-- =============================================

CREATE FUNCTION [@Info].[getObjectType]
(@objectName NVARCHAR (MAX))
RETURNS NCHAR(2)
AS
BEGIN
	DECLARE @Result NCHAR(2)
	DECLARE @ObjectID INT=[@Info].[getObjectId](@objectName)

	SELECT @Result=[type] FROM sys.objects WHERE object_id = @ObjectID
	IF @Result IS NULL  -- vielleicht ein Typ
	BEGIN
		SELECT @Result='Y' FROM sys.types WHERE TYPE_ID(@objectName) IN (system_type_id,user_type_id)
	END
	RETURN @Result
END
GO

