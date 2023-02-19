




CREATE PROC [@@].[ExecuteTemplateWithCursor]
@Template NVARCHAR (MAX) OUTPUT
,@Cursor CURSOR VARYING OUTPUT
,@p01 NVARCHAR (MAX)=null,@p02 NVARCHAR (MAX)=null,@p03 NVARCHAR (MAX)=null,@p04 NVARCHAR (MAX)=null,@p05 NVARCHAR (MAX)=null,@p06 NVARCHAR (MAX)=null,@p07 NVARCHAR (MAX)=null,@p08 NVARCHAR (MAX)=null,@p09 NVARCHAR (MAX)=null,@p10 NVARCHAR (MAX)=null
,@p11 NVARCHAR (MAX)=null,@p12 NVARCHAR (MAX)=null,@p13 NVARCHAR (MAX)=null,@p14 NVARCHAR (MAX)=null,@p15 NVARCHAR (MAX)=null,@p16 NVARCHAR (MAX)=null,@p17 NVARCHAR (MAX)=null,@p18 NVARCHAR (MAX)=null,@p19 NVARCHAR (MAX)=null,@p20 NVARCHAR (MAX)=null
,@p21 NVARCHAR (MAX)=null,@p22 NVARCHAR (MAX)=null,@p23 NVARCHAR (MAX)=null,@p24 NVARCHAR (MAX)=null,@p25 NVARCHAR (MAX)=null,@p26 NVARCHAR (MAX)=null,@p27 NVARCHAR (MAX)=null,@p28 NVARCHAR (MAX)=null,@p29 NVARCHAR (MAX)=null,@p30 NVARCHAR (MAX)=null
,@p31 NVARCHAR (MAX)=null,@p32 NVARCHAR (MAX)=null,@p33 NVARCHAR (MAX)=null,@p34 NVARCHAR (MAX)=null,@p35 NVARCHAR (MAX)=null,@p36 NVARCHAR (MAX)=null,@p37 NVARCHAR (MAX)=null,@p38 NVARCHAR (MAX)=null,@p39 NVARCHAR (MAX)=null,@p40 NVARCHAR (MAX)=null
,@p41 NVARCHAR (MAX)=null,@p42 NVARCHAR (MAX)=null,@p43 NVARCHAR (MAX)=null,@p44 NVARCHAR (MAX)=null,@p45 NVARCHAR (MAX)=null,@p46 NVARCHAR (MAX)=null,@p47 NVARCHAR (MAX)=null,@p48 NVARCHAR (MAX)=null,@p49 NVARCHAR (MAX)=null,@p50 NVARCHAR (MAX)=null
,@p51 NVARCHAR (MAX)=null,@p52 NVARCHAR (MAX)=null,@p53 NVARCHAR (MAX)=null,@p54 NVARCHAR (MAX)=null,@p55 NVARCHAR (MAX)=null,@p56 NVARCHAR (MAX)=null,@p57 NVARCHAR (MAX)=null,@p58 NVARCHAR (MAX)=null,@p59 NVARCHAR (MAX)=null,@p60 NVARCHAR (MAX)=null
,@p61 NVARCHAR (MAX)=null,@p62 NVARCHAR (MAX)=null,@p63 NVARCHAR (MAX)=null,@p64 NVARCHAR (MAX)=null,@p65 NVARCHAR (MAX)=null,@p66 NVARCHAR (MAX)=null,@p67 NVARCHAR (MAX)=null,@p68 NVARCHAR (MAX)=null,@p69 NVARCHAR (MAX)=null,@p70 NVARCHAR (MAX)=null
,@p71 NVARCHAR (MAX)=null,@p72 NVARCHAR (MAX)=null,@p73 NVARCHAR (MAX)=null,@p74 NVARCHAR (MAX)=null,@p75 NVARCHAR (MAX)=null,@p76 NVARCHAR (MAX)=null,@p77 NVARCHAR (MAX)=null,@p78 NVARCHAR (MAX)=null,@p79 NVARCHAR (MAX)=null,@p80 NVARCHAR (MAX)=null
,@p81 NVARCHAR (MAX)=null,@p82 NVARCHAR (MAX)=null,@p83 NVARCHAR (MAX)=null,@p84 NVARCHAR (MAX)=null,@p85 NVARCHAR (MAX)=null,@p86 NVARCHAR (MAX)=null,@p87 NVARCHAR (MAX)=null,@p88 NVARCHAR (MAX)=null,@p89 NVARCHAR (MAX)=null,@p90 NVARCHAR (MAX)=null
,@p91 NVARCHAR (MAX)=null,@p92 NVARCHAR (MAX)=null,@p93 NVARCHAR (MAX)=null,@p94 NVARCHAR (MAX)=null,@p95 NVARCHAR (MAX)=null,@p96 NVARCHAR (MAX)=null,@p97 NVARCHAR (MAX)=null,@p98 NVARCHAR (MAX)=null,@p99 NVARCHAR (MAX)=null
,@Database NVARCHAR (MAX)=null
,@LinkedServer sysname=null
,@ParameterNameList NVARCHAR (MAX)=null
,@Print bit=0
AS
BEGIN
	print @Template
  EXECUTE [@@].[_doTemplateWithCursor]
  @Template OUTPUT
  ,@Cursor
	,@p01,@p02,@p03,@p04,@p05,@p06,@p07,@p08,@p09,@p10
	,@p11,@p12,@p13,@p14,@p15,@p16,@p17,@p18,@p19,@p20
	,@p21,@p22,@p23,@p24,@p25,@p26,@p27,@p28,@p29,@p30
	,@p31,@p32,@p33,@p34,@p35,@p36,@p37,@p38,@p39,@p40
	,@p41,@p42,@p43,@p44,@p45,@p46,@p47,@p48,@p49,@p50
	,@p51,@p52,@p53,@p54,@p55,@p56,@p57,@p58,@p59,@p60
	,@p61,@p62,@p63,@p64,@p65,@p66,@p67,@p68,@p69,@p70
	,@p71,@p72,@p73,@p74,@p75,@p76,@p77,@p78,@p79,@p80
	,@p81,@p82,@p83,@p84,@p85,@p86,@p87,@p88,@p89,@p90
	,@p91,@p92,@p93,@p94,@p95,@p96,@p97,@p98,@p99
  ,@ParameterNameList=@ParameterNameList

  EXECUTE [@@].[_executeSQL] @Template,@Database=@Database,@LinkedServer=@LinkedServer,@Print=@Print
		
END
GO

