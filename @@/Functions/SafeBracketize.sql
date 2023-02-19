-- =============================================
-- Author:		Henrik Bauer
-- Description:	Surround Text with Brackets (not with Empty or null)
-- 				Only, if Text is not yet surrounded
-- Returns:		Text with Brackets
-- =============================================
CREATE FUNCTION [@@].[SafeBracketize]
(@Text NVARCHAR (MAX), @Bracket NCHAR (1))
RETURNS NVARCHAR (MAX)
AS
BEGIN
	-- Wollen wir null oder einen Leerstring wirklich klammern??
	IF len(isnull(@Text,''))=0
		RETURN ''  -- Nein, wir geben lieber Leeren String zurück.
		
	-- Nur, wenn nicht bereits korrekt geklammert
	IF [@@].[_checkBrackets](@Text,@Bracket) <> 1
		SET @Text=[@@].[Bracketize](@Text,@Bracket)
	
	RETURN @Text
END
GO

