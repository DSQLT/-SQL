




CREATE   PROCEDURE [@Templates].[@getObjectDefinition@]
@object@ NVARCHAR (MAX)
AS
BEGIN
	DECLARE @Definition NVARCHAR(MAX)=''

	DECLARE @ObjectID INT=OBJECT_ID('@object@')
	DECLARE @UserTypeID INT=TYPE_ID('@object@')
  IF @UserTypeID IS NOT NULL  -- special for table types
    BEGIN
      SELECT NULL -- hier muss Table Definition ermittelt werden
    END
  ELSE
    BEGIN
  	  SELECT OBJECT_DEFINITION(OBJECT_ID(@ObjectID))
    END
END
GO

