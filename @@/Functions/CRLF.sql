-- =============================================
-- Author:		Henrik Bauer
-- Returns:		CR LF
-- =============================================
CREATE FUNCTION [@@].[CRLF]
( )
RETURNS CHAR (2)
AS
BEGIN
	RETURN CHAR(13)+CHAR(10)
END
GO

