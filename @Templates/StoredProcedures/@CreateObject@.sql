


CREATE PROCEDURE [@Templates].[@CreateObject@]
@Object@ sysname,
@Schema@ sysname,
@Database@ sysname,
@LinkedServer@ sysname
AS
BEGIN
EXECUTE [@Script].[@CreateObject] '@Object@','@Schema@','@Database@','@LinkedServer@'
END
GO

