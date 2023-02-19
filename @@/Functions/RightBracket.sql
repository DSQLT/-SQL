-- =============================================
-- Author:		Henrik Bauer
-- Description:	get Right Bracket for a given Bracket
-- Returns:		Right Bracket
-- =============================================
CREATE FUNCTION [@@].[RightBracket]
(@Bracket nchar(1))
RETURNS nchar(1)
AS
BEGIN
	IF @Bracket='['
		SET @Bracket=']'
	IF @Bracket='('
		SET @Bracket=')'
	IF @Bracket='<'
		SET @Bracket='>'
	IF @Bracket='{'
		SET @Bracket='}'
	RETURN @Bracket
END
GO

