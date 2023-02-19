

CREATE FUNCTION [@Info].[getObjectId]
(@objectName NVARCHAR (MAX))
RETURNS INT
AS
BEGIN
  DECLARE @ObjectID INT=OBJECT_ID(@objectName)
  DECLARE @UserTypeID INT=TYPE_ID(@objectName)
  IF @UserTypeID IS NOT NULL  -- special for table types
    BEGIN
      SELECT @ObjectID=type_table_object_id FROM sys.table_types WHERE user_type_id=@UserTypeID
    END
	RETURN @ObjectID
END
GO

