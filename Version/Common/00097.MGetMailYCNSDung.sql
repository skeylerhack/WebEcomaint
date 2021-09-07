
-- EXEC MGetMailYCNSDung 17,0
ALTER PROC [dbo].[MGetMailYCNSDung]
	@STT INT,
	@NNgu int
AS

SELECT     CONVERT(INT, NULL) AS STT, C.MS_MAY, C.TEN_MAY, B.MO_TA_TINH_TRANG, B.YEU_CAU, D.TEN_UU_TIEN, A.STT AS MA_SO, 
			A.NGAY, A.GIO_YEU_CAU, A.NGUOI_YEU_CAU, A.NGAY_HOAN_THANH, 
			A.EMAIL_NSD , A.MS_YEU_CAU, A.SO_YEU_CAU, 
			CASE @NNgu WHEN 0 THEN E.Ten_N_XUONG WHEN 1 THEN E.TEN_N_XUONG_A ELSE E.TEN_N_XUONG_H END AS MS_N_XUONG, A.USER_COMMENT,
			CONVERT(DATETIME, CONVERT(NVARCHAR(10), NGAY_XAY_RA, 101) + ' ' + CONVERT(NVARCHAR(10), GIO_XAY_RA, 108)) AS NGAY_GIO_XR,
			dbo.GetMailTheoUserYCSD (A.STT) AS MAIL_USER_LAP
FROM         dbo.YEU_CAU_NSD AS A INNER JOIN
                      dbo.YEU_CAU_NSD_CHI_TIET AS B ON A.STT = B.STT INNER JOIN
                      dbo.MAY AS C ON B.MS_MAY = C.MS_MAY INNER JOIN
                      dbo.MUC_UU_TIEN AS D ON B.MS_UU_TIEN = D.MS_UU_TIEN INNER JOIN
                      dbo.NHA_XUONG AS E ON A.MS_N_XUONG = E.MS_N_XUONG
WHERE     (A.STT = @STT)
ORDER BY C.MS_MAY, C.TEN_MAY, B.MO_TA_TINH_TRANG

