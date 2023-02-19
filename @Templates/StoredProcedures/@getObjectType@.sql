



CREATE   PROCEDURE [@Templates].[@getObjectType@]
@object@ NVARCHAR (MAX)
AS
BEGIN
	DECLARE @Result varchar(2)=null
	DECLARE @ObjectID int=OBJECT_ID('@object@')
	DECLARE @UserTypeID int=TYPE_ID('@object@')
  IF @UserTypeID IS NOT NULL  -- special for table types
    BEGIN
      select @ObjectID=type_table_object_id from sys.table_types WHERE user_type_id=@UserTypeID
    END
	SELECT @Result=type FROM sys.objects WHERE object_id = @ObjectID
	SELECT @Result
END
GO

