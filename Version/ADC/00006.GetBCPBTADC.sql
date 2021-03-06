--SELECT * FROM PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = 'WO-201404000386'

--	EXEC GetBCPBTADC 'ADMIN','WO-201508000011','ROP-31', '2015-09-01 00:00:00.000',0
--	EXEC GetBCPBTADC 'ADMIN','WO-201404000386','COM-0003', '2014-04-18 00:00:00.000',0

ALTER PROC [dbo].[GetBCPBTADC]
	@UserName NVARCHAR(50),
	@MsPBT NVARCHAR(100),
	@MsMay NVARCHAR(50),
	@NgayBDKH DATETIME,
	@NNgu INT
AS	


-- Lay thong tin phieu bao tri
SELECT     A.MS_PHIEU_BAO_TRI, A.SO_PHIEU_BAO_TRI, F.HO + ' ' + F.TEN AS HT_NGUOI_LAP, 
	CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY_LAP,101) + ' ' + CONVERT(NVARCHAR(10),A.GIO_LAP,108) ) AS NGAY_LAP, 
	C.MS_MAY, C.TEN_MAY, CASE @NNgu WHEN 0 THEN B.TEN_TINH_TRANG WHEN 1 THEN B.TEN_TINH_TRANG_ANH ELSE B.TEN_TINH_TRANG_HOA END AS TEN_TTRANG, 
                      G.TEN_HT_BT , D.TEN_LOAI_BT, C.Ten_N_XUONG, A.LY_DO_BT, A.NGAY_BD_KH, A.NGAY_KT_KH, C.TEN_BP_CHIU_PHI
FROM         dbo.PHIEU_BAO_TRI AS A INNER JOIN
                      dbo.TINH_TRANG_PBT AS B ON A.TINH_TRANG_PBT = B.STT INNER JOIN
                       (SELECT * FROM dbo.MGetMayUserNgay(@NgayBDKH,@UserName,'-1',-1,-1,'-1','-1',@MsMay,0)) AS C ON A.MS_MAY = C.MS_MAY INNER JOIN
                      dbo.LOAI_BAO_TRI AS D ON A.MS_LOAI_BT = D.MS_LOAI_BT INNER JOIN
                      dbo.MUC_UU_TIEN AS E ON A.MS_UU_TIEN = E.MS_UU_TIEN INNER JOIN
                      dbo.CONG_NHAN AS F ON A.NGUOI_LAP = F.MS_CONG_NHAN INNER JOIN
                      dbo.HINH_THUC_BAO_TRI G ON D.MS_HT_BT = G.MS_HT_BT

WHERE     (A.MS_PHIEU_BAO_TRI = @MsPBT)

-- Lay thong tin phieu bao tri cong viec
SELECT   MO_TA_CV, TEN_BO_PHAN, CACH_TH, SO_GIO_KH, dbo.MGetListCNhanTGianPBT(@MsPBT,MS_CV,MS_BO_PHAN) AS GHI_CHU, 
	CASE WHEN H_THANH = 1 THEN 'Y' ELSE 'N' END AS H_THANH
FROM
(
	SELECT  CASE @NNgu  WHEN 0 THEN B.MO_TA_CV WHEN 1 THEN B.MO_TA_CV_ANH ELSE B.MO_TA_CV_HOA END AS MO_TA_CV, 
		D.TEN_BO_PHAN, A.THAO_TAC AS CACH_TH, A.SO_GIO_KH, A.GHI_CHU, A.H_THANH, A.MS_CV,A.MS_BO_PHAN
	FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC AS A INNER JOIN
						  dbo.CONG_VIEC AS B ON A.MS_CV = B.MS_CV INNER JOIN
						  dbo.PHIEU_BAO_TRI AS C ON A.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI INNER JOIN
						  dbo.CAU_TRUC_THIET_BI AS D ON A.MS_BO_PHAN = D.MS_BO_PHAN AND C.MS_MAY = D.MS_MAY
	WHERE     (C.MS_PHIEU_BAO_TRI = @MsPBT)
	UNION
	SELECT     TEN_CONG_VIEC, NULL AS BO_PHAN, NULL AS CACH_TH, SO_GIO_KH, NULL AS GHI_CHU, 
		CASE NGAY_HOAN_THANH WHEN NULL THEN 0 ELSE 1 END AS H_THANH,-1,'-1'
		FROM         dbo.PHIEU_BAO_TRI_CV_PHU_TRO
	WHERE     (MS_PHIEU_BAO_TRI = @MsPBT)
) PBT_CV
ORDER BY MO_TA_CV, TEN_BO_PHAN

