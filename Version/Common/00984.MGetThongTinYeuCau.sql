
--SELECT * FROM YEU_CAU_NSD_CHI_TIET where stt = 3447
--EXEC MGetThongTinYeuCau 3447,0,'10-05-GRA-011-00','ADMIN', '-1',3756
--------------------------
ALTER procedure [dbo].[MGetThongTinYeuCau]
	@STT INT,
	@NNgu int,
	@MS_MAY NVARCHAR(50),
	@USERNAME NVARCHAR(50),
	@MS_PBT nvarchar(50), 
	@STT_VAN_DE INT
as

DECLARE @NgayHT DATETIME
SET @NgayHT = GETDATE()
SELECT A.* INTO #MAY_TMP FROM dbo.MGetMayUserNgay(@NgayHT,@USERNAME,'-1',-1,-1,-1,'-1','-1',0) A WHERE A.MS_MAY = @MS_MAY

SELECT MS_TTRANG, CASE @NNgu WHEN 0 THEN TEN_TTRANG WHEN 1 THEN TEN_TTRANG_ANH ELSE TEN_TTRANG_HOA END AS TEN_TINH_TRANG INTO #TT FROM TINH_TRANG_YCSD ORDER BY MS_TTRANG


SELECT B.TEN_TINH_TRANG, A.* INTO #YCNSDCT FROM 
(
SELECT CASE WHEN ISNULL(USERNAME_DSX,'') = '' THEN 0
	WHEN ISNULL(USERNAME_DSX,'') <> '' AND ISNULL(THUC_HIEN_DSX,0) = 0 THEN 1
	WHEN THUC_HIEN_DSX=1 and MS_CACH_TH is null  THEN 2
	WHEN MS_CACH_TH ='06' THEN 3
	WHEN MS_CACH_TH ='01'  AND ISNULL(MS_PBT,'') = '' THEN 4
	WHEN (MS_CACH_TH ='04' OR MS_CACH_TH ='01') AND (TINH_TRANG_PBT <3) AND (ISNULL(MS_PBT,'') <> '') THEN 5
	WHEN (MS_CACH_TH = '04' OR MS_CACH_TH ='01') AND (TINH_TRANG_PBT >=3) AND (ISNULL(MS_PBT,'') <> '')  THEN 6
	WHEN MS_CACH_TH ='03' THEN 7 END AS MS_TTRANG, T1.* , 
	CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY,101) + ' ' + CONVERT(NVARCHAR(8),GIO_YEU_CAU,108)) AS NGAY_YC, 	T3.NGUOI_YEU_CAU 
FROM YEU_CAU_NSD T3 INNER JOIN YEU_CAU_NSD_CHI_TIET T1 ON T3.STT = T1.STT LEFT JOIN PHIEU_BAO_TRI T2 ON T1.MS_PBT = T2.MS_PHIEU_BAO_TRI 
WHERE T1.STT = @STT AND (T1.MS_PBT = @MS_PBT OR @MS_PBT = '-1') AND (T1.STT_VAN_DE = @STT_VAN_DE OR @STT_VAN_DE = -1)
) A LEFT JOIN #TT B ON A.MS_TTRANG = B.MS_TTRANG



SELECT B.MS_TTRANG,B.MS_MAY, C.TEN_MAY, B.MO_TA_TINH_TRANG,  B.YEU_CAU, D.TEN_UU_TIEN,B.TEN_TINH_TRANG, (ISNULL(B.USERNAME_DSX, '') + ' - ' + U1.FULL_NAME ) AS USERNAME_DSX, ISNULL(B.THOI_GIAN_DSX, '') AS THOI_GIAN_DSX,  ISNULL(B.Y_KIEN_DSX, '') AS Y_KIEN_DSX, ISNULL(B.THUC_HIEN_DSX, '') AS THUC_HIEN_DSX , U2.FULL_NAME as USERNAME_DBT, B.NGAY_DBT, 
                      B.Y_KIEN_DBT, 
                      CASE @NNgu WHEN 0 THEN  E.TEN_TIENG_VIET WHEN 1 THEN E.TEN_TIENG_ANH ELSE E.TEN_TIENG_HOA END AS TEN_TIENG_VIET ,
                      B.MS_PBT, dbo.TINH_TRANG_PBT.TEN_TINH_TRANG, 
                      dbo.[MGetPBTNhanSu](A.MS_PHIEU_BAO_TRI) AS MS_CONG_NHAN,convert(nvarchar(10), Convert(Date, A.NGAY_BD_KH), 103) as NGAY_BD_KH,convert(nvarchar(10), Convert(Date, A.NGAY_KT_KH),103) as NGAY_KT_KH,convert(nvarchar(10),Convert(Date,  PBT_MIN.TU_NGAY), 103) as TU_NGAY, convert(nvarchar(10),Convert(Date, PBT_MAX.DEN_NGAY),103) as DEN_NGAY, 
                      dbo.MGetPBTMoTaCongViec(A.MS_PHIEU_BAO_TRI, @NNgu) AS MO_TA_CV, B.NGAY_YC,B.NGUOI_YEU_CAU AS NGUOI_YC, CONVERT(NVARCHAR(1),'') AS VAT_TU
FROM         #YCNSDCT AS B INNER JOIN
                      #MAY_TMP AS C ON B.MS_MAY = C.MS_MAY LEFT OUTER JOIN
                      dbo.CONG_NHAN ON B.MS_CONG_NHAN = dbo.CONG_NHAN.MS_CONG_NHAN LEFT OUTER JOIN
					  dbo.USERS U1 on B.USERNAME_DSX = U1.USERNAME  LEFT OUTER JOIN
					   dbo.USERS U2 on B.USERNAME_DBT = U2.USERNAME  LEFT OUTER JOIN
                      dbo.PHIEU_BAO_TRI AS A ON B.MS_PBT = A.MS_PHIEU_BAO_TRI LEFT OUTER JOIN
                      dbo.TINH_TRANG_PBT ON A.TINH_TRANG_PBT = dbo.TINH_TRANG_PBT.STT LEFT OUTER JOIN
                      dbo.MUC_UU_TIEN AS D ON B.MS_UU_TIEN = D.MS_UU_TIEN LEFT OUTER JOIN
                      dbo.CACH_THUC_HIEN AS E ON B.MS_CACH_TH = E.MS_CACH_TH LEFT OUTER JOIN
                          (SELECT     MS_PHIEU_BAO_TRI, MIN(TU_NGAY) AS TU_NGAY
                            FROM          (SELECT     MS_PHIEU_BAO_TRI, CONVERT(DATETIME, NGAY + ' ' + TU_GIO) AS TU_NGAY
                                                    FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET) AS A
                            GROUP BY MS_PHIEU_BAO_TRI) AS PBT_MIN ON A.MS_PHIEU_BAO_TRI = PBT_MIN.MS_PHIEU_BAO_TRI LEFT OUTER JOIN
                          (SELECT     MS_PHIEU_BAO_TRI, MAX(DEN_NGAY) AS DEN_NGAY
                            FROM          (SELECT     MS_PHIEU_BAO_TRI, CONVERT(DATETIME, DEN_NGAY + ' ' + DEN_GIO) AS DEN_NGAY
                                                    FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET AS PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET_1) AS A_1
                            GROUP BY MS_PHIEU_BAO_TRI) AS PBT_MAX ON A.MS_PHIEU_BAO_TRI = PBT_MAX.MS_PHIEU_BAO_TRI
WHERE B.STT = @STT AND  (B.MS_PBT = @MS_PBT OR @MS_PBT = '-1') AND (B.STT_VAN_DE = @STT_VAN_DE OR @STT_VAN_DE = -1)
            

