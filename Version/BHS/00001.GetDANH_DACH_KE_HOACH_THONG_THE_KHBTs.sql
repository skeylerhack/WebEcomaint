
-- Exec [dbo].[GetDANH_DACH_KE_HOACH_THONG_THE_KHBTs] 'CV10001' , '20140101','20141201','admin',''

ALTER procedure [dbo].[GetDANH_DACH_KE_HOACH_THONG_THE_KHBTs]
	@MS_MAY NVARCHAR(30),
	@TU_NGAY DATETIME,
	@DEN_NGAY DATETIME ,
	@USERNAME NVARCHAR(50),
	@MS_PHIEU_BAO_TRI NVARCHAR(20)
 AS
SELECT  DISTINCT dbo.KE_HOACH_TONG_THE.HANG_MUC_ID , KE_HOACH_TONG_THE_CHI_TIET.KH_NAM,KE_HOACH_TONG_THE_CHI_TIET.KH_THANG , 
dbo.KE_HOACH_TONG_THE.TEN_HANG_MUC, dbo.KE_HOACH_TONG_THE.GHI_CHU, CASE  ISNULL(T8.HANG_MUC_ID_KE_HOACH,0) WHEN 0 THEN 0 ELSE 1 END AS YCSDCT
FROM         dbo.KE_HOACH_TONG_THE INNER JOIN
                      dbo.KE_HOACH_TONG_CONG_VIEC ON dbo.KE_HOACH_TONG_THE.MS_MAY = dbo.KE_HOACH_TONG_CONG_VIEC.MS_MAY AND 
                      dbo.KE_HOACH_TONG_THE.HANG_MUC_ID = dbo.KE_HOACH_TONG_CONG_VIEC.HANG_MUC_ID AND KHONG_GQ<>1  
                      INNER JOIN ( SELECT * FROM dbo.KE_HOACH_TONG_THE_CHI_TIET WHERE KH_TYPE = 2 )  AS KE_HOACH_TONG_THE_CHI_TIET ON dbo.KE_HOACH_TONG_THE.HANG_MUC_ID = KE_HOACH_TONG_THE_CHI_TIET.MA_HANG_MUC
                      INNER JOIN
                      dbo.CONG_VIEC ON dbo.KE_HOACH_TONG_CONG_VIEC.MS_CV = dbo.CONG_VIEC.MS_CV INNER JOIN
                      dbo.LOAI_CONG_VIEC ON dbo.CONG_VIEC.MS_LOAI_CV = dbo.LOAI_CONG_VIEC.MS_LOAI_CV INNER JOIN
                      dbo.NHOM_LOAI_CONG_VIEC ON dbo.LOAI_CONG_VIEC.MS_LOAI_CV = dbo.NHOM_LOAI_CONG_VIEC.MS_LOAI_CV INNER JOIN
                      dbo.NHOM ON dbo.NHOM_LOAI_CONG_VIEC.GROUP_ID = dbo.NHOM.GROUP_ID INNER JOIN
                      dbo.USERS ON dbo.NHOM.GROUP_ID = dbo.USERS.GROUP_ID LEFT OUTER JOIN
                      dbo.YEU_CAU_NSD_CHI_TIET AS T8 ON KE_HOACH_TONG_THE.HANG_MUC_ID = T8.HANG_MUC_ID_KE_HOACH
WHERE (dbo.KE_HOACH_TONG_CONG_VIEC.MS_PHIEU_BAO_TRI IS NULL) AND (dbo.KE_HOACH_TONG_CONG_VIEC.EOR_ID IS NULL) AND  KE_HOACH_TONG_CONG_VIEC.THUE_NGOAI=0 AND KE_HOACH_TONG_CONG_VIEC.KHONG_GQ=0 AND
                      (dbo.KE_HOACH_TONG_THE.MS_MAY =@MS_MAY) 
AND KE_HOACH_TONG_THE.NGAY BETWEEN @TU_NGAY AND DateAdd(day,1, @DEN_NGAY)
AND CONG_VIEC.MS_CV NOT IN(SELECT MS_CV FROM PHIEU_BAO_TRI_CONG_VIEC  PBT WHERE PBT.MS_PHIEU_BAO_TRI=@MS_PHIEU_BAO_TRI AND PBT.MS_BO_PHAN= dbo.KE_HOACH_TONG_CONG_VIEC.MS_BO_PHAN)
