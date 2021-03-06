
ALTER PROCEDURE [dbo].[GetCongViecTheoThongSo]
    --@LoaiCV INT = 1,
    @NNgu INT = 0,
    @Kieu INT = 1,
	@MsTSGS int =1,
	@USERNAME NVARCHAR	(100) = 'admin'
--loaiTS = -1 load all
--loaiTS = 0 dinh luong
--loaiTS = 1 dinh tinh

--kieu = 0 load form
--kieu =1 chinh sua
AS
BEGIN

SELECT	T4.MS_CV,T4.MS_LOAI_CV, CASE @NNgu WHEN 0 THEN MO_TA_CV WHEN 1 THEN ISNULL(NULLIF(MO_TA_CV_ANH, ''), MO_TA_CV) ELSE ISNULL(NULLIF(MO_TA_CV_HOA, ''), MO_TA_CV) END AS MO_TA_CV
INTO #CONG_VIEC
FROM            dbo.NHOM_LOAI_CONG_VIEC AS T2 INNER JOIN
                         dbo.USERS AS T3 ON T2.GROUP_ID = T3.GROUP_ID INNER JOIN
                         dbo.CONG_VIEC AS T4 ON T2.MS_LOAI_CV = T4.MS_LOAI_CV
WHERE (USERNAME = @USERNAME) AND (ISNULL(T4.MS_LOAI_CV,'') <> '')




IF ( @Kieu = 0 )
BEGIN
    SELECT DISTINCT
	CONVERT(BIT	,0) CHON,
            T1.MS_CV ,
			T2.MS_LOAI_CV,
            T2.MO_TA_CV
    FROM    dbo.GSTT_CV T1
            INNER JOIN #CONG_VIEC T2 ON T2.MS_CV = T1.MS_CV
    WHERE   T1.MS_TS_GSTT = @MsTSGS
	ORDER BY  T2.MO_TA_CV
END
ELSE
BEGIN
    SELECT DISTINCT
		CASE when ISNULL(T1.MS_CV,'') ='' then CONVERT(BIT,0) else CONVERT(BIT,1)  end as CHON,
		@MsTSGS AS MS_TS_GSTT,
		T1.MS_CV,
		T2.MS_LOAI_CV,T2.MO_TA_CV
    FROM    dbo.GSTT_CV T1
            INNER JOIN #CONG_VIEC T2 ON T2.MS_CV = T1.MS_CV
    WHERE    MS_TS_GSTT =@MsTSGS
	UNION
	select CONVERT(BIT,0),@MsTSGS AS MS_TS_GSTT, MS_CV,MS_LOAI_CV,  MO_TA_CV from #CONG_VIEC
	WHERE MS_CV not in (SELECT MS_CV from GSTT_CV WHERE MS_TS_GSTT = @MsTSGS)
	ORDER by CHON DESC,MO_TA_CV
                          
END
END	


	