-- Lay thong tin phieu bao tri nhan vien
SELECT HO_TEN, TEN_TO, NGAY, DEN_NGAY,SPHUT,  GHI_CHU FROM 
(
	SELECT     T5.HO + ' ' + T5.TEN AS HO_TEN, T4.TEN_TO, 
	CONVERT(DATETIME,CONVERT(NVARCHAR(10),T2.NGAY,101) + ' ' + CONVERT(NVARCHAR(10),T2.TU_GIO,108) ) AS NGAY, 	
	CONVERT(DATETIME,CONVERT(NVARCHAR(10),T2.DEN_NGAY,101) + ' ' + CONVERT(NVARCHAR(10),T2.DEN_GIO,108) ) AS DEN_NGAY, SO_GIO * 60 AS SPHUT,
	NULL AS GHI_CHU
	FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU AS T1 INNER JOIN
						  dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET AS T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI AND T1.MS_CV = T2.MS_CV AND T1.MS_BO_PHAN = T2.MS_BO_PHAN AND 
						  T1.MS_CONG_NHAN = T2.MS_CONG_NHAN INNER JOIN
						  dbo.CONG_NHAN AS T5 ON T1.MS_CONG_NHAN = T5.MS_CONG_NHAN INNER JOIN
						  dbo.[TO] AS T3 ON T5.MS_TO = T3.MS_TO1 INNER JOIN
						  dbo.TO_PHONG_BAN AS T4 ON T3.MS_TO = T4.MS_TO
	WHERE     (T1.MS_PHIEU_BAO_TRI = @MsPBT)
	UNION 
	SELECT     T2.HO + ' ' + T2.TEN AS HO_TEN, T4.TEN_TO, 
	CONVERT(DATETIME,CONVERT(NVARCHAR(10),T1.NGAY,101) + ' ' + CONVERT(NVARCHAR(10),T1.TU_GIO,108) ) AS NGAY, 	
	CONVERT(DATETIME,CONVERT(NVARCHAR(10),T1.DEN_NGAY,101) + ' ' + CONVERT(NVARCHAR(10),T1.DEN_GIO,108) ) AS DEN_NGAY, SO_GIO * 60 AS SPHUT, 	
	NULL AS GHI_CHU
	FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO AS T1 INNER JOIN
						  dbo.CONG_NHAN AS T2 ON T1.MS_CONG_NHAN = T2.MS_CONG_NHAN INNER JOIN
						  dbo.[TO] AS T3 ON T2.MS_TO = T3.MS_TO1 INNER JOIN
						  dbo.TO_PHONG_BAN AS T4 ON T3.MS_TO = T4.MS_TO
	WHERE     (T1.MS_PHIEU_BAO_TRI = @MsPBT)
) A
ORDER BY A.HO_TEN



-- Lay thong tin phieu bao tri phu tung + vat tu
DECLARE @PBT_PT TABLE (
	[MS_PT] [nvarchar](25) NULL,
	[TEN_PT] [nvarchar](500) NULL,
	[MS_PT_NCC] [nvarchar](25) NULL,
	[TEN_DVT] [nvarchar](20) NULL,
	[SL_KH] [float] NULL,
	[SL_TT] [float] NULL,
	[GHI_CHU] [nvarchar](500) NULL
)
DECLARE @TTPBT INT
SELECT @TTPBT = ISNULL(TINH_TRANG_PBT,0) FROM PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = @MsPBT

