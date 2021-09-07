
--SELECT * FROM dbo.USERS
--WO-202012001391
-- SELECT * FROM NHA_XUONG
-- EXEC GetPhieuBaoTriBHNT 3, 'trungnv', '06/01/2021' , '06/30/2021','-1',-1,'-1','-1'
ALTER PROC [dbo].[GetPhieuBaoTriBHNT]
    @LOAI INT ,
    @UserName NVARCHAR(50) ,
    @TNGAY DATETIME ,
    @DNGAY DATETIME ,
    @MS_N_XUONG NVARCHAR(50) ,
    @MS_HE_THONG AS INT ,
    @MS_LOAI_MAY NVARCHAR(20) ,
    @MS_MAY NVARCHAR(30)
AS -- @LOAI = 1 Ban Hanh
-- @LOAI = 2 Hoan Thanh
-- @LOAI = 3 Nghiem Thu
-- @LOAI = 4 Lock

--Lay nha xuong theo nha xuong cha va user
    SELECT DISTINCT
            MS_MAY
    INTO    #MAY_USER
    FROM    dbo.MGetMayUserNgay(@DNGAY, @UserName, @MS_N_XUONG, @MS_HE_THONG,
                                -1, @MS_LOAI_MAY, '-1', @MS_MAY, 0)

    SELECT  T1.*
    INTO    #PBT
    FROM    dbo.PHIEU_BAO_TRI T1
            INNER JOIN #MAY_USER T2 ON T2.MS_MAY = T1.MS_MAY
    WHERE   CONVERT(DATE, T1.NGAY_BD_KH) BETWEEN @TNGAY
                                         AND     @DNGAY 

-- BAN HANH LAY NHUNG PHIEU DANG NGHIEM THU --> 1
    IF @LOAI = 1
	BEGIN
        SELECT DISTINCT
                CONVERT (BIT, 0) AS CHON, T4.Ten_N_XUONG, T1.MS_PHIEU_BAO_TRI,
                T1.LY_DO_BT, T1.MS_MAY, T2.TEN_LOAI_BT, T1.NGAY_LAP,
                T3.TEN_UU_TIEN, T1.NGAY_BD_KH, T1.MS_LOAI_BT, T2.MS_HT_BT,
                T10.PHONG_NGUA
        FROM    #PBT AS T1
                INNER JOIN dbo.LOAI_BAO_TRI AS T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT
                INNER JOIN HINH_THUC_BAO_TRI T10 ON T10.MS_HT_BT = T2.MS_HT_BT
                INNER JOIN dbo.MUC_UU_TIEN AS T3 ON T1.MS_UU_TIEN = T3.MS_UU_TIEN
                INNER JOIN dbo.MAY_NHA_XUONG_NGAY_MAX AS T4 ON T1.MS_MAY = T4.MS_MAY
                INNER JOIN dbo.MAY_HE_THONG_NGAY_MAX AS T6 ON T1.MS_MAY = T6.MS_MAY
                INNER JOIN #MAY_USER T9 ON T1.MS_MAY = T9.MS_MAY
        WHERE   ( T1.TINH_TRANG_PBT = 1 )
                AND ( CONVERT(DATE, T1.NGAY_BD_KH) BETWEEN @TNGAY
                                                   AND     @DNGAY )
        ORDER BY T1.MS_PHIEU_BAO_TRI DESC
	END
