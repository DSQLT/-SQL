


CREATE PROCEDURE [@Templates].[@isDatabase@]
@database@ sysname
AS
BEGIN
	DECLARE @Result BIT=0
	IF EXISTS (SELECT 1 FROM sys.[databases] WHERE [name]='@database@')
		SET @Result=1
	SELECT @Result
END
GO

