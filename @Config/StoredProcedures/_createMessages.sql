

-- =============================================
-- Author:		Henrik Bauer
-- Description:	Check, if object exists
-- Returns:		1 if Function, 0 else
-- =============================================

CREATE PROCEDURE [@Config].[_createMessages]
AS
BEGIN
  DECLARE @ErrorMessageID INT = 424242000
  SET @ErrorMessageID=@ErrorMessageID+1
  IF NOT EXISTS(SELECT 1 FROM sys.[messages] WHERE [message_id]=@ErrorMessageID)
  BEGIN
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='ERROR: Linked Server %s doesn´t exist',@lang = 'us_english'; 
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='FEHLER: Verbindungsserver %1! existiert nicht',@lang = 'Deutsch'; 
  END
  SET @ErrorMessageID=@ErrorMessageID+1
  IF NOT EXISTS(SELECT 1 FROM sys.[messages] WHERE [message_id]=@ErrorMessageID)
  BEGIN
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='ERROR: Database %s doesn´t exist',@lang = 'us_english'; 
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='FEHLER: Datenbank %1! existiert nicht',@lang = 'Deutsch'; 
  END
  SET @ErrorMessageID=@ErrorMessageID+1
  IF NOT EXISTS(SELECT 1 FROM sys.[messages] WHERE [message_id]=@ErrorMessageID)
  BEGIN
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='ERROR: Database %s doesn´t exist at Linked Server %s',@lang = 'us_english'; 
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='FEHLER: Datenbank %1! existiert nicht am Verbindungsserver %2!',@lang = 'Deutsch'; 
  END
  SET @ErrorMessageID=@ErrorMessageID+1
  IF NOT EXISTS(SELECT 1 FROM sys.[messages] WHERE [message_id]=@ErrorMessageID)
  BEGIN
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='ERROR: Schema %s doesn´t exist',@lang = 'us_english'; 
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='FEHLER: Schema %1! existiert nicht',@lang = 'Deutsch'; 
  END
  SET @ErrorMessageID=@ErrorMessageID+1
  IF NOT EXISTS(SELECT 1 FROM sys.[messages] WHERE [message_id]=@ErrorMessageID)
  BEGIN
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='ERROR: Schema %s doesn´t exist in Database %s',@lang = 'us_english'; 
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='FEHLER: Schema %1! existiert nicht in Datenbank %2!',@lang = 'Deutsch'; 
  END
  SET @ErrorMessageID=@ErrorMessageID+1
  IF NOT EXISTS(SELECT 1 FROM sys.[messages] WHERE [message_id]=@ErrorMessageID)
  BEGIN
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='ERROR: Schema %s doesn´t exist in Database %s at Linked Server %s.',@lang = 'us_english'; 
    EXECUTE sp_addmessage @msgnum=@ErrorMessageID,@severity=11,@msgtext='FEHLER: Schema %1! existiert nicht in Datenbank %2! am Verbindungsserver %3!',@lang = 'Deutsch'; 
  END
END
GO

