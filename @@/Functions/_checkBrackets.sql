-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if Text has correct Brackets
-- Returns:		1 if ok, 0 if no Brackets around, -1 if incorrect Brackets inside Text
-- =============================================
CREATE FUNCTION [@@].[_checkBrackets]
(@Text NVARCHAR (MAX), @Bracket NCHAR(1))
RETURNS INT
AS
BEGIN
	DECLARE @Prefix NCHAR(1) = [@@].[LeftBracket](@Bracket)
	DECLARE @Postfix NCHAR(1) = [@@].[RightBracket](@Bracket)
	DECLARE @Infix NCHAR(2)=@Postfix+@Postfix
	DECLARE @Result INT=1
	SET @Bracket=@Postfix
	
	-- mindestens 2 Zeichen, sonst nicht geklammert
	IF LEN(@Text) < 2
		RETURN 0  -- nicht weitermachen
	-- Prüfen, ob links und rechts geklammert
	IF LEFT(@Text,1) <> @Prefix OR RIGHT(@Text,1) <> @Postfix
		RETURN 0  -- nicht weitermachen

	-- restlicher Text	
	SET @Text=SUBSTRING(@Text,2,LEN(@Text)-2)
	-- prüfen, ob im Text vorkommende rechte Klammer auch immer doppelt ist
	-- sonst fehlerhafte Klammerung
	DECLARE @Pos INT=-1
	WHILE @Result=1
	BEGIN
		SET @Pos=CHARINDEX(@Bracket,@Text,@Pos+2)  -- Infix Länge 2
		-- keine Klammern mehr
		IF @Pos = 0 
			BREAK
		-- Klammer ist einzeln am Ende!
		IF @Pos = LEN(@Text) 
		  SET @Result=-1
		-- nicht passend ??
		IF SUBSTRING(@Text,@Pos,2) <> @Infix  -- Infix Länge 2
		  SET @Result=-1
	END
	RETURN @Result
END
GO