-- HOAN THANH LAY NHUNG PHIEU BAN HANH --> 2
    IF @LOAI = 2
	BEGIN
        SELECT DISTINCT
                CHON, Ten_N_XUONG, MS_PHIEU_BAO_TRI, LY_DO_BT, MS_MAY,
                TEN_LOAI_BT, NGAY_LAP, TEN_UU_TIEN, NGAY_BD_KH, MS_LOAI_BT,
                MS_HT_BT, PHONG_NGUA
        FROM    ( SELECT DISTINCT
                            CONVERT (BIT, 0) AS CHON, T4.Ten_N_XUONG,
                            T1.MS_PHIEU_BAO_TRI, T1.LY_DO_BT, T1.MS_MAY,
                            T2.TEN_LOAI_BT, T1.NGAY_LAP, T3.TEN_UU_TIEN,
                            T1.NGAY_BD_KH, T1.MS_LOAI_BT, T2.MS_HT_BT,
                            dbo.KiemNSHoanThanhPBT(T1.MS_PHIEU_BAO_TRI) AS HT,
                            T10.PHONG_NGUA
                  FROM      #PBT AS T1
                            INNER JOIN dbo.LOAI_BAO_TRI AS T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT
                            INNER JOIN HINH_THUC_BAO_TRI T10 ON T10.MS_HT_BT = T2.MS_HT_BT
                            INNER JOIN dbo.MUC_UU_TIEN AS T3 ON T1.MS_UU_TIEN = T3.MS_UU_TIEN
                            INNER JOIN dbo.MAY_NHA_XUONG_NGAY_MAX AS T4 ON T1.MS_MAY = T4.MS_MAY
                            INNER JOIN dbo.MAY_HE_THONG_NGAY_MAX AS T6 ON T1.MS_MAY = T6.MS_MAY
                            INNER JOIN #MAY_USER T9 ON T1.MS_MAY = T9.MS_MAY
                  WHERE     ( T1.TINH_TRANG_PBT = 2 )
                            AND ( CONVERT(DATE, T1.NGAY_BD_KH) BETWEEN @TNGAY
                                                              AND
                                                              @DNGAY ) 
--Kiem not in trong PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET	
                            AND ( MS_PHIEU_BAO_TRI NOT IN (
                                  SELECT DISTINCT
                                            T1.MS_PHIEU_BAO_TRI
                                  FROM      dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET T1
                                            INNER JOIN dbo.PHIEU_BAO_TRI AS T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
                                  WHERE     ( ISNULL(CONVERT(NVARCHAR, SO_GIO),
                                                     '') = '' )
                                            AND ( T2.TINH_TRANG_PBT = 2 ) ) )
--Kiem not in trong PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO
                            AND ( MS_PHIEU_BAO_TRI NOT IN (
                                  SELECT DISTINCT
                                            T1.MS_PHIEU_BAO_TRI
                                  FROM      dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO T1
                                            INNER JOIN dbo.PHIEU_BAO_TRI AS T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
                                  WHERE     ( ISNULL(CONVERT(NVARCHAR, SO_GIO),
                                                     '') = '' )
                                            AND ( T2.TINH_TRANG_PBT = 2 ) ) )
                ) T1
        WHERE   HT = 1
        ORDER BY T1.MS_PHIEU_BAO_TRI DESC
	END
--NGHIEM THU LAY NHUNG PHIEU HOAN THANH --> 3
    IF @LOAI = 3
	BEGIN

	SELECT   DISTINCT  T3.MS_PHIEU_BAO_TRI,  T3.MS_DH_XUAT_PT, T2.ID_GOC, T2.MS_DH_NHAP_PT_GOC, T4.MS_PT AS MS_PT_GOC, SUM(T4.SL_VT) AS SL_TRA  INTO #TMP_TRA
FROM            dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT INNER JOIN
                         dbo.IC_DON_HANG_XUAT AS T3 ON T1.MS_DHX = T3.MS_DH_XUAT_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T4 ON T2.MS_DH_NHAP_PT = T4.MS_DH_NHAP_PT AND T2.MS_PT = T4.MS_PT AND T2.ID = T4.ID 
