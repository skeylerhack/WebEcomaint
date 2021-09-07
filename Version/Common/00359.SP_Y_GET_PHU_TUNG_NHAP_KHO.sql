
-- exec SP_Y_GET_PHU_TUNG_NHAP_KHO 17,3,'DX-1405-0034'


ALTER PROCEDURE [dbo].[SP_Y_GET_PHU_TUNG_NHAP_KHO]
@MS_KHO INT , 
@MS_DANG_NHAP INT,
@MS_DON_DAT_HANG NVARCHAR (50)
AS

BEGIN
IF (@MS_DANG_NHAP = 6 ) 
BEGIN
	SELECT DISTINCT 
                      CONVERT(BIT, 0) AS CHON, dbo.IC_PHU_TUNG.MS_PT, dbo.LOAI_VT.TEN_LOAI_VT_TV AS TEN_LOAI_VT, dbo.IC_PHU_TUNG.MS_PT_NCC AS PART_NO, 
                      dbo.IC_PHU_TUNG.TEN_PT, dbo.IC_PHU_TUNG.QUY_CACH, dbo.DON_VI_TINH.TEN_1 AS DVT, ISNULL(X.SLCL, 0) AS TON_KHO, 
                      ISNULL(dbo.IC_PHU_TUNG.TON_TOI_THIEU, 0) AS TON_MIN, ISNULL(dbo.IC_PHU_TUNG.TON_KHO_MAX, 0) AS TON_MAX, CONVERT(NUMERIC(18, 2), X.SLCL) 
                      AS SL_DAT_HANG,
                          (SELECT     TOP (1) ISNULL(dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA, 0) AS DON_GIA
                            FROM          dbo.IC_DON_HANG_NHAP INNER JOIN
                                                   dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT
                            WHERE      (dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT = dbo.IC_PHU_TUNG.MS_PT) AND (dbo.IC_DON_HANG_NHAP.LOCK = 1)
                            ORDER BY dbo.IC_DON_HANG_NHAP.NGAY DESC) AS DON_GIA,
                          (SELECT     TOP (1) IC_DON_HANG_NHAP_VAT_TU_2.NGOAI_TE
                            FROM          dbo.IC_DON_HANG_NHAP AS IC_DON_HANG_NHAP_2 INNER JOIN
                                                   dbo.IC_DON_HANG_NHAP_VAT_TU AS IC_DON_HANG_NHAP_VAT_TU_2 ON 
                                                   IC_DON_HANG_NHAP_2.MS_DH_NHAP_PT = IC_DON_HANG_NHAP_VAT_TU_2.MS_DH_NHAP_PT
                            WHERE      (IC_DON_HANG_NHAP_VAT_TU_2.MS_PT = dbo.IC_PHU_TUNG.MS_PT) AND (IC_DON_HANG_NHAP_2.LOCK = 1)
                            ORDER BY IC_DON_HANG_NHAP_2.NGAY DESC) AS NGOAI_TE,
                             dbo.fnGet_VI_TRI_PT_THEO_KHO(dbo.IC_PHU_TUNG.MS_PT, IC_PHU_TUNG.THEO_KHO, @MS_KHO) as MS_VI_TRI
                             , CONVERT(NVARCHAR(50), X.MS_DH_XUAT_PT) 
                      AS MS_CHI_TIET_DH, dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.MS_DH_NHAP_PT, dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.ID_XUAT, CONVERT(FLOAT,0) AS THUE_VAT
	FROM         dbo.IC_PHU_TUNG INNER JOIN
                      dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT INNER JOIN
                      dbo.LOAI_VT ON dbo.IC_PHU_TUNG.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT INNER JOIN
                          (SELECT DISTINCT A_1.MS_DH_XUAT_PT, A_1.MS_PT, ISNULL(A_1.SLX, 0) - (ISNULL(B.SLBT, 0) + ISNULL(C.SLN, 0)) AS SLCL
                            FROM          (SELECT     MS_DH_XUAT_PT, MS_PT, SUM(SO_LUONG_CTU) AS SLX
                                                    FROM          dbo.IC_DON_HANG_XUAT_VAT_TU
                                                    GROUP BY MS_DH_XUAT_PT, MS_PT) AS A_1 LEFT OUTER JOIN
                                                       (SELECT     MS_DH_XUAT_PT, MS_PT, ISNULL(SUM(SL_TT), 0) AS SLBT
                                                         FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO
                                                         GROUP BY MS_DH_XUAT_PT, MS_PT) AS B ON A_1.MS_DH_XUAT_PT = B.MS_DH_XUAT_PT AND A_1.MS_PT = B.MS_PT LEFT OUTER JOIN
                                                       (SELECT     IC_DON_HANG_NHAP_1.MS_DHX, IC_DON_HANG_NHAP_VAT_TU_1.MS_PT, SUM(IC_DON_HANG_NHAP_VAT_TU_1.SL_THUC_NHAP) 
                                                                                AS SLN
                                                         FROM          dbo.IC_DON_HANG_NHAP AS IC_DON_HANG_NHAP_1 INNER JOIN
                                                                                dbo.IC_DON_HANG_NHAP_VAT_TU AS IC_DON_HANG_NHAP_VAT_TU_1 ON 
                                                                                IC_DON_HANG_NHAP_1.MS_DH_NHAP_PT = IC_DON_HANG_NHAP_VAT_TU_1.MS_DH_NHAP_PT
                                                         WHERE      (ISNULL(IC_DON_HANG_NHAP_1.MS_DHX, N'') <> '')
                                                         GROUP BY IC_DON_HANG_NHAP_1.MS_DHX, IC_DON_HANG_NHAP_VAT_TU_1.MS_PT) AS C ON A_1.MS_DH_XUAT_PT = C.MS_DHX AND 
                                                   A_1.MS_PT = C.MS_PT
                            WHERE      (ISNULL(A_1.SLX, 0) - (ISNULL(B.SLBT, 0) + ISNULL(C.SLN, 0)) > 0) AND (A_1.MS_DH_XUAT_PT = @MS_DON_DAT_HANG)) AS X ON 
                      dbo.IC_PHU_TUNG.MS_PT = X.MS_PT INNER JOIN
                      dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET ON X.MS_DH_XUAT_PT = dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.MS_DH_XUAT_PT AND 
                      X.MS_PT = dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.MS_PT LEFT OUTER JOIN
                          (SELECT     MS_PT, SUM(SL_VT) AS TON_KHO
                            FROM          dbo.VI_TRI_KHO_VAT_TU
                            GROUP BY MS_PT) AS TMP1 ON dbo.IC_PHU_TUNG.MS_PT = TMP1.MS_PT
	WHERE IC_PHU_TUNG.ACTIVE_PT = 1                            
