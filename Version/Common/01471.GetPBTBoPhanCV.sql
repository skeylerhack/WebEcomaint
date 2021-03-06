IF NOT EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'GetPBTBoPhanCV')
   exec('CREATE FUNCTION  dbo.GetPBTBoPhanCV () RETURNS  nvarchar(max) as Begin return null end')
GO


--SELECT dbo.GetPBTBoPhanCV(MS_PHIEU_BAO_TRI,0) as asdasas FROM PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI  = 'WO-201901000014'



ALTER function [dbo].[GetPBTBoPhanCV]
(
	@MS_PHIEU_BAO_TRI nvarchar(20),
	@NNgu int
)
returns nvarchar(max)
as
begin
declare @sName nvarchar(max)

	SELECT @sName =COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'' )  + TEN_CV
	FROM
	(
		SELECT        T3.MS_BO_PHAN + ' - ' + T3.TEN_BO_PHAN + ' - ' + CASE @NNgu WHEN 0 THEN 	ISNULL(MO_TA_CV ,'') 
				WHEN 1 THEN ISNULL(NULLIF(MO_TA_CV_ANH,'') ,MO_TA_CV) 
				ELSE ISNULL(NULLIF(MO_TA_CV_HOA,'') ,MO_TA_CV) END AS TEN_CV, 1 AS LOAI
		FROM            dbo.PHIEU_BAO_TRI AS T1 INNER JOIN
								 dbo.PHIEU_BAO_TRI_CONG_VIEC AS T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI INNER JOIN
								 dbo.CAU_TRUC_THIET_BI AS T3 ON T1.MS_MAY = T3.MS_MAY AND T2.MS_BO_PHAN = T3.MS_BO_PHAN INNER JOIN
								 dbo.CONG_VIEC ON T2.MS_CV = dbo.CONG_VIEC.MS_CV
		WHERE        (T1.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)

		
		UNION

		SELECT TEN_CONG_VIEC,2 AS LOAI FROM PHIEU_BAO_TRI_CV_PHU_TRO WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
	) T1
              
return @sName
end

