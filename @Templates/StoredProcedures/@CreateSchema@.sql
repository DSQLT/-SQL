

CREATE PROCEDURE [@Templates].[@CreateSchema@]
@Schema@ sysname
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM sys.[schemas] WHERE [schema_id] = SCHEMA_ID('@Schema@'))
		EXECUTE ('CREATE SCHEMA [@Schema@]')
END
GO

