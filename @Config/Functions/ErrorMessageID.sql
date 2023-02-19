-- =============================================
-- Author:		Henrik Bauer
-- Returns:		ErrorMessageID
-- =============================================
CREATE FUNCTION [@Config].[ErrorMessageID]
(@Offset INT )
RETURNS INT
AS
BEGIN
	RETURN 424242000+@Offset
END
GO

