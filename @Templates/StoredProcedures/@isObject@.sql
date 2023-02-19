

CREATE PROCEDURE [@Templates].[@isObject@]
@object@ NVARCHAR (MAX)
AS
BEGIN
	DECLARE @Result bit=0
	DECLARE @ObjectID int=OBJECT_ID('@object@')
	DECLARE @UserTypeID int=TYPE_ID('@object@')
  IF @UserTypeID is not null  -- special for table types
    BEGIN
      select @ObjectID=type_table_object_id from sys.table_types WHERE user_type_id=@UserTypeID
    END
	IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = @ObjectID)
		SET @Result=1
	SELECT @Result
END
GO

