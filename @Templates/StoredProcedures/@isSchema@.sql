


CREATE PROCEDURE [@Templates].[@isSchema@]
@schema@ sysname
AS
BEGIN
	DECLARE @Result BIT=0
	DECLARE @SchemaID INT=SCHEMA_ID(Parsename('@schema@',1))  -- Parsename removes square brackets
	IF EXISTS (SELECT 1 FROM sys.[schemas] WHERE [schema_id] = @SchemaID)
		SET @Result=1
	SELECT @Result
END
GO

