-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if linked server exists
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE FUNCTION [@Info].[isLinkedServer]
(@LinkedServer NVARCHAR (MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT =0
  	IF EXISTS (SELECT * FROM sys.servers WHERE [@@].[QuoteSB]([name])=[@@].[QuoteSB](@LinkedServer))
		SET @Result=1
	RETURN @Result
END
GO

