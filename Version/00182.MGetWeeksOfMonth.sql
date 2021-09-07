
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MGetWeeksOfMonth]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	DROP FUNCTION MGetWeeksOfMonth
END	
GO
--SELECT * FROM DBO.MGetWeeksOfMonth ('05/01/2019')
CREATE	 function dbo.MGetWeeksOfMonth (@dMonth DATE,@) 
returns table as return (
with n as (select n from (values(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) t(n))
, dates as (
  select top (datediff(day, @dMonth, dateadd(month, datediff(month, 0, @dMonth )+1, 0))) 
    [DateValue]=convert(date,dateadd(day,row_number() over(order by (select 1))-1,@dMonth))
  from n as deka cross join n as hecto
)
select 
    WeekOfMonth = row_number() over (order by datepart(week,DateValue))
  , Week        = datepart(week,DateValue)
  , WeekStart   = min(DateValue)
  , WeekEnd     = max(DateValue)
from dates
group by datepart(week,DateValue)
);