WHERE        (T1.MS_DANG_NHAP = 6)
GROUP BY T3.MS_PHIEU_BAO_TRI,  T3.MS_DH_XUAT_PT, T2.ID_GOC, T2.MS_DH_NHAP_PT_GOC, T4.MS_PT 

        SELECT DISTINCT
                CHON, Ten_N_XUONG, T1.MS_PHIEU_BAO_TRI, T1.LY_DO_BT, T1.MS_MAY,
                TEN_LOAI_BT, T1.NGAY_LAP, TEN_UU_TIEN, T1.NGAY_BD_KH,
                T1.MS_LOAI_BT, MS_HT_BT,T1.PHONG_NGUA
        FROM    ( SELECT DISTINCT
                            CONVERT (BIT, 0) AS CHON, T4.Ten_N_XUONG,
                            T1.MS_PHIEU_BAO_TRI, T1.LY_DO_BT, T1.MS_MAY,
                            T2.TEN_LOAI_BT, T1.NGAY_LAP, T3.TEN_UU_TIEN,
                            T1.NGAY_BD_KH, T1.MS_LOAI_BT, T2.MS_HT_BT,
                            dbo.KiemNSHoanThanhPBT(T1.MS_PHIEU_BAO_TRI) AS HT,
                            T10.PHONG_NGUA
                  FROM      #PBT AS T1
                            INNER JOIN dbo.LOAI_BAO_TRI AS T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT
                            INNER JOIN HINH_THUC_BAO_TRI T10 ON T10.MS_HT_BT = T2.MS_HT_BT
                            INNER JOIN dbo.MUC_UU_TIEN AS T3 ON T1.MS_UU_TIEN = T3.MS_UU_TIEN
                            INNER JOIN dbo.MAY_NHA_XUONG_NGAY_MAX AS T4 ON T1.MS_MAY = T4.MS_MAY
                            INNER JOIN dbo.MAY_HE_THONG_NGAY_MAX AS T6 ON T1.MS_MAY = T6.MS_MAY
                            INNER JOIN #MAY_USER T9 ON T1.MS_MAY = T9.MS_MAY
                  WHERE     ( T1.TINH_TRANG_PBT = 3 )
                            AND ( CONVERT(DATE, T1.NGAY_BD_KH) BETWEEN @TNGAY
                                                              AND
                                                              @DNGAY )
                            AND ( NOT EXISTS ( SELECT   *
                                               FROM     ( SELECT DISTINCT
                                                              T1.MS_PHIEU_BAO_TRI
                                                          FROM
                                                              dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET T1
                                                              INNER JOIN dbo.PHIEU_BAO_TRI
                                                              AS T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
                                                          WHERE
                                                              ( ISNULL(CONVERT(NVARCHAR, SO_GIO),
                                                              '') = '' )
                                                              AND ( T2.TINH_TRANG_PBT = 3 )
                                                          UNION
                                                          SELECT DISTINCT
                                                              T1.MS_PHIEU_BAO_TRI
                                                          FROM
                                                              dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO T1
                                                              INNER JOIN dbo.PHIEU_BAO_TRI
                                                              AS T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
                                                          WHERE
                                                              ( ISNULL(CONVERT(NVARCHAR, SO_GIO),
                                                              '') = '' )
                                                              AND ( T2.TINH_TRANG_PBT = 3 ) 
	---- LOAI BO CHUA NHAP SO LUONG THUC TE SU DUNG
	--	UNION 	SELECT DISTINCT T1.MS_PHIEU_BAO_TRI 
	--	FROM   PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET T1 INNER JOIN #PBT T2 ON T2.MS_PHIEU_BAO_TRI = T1.MS_PHIEU_BAO_TRI
	--	WHERE  ( ISNULL(SL_TT, 0) = 0 )        AND ( ISNULL(GHI_CHU, N'') = N'' )  

 --EXEC GetPhieuBaoTriBHNT 3, 'trungnv', '01/01/2021' , '01/30/2021','-1',-1,'-1','-1'
	-- loai bo cac PBT co cong viec khong thuc hien
                                                          UNION
                                                          SELECT DISTINCT
                                                              MS_PHIEU_BAO_TRI
                                                          FROM
                                                              PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET T1
                                                          WHERE
                                                              ( ( T1.SL_TT IS NULL
                                                              OR T1.SL_TT = 0
                                                              )
                                                              AND ISNULL(T1.GHI_CHU,
                                                              '') IS NULL
                                                              )
	-- loai bo cac phieu co so luong khong can voi phieu xuat
                                                          UNION
                                                          SELECT DISTINCT T5.MS_PHIEU_BAO_TRI
FROM            dbo.IC_DON_HANG_XUAT AS T2 INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T3 ON T2.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT INNER JOIN
                         dbo.IC_PHU_TUNG AS T6 ON T3.MS_PT = T6.MS_PT INNER JOIN
                         dbo.LOAI_VT AS T7 ON T6.MS_LOAI_VT = T7.MS_LOAI_VT LEFT OUTER JOIN
                         dbo.CAU_TRUC_THIET_BI AS T4 INNER JOIN
                         dbo.PHIEU_BAO_TRI AS T5 ON T4.MS_MAY = T5.MS_MAY INNER JOIN
                             (SELECT        MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN, MS_PT, MS_DH_XUAT_PT, MS_DH_NHAP_PT, ID, MS_PTTT, SUM(SL_TT) AS SL_TT
                               FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS T2
                               GROUP BY ID, MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN, MS_PT, MS_DH_XUAT_PT, MS_DH_NHAP_PT, MS_PTTT) AS T1 ON T5.MS_PHIEU_BAO_TRI = T1.MS_PHIEU_BAO_TRI AND 
                         T4.MS_BO_PHAN = T1.MS_BO_PHAN ON T3.ID_XUAT = T1.ID AND T2.MS_PHIEU_BAO_TRI = T5.MS_PHIEU_BAO_TRI AND T3.MS_PT = T1.MS_PTTT AND T3.MS_DH_NHAP_PT = T1.MS_DH_NHAP_PT AND 
                         T3.MS_DH_XUAT_PT = T1.MS_DH_XUAT_PT
						LEFT JOIN #TMP_TRA ON #TMP_TRA.MS_DH_XUAT_PT = T2.MS_DH_XUAT_PT AND #TMP_TRA.MS_PHIEU_BAO_TRI = T1.MS_PHIEU_BAO_TRI
	WHERE   ( ISNULL(T7.VAT_TU, 0) = 0 ) AND ( T1.SL_TT <> T3.SL_VT - ISNULL(SL_TRA,0) ) 
	GROUP BY T5.MS_PHIEU_BAO_TRI
	-- loai bo cac PBT co phieu xuat chua co lock
                                                          UNION
                                                          SELECT
                                                              MS_PHIEU_BAO_TRI
                                                          FROM
                                                              dbo.IC_DON_HANG_XUAT T1
                                                          WHERE
                                                              ( ISNULL(LOCK, 0) = 0 )
                                                              AND ( ISNULL(T1.MS_PHIEU_BAO_TRI,
                                                              '') <> '' )
	-- loai bo cac PBT trong PBT di chuyen
                                                          UNION
                                                          SELECT
                                                              MS_PHIEU_BAO_TRI
                                                          FROM
                                                              PHIEU_BAO_TRI_DI_CHUYEN_BP
                                                        ) X
                                               WHERE    T1.MS_PHIEU_BAO_TRI = X.MS_PHIEU_BAO_TRI )
                                )
                ) T1
        WHERE   HT = 1
        ORDER BY T1.MS_PHIEU_BAO_TRI DESC
	END
