IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MGetWeeksOfMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	DROP FUNCTION MGetWeeksOfMonth
END	
GO
--select * from MGetWeeksOfMonth('11/1/2018',0)
CREATE	 function dbo.MGetWeeksOfMonth (@Month date ,@DayOfWeek INT) 
RETURNS @tmpWeek TABLE (
        TT int,
        Week int,
        WeekStart date,
        WeekEnd date
    )
AS
BEGIN
declare @ngay DATE
declare @NGAY_CUOI DATE
set @NGAY_CUOI =  DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,@Month)+1, 0))
declare @stt int
set @stt=1
set @ngay=dateadd(day,8- datepart(dw,convert(DATE,@Month,103)),convert(DATE,@Month,103))
declare @str nvarchar(255)
INSERT INTO @tmpWeek VALUES(@stt, DATEPART(WEEK,@ngay),@Month , CONVERT(DATE,dateadd(day,7- datepart(dw,convert(DATE,@Month,103)),convert(DATE,@Month,103)),103) )
while @ngay<=convert(DATE,@NGAY_CUOI,103)
begin
	set @stt=@stt+1
	INSERT INTO @tmpWeek VALUES(@stt, DATEPART(WEEK,@ngay),convert(DATE,@ngay,103) , case when dateadd(day,6,@ngay)>convert(DATE,@NGAY_CUOI,103)THEN @NGAY_CUOI ELSE convert(DATE,dateadd(day,6,@ngay),103)END )
	set @ngay=dateadd(day,7,@ngay)
continue
end    
    RETURN;
END;
