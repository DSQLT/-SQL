-- =============================================
-- Author:		Henrik Bauer
-- Description:	get Left Bracket for a given Bracket
-- Returns:		Left Bracket
-- =============================================
CREATE FUNCTION [@@].[LeftBracket]
(@Bracket NCHAR(1))
RETURNS NCHAR(1)
AS
BEGIN
	IF @Bracket=']'
		SET @Bracket='['
	IF @Bracket=')'
		SET @Bracket='('
	IF @Bracket='>'
		SET @Bracket='<'
	IF @Bracket='}'
		SET @Bracket='{'
	RETURN @Bracket
END
GO

