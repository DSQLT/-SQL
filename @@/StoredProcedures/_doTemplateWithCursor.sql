

CREATE   PROC [@@].[_doTemplateWithCursor]
  @Template                  NVARCHAR(MAX) OUTPUT
, @Cursor                    CURSOR        VARYING OUTPUT
, @p01                       NVARCHAR(MAX) = NULL
, @p02                       NVARCHAR(MAX) = NULL
, @p03                       NVARCHAR(MAX) = NULL
, @p04                       NVARCHAR(MAX) = NULL
, @p05                       NVARCHAR(MAX) = NULL
, @p06                       NVARCHAR(MAX) = NULL
, @p07                       NVARCHAR(MAX) = NULL
, @p08                       NVARCHAR(MAX) = NULL
, @p09                       NVARCHAR(MAX) = NULL
, @p10                       NVARCHAR(MAX) = NULL
, @p11                       NVARCHAR(MAX) = NULL
, @p12                       NVARCHAR(MAX) = NULL
, @p13                       NVARCHAR(MAX) = NULL
, @p14                       NVARCHAR(MAX) = NULL
, @p15                       NVARCHAR(MAX) = NULL
, @p16                       NVARCHAR(MAX) = NULL
, @p17                       NVARCHAR(MAX) = NULL
, @p18                       NVARCHAR(MAX) = NULL
, @p19                       NVARCHAR(MAX) = NULL
, @p20                       NVARCHAR(MAX) = NULL
, @p21                       NVARCHAR(MAX) = NULL
, @p22                       NVARCHAR(MAX) = NULL
, @p23                       NVARCHAR(MAX) = NULL
, @p24                       NVARCHAR(MAX) = NULL
, @p25                       NVARCHAR(MAX) = NULL
, @p26                       NVARCHAR(MAX) = NULL
, @p27                       NVARCHAR(MAX) = NULL
, @p28                       NVARCHAR(MAX) = NULL
, @p29                       NVARCHAR(MAX) = NULL
, @p30                       NVARCHAR(MAX) = NULL
, @p31                       NVARCHAR(MAX) = NULL
, @p32                       NVARCHAR(MAX) = NULL
, @p33                       NVARCHAR(MAX) = NULL
, @p34                       NVARCHAR(MAX) = NULL
, @p35                       NVARCHAR(MAX) = NULL
, @p36                       NVARCHAR(MAX) = NULL
, @p37                       NVARCHAR(MAX) = NULL
, @p38                       NVARCHAR(MAX) = NULL
, @p39                       NVARCHAR(MAX) = NULL
, @p40                       NVARCHAR(MAX) = NULL
, @p41                       NVARCHAR(MAX) = NULL
, @p42                       NVARCHAR(MAX) = NULL
, @p43                       NVARCHAR(MAX) = NULL
, @p44                       NVARCHAR(MAX) = NULL
, @p45                       NVARCHAR(MAX) = NULL
, @p46                       NVARCHAR(MAX) = NULL
, @p47                       NVARCHAR(MAX) = NULL
, @p48                       NVARCHAR(MAX) = NULL
, @p49                       NVARCHAR(MAX) = NULL
, @p50                       NVARCHAR(MAX) = NULL
, @p51                       NVARCHAR(MAX) = NULL
, @p52                       NVARCHAR(MAX) = NULL
, @p53                       NVARCHAR(MAX) = NULL
, @p54                       NVARCHAR(MAX) = NULL
, @p55                       NVARCHAR(MAX) = NULL
, @p56                       NVARCHAR(MAX) = NULL
, @p57                       NVARCHAR(MAX) = NULL
, @p58                       NVARCHAR(MAX) = NULL
, @p59                       NVARCHAR(MAX) = NULL
, @p60                       NVARCHAR(MAX) = NULL
, @p61                       NVARCHAR(MAX) = NULL
, @p62                       NVARCHAR(MAX) = NULL
, @p63                       NVARCHAR(MAX) = NULL
, @p64                       NVARCHAR(MAX) = NULL
, @p65                       NVARCHAR(MAX) = NULL
, @p66                       NVARCHAR(MAX) = NULL
, @p67                       NVARCHAR(MAX) = NULL
, @p68                       NVARCHAR(MAX) = NULL
, @p69                       NVARCHAR(MAX) = NULL
, @p70                       NVARCHAR(MAX) = NULL
, @p71                       NVARCHAR(MAX) = NULL
, @p72                       NVARCHAR(MAX) = NULL
, @p73                       NVARCHAR(MAX) = NULL
, @p74                       NVARCHAR(MAX) = NULL
, @p75                       NVARCHAR(MAX) = NULL
, @p76                       NVARCHAR(MAX) = NULL
, @p77                       NVARCHAR(MAX) = NULL
, @p78                       NVARCHAR(MAX) = NULL
, @p79                       NVARCHAR(MAX) = NULL
, @p80                       NVARCHAR(MAX) = NULL
, @p81                       NVARCHAR(MAX) = NULL
, @p82                       NVARCHAR(MAX) = NULL
, @p83                       NVARCHAR(MAX) = NULL
, @p84                       NVARCHAR(MAX) = NULL
, @p85                       NVARCHAR(MAX) = NULL
, @p86                       NVARCHAR(MAX) = NULL
, @p87                       NVARCHAR(MAX) = NULL
, @p88                       NVARCHAR(MAX) = NULL
, @p89                       NVARCHAR(MAX) = NULL
, @p90                       NVARCHAR(MAX) = NULL
, @p91                       NVARCHAR(MAX) = NULL
, @p92                       NVARCHAR(MAX) = NULL
, @p93                       NVARCHAR(MAX) = NULL
, @p94                       NVARCHAR(MAX) = NULL
, @p95                       NVARCHAR(MAX) = NULL
, @p96                       NVARCHAR(MAX) = NULL
, @p97                       NVARCHAR(MAX) = NULL
, @p98                       NVARCHAR(MAX) = NULL
, @p99                       NVARCHAR(MAX) = NULL
, @ObjectName                NVARCHAR(MAX) = NULL -- Name der Prozedur, falls Template als Stored procedure gespeichert war
, @Database                  NVARCHAR(MAX) = NULL OUTPUT
, @LinkedServer              sysname       = NULL OUTPUT
, @ProcedureName             NVARCHAR(MAX) = NULL OUTPUT
, @ParameterNameList         NVARCHAR(MAX) = NULL
, @BodyProcedureTemplateName NVARCHAR(MAX) = NULL
, @CreateManyProcedures      BIT           = 0
, @Print                     BIT           = 0
AS
BEGIN
  DECLARE @myReference CURSOR
  SET @myReference = @Cursor

  DECLARE @Count INT
  EXECUTE @Count = [@@].[_getCursorColumnCount] @myReference, '@myReference'

  DECLARE @ParameterTable [@@].[ParameterTable]
  INSERT INTO @ParameterTable
  EXECUTE [@@].[_selectParameterList]
    @p01
  , @p02
  , @p03
  , @p04
  , @p05
  , @p06
  , @p07
  , @p08
  , @p09
  , @p10
  , @p11
  , @p12
  , @p13
  , @p14
  , @p15
  , @p16
  , @p17
  , @p18
  , @p19
  , @p20
  , @p21
  , @p22
  , @p23
  , @p24
  , @p25
  , @p26
  , @p27
  , @p28
  , @p29
  , @p30
  , @p31
  , @p32
  , @p33
  , @p34
  , @p35
  , @p36
  , @p37
  , @p38
  , @p39
  , @p40
  , @p41
  , @p42
  , @p43
  , @p44
  , @p45
  , @p46
  , @p47
  , @p48
  , @p49
  , @p50
  , @p51
  , @p52
  , @p53
  , @p54
  , @p55
  , @p56
  , @p57
  , @p58
  , @p59
  , @p60
  , @p61
  , @p62
  , @p63
  , @p64
  , @p65
  , @p66
  , @p67
  , @p68
  , @p69
  , @p70
  , @p71
  , @p72
  , @p73
  , @p74
  , @p75
  , @p76
  , @p77
  , @p78
  , @p79
  , @p80
  , @p81
  , @p82
  , @p83
  , @p84
  , @p85
  , @p86
  , @p87
  , @p88
  , @p89
  , @p90
  , @p91
  , @p92
  , @p93
  , @p94
  , @p95
  , @p96
  , @p97
  , @p98
  , @p99
  , @ObjectName = @ObjectName               -- Name der Prozedur, falls Template als Stored procedure gespeichert war
  , @ParameterNameList = @ParameterNameList -- explizite Parameterliste
  , @Offset = @Count                        -- Anzahl Parameter, die über Cursor gesetzt werden

  DECLARE @ParameterIterationValueTable [@@].[ParameterIterationValueTable]
  INSERT INTO @ParameterIterationValueTable
  EXECUTE [@@].[_SelectCursorRows] @myReference,@Count -- '@myReference'

  DECLARE @CreateProcedureTemplate NVARCHAR(MAX) =
    'CREATE OR ALTER PROCEDURE [@01@].[@01@]' + [@@].CRLF()
  DECLARE @ProcedureParameter NVARCHAR(MAX) = ''
  IF [@Info].[isProcedure](@ObjectName) > 0
  BEGIN
    SET @ProcedureParameter = [@@].[_getRemainingParameters](@ObjectName)
    IF @ProcedureParameter > ''
      SET @CreateProcedureTemplate =
        @CreateProcedureTemplate + '@02@' + [@@].CRLF()
  END
  DECLARE @BodyProcedureTemplate NVARCHAR(MAX) =
    'BEGIN' + [@@].CRLF() + '@03@' + [@@].CRLF() + 'END' + [@@].CRLF()
  IF [@Info].[isProcedure](@BodyProcedureTemplateName) > 0
  BEGIN
    EXECUTE [@@].[_getObjectTemplate]
      @BodyProcedureTemplateName
    , @BodyProcedureTemplate OUTPUT
    , @OnlyBeginEndBlock = 1
  END
  SET @CreateProcedureTemplate =
    @CreateProcedureTemplate + 'AS' + [@@].CRLF() + @BodyProcedureTemplate

  DECLARE @Rows INT = 0
  DECLARE @Loop INT = 1
  DECLARE @LoopTemplate NVARCHAR(MAX)
  DECLARE @LoopDatabase NVARCHAR(MAX)
  DECLARE @LoopLinkedServer NVARCHAR(MAX)
  DECLARE @LoopProcedureName NVARCHAR(MAX)
  DECLARE @LoopCreateProcedureTemplate NVARCHAR(MAX)
  DECLARE @ResultTemplate NVARCHAR(MAX) = ''
  SET @Rows = (SELECT MAX([@Iteration])FROM @ParameterIterationValueTable)
  WHILE @Loop <= @Rows
  BEGIN
    UPDATE  P
    SET P.[@Value] = I.[@Value]
    FROM  @ParameterTable P
    JOIN @ParameterIterationValueTable I
      ON P.[@ID] = I.[@ParameterID]
         AND I.[@Iteration] = @Loop

    SET @LoopTemplate = @Template
    SET @LoopDatabase = @Database
    SET @LoopLinkedServer = @LinkedServer
    SET @LoopProcedureName = @ProcedureName
    SET @LoopCreateProcedureTemplate = @CreateProcedureTemplate

    EXECUTE [@@].[_replaceTemplateParameterTable]
      @LoopTemplate OUTPUT, @ParameterTable
    EXECUTE [@@].[_replaceTemplateParameterTable]
      @LoopDatabase OUTPUT, @ParameterTable
    EXECUTE [@@].[_replaceTemplateParameterTable]
      @LoopLinkedServer OUTPUT, @ParameterTable
    EXECUTE [@@].[_replaceTemplateParameterTable]
      @LoopProcedureName OUTPUT, @ParameterTable
    IF @ProcedureName IS NOT NULL
    BEGIN
      IF @CreateManyProcedures = 1
      BEGIN
        EXECUTE [@@].[_replaceTemplateParameterValue]
          @LoopCreateProcedureTemplate OUTPUT, '@01@', @LoopProcedureName
        EXECUTE [@@].[_replaceTemplateParameterValue]
          @LoopCreateProcedureTemplate OUTPUT, '@02@', @ProcedureParameter
        EXECUTE [@@].[_replaceTemplateParameterValue]
          @LoopCreateProcedureTemplate OUTPUT, '@03@', @LoopTemplate
        EXECUTE [@@].[_executeSQL]
          @LoopCreateProcedureTemplate
        , @Database = @LoopDatabase
        , @LinkedServer = @LoopLinkedServer
        , @Print = @Print
      END
      ELSE
		  BEGIN
			  EXECUTE [@@].[_executeSQL]
				@LoopTemplate
			  , @Database = @LoopDatabase
			  , @LinkedServer = @LoopLinkedServer
			  , @Print = @Print
			END
    END
    ELSE
       BEGIN
        SET @ResultTemplate = @ResultTemplate + @LoopTemplate
      END
 
    SET @Loop = @Loop + 1
  END

  IF @ProcedureName IS NOT NULL
     AND @CreateManyProcedures = 0
  BEGIN
    EXECUTE [@@].[_replaceTemplateParameterValue]
      @CreateProcedureTemplate OUTPUT, '@01@', @LoopProcedureName
    EXECUTE [@@].[_replaceTemplateParameterValue]
      @CreateProcedureTemplate OUTPUT, '@02@', @ProcedureParameter
    EXECUTE [@@].[_replaceTemplateParameterValue]
      @CreateProcedureTemplate OUTPUT, '@03@', @ResultTemplate
    EXECUTE [@@].[_executeSQL]
      @CreateProcedureTemplate
    , @Database = @LoopDatabase
    , @LinkedServer = @LoopLinkedServer
    , @Print = @Print
  END

  SET @Template = @ResultTemplate

END
GO

