--select dbo.[fn_Exec_Count]()
alter FUNCTION [dbo].[fn_Exec_Count] ( )
RETURNS nvarchar(max)
AS
    BEGIN
		Declare  @Result int
		Declare @Sql Varchar(Max)
		set @Sql = 'spGetDataPIL ''100000000283678'',''7GFX21YNzdPz5iU5YFRss4ALrTYI'''
		Exec @Result = SP_Executesql @Sql
		return @Result
		--return @Sql
    END

GO

-- SELECT 2
--SELECT  dbo.fn_Exec_Count('SELECT 1 UNION SELECT 2')

