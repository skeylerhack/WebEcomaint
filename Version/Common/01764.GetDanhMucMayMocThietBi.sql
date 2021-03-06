--Ten_N_XUONG,TEN_HE_THONG,TEN_LOAI_MAY,TEN_NHOM_MAY,TEN_BP_CHIU_PHI   2001-01-01 00:00:00.000
--	EXEC GetDanhMucMayMocThietBi 'ADMINISTRATOR',0 , '-1', -1,'-1','TEN_NHOM_MAY'
ALTER PROC [dbo].[GetDanhMucMayMocThietBi]
	@UserName NVARCHAR(50) = 'admin',
	@NNgu INT = 3,	--3 = VN,4=E,5=H
	@NXuong NVARCHAR(50) = '-1',
	@HThong INT = -1,
	@LMay NVARCHAR(50) = '-1',
	@NMay NVARCHAR(50) = '-1',
	@BPCPhi INT = -1,
	@HTrang INT= -1, --hiện trạng SD máy	
	@BaoHanh INT= -1, -- -1 ALL, 0 Con BH, 1 hit bh
	@KhauHao INT= -1, --:-1 All, 0 Còn khấu hao, 1 Hết khấu hao 
	@AnToan INT= -1, --: -1 All, 0 Bình thường, 1 ĐB an toàn 
	@sGroup NVARCHAR(500) = 'TEN_NHOM_MAY'
AS
DECLARE @NgayKT DATETIME
SET @NgayKT = GETDATE()
DECLARE @NgayBH DATE = GETDATE()
--còn hạn bảo hành
--WHERE @NgayBH < DATEADD(MONTH,dbo.MAY.SO_THANG_BH,dbo.MAY.NGAY_BD_BAO_HANH) 


