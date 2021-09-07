
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetDayChuyenSTT')
   exec('CREATE PROCEDURE GetDayChuyenSTT AS BEGIN SET NOCOUNT ON; END')
GO


--exec GetDayChuyenSTT  -1 ,'ADMIN'
ALTER PROC [dbo].[GetDayChuyenSTT]
	@MS_HE_THONG INT = -1,
	@Username NVARCHAR(50) = 'admin'
AS
SELECT DISTINCT MS_HE_THONG INTO #HT_TMP FROM [dbo].[MashjGetDCUser](@Username,@MS_HE_THONG)

;with cte as
(
select
    T1.MS_HE_THONG,
    MS_CHA,
    cast(row_number()over(partition by MS_CHA order by ISNULL(STT,9999)) as varchar(max)) as [path],
    0 as level,
    row_number()over(partition by MS_CHA order by  ISNULL(STT,9999)) / power(10.0,0) as x,
	STT
from HE_THONG T1 INNER JOIN #HT_TMP T2 ON  T1.MS_HE_THONG = T2.MS_HE_THONG
where ISNULL(MS_CHA,0) = 0
union all
select
    t.MS_HE_THONG,
    t.MS_CHA,
    [path] +'-'+ cast(row_number()over(partition by t.MS_CHA order by ISNULL(T.STT,9999)) as varchar(max)),
    level+1,
    x + row_number()over(partition by t.MS_CHA order by ISNULL(T.STT,9999)) / power(10.0,level+1),T.STT
 
from
    cte
join HE_THONG t on cte.MS_HE_THONG = t.MS_CHA 
INNER JOIN #HT_TMP T2 ON  t.MS_HE_THONG = T2.MS_HE_THONG
)
   
select
    T2.*, x as STT_SORT 
from cte T1 INNER JOIN HE_THONG T2 ON T1.MS_HE_THONG = T2.MS_HE_THONG 
order by x, TEN_HE_THONG

