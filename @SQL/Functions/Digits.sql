
CREATE FUNCTION [@SQL].[Digits]
(@from INT=0, @to INT=9)
RETURNS TABLE 
AS
RETURN 
(
WITH Digits(Digit) as
(
select Digit FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) AS Digits(Digit)
UNION ALL
select Digit+1 from Digits where Digit <9
)
select 
Digit
,cast(ltrim(str(Digit)) as nchar(1)) as DigitChar
,cast(Quotename(ltrim(str(Digit))) as nchar(3)) as DigitCharQ
,cast('@'+ltrim(str(Digit)) as nchar(2)) as Parameter
,cast(Quotename('@'+ltrim(str(Digit))) as nchar(4)) as ParameterQ 
FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) AS Digits(Digit)
where Digit between @from and @to
)
GO

