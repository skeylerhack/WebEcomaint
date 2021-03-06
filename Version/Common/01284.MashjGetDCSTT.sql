
IF EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'MashjGetDCSTT')
   exec('DROP FUNCTION MashjGetDCSTT')
GO

--DROP FUNCTION MashjGetDCSTT
--SELECT * FROM [dbo].[MashjGetDCSTT]() order by stt_sort

CREATE  FUNCTION [dbo].MashjGetDCSTT
()
returns   TABLE 
as



RETURN (
with cte as
(
select
    T1.MS_HE_THONG,
    MS_CHA,
    cast(row_number()over(partition by MS_CHA order by ISNULL(STT,9999)) as varchar(max)) as [path],
    0 as level,
    row_number()over(partition by MS_CHA order by  ISNULL(STT,9999)) / power(10.0,0) as x,
	STT
from HE_THONG T1 
where ISNULL(MS_CHA,-1) = -1
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
)
   
select
    T2.*, x as STT_SORT 
from cte T1 INNER JOIN HE_THONG T2 ON T1.MS_HE_THONG = T2.MS_HE_THONG 

)