--LOCK LAY NHUNG PHIEU NGHIEM THU --> 4
    IF @LOAI = 4
	BEGIN
        SELECT DISTINCT
                CHON, Ten_N_XUONG, T1.MS_PHIEU_BAO_TRI, T1.LY_DO_BT, T1.MS_MAY,
                TEN_LOAI_BT, T1.NGAY_LAP, TEN_UU_TIEN, T1.NGAY_BD_KH,
                T1.MS_LOAI_BT, MS_HT_BT, PHONG_NGUA
        FROM    ( SELECT DISTINCT
                            CONVERT (BIT, 0) AS CHON, T4.Ten_N_XUONG,
                            T1.MS_PHIEU_BAO_TRI, T1.LY_DO_BT, T1.MS_MAY,
                            T2.TEN_LOAI_BT, T1.NGAY_LAP, T3.TEN_UU_TIEN,
                            T1.NGAY_BD_KH, T1.MS_LOAI_BT, T2.MS_HT_BT,
                            dbo.KiemNSHoanThanhPBT(T1.MS_PHIEU_BAO_TRI) AS HT,
                            T10.PHONG_NGUA
                  FROM      #PBT AS T1
                            INNER JOIN dbo.LOAI_BAO_TRI AS T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT
                            INNER JOIN HINH_THUC_BAO_TRI T10 ON T10.MS_HT_BT = T2.MS_HT_BT
                            INNER JOIN dbo.MUC_UU_TIEN AS T3 ON T1.MS_UU_TIEN = T3.MS_UU_TIEN
                            INNER JOIN dbo.MAY_NHA_XUONG_NGAY_MAX AS T4 ON T1.MS_MAY = T4.MS_MAY
                            INNER JOIN dbo.MAY_HE_THONG_NGAY_MAX AS T6 ON T1.MS_MAY = T6.MS_MAY
                            INNER JOIN #MAY_USER T9 ON T1.MS_MAY = T9.MS_MAY
                  WHERE     ( T1.TINH_TRANG_PBT = 4 )
                            AND ( CONVERT(DATE, T1.NGAY_BD_KH) BETWEEN @TNGAY
                                                              AND
                                                              @DNGAY )
                ) T1
        ORDER BY T1.MS_PHIEU_BAO_TRI DESC
	END