-- GET PHU TUNG
IF @TTPBT = 3
BEGIN
		INSERT INTO @PBT_PT ([MS_PT],[TEN_PT],[MS_PT_NCC],[TEN_DVT],[SL_KH],[SL_TT],GHI_CHU)
		SELECT     A.MS_PT, CONVERT(NVARCHAR(500),A.TEN_PT + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ' ' END +
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE '( ' + A.QUY_CACH END + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ' )' END) AS TEN_PT, A.MS_PT_NCC, 
			CASE @NNgu WHEN 0 THEN B.TEN_1 WHEN 1 THEN B.TEN_2 ELSE B.TEN_3 END AS TEN_DVT, 
			SUM(D.SL_KH) AS SL_KH, SUM(C.SL_TT) AS SL_TT, D.GHI_CHU
		FROM         dbo.IC_PHU_TUNG AS A INNER JOIN
							  dbo.DON_VI_TINH AS B ON A.DVT = B.DVT INNER JOIN
							  dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS C ON A.MS_PT = C.MS_PTTT INNER JOIN
							  dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG AS D ON C.MS_PHIEU_BAO_TRI = D.MS_PHIEU_BAO_TRI AND C.MS_CV = D.MS_CV AND C.MS_BO_PHAN = D.MS_BO_PHAN AND 
							  C.MS_PT = D.MS_PT INNER JOIN
							  dbo.LOAI_VT ON A.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT
		WHERE     (C.MS_PHIEU_BAO_TRI = @MsPBT) AND (dbo.LOAI_VT.VAT_TU = 0)
		GROUP BY A.MS_PT, A.TEN_PT, A.QUY_CACH, A.MS_PT_NCC, B.TEN_1,B.TEN_2, B.TEN_3,D.GHI_CHU
END
ELSE
BEGIN
	IF @TTPBT > 3
	BEGIN
		INSERT INTO @PBT_PT ([MS_PT],[TEN_PT],[MS_PT_NCC],[TEN_DVT],[SL_KH],[SL_TT],GHI_CHU)
		SELECT     A.MS_PT, CONVERT(NVARCHAR(500),A.TEN_PT + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ' ' END +
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE '( ' END + A.QUY_CACH + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ') ' END) AS TEN_PT,A.MS_PT_NCC, 
			CASE @NNgu WHEN 0 THEN B.TEN_1 WHEN 1 THEN B.TEN_2 ELSE B.TEN_3 END AS TEN_DVT, 
			SUM(D.SL_KH) AS SL_KH, SUM(C.SL_TT) AS SL_TT,D.GHI_CHU
		FROM         dbo.IC_PHU_TUNG AS A INNER JOIN
							  dbo.DON_VI_TINH AS B ON A.DVT = B.DVT INNER JOIN
							  dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS C ON A.MS_PT = C.MS_PTTT INNER JOIN
							  dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG AS D ON C.MS_PHIEU_BAO_TRI = D.MS_PHIEU_BAO_TRI AND C.MS_CV = D.MS_CV AND C.MS_BO_PHAN = D.MS_BO_PHAN AND 
							  C.MS_PT = D.MS_PT INNER JOIN
							  dbo.LOAI_VT ON A.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT 
		WHERE    (C.MS_PHIEU_BAO_TRI = @MsPBT) AND (dbo.LOAI_VT.VAT_TU = 0)
		GROUP BY A.MS_PT, A.TEN_PT, A.QUY_CACH, A.MS_PT_NCC, B.TEN_1,B.TEN_2, B.TEN_3,D.GHI_CHU
	END 
	ELSE
	BEGIN
		INSERT INTO @PBT_PT ([MS_PT],[TEN_PT],[MS_PT_NCC],[TEN_DVT],[SL_KH],[SL_TT],GHI_CHU)
		SELECT     A.MS_PT, CONVERT(NVARCHAR(500),B.TEN_PT + 
			CASE ISNULL(B.QUY_CACH,'') WHEN '' THEN '' ELSE ' ' END +
			CASE ISNULL(B.QUY_CACH,'') WHEN '' THEN '' ELSE '( ' END + B.QUY_CACH + 
			CASE ISNULL(B.QUY_CACH,'') WHEN '' THEN '' ELSE ') ' END) AS TEN_PT,B.MS_PT_NCC, 
			CASE @NNgu WHEN 0 THEN C.TEN_1 WHEN 1 THEN C.TEN_2 ELSE C.TEN_3 END AS TEN_DVT, 
			SUM(A.SL_KH) AS SL_KH, SUM(A.SL_TT) AS SL_TT,A.GHI_CHU
		FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG AS A INNER JOIN
							  dbo.IC_PHU_TUNG AS B ON A.MS_PT = B.MS_PT INNER JOIN
							  dbo.DON_VI_TINH AS C ON B.DVT = C.DVT INNER JOIN
							  dbo.LOAI_VT ON B.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT
		WHERE     (dbo.LOAI_VT.VAT_TU = 0) AND (A.MS_PHIEU_BAO_TRI = @MsPBT)
		GROUP BY A.MS_PT, B.TEN_PT, B.QUY_CACH, B.MS_PT_NCC,C.TEN_1, C.TEN_2, C.TEN_3,A.GHI_CHU
