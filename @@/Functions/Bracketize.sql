-- =============================================
-- Author:		Henrik Bauer
-- Description:	Surround aText with Brackets
-- Returns:		Bracketized Text
-- =============================================
CREATE FUNCTION [@@].[Bracketize]
(@Text NVARCHAR (MAX), @Bracket NVARCHAR (1))
RETURNS NVARCHAR (MAX)
AS
BEGIN
	DECLARE @Prefix nchar(1) = [@@].[LeftBracket](@Bracket)
	DECLARE @Postfix nchar(1) = [@@].[RightBracket](@Bracket)
	DECLARE @Infix nchar(2)=@Postfix+@Postfix
	SET @Bracket=@Postfix
	SET @Text=@Prefix+REPLACE(@Text,@Bracket,@Infix)+@Postfix
	
	RETURN @Text
END
GO

