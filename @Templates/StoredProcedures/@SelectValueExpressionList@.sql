


CREATE PROCEDURE [@Templates].[@SelectValueExpressionList@]
@Table@ sysname
,@valueExpressionList@ VARCHAR(MAX)
AS
BEGIN
DECLARE @Delimiter SYSNAME=[@@].[CRLF]()+',';
SELECT STRING_AGG(@valueExpressionList@,@Delimiter) 
FROM "@Table@"
END
GO

