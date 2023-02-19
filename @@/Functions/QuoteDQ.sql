-- =============================================
-- Author:		Henrik Bauer
-- Description:	Surround Text with Double Quotes 
-- Returns:		Text with Double Quotes
-- =============================================
CREATE FUNCTION [@@].[QuoteDQ]
(@Text NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
BEGIN
	RETURN [@@].[Bracketize](@Text,'"')
END
GO

