-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE   FUNCTION [@Info].[isSchema]
(@SchemaName NVARCHAR (MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT =IIF(ISNULL(SCHEMA_ID(@SchemaName),0) > 0,1,0)
	RETURN @Result
END
GO

