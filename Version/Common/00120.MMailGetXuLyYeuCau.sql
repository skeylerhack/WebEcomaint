
--EXEC MMailGetXuLyYeuCau 81,'10-01-OFF-001-00',0

ALTER procedure [dbo].[MMailGetXuLyYeuCau]
	@STT INT,
	@MsMay NVARCHAR(50),
	@NNgu int
	
as
SELECT CONVERT(INT, NULL) AS STT,   B.MS_MAY, C.TEN_MAY, B.MO_TA_TINH_TRANG, B.YEU_CAU, D.TEN_UU_TIEN, B.USERNAME_DSX, B.THOI_GIAN_DSX, B.Y_KIEN_DSX, 
		B.THUC_HIEN_DSX, B.USERNAME_DBT, B.NGAY_DBT, 
		B.Y_KIEN_DBT, CASE @NNgu WHEN 0 THEN E.TEN_TIENG_VIET WHEN 1 THEN E.TEN_TIENG_ANH ELSE E.TEN_TIENG_HOA END AS TEN_TIENG_VIET, B.MS_PBT, 
		dbo.TINH_TRANG_PBT.TEN_TINH_TRANG, ISNULL(B.MS_CONG_NHAN, N'') + CASE LEN(ISNULL(dbo.CONG_NHAN.HO, '') + ISNULL(dbo.CONG_NHAN.TEN, '')) 
		WHEN 0 THEN '' ELSE N'(' + ISNULL(dbo.CONG_NHAN.HO, '') + N' ' + ISNULL(dbo.CONG_NHAN.TEN, '') + N')' END AS MS_CONG_NHAN, A.NGAY_BD_KH, A.NGAY_KT_KH, PBT_MIN.TU_NGAY, 
		PBT_MAX.DEN_NGAY, dbo.MGetPBTMoTaCongViec(A.MS_PHIEU_BAO_TRI, @NNgu) AS MO_TA_CV, dbo.MGetPBTVTu(A.MS_PHIEU_BAO_TRI, @NNgu) AS VAT_TU, dbo.YEU_CAU_NSD.NGAY, 
		dbo.YEU_CAU_NSD.GIO_YEU_CAU, dbo.YEU_CAU_NSD.NGUOI_YEU_CAU, dbo.YEU_CAU_NSD.NGAY_HOAN_THANH, dbo.YEU_CAU_NSD.EMAIL_NSD, dbo.YEU_CAU_NSD.MS_YEU_CAU, 
		dbo.YEU_CAU_NSD.SO_YEU_CAU, CASE @NNgu WHEN 0 THEN  dbo.NHA_XUONG.Ten_N_XUONG WHEN 1 THEN dbo.NHA_XUONG.TEN_N_XUONG_A ELSE E.TEN_TIENG_HOA END AS MS_N_XUONG, 
		dbo.YEU_CAU_NSD.USER_COMMENT, T1.TEN_HANG_MUC, B.MS_CACH_TH, dbo.YEU_CAU_NSD.USER_LAP,HO_TEN_DSX
FROM         dbo.YEU_CAU_NSD_CHI_TIET AS B INNER JOIN
                      dbo.MAY AS C ON B.MS_MAY = C.MS_MAY INNER JOIN
                      dbo.YEU_CAU_NSD ON B.STT = dbo.YEU_CAU_NSD.STT INNER JOIN
                      dbo.NHA_XUONG ON dbo.YEU_CAU_NSD.MS_N_XUONG = dbo.NHA_XUONG.MS_N_XUONG LEFT OUTER JOIN
                      dbo.CONG_NHAN ON B.MS_CONG_NHAN = dbo.CONG_NHAN.MS_CONG_NHAN LEFT OUTER JOIN
                      dbo.PHIEU_BAO_TRI AS A ON B.MS_PBT = A.MS_PHIEU_BAO_TRI LEFT OUTER JOIN
                      dbo.TINH_TRANG_PBT ON A.TINH_TRANG_PBT = dbo.TINH_TRANG_PBT.STT LEFT OUTER JOIN
                      dbo.MUC_UU_TIEN AS D ON B.MS_UU_TIEN = D.MS_UU_TIEN LEFT OUTER JOIN
                      dbo.CACH_THUC_HIEN AS E ON B.MS_CACH_TH = E.MS_CACH_TH LEFT OUTER JOIN
                          (SELECT     MS_PHIEU_BAO_TRI, MIN(TU_NGAY) AS TU_NGAY
                            FROM          (SELECT     MS_PHIEU_BAO_TRI, CONVERT(DATETIME, NGAY + ' ' + TU_GIO) AS TU_NGAY
                                                    FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET) AS A_2
                            GROUP BY MS_PHIEU_BAO_TRI) AS PBT_MIN ON A.MS_PHIEU_BAO_TRI = PBT_MIN.MS_PHIEU_BAO_TRI LEFT OUTER JOIN
                          (SELECT     MS_PHIEU_BAO_TRI, MAX(DEN_NGAY) AS DEN_NGAY
                            FROM          (SELECT     MS_PHIEU_BAO_TRI, CONVERT(DATETIME, DEN_NGAY + ' ' + DEN_GIO) AS DEN_NGAY
                                                    FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET AS PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET_1) AS A_1
                            GROUP BY MS_PHIEU_BAO_TRI) AS PBT_MAX ON A.MS_PHIEU_BAO_TRI = PBT_MAX.MS_PHIEU_BAO_TRI LEFT JOIN 
						KE_HOACH_TONG_THE T1 ON B.HANG_MUC_ID_KE_HOACH = T1.HANG_MUC_ID LEFT JOIN 
						(SELECT T1.USERNAME, HO + ' ' + TEN AS HO_TEN_DSX FROM USERS T1 INNER JOIN CONG_NHAN T2 ON T1.MS_CONG_NHAN = T2.MS_CONG_NHAN) T3 ON 
						B.USERNAME_DSX = T3.USERNAME
WHERE B.STT = @STT AND B.MS_MAY = @MsMay
            

