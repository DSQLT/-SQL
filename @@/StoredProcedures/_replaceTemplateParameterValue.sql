


CREATE PROCEDURE [@@].[_replaceTemplateParameterValue]
@Template NVARCHAR (MAX) OUTPUT,
@Parameter NVARCHAR (MAX), 
@Value NVARCHAR (MAX)
AS
BEGIN
-- 16.11.22  -- NULL Wert ermöglicht
DECLARE @From int
DECLARE @To int
DECLARE @Pattern nvarchar(max)
DECLARE @Replace nvarchar(max)=null

declare @pos int=0
WHILE @pos >= 0 -- wird innerhalb der Schleife abgebrochen
BEGIN
	set @pos=Charindex(@Parameter,@Template,@pos) 
	if @pos<=0 
		break
	SET @Replace=null
	SET @From=@Pos-2
	-- 2 zurück
	-- Für Parameterersetzung 
	-- mit "'@Param@'"
	-- und ""@Param@""
	-- und "[@Param@]"
	-- und /*@Param@*/
	IF @From > 0
	BEGIN
	--  ""@Param@""
		SET @Pattern='""'+@Parameter+'""'
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=@Parameter  -- Parameter bleibt erhalten
			GOTO ReplaceParam
		END
	--  "'@Param@'"
		SET @Pattern='"'''+@Parameter+'''"'
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=[@@].QuoteSQ(@Parameter)  -- Parameter bleibt erhalten Single Quoted
			GOTO ReplaceParam
		END
	--  "[@Param@]"
		SET @Pattern='"['+@Parameter+']"'
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=[@@].QuoteSB(@Parameter)  -- Parameter bleibt erhalten mit Klammern
			GOTO ReplaceParam
		END
	--  /*@Param@*/
		SET @Pattern='/*'+@Parameter+'*/'
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=@Value	-- Parameter wird durch Value ersetzt
			GOTO ReplaceParam
		END
	END
	SET @From=@Pos-1
	-- 1 zurück
	-- Für Parameterersetzung 
	-- mit "@Param@"
	-- und [@Param@].[@Param@]
	-- und [@Param@]
	-- und (@Param@=@Param@)
	-- und '@Param@'
	IF @From > 0
	BEGIN
	--  "@Param@"
		SET @Pattern='"'+@Parameter+'"'
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=ISNULL(@Value,'NULL')	-- Parameter wird durch Value ersetzt ODER NULL
			GOTO ReplaceParam
		END
	--  [@Param@].[@Param@]
		SET @Pattern='['+@Parameter+'].['+@Parameter+']'
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=[@@].QuoteNameSB(@Value) -- mit Zerlegung in Namensbestandteile, dann klammern mit []
			GOTO ReplaceParam
		END
	--  [@Param@]
		SET @Pattern='['+@Parameter+']'
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=[@@].QuoteSB(@Value) --  klammern mit []
			GOTO ReplaceParam
		END
	--  (@Param@=@Param@)
		SET @Pattern='('+@Parameter+'='+@Parameter+')'
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=ISNULL(@Value,'NULL')	-- Parameter wird durch Value ersetzt ODER NULL
			GOTO ReplaceParam
		END
	--  '@Param@'
		SET @Pattern=''''+@Parameter+''''
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=ISNULL([@@].QuoteSQ(@Value),'NULL') --  klammern mit ', ODER NULL
			GOTO ReplaceParam
		END
	END
	SET @From=@Pos
	-- 0 zurück
	-- Für Parameterersetzung 
	-- mit @Param@=@Param@
	-- und @Param@
	IF @From > 0
	BEGIN
	--  @Param@=@Param@
		SET @Pattern=@Parameter+'='+@Parameter
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=ISNULL(@Value,'NULL')	-- Parameter wird durch Value ersetzt ODER NULL
			GOTO ReplaceParam
		END
	--  @Param@
		SET @Pattern=@Parameter
		IF SUBSTRING(@Template,@From,LEN(@Pattern)) = @Pattern
		BEGIN
			SET @Replace=ISNULL(@Value,'NULL')	-- Parameter wird durch Value ersetzt ODER NULL
			GOTO ReplaceParam
		END
	END

	ReplaceParam:
	IF @Replace IS NOT NULL
		BEGIN
			SET @To=@From+LEN(@Pattern)-1
			SET @Template=STUFF(@Template,@From,@To-@From+1,@Replace)
			SET @Pos=@From+LEN(@Replace)
		END
	ELSE
		SET @Pos=@Pos+1
END
END

RETURN 0
GO