END
END

-- GET VAT TU
IF @TTPBT >=3 
BEGIN
		INSERT INTO @PBT_PT ([MS_PT],[TEN_PT],[MS_PT_NCC],[TEN_DVT],[SL_KH],[SL_TT],GHI_CHU)
		SELECT     A.MS_PT, CONVERT(NVARCHAR(500),A.TEN_PT + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ' ' END +
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE '( ' END + A.QUY_CACH + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ') ' END) AS TEN_PT, A.MS_PT_NCC, 
			CASE @NNgu WHEN 0 THEN E.TEN_1 WHEN 1 THEN E.TEN_2 ELSE E.TEN_3 END AS TEN_DVT, 
			SUM(F.SL_KH) AS SL_KH, SUM(G.SL_VT) AS SL_TT	, F.GHI_CHU
		FROM         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS H INNER JOIN
				dbo.IC_DON_HANG_NHAP_VAT_TU AS K ON H.MS_DH_NHAP_PT = K.MS_DH_NHAP_PT AND H.MS_PT = K.MS_PT AND H.ID = K.ID INNER JOIN
				dbo.IC_PHU_TUNG AS A INNER JOIN
				dbo.IC_DON_HANG_XUAT AS B INNER JOIN
				dbo.IC_DON_HANG_XUAT_VAT_TU AS C ON B.MS_DH_XUAT_PT = C.MS_DH_XUAT_PT ON A.MS_PT = C.MS_PT INNER JOIN
				dbo.LOAI_VT AS D ON A.MS_LOAI_VT = D.MS_LOAI_VT INNER JOIN
				dbo.DON_VI_TINH AS E ON A.DVT = E.DVT INNER JOIN
				dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS G ON C.MS_DH_XUAT_PT = G.MS_DH_XUAT_PT AND C.MS_PT = G.MS_PT ON H.MS_DH_NHAP_PT = G.MS_DH_NHAP_PT AND 
				H.MS_PT = G.MS_PT AND H.MS_VI_TRI = G.MS_VI_TRI AND H.ID = G.ID_XUAT LEFT OUTER JOIN
				dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG AS F ON C.MS_PT = F.MS_PT AND B.MS_PHIEU_BAO_TRI = F.MS_PHIEU_BAO_TRI LEFT OUTER JOIN
				dbo.HANG_SAN_XUAT AS X ON A.MS_HSX = X.MS_HSX 
		WHERE     (B.MS_PHIEU_BAO_TRI = @MsPBT) AND (D.VAT_TU = 1)
		GROUP BY A.MS_PT, A.TEN_PT, A.QUY_CACH, A.MS_PT_NCC, E.TEN_1,E.TEN_2, E.TEN_3, F.GHI_CHU
	
