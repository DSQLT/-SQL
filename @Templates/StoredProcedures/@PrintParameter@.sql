



CREATE   PROCEDURE [@Templates].[@PrintParameter@]
@01@ NVARCHAR (MAX)=null, @02@ NVARCHAR (MAX)=null, @03@ NVARCHAR (MAX)=null
AS
BEGIN
	PRINT '@01@'
	PRINT '@02@'
	PRINT '@03@'
  select @@SERVERNAME,DB_NAME()
END
GO

