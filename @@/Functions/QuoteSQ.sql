

-- =============================================
-- Author:		Henrik Bauer
-- Description:	Surround Text with Single Quotes 
-- Returns:		Text with Single Quotes
-- =============================================
CREATE FUNCTION [@@].[QuoteSQ]
(@Text NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
BEGIN
	RETURN [@@].[Bracketize](@Text,[@@].SQ())
END
GO