END
ELSE 
BEGIN
	
	INSERT INTO @PBT_PT ([MS_PT],[TEN_PT],[MS_PT_NCC],[TEN_DVT],[SL_KH],[SL_TT],GHI_CHU)
	SELECT     A.MS_PT, CONVERT(NVARCHAR(500),A.TEN_PT + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ' ' END +
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE '( ' END + A.QUY_CACH + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ') ' END) AS TEN_PT,A.MS_PT_NCC, 
			CASE @NNgu WHEN 0 THEN E.TEN_1 WHEN 1 THEN E.TEN_2 ELSE E.TEN_3 END AS TEN_DVT, 
			SUM(F.SL_KH) AS SL_KH, SUM(C.SO_LUONG_THUC_XUAT) AS SL_TT, F.GHI_CHU
	FROM         dbo.IC_PHU_TUNG AS A INNER JOIN
						  dbo.IC_DON_HANG_XUAT AS B INNER JOIN
						  dbo.IC_DON_HANG_XUAT_VAT_TU AS C ON B.MS_DH_XUAT_PT = C.MS_DH_XUAT_PT ON A.MS_PT = C.MS_PT INNER JOIN
						  dbo.LOAI_VT AS D ON A.MS_LOAI_VT = D.MS_LOAI_VT INNER JOIN
						  dbo.DON_VI_TINH AS E ON A.DVT = E.DVT LEFT OUTER JOIN
						  dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG AS F ON C.MS_PT = F.MS_PT AND B.MS_PHIEU_BAO_TRI = F.MS_PHIEU_BAO_TRI LEFT OUTER JOIN
					dbo.HANG_SAN_XUAT AS X ON A.MS_HSX = X.MS_HSX 
	WHERE     (D.VAT_TU = 1) AND (B.MS_PHIEU_BAO_TRI = @MsPBT)
	GROUP BY A.MS_PT, A.TEN_PT, A.QUY_CACH, A.MS_PT_NCC, E.TEN_1,E.TEN_2, E.TEN_3, F.GHI_CHU
	UNION
	SELECT     A.MS_PT, CONVERT(NVARCHAR(500),A.TEN_PT + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ' ' END +
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE '( ' END + A.QUY_CACH + 
			CASE ISNULL(A.QUY_CACH,'') WHEN '' THEN '' ELSE ') ' END) AS TEN_PT,A.MS_PT_NCC, 
			CASE @NNgu WHEN 0 THEN D.TEN_1 WHEN 1 THEN D.TEN_2 ELSE D.TEN_3 END AS TEN_DVT, 
			SUM(B.SL_KH) AS SL_KH, SUM(B.SL_TT) AS SL_TT,B.GHI_CHU
	FROM         dbo.IC_PHU_TUNG AS A INNER JOIN
						  dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG AS B ON A.MS_PT = B.MS_PT INNER JOIN
						  dbo.LOAI_VT AS C ON C.MS_LOAI_VT = A.MS_LOAI_VT INNER JOIN
						  dbo.DON_VI_TINH AS D ON A.DVT = D.DVT LEFT OUTER JOIN
					dbo.HANG_SAN_XUAT AS X ON A.MS_HSX = X.MS_HSX 
	WHERE     (C.VAT_TU = 1) AND (B.MS_PHIEU_BAO_TRI = @MsPBT) AND (B.MS_PT NOT IN
							  (SELECT Y.MS_PT FROM dbo.IC_DON_HANG_XUAT AS X INNER JOIN dbo.IC_DON_HANG_XUAT_VAT_TU AS Y ON 
								X.MS_DH_XUAT_PT = Y.MS_DH_XUAT_PT WHERE (X.MS_PHIEU_BAO_TRI = @MsPBT)))
	GROUP BY A.MS_PT, A.TEN_PT, A.QUY_CACH, A.MS_PT_NCC, D.TEN_1,D.TEN_2,D.TEN_3,B.GHI_CHU	
END
SELECT MS_PT,MS_PT_NCC,TEN_PT,SL_KH,SL_TT,TEN_DVT,GHI_CHU FROM @PBT_PT ORDER BY [MS_PT],[TEN_PT]

-- Lay thong tin phieu bao tri Phan hoi thong tin
SELECT T1.*,T2.TEN_DV_DO FROM PHIEU_BAO_TRI_TINH_TRANG T1 INNER JOIN DON_VI_DO T2 ON T2.MS_DV_DO = T1.MS_DV_DO
	WHERE MS_PHIEU_BAO_TRI = @MsPBT 