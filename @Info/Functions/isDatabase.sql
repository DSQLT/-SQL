-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if database exists
-- Returns:		1 if Database, 0 else
-- =============================================

CREATE   FUNCTION [@Info].[isDatabase]
(@Database NVARCHAR (MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT =IIF(ISNULL(DB_ID(@Database),0) > 0,1,0)
	RETURN @Result
END
GO

