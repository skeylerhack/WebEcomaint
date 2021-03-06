
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCTTBExcel')
   exec('CREATE PROCEDURE spCTTBExcel AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROC [dbo].spCTTBExcel
	@MsMay NVARCHAR(100) =   'MCLT5G' ,
	@MsBP NVARCHAR(100) =   '-1' 
AS
begin


SELECT T1.MSCHA, A.TEN_MAY,B.Ten_N_XUONG,MS_N_XUONG,C.TEN_HE_THONG,C.MS_HE_THONG,
       T1.MS_BO_PHAN,
       T1.TEN_BO_PHAN AS TENBP1,
       T2.MSCHA2,
       T2.MSBP2,
       T2.TEN_BO_PHAN AS TENBP2,
       T3.MSCHA3,
       T3.MSBP3,
       T3.TEN_BO_PHAN AS TENBP3,
       T4.MSCHA4,
       T4.MSBP4,
       T4.TENBP4,
       T5.MSCHA5,
       T5.MSBP5,
       T5.TENBP5,
       T6.MSCHA6,
       T6.MSBP6,
       T6.TENBP6 
	   FROM 
(
SELECT DISTINCT	MS_MAY AS MSCHA , MS_BO_PHAN,TEN_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI  WHERE  (MS_BO_PHAN_CHA = MS_MAY) AND (MS_MAY = @MsMay) AND (MS_BO_PHAN = @MsBP OR @MsBP = '-1')
) T1 
LEFT JOIN 
(
	SELECT DISTINCT	 MS_BO_PHAN_CHA AS MSCHA2 ,  MS_BO_PHAN AS MSBP2,TEN_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	MS_MAY + MS_BO_PHAN_CHA  IN 
					(SELECT DISTINCT	MS_MAY + MS_BO_PHAN   FROM dbo.CAU_TRUC_THIET_BI  WHERE (MS_BO_PHAN_CHA = MS_MAY) AND (MS_MAY = @MsMay) AND (MS_BO_PHAN = @MsBP OR @MsBP = '-1') ) 
				) T2 ON T1.MS_BO_PHAN = T2.MSCHA2	

LEFT JOIN 
(
		SELECT DISTINCT	T1.MS_BO_PHAN_CHA MSCHA3,  MS_BO_PHAN AS MSBP3,TEN_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
		(
			SELECT DISTINCT	MS_MAY +  MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	MS_MAY + MS_BO_PHAN_CHA  IN 
				(SELECT DISTINCT	MS_MAY + MS_BO_PHAN   FROM dbo.CAU_TRUC_THIET_BI WHERE   (MS_BO_PHAN_CHA = MS_MAY) AND (MS_MAY = @MsMay) AND (MS_BO_PHAN = @MsBP OR @MsBP = '-1') ) 

		)
)	T3 ON T2.MSBP2 = T3.MSCHA3	

LEFT JOIN 
(
		SELECT DISTINCT	T1.MS_BO_PHAN_CHA MSCHA4 , MS_BO_PHAN AS MSBP4,TEN_BO_PHAN AS TENBP4 FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
		(
			SELECT DISTINCT	MS_MAY +  MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
			(
				SELECT DISTINCT	MS_MAY +  MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	MS_MAY + MS_BO_PHAN_CHA  IN 
					(SELECT DISTINCT	MS_MAY + MS_BO_PHAN   FROM dbo.CAU_TRUC_THIET_BI  WHERE (MS_BO_PHAN_CHA = MS_MAY) AND (MS_MAY = @MsMay) AND (MS_BO_PHAN = @MsBP OR @MsBP = '-1')) 

			)
		)
) T4 ON T3.MSBP3 = T4.MSCHA4
LEFT JOIN 
(
	SELECT DISTINCT		T1.MS_BO_PHAN_CHA MSCHA5 , MS_BO_PHAN AS MSBP5,TEN_BO_PHAN AS TENBP5 FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
	(

		SELECT DISTINCT	MS_MAY + MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
		(
			SELECT DISTINCT	MS_MAY +  MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
			(
				SELECT DISTINCT	MS_MAY +  MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	MS_MAY + MS_BO_PHAN_CHA  IN 
					(SELECT DISTINCT	MS_MAY + MS_BO_PHAN   FROM dbo.CAU_TRUC_THIET_BI WHERE   (MS_BO_PHAN_CHA = MS_MAY) AND (MS_MAY = @MsMay) AND (MS_BO_PHAN = @MsBP OR @MsBP = '-1')) 
			)
		)
	)
) T5 ON T4.MSBP4 = T5.MSCHA5

LEFT JOIN 
(
SELECT DISTINCT	T1.MS_BO_PHAN_CHA MSCHA6 , MS_BO_PHAN AS MSBP6,TEN_BO_PHAN AS TENBP6  FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
(
	SELECT DISTINCT	MS_MAY + MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
	(

		SELECT DISTINCT	MS_MAY + MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
		(
			SELECT DISTINCT	MS_MAY +  MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	 MS_MAY + MS_BO_PHAN_CHA  IN 
			(
				SELECT DISTINCT	MS_MAY +  MS_BO_PHAN FROM dbo.CAU_TRUC_THIET_BI T1 WHERE	MS_MAY + MS_BO_PHAN_CHA  IN 
					(SELECT DISTINCT	MS_MAY + MS_BO_PHAN   FROM dbo.CAU_TRUC_THIET_BI WHERE   (MS_BO_PHAN_CHA = MS_MAY) AND (MS_MAY = @MsMay) AND (MS_BO_PHAN = @MsBP OR @MsBP = '-1') )  

			)
		)
	)
)
) T6 ON T5.MSBP5 = T6.MSCHA6 INNER JOIN dbo.MAY A ON T1.MSCHA = A.MS_MAY LEFT JOIN 
(SELECT T1.MS_MAY,T2.Ten_N_XUONG,T1.MS_N_XUONG FROM dbo.MAY_NHA_XUONG T1 INNER JOIN dbo.NHA_XUONG T2 ON T2.MS_N_XUONG = T1.MS_N_XUONG) B ON T1.MSCHA = B.MS_MAY LEFT JOIN 
(SELECT T2.MS_MAY,T1.TEN_HE_THONG,T1.MS_HE_THONG FROM dbo.HE_THONG T1 INNER JOIN dbo.MAY_HE_THONG T2 ON T2.MS_HE_THONG = T1.MS_HE_THONG) C ON T1.MSCHA = C.MS_MAY

ORDER BY C.MS_HE_THONG,MS_N_XUONG,T1.MSCHA, T1.MS_BO_PHAN,T2.MSBP2,T3.MSBP3,T4.MSBP4,T5.MSBP5


end