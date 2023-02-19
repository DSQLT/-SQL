
CREATE PROCEDURE [@Script].[_getObjectTemplate]
@Object NVARCHAR (MAX)
,@Template NVARCHAR (MAX) OUTPUT
,@CreateOrAlter BIT =1
AS
BEGIN
DECLARE @Text varchar(max)= OBJECT_DEFINITION(OBJECT_ID(@Object))
DECLARE @i int=0
DECLARE @p int=0
DECLARE @l int=LEN(@Text)
DECLARE @z varchar(max)
DECLARE @CRLF char(2)=[@@].[CRLF]()
DECLARE @Begin int=0
DECLARE @End int=0
DECLARE @Template_BeforeEnd NVARCHAR (MAX)=''

SET @Template=''

WHILE @i <= @l
BEGIN
  SET @p=CHARINDEX(@CRLF,@Text,@i)
  SET @z=SUBSTRING(@Text,@i,@p-@i)
  SET @i=@p+2

 	-- Kommentare strippen
	BEGIN
		SET @z = LEFT(@z,CASE WHEN CHARINDEX('--',@z)=0 THEN LEN(@z) ELSE CHARINDEX('--',@z)-1 END)
	END

END
END
GO

