


CREATE   FUNCTION [@@].[StandardParameterNames]
(@from INT=1, @to INT=99)
RETURNS TABLE 
AS
RETURN 
(
WITH Digits as
(select Digit FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) AS Digits(Digit)
)
, Numbers AS
(
Select D1.Digit*10+D2.Digit AS Number FROM Digits D1 Cross JOIN Digits D2
)
SELECT
number AS [@ID]
,FORMAT(number,'@00@') AS [@Parameter]
FROM Numbers Where Number Between @from AND @to
)
GO

