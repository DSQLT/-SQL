-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE PROCEDURE [@Info].[_checkLinkedServer]
(@LinkedServer sysname
,@RaiseError BIT = 1
)
AS
BEGIN
	DECLARE @Result BIT =[@Info].[isLinkedServer](@LinkedServer)
  DECLARE @ErrorMessageID INT = [@Config].[ErrorMessageID](1)
  IF @RaiseError=1 AND @Result=0 RAISERROR (@ErrorMessageID,11,1,@LinkedServer)
	RETURN @Result
END
GO

