-- =============================================
-- Author:		Henrik Bauer
-- Description:	Surround Objectname with Square Brackets 
-- 				if there are more than one Part, bracketize each Part
--				It is safer than intrinsic QUOTENAME
-- Returns:		Objectname with Brackets
-- =============================================
CREATE FUNCTION [@@].[QuoteNameSB]
(@Text NVARCHAR (MAX))
RETURNS NVARCHAR (MAX)
AS
BEGIN
	RETURN [@@].[QuoteName] (@Text,'[')
END
GO

