
--EXEC SP_NHU_Y_GET_KHTT '-1','-1','-1','ADMINISTRATOR','-1',-1, '08/01/2014', '01/01/2017'
ALTER PROC [dbo].[SP_NHU_Y_GET_KHTT]
	@MS_LOAI_MAY NVARCHAR(50),
	@MS_NHOM_MAY NVARCHAR(50),
	@MS_MAY NVARCHAR(50),
	@USERNAME NVARCHAR(50),
	@MS_NHA_XUONG NVARCHAR(50),
	@MS_HE_THONG INT,
	@TU_NGAY DATETIME,
	@DEN_NGAY DATETIME
AS


SELECT DISTINCT TEN_MAY, MS_MAY INTO #TMP2 FROM dbo.MGetMayUserNgay(@DEN_NGAY, @USERNAME, @MS_NHA_XUONG, @MS_HE_THONG, -1, 
	@MS_LOAI_MAY, @MS_NHOM_MAY,@MS_MAY, 0) A 

SELECT * INTO #KHTT FROM KE_HOACH_TONG_THE
	WHERE (CONVERT(DATETIME, CONVERT(NVARCHAR(10), NGAY, 103), 103) BETWEEN @TU_NGAY AND @DEN_NGAY)

--SELECT T2.USER_COMMENT,T1.MO_TA_TINH_TRANG,T1.YEU_CAU
SELECT DISTINCT 
  TEMP.MS_MAY, TEN_MAY, TEMP.HANG_MUC_ID, TEMP.TEN_HANG_MUC, TEMP.NGAY, TEMP.NGAY_DK_HT, TEMP.GHI_CHU, 
  TEMP.MS_LOAI_BT, TEMP.NGAY_BTPN, TEMP.LY_DO_SC, TEMP.MS_CACH_TH, TEMP.USERNAME,MS_UU_TIEN, CONVERT(NVARCHAR(50),MS_CN_PT) AS MS_CONG_NHAN
  ,dbo.GetThongSoYCSD(HANG_MUC_ID,1) AS YC_CHUNG,
  dbo.GetThongSoYCSD(HANG_MUC_ID,2) AS	YC_MO_TA,
  dbo.GetThongSoYCSD(HANG_MUC_ID,3) AS	YC,
  CONVERT(NVARCHAR(50),MS_CN_GS) AS MS_CN_GS
  
  
  
       FROM          (SELECT     A.MS_MAY, A.HANG_MUC_ID, A.TEN_HANG_MUC, A.NGAY, A.NGAY_DK_HT, A.GHI_CHU, A.MS_LOAI_BT, A.NGAY_BTPN, 
                                                      A.LY_DO_SC, A.MS_CACH_TH, A.USERNAME,A.MS_UU_TIEN, MS_CN_PT, MS_CN_GS
                               FROM          #KHTT AS A INNER JOIN
                                                          (SELECT DISTINCT MS_MAY, HANG_MUC_ID
                                                            FROM          dbo.KE_HOACH_TONG_CONG_VIEC AS KHTCV
                                                            WHERE      (MS_PHIEU_BAO_TRI IS NULL) AND (EOR_ID IS NULL) AND (KHONG_GQ = 0 OR
                                                                                   KHONG_GQ IS NULL) AND (THUE_NGOAI = 0 OR
                                                                                   THUE_NGOAI IS NULL)) AS TEMP_1 ON A.MS_MAY = TEMP_1.MS_MAY AND 
                                                      A.HANG_MUC_ID = TEMP_1.HANG_MUC_ID
                               UNION
                               SELECT     MS_MAY, HANG_MUC_ID, TEN_HANG_MUC, NGAY, NGAY_DK_HT, GHI_CHU, MS_LOAI_BT, NGAY_BTPN, LY_DO_SC, 
                                                     MS_CACH_TH, USERNAME,A.MS_UU_TIEN, MS_CN_PT, MS_CN_GS
                               FROM         #KHTT AS A
                               WHERE     (HANG_MUC_ID NOT IN
                                                         (SELECT     HANG_MUC_ID
                                                           FROM          dbo.KE_HOACH_TONG_CONG_VIEC))) AS TEMP 
       INNER JOIN #TMP2 T1 ON TEMP.MS_MAY = T1.MS_MAY
       ORDER BY HANG_MUC_ID DESC
