
-- EXEC MGetMailDuyetYCBT 0
ALTER PROC [dbo].[MGetMailDuyetYCBT]
	@NNgu int
AS

SELECT DISTINCT STT,STT_VAN_DE,MS_MAY  INTO #DSX FROM DSX 
DROP TABLE DSX

SELECT     TOP (100) PERCENT CONVERT(INT, NULL) AS STT, A.MS_YEU_CAU, A.SO_YEU_CAU, 
                      CASE @NNgu WHEN 0 THEN E.Ten_N_XUONG WHEN 1 THEN E.TEN_N_XUONG_A ELSE E.TEN_N_XUONG_H END AS MS_N_XUONG, C.MS_MAY, C.TEN_MAY, B.MO_TA_TINH_TRANG, B.YEU_CAU, 
                      D.TEN_UU_TIEN, CONVERT(DATETIME, CONVERT(NVARCHAR(10), B.NGAY_XAY_RA, 101) + ' ' + 
                      CONVERT(NVARCHAR(10), B.GIO_XAY_RA, 108)) AS NGAY_GIO_XR, B.USERNAME_DSX, B.THOI_GIAN_DSX, B.Y_KIEN_DSX, 
                      CONVERT(BIT, ISNULL(B.THUC_HIEN_DSX, 0)) AS THUC_HIEN_DSX, A.EMAIL_NSD
FROM dbo.YEU_CAU_NSD AS A INNER JOIN
                      dbo.YEU_CAU_NSD_CHI_TIET AS B ON A.STT = B.STT INNER JOIN
                      dbo.MAY AS C ON B.MS_MAY = C.MS_MAY INNER JOIN
                      dbo.MUC_UU_TIEN AS D ON B.MS_UU_TIEN = D.MS_UU_TIEN INNER JOIN
                      dbo.NHA_XUONG AS E ON A.MS_N_XUONG = E.MS_N_XUONG LEFT OUTER JOIN
                      dbo.USERS ON A.USERNAME = dbo.USERS.USERNAME INNER JOIN 
                      #DSX T1 ON A.STT = T1.STT AND B.STT_VAN_DE = T1.STT_VAN_DE AND B.MS_MAY = T1.MS_MAY 
ORDER BY C.MS_MAY, C.TEN_MAY, B.MO_TA_TINH_TRANG

