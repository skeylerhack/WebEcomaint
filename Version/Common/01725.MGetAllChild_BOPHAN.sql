
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MGetAllChild_BOPHAN]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	DROP FUNCTION MGetAllChild_BOPHAN
END	
GO
CREATE FUNCTION [dbo].[MGetAllChild_BOPHAN]
    (@MS_MAY NVarchar(30),@MS_BO_PHAN NVarchar(50))
RETURNS TABLE 
AS RETURN
with cte(MS_BO_PHAN, MS_CHA,[ALL_CHA])
AS 
(
select MS_BO_PHAN,MS_BO_PHAN_CHA , CAST('' AS VARCHAR(8000))  AS ALL_CHA FROM 
dbo.CAU_TRUC_THIET_BI
where MS_BO_PHAN_CHA = @MS_BO_PHAN AND  MS_MAY = @MS_MAY
UNION ALL
select A.MS_BO_PHAN, A.MS_BO_PHAN_CHA,cast ((B.ALL_CHA + cast(A.MS_BO_PHAN_CHA as varchar(10)) +'; ') as varchar(8000))
FROM 
dbo.CAU_TRUC_THIET_BI A 
inner join cte B
ON A.MS_BO_PHAN_CHA=B.MS_BO_PHAN 
WHERE MS_MAY = @MS_MAY
)
select MS_BO_PHAN, CASE substring(ALL_CHA,0,LEN(ALL_CHA)) WHEN '' THEN MS_BO_PHAN ELSE substring(ALL_CHA,0,LEN(ALL_CHA)) END  AS NX_CHA from cte 

