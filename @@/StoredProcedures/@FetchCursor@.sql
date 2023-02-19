


CREATE PROCEDURE [@@].[@FetchCursor@]
@01@ as nvarchar(max),@02@ as nvarchar(max),@03@ as nvarchar(max)
,@Cursor CURSOR VARYING OUTPUT
AS 
BEGIN
/*@01@*/   -- leider kein DECLARE @01@ möglich, deshalb einziger Ausweg: Kommentar-Regel zum Ersetzen
declare @table as [@@].[ParameterIterationValueTable]
declare @i int=0
open @cursor
while (1=1)
begin
  fetch next from @cursor into @02@
  if (@@fetch_status <> 0) break
	SET @i=@i+1
  insert into @table values (@i,1,@03@)
end
close @Cursor
deallocate @Cursor
select * from @table
END
GO

