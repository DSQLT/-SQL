-- =============================================
-- Author:		Henrik Bauer
-- Description:	Surround Text with Square Brackets 
-- 				Only, if Text is not yet surrounded
-- Returns:		Text with Brackets
-- =============================================
CREATE FUNCTION [@@].[QuoteSB]
(@Text NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
BEGIN
	RETURN [@@].[SafeBracketize](@Text,'[')
END
GO