SELECT  T1.*,DATEADD(MONTH, ISNULL(T1.SO_THANG_BH,0), T1.NGAY_BD_BAO_HANH) AS NGAY_HET_BAO_HANH,
((T1.SO_NAM_KHAU_HAO*365)+T1.NGAY_DUA_VAO_SD) NGAY_KHAU_HAO
,CASE @NNgu WHEN 0 THEN T2.TEN_HIEN_TRANG ELSE ISNULL(NULLIF(TEN_HIEN_TRANG_ANH,''''),T2.TEN_HIEN_TRANG) END  AS TEN_HIEN_TRANG
INTO  #MAY 
FROM dbo.MGetMayUserNgay(@NgayKT,@UserName,@NXuong,@HThong,@BPCPhi,@LMay,@NMay,'-1',@NNGU + 3) T1 INNER JOIN
                         dbo.HIEN_TRANG_SU_DUNG_MAY AS T2 ON T1.MS_HIEN_TRANG = T2.MS_HIEN_TRANG 
WHERE (T1.MS_HIEN_TRANG = @HTrang OR @HTrang = -1)




SELECT p1.MS_MAY,
       stuff( (SELECT ','+TEN_LOAI_BT 
               FROM (SELECT DISTINCT T1.MS_MAY,T2.TEN_LOAI_BT   FROM dbo.MAY_LOAI_BTPN T1 INNER JOIN dbo.LOAI_BAO_TRI T2 ON	T2.MS_LOAI_BT = T1.MS_LOAI_BT INNER JOIN #MAY T3 ON T1.MS_MAY = T3.MS_MAY ) p2
               WHERE p2.MS_MAY = p1.MS_MAY
               ORDER BY TEN_LOAI_BT
               FOR XML PATH(''), TYPE).value('.', 'Nvarchar(max)'),1,1,'')
       AS LBT INTO #LBT
      FROM (SELECT DISTINCT T1.MS_MAY,T2.TEN_LOAI_BT   FROM dbo.MAY_LOAI_BTPN T1 INNER JOIN dbo.LOAI_BAO_TRI T2 ON	T2.MS_LOAI_BT = T1.MS_LOAI_BT INNER JOIN #MAY T3 ON T1.MS_MAY = T3.MS_MAY) p1
      GROUP BY MS_MAY ;


SELECT p1.MS_MAY,
       stuff( (SELECT ','+TEN_DV_TG 
               FROM (			SELECT DISTINCT T1.MS_MAY,CONVERT(NVARCHAR(10), T1.CHU_KY_DO) + ' ' + 		
			CASE 0 WHEN 0 THEN T2.TEN_DV_TG  
			WHEN 1 THEN ISNULL(NULLIF(T2.TEN_DV_TG_ANH ,''),T2.TEN_DV_TG )
			ELSE ISNULL(NULLIF(T2.TEN_DV_TG_HOA,''),T2.TEN_DV_TG ) END  AS TEN_DV_TG
			FROM dbo.CAU_TRUC_THIET_BI_TS_GSTT T1 INNER JOIN dbo.DON_VI_THOI_GIAN T2 ON T2.MS_DV_TG = T1.MS_DV_TG INNER JOIN #MAY T3 ON T1.MS_MAY = T3.MS_MAY
			) p2
               WHERE p2.MS_MAY = p1.MS_MAY
               ORDER BY TEN_DV_TG
               FOR XML PATH(''), TYPE).value('.', 'Nvarchar(max)')
            ,1,1,'')
       AS LOAI_BT_GSTT INTO #LBTGSTT
      FROM (			SELECT DISTINCT T1.MS_MAY,CONVERT(NVARCHAR(10), T1.CHU_KY_DO) + ' ' + 		
			CASE 0 WHEN 0 THEN T2.TEN_DV_TG  
			WHEN 1 THEN ISNULL(NULLIF(T2.TEN_DV_TG_ANH ,''),T2.TEN_DV_TG )
			ELSE ISNULL(NULLIF(T2.TEN_DV_TG_HOA,''),T2.TEN_DV_TG ) END  AS TEN_DV_TG
			FROM dbo.CAU_TRUC_THIET_BI_TS_GSTT T1 INNER JOIN dbo.DON_VI_THOI_GIAN T2 ON T2.MS_DV_TG = T1.MS_DV_TG INNER JOIN #MAY T3 ON T1.MS_MAY = T3.MS_MAY
			) p1
      GROUP BY MS_MAY ;
--ROW_NUMBER() OVER(PARTITION BY T1.TEN_LOAI_MAY, T1.TEN_NHOM_MAY ORDER BY T1.TEN_LOAI_MAY, T1.TEN_NHOM_MAY,T1.MS_MAY, T1.TEN_MAY, T1.MS_LOAI_MAY, T1.MS_NHOM_MAY, T1.NGAY_DUA_VAO_SD) AS STT,
DECLARE	@sSql NVARCHAR(MAX)
DECLARE	@sOB NVARCHAR(MAX)
IF @sGroup <> ''
BEGIN
    SET @sSql = ' ROW_NUMBER() OVER(PARTITION BY ' + @sGroup + ' ORDER BY ' + @sGroup + ',T1.MS_MAY, T1.TEN_MAY, T1.MS_LOAI_MAY, T1.MS_NHOM_MAY, T1.NGAY_DUA_VAO_SD) AS STT,'
	SET @sOB = ' ORDER BY   ' + @sGroup + ',T1.MS_MAY, T1.TEN_MAY, T1.MS_LOAI_MAY, T1.MS_NHOM_MAY, T1.NGAY_DUA_VAO_SD'
END
ELSE
BEGIN
    SET @sSql = ' ROW_NUMBER() OVER(ORDER BY T1.MS_MAY, T1.TEN_MAY, T1.MS_LOAI_MAY, T1.MS_NHOM_MAY, T1.NGAY_DUA_VAO_SD) AS STT,'
	SET @sOB = ' ORDER BY T1.MS_MAY, T1.TEN_MAY, T1.MS_LOAI_MAY, T1.MS_NHOM_MAY, T1.NGAY_DUA_VAO_SD'
END



SET @sSql = '
SELECT '+ @sSql + '
T1.MS_MAY, T1.TEN_MAY,  T1.TEN_LOAI_MAY, 
	T1.TEN_NHOM_MAY,T1.NGAY_DUA_VAO_SD  , 
	T1.SO_THANG_BH, NGAY_HET_BAO_HANH,T1.NHIEM_VU_THIET_BI, T1.GIA_MUA , T1.NGOAI_TE,
	TEN_HIEN_TRANG,
	CASE ' + CONVERT(NVARCHAR(5),@NNgu) + ' WHEN 0 THEN T3.TEN_UU_TIEN ELSE ISNULL(NULLIF(TEN_TA,''''),T3.TEN_UU_TIEN) END  AS TEN_UU_TIEN,
	T1.AN_TOAN,T1.MS_N_XUONG,T1.Ten_N_XUONG, T1.TEN_HE_THONG,  T1.TEN_BP_CHIU_PHI,T4.LBT AS TEN_LOAI_BT,T5.LOAI_BT_GSTT

FROM            #MAY AS T1 INNER JOIN
                         dbo.MUC_UU_TIEN AS T3 ON T1.MUC_UU_TIEN = T3.MS_UU_TIEN LEFT JOIN #LBT T4 ON T1.MS_MAY = T4.MS_MAY LEFT JOIN 
						 #LBTGSTT T5 ON T1.MS_MAY = T5.MS_MAY WHERE (1 = 1)' 

--còn hạn bảo hành -- -1 ALL, 0Con BH, 1 hit bh
--WHERE @NgayBH <= DATEADD(MONTH,dbo.MAY.SO_THANG_BH,dbo.MAY.NGAY_BD_BAO_HANH) 
IF @BaoHanh = 0 
BEGIN
    SET @sSql = @sSql + ' AND (''' + CONVERT(NVARCHAR(10), @NgayBH,101) + ''' < NGAY_HET_BAO_HANH) '
END
IF @BaoHanh = 1 
BEGIN
    SET @sSql = @sSql + ' AND (''' + CONVERT(NVARCHAR(10), @NgayBH,101) + ''' > NGAY_HET_BAO_HANH) '
END


-- khấu hao  -1 All, 0 Còn khấu hao, 1Hết khấu hao 
-- (([MAY].[SO_NAM_KHAU_HAO]*365)+[MAY].[NGAY_DUA_VAO_SD])>= getdate() 
IF @KhauHao = 0 
BEGIN
    SET @sSql = @sSql + ' AND (GETDATE() < NGAY_KHAU_HAO) '
END
IF @KhauHao = 1 
BEGIN
    SET @sSql = @sSql + ' AND (GETDATE() > NGAY_KHAU_HAO) '
END

SET @sSql = @sSql  +  @sOB




print (@sSql)
EXEC (@sSql)
--
--ORDER BY  T1.MS_MAY, T1.TEN_MAY, T1.MS_LOAI_MAY, T1.TEN_LOAI_MAY, T1.MS_NHOM_MAY, T1.TEN_NHOM_MAY, T1.NGAY_DUA_VAO_SD

