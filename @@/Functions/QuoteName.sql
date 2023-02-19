-- =============================================
-- Author:		Henrik Bauer
-- Description:	Surround Objectname with Square Brackets 
-- 				if there are more than one Part, bracketize each Part
--				It is safer than intrinsic QUOTENAME
-- Returns:		Objectname with Brackets
-- =============================================
CREATE FUNCTION [@@].[QuoteName]
(@Text NVARCHAR (MAX), @Bracket NVARCHAR (MAX)='[')
RETURNS NVARCHAR (MAX)
AS
BEGIN
	DECLARE @Server sysname=PARSENAME(@Text,4)
	DECLARE @Database sysname=PARSENAME(@Text,3)
	DECLARE @Schema sysname=PARSENAME(@Text,2)
	DECLARE @Object sysname=PARSENAME(@Text,1)
	
	IF @Server is not null
		SET @Server=[@@].[SafeBracketize](@Server,@Bracket)+'.'
	ELSE
		SET @Server=''
	
	IF @Database is not null
		SET @Database=[@@].[SafeBracketize](@Database,@Bracket)+'.'
	ELSE
		IF LEN(@Server) = 0
			SET @Database=''
		ELSE
			SET @Database='.'
			
	IF @Schema is not null
		SET @Schema=[@@].[SafeBracketize](@Schema,@Bracket)+'.'
	ELSE
		IF LEN(@Database) = 0
			SET @Schema=''
		ELSE
			SET @Schema='.'
			
	IF @Object is not null
		SET @Object=[@@].[SafeBracketize](@Object,@Bracket)
	ELSE	-- verrückter Name , hat mehr wie 4 Bestandteile. Klammern wir ihn einfach, falls nötig
		SET @Text=[@@].[SafeBracketize](@Text,@Bracket)
	
	-- Wenn es ein gültiger Name war, bauen wir ihn aus den Bestandteilen wieder zusammen		
	IF @Object is not null
		SET @Text=@Server+@Database+@Schema+@Object
	
	RETURN @Text
END
GO

