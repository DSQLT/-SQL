
-- =============================================
-- Author:		Henrik Bauer
-- Description:	construct the correct typename with length/scale/precision Information for a given type_id
-- Returns:		typename, e.g. NUMERIC(9,2)
-- =============================================
CREATE   FUNCTION [@@].[TypeDefinition]
(@Type_id INT, @Len INT, @Precision INT, @Scale INT)
RETURNS sysname
AS
BEGIN
DECLARE @Pattern NVARCHAR(MAX)
DECLARE @TypeName NVARCHAR(MAX)=QUOTENAME(UPPER(TYPE_NAME(@Type_id)))
SELECT @Pattern=type_pattern FROM [@@].Types WHERE type_id=@Type_id

DECLARE @Result NVARCHAR(MAX)
SET @Result=REPLACE(
				REPLACE(
					REPLACE(
						REPLACE(
							REPLACE(@Pattern,'%t',@TypeName)
						,'%l',LTRIM(CASE WHEN @Len=-1 THEN 'max' ELSE STR(@Len) END))
					,'%h',LTRIM(CASE WHEN @Len=-1 THEN 'max' ELSE STR(@Len/2) END))
				,'%p',LTRIM(STR(@Precision)))
			,'%s',LTRIM(STR(@Scale))) 
IF @Result = 'time(7)' 
	SET @Result='time'

RETURN @Result
END
GO

