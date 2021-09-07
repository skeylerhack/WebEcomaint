IF NOT EXISTS ( SELECT  * FROM    sys.objects WHERE   type = 'P' AND name = 'GetCongViecTheoThongSo' )
    EXEC('CREATE PROCEDURE GetCongViecTheoThongSo AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[GetCongViecTheoThongSo]
    @NNgu INT = 0,
    @Kieu INT = 1,
	@MsTSGS int =1
--loaiTS = -1 load all
--loaiTS = 0 dinh luong
--loaiTS = 1 dinh tinh
--kieu = 0 load form
--kieu =1 chinh sua
AS
    BEGIN
        IF ( @Kieu = 0 )
            BEGIN
                SELECT DISTINCT
				CONVERT(BIT	,0) CHON,
                        T1.MS_CV ,
						T2.MS_LOAI_CV,
                        CASE @NNgu
                          WHEN 0 THEN T2.MO_TA_CV
                          WHEN 1
                          THEN ISNULL(NULLIF(T2.MO_TA_CV_ANH, ''), T2.MO_TA_CV)
                          ELSE ISNULL(NULLIF(T2.MO_TA_CV_HOA, ''), T2.MO_TA_CV)
                        END AS MO_TA_CV
                FROM    GSTT_CV T1
                        INNER JOIN dbo.CONG_VIEC T2 ON T2.MS_CV = T1.MS_CV
                WHERE   T1.MS_TS_GSTT =@MsTSGS
            END
        ELSE
            BEGIN
                SELECT DISTINCT
					CASE when ISNULL(T1.MS_CV,'') ='' then CONVERT(BIT,0) else CONVERT(BIT,1)  end as CHON,
					@MsTSGS AS MS_TS_GSTT,
					T1.MS_CV,
					T2.MS_LOAI_CV,
                        CASE @NNgu
                          WHEN 0 THEN T2.MO_TA_CV
                          WHEN 1
                          THEN ISNULL(NULLIF(T2.MO_TA_CV_ANH, ''), T2.MO_TA_CV)
                          ELSE ISNULL(NULLIF(T2.MO_TA_CV_HOA, ''), T2.MO_TA_CV)
                        END AS MO_TA_CV
                FROM    GSTT_CV T1
                        INNER JOIN dbo.CONG_VIEC T2 ON T2.MS_CV = T1.MS_CV
                WHERE    MS_TS_GSTT =@MsTSGS
				UNION
				select CONVERT(BIT,0),@MsTSGS AS MS_TS_GSTT, MS_CV,MS_LOAI_CV,MO_TA_CV from CONG_VIEC
where MS_CV not in (select MS_CV from GSTT_CV where MS_TS_GSTT = @MsTSGS)
order by CHON desc
            END
END


	