END
ELSE
BEGIN
	IF (@MS_DANG_NHAP <> 3 ) 
	BEGIN
		SELECT DISTINCT CONVERT (BIT , 0 ) AS CHON,dbo.IC_PHU_TUNG.MS_PT,dbo.LOAI_VT.TEN_LOAI_VT_TV AS TEN_LOAI_VT,
				dbo.IC_PHU_TUNG.MS_PT_NCC AS PART_NO,dbo.IC_PHU_TUNG.TEN_PT,dbo.IC_PHU_TUNG.QUY_CACH,
				dbo.DON_VI_TINH.TEN_1 AS DVT,ISNULL(TMP1.TON_KHO,0) AS TON_KHO,ISNULL(dbo.IC_PHU_TUNG.TON_TOI_THIEU,0) AS TON_MIN , 
				ISNULL(dbo.IC_PHU_TUNG.TON_KHO_MAX,0) AS TON_MAX, CONVERT (NUMERIC (18,2),0) AS SL_DAT_HANG, 
			(SELECT     TOP 1 ISNULL(dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA,0) AS DON_GIA 
				FROM         dbo.IC_DON_HANG_NHAP INNER JOIN
									  dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT
				WHERE dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT=IC_PHU_TUNG.MS_PT AND dbo.IC_DON_HANG_NHAP.LOCK=1 
				ORDER BY dbo.IC_DON_HANG_NHAP.NGAY DESC
				) AS DON_GIA,
				(SELECT     TOP 1 dbo.IC_DON_HANG_NHAP_VAT_TU.NGOAI_TE
				FROM         dbo.IC_DON_HANG_NHAP INNER JOIN
									  dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT
				WHERE dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT=IC_PHU_TUNG.MS_PT AND dbo.IC_DON_HANG_NHAP.LOCK=1 
				ORDER BY dbo.IC_DON_HANG_NHAP.NGAY DESC
				) AS NGOAI_TE,
				dbo.fnGet_VI_TRI_PT_THEO_KHO(dbo.IC_PHU_TUNG.MS_PT, IC_PHU_TUNG.THEO_KHO, @MS_KHO) as MS_VI_TRI
				, CONVERT(NVARCHAR(50),NULL) AS MS_CHI_TIET_DH, CONVERT(FLOAT,0) AS THUE_VAT
		FROM dbo.IC_PHU_TUNG INNER JOIN
				dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT INNER JOIN
				dbo.LOAI_VT ON dbo.IC_PHU_TUNG.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT LEFT OUTER JOIN 
			(SELECT MS_PT ,SUM( SL_VT) AS TON_KHO
			FROM dbo.VI_TRI_KHO_VAT_TU GROUP BY MS_PT) TMP1 ON dbo.IC_PHU_TUNG.MS_PT = TMP1.MS_PT
		WHERE IC_PHU_TUNG.ACTIVE_PT = 1     			
	END
	ELSE 
	BEGIN 
	DECLARE @DE_XUAT BIT 
	SELECT TOP 1 @DE_XUAT = DDH_DXMH FROM dbo.THONG_TIN_CHUNG
	--select @DE_XUAT
	IF (@DE_XUAT = 1 ) 
	BEGIN 
			SELECT DISTINCT CONVERT (BIT , 0 ) AS CHON,dbo.IC_PHU_TUNG.MS_PT,dbo.LOAI_VT.TEN_LOAI_VT_TV AS TEN_LOAI_VT,
				dbo.IC_PHU_TUNG.MS_PT_NCC AS PART_NO,dbo.IC_PHU_TUNG.TEN_PT,dbo.IC_PHU_TUNG.QUY_CACH,
				dbo.DON_VI_TINH.TEN_1 AS DVT,ISNULL(TMP1.TON_KHO,0) AS TON_KHO,ISNULL(dbo.IC_PHU_TUNG.TON_TOI_THIEU,0) AS TON_MIN , 
				ISNULL(dbo.IC_PHU_TUNG.TON_KHO_MAX,0) AS TON_MAX, ISNULL(TMP2.SL_DAT_HANG,0) AS SL_DAT_HANG,
				ISNULL(TMP2.DON_GIA,0) AS DON_GIA,TMP2.NGOAI_TE,
				dbo.fnGet_VI_TRI_PT_THEO_KHO(dbo.IC_PHU_TUNG.MS_PT, IC_PHU_TUNG.THEO_KHO, @MS_KHO) as MS_VI_TRI
				,MS_CHI_TIET_DH,THUE_VAT
			FROM dbo.IC_PHU_TUNG INNER JOIN
				dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT INNER JOIN
				dbo.LOAI_VT ON dbo.IC_PHU_TUNG.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT LEFT OUTER JOIN 
				(SELECT MS_PT ,SUM( SL_VT) AS TON_KHO
				FROM dbo.VI_TRI_KHO_VAT_TU
				GROUP BY MS_PT) TMP1 ON dbo.IC_PHU_TUNG.MS_PT = TMP1.MS_PT INNER JOIN
				(
				SELECT T1.MS_PT , (T1.SL_DAT_HANG - CASE WHEN SUM( dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP) IS NULL 
				THEN 0 ELSE SUM(dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP) END ) AS SL_DAT_HANG , 
				T1.DON_GIA, T1.NGOAI_TE ,T1.MS_CHI_TIET_DH, THUE_VAT
				FROM 
				(SELECT  dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG,dbo.DON_DAT_HANG_CHI_TIET.MS_PT, 
				SUM(dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG ) AS SL_DAT_HANG,
				SUM(dbo.DON_DAT_HANG_CHI_TIET.DON_GIA*dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG)/
				SUM(dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG ) AS DON_GIA,
				MAX(dbo.DON_DAT_HANG_CHI_TIET.NGOAI_TE)AS NGOAI_TE,MS_CHI_TIET_DH, 
				MAX(dbo.DON_DAT_HANG_CHI_TIET.THUE_VAT)AS THUE_VAT
				FROM         dbo.DON_DAT_HANG INNER JOIN
				dbo.DON_DAT_HANG_CHI_TIET ON dbo.DON_DAT_HANG.MS_DON_DAT_HANG = dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG 
				WHERE dbo.DON_DAT_HANG.TRANG_THAI = 3 AND dbo.DON_DAT_HANG.MS_DON_DAT_HANG = @MS_DON_DAT_HANG
				GROUP BY dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG,dbo.DON_DAT_HANG_CHI_TIET.MS_PT,MS_CHI_TIET_DH
				) T1 LEFT OUTER JOIN dbo.IC_DON_HANG_NHAP ON T1.MS_DON_DAT_HANG = dbo.IC_DON_HANG_NHAP.MS_DDH LEFT OUTER JOIN 
				dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT 
				AND T1.MS_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT AND T1.MS_CHI_TIET_DH = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_CHI_TIET_DH 
							GROUP BY T1.MS_PT, T1.DON_GIA, T1.NGOAI_TE ,T1.SL_DAT_HANG,T1.MS_CHI_TIET_DH, THUE_VAT
				HAVING (T1.SL_DAT_HANG - CASE WHEN SUM( dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP) IS NULL THEN 0 ELSE SUM(dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP) END ) > 0
				) TMP2 
				ON dbo.IC_PHU_TUNG.MS_PT = TMP2.MS_PT 
			WHERE TMP2.SL_DAT_HANG > 0 AND IC_PHU_TUNG.ACTIVE_PT = 1     
		END 
	ELSE 
	BEGIN
		SELECT DISTINCT CONVERT (BIT , 0 ) AS CHON,dbo.IC_PHU_TUNG.MS_PT,dbo.LOAI_VT.TEN_LOAI_VT_TV AS TEN_LOAI_VT,
					dbo.IC_PHU_TUNG.MS_PT_NCC AS PART_NO,dbo.IC_PHU_TUNG.TEN_PT,dbo.IC_PHU_TUNG.QUY_CACH,
					dbo.DON_VI_TINH.TEN_1 AS DVT,TMP1.TON_KHO,dbo.IC_PHU_TUNG.TON_TOI_THIEU AS TON_MIN , 
					dbo.IC_PHU_TUNG.TON_KHO_MAX AS TON_MAX, TMP2.SL_DAT_HANG,TMP2.DON_GIA, TMP2.NGOAI_TE,
					dbo.fnGet_VI_TRI_PT_THEO_KHO(dbo.IC_PHU_TUNG.MS_PT, IC_PHU_TUNG.THEO_KHO, @MS_KHO) as MS_VI_TRI
					,CONVERT(NVARCHAR(50),MS_DE_XUAT) AS MS_CHI_TIET_DH, TMP2.THUE_VAT
		FROM dbo.IC_PHU_TUNG INNER JOIN
				dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT INNER JOIN
				dbo.LOAI_VT ON dbo.IC_PHU_TUNG.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT LEFT OUTER JOIN 
		(SELECT MS_PT ,SUM( SL_VT) AS TON_KHO
		FROM dbo.VI_TRI_KHO_VAT_TU
		GROUP BY MS_PT) TMP1 ON dbo.IC_PHU_TUNG.MS_PT = TMP1.MS_PT INNER JOIN 
		(SELECT T1.MS_PT , (T1.SL_DE_XUAT - CASE WHEN SUM(T2.SL_THUC_NHAP) IS NULL THEN 0 ELSE 
						SUM(T2.SL_THUC_NHAP) END ) AS SL_DAT_HANG,T1.DON_GIA,T1.NGOAI_TE,T1.MS_DE_XUAT,MAX(T1.THUE_VAT) AS THUE_VAT
			FROM 		
			(SELECT     dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT, dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT, SUM(dbo.DE_XUAT_MUA_HANG_CHI_TIET.SL_DA_DUYET) AS SL_DE_XUAT, 
								  dbo.DE_XUAT_MUA_HANG_CHI_TIET.DON_GIA, CONVERT(NVARCHAR(50), NULL) AS NGOAI_TE, THUE_VAT
			FROM         dbo.DE_XUAT_MUA_HANG INNER JOIN
								  dbo.DE_XUAT_MUA_HANG_CHI_TIET ON dbo.DE_XUAT_MUA_HANG.MS_DE_XUAT = dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT
			WHERE     (dbo.DE_XUAT_MUA_HANG.TRANG_THAI = 3) AND (dbo.DE_XUAT_MUA_HANG.MS_DE_XUAT = @MS_DON_DAT_HANG)
			GROUP BY dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT, dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT, dbo.DE_XUAT_MUA_HANG_CHI_TIET.DON_GIA, THUE_VAT
			) T1 LEFT JOIN
			(		
			SELECT     dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT, SUM(dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP) AS SL_THUC_NHAP
			FROM         dbo.IC_DON_HANG_NHAP INNER JOIN
								  dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT
			WHERE     (dbo.IC_DON_HANG_NHAP.MS_DANG_NHAP = 3) AND (dbo.IC_DON_HANG_NHAP.MS_DDH = @MS_DON_DAT_HANG)
			GROUP BY dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT, dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP
			) T2 ON T1.MS_PT = T2.MS_PT
			WHERE (T1.SL_DE_XUAT - CASE WHEN T2.SL_THUC_NHAP IS NULL THEN 0 ELSE T2.SL_THUC_NHAP END ) > 0 			
			GROUP BY T1.MS_PT, T1.DON_GIA, T1.NGOAI_TE ,T1.SL_DE_XUAT ,T1.MS_DE_XUAT 

	) TMP2
		ON dbo.IC_PHU_TUNG.MS_PT = TMP2.MS_PT 
		WHERE TMP2.SL_DAT_HANG >0 AND IC_PHU_TUNG.ACTIVE_PT = 1
		END
	END 
END 	

END
