
-- EXEC SP_Y_GET_PBTTN 'ADMIN',0,'-1',-1,'-1','-1','-1','-1','-1'
ALTER procedure [dbo].[SP_Y_GET_PBTTN]
	@USERNAME NVARCHAR (64), 
	@LANGUAGE INT,
	@MS_NHA_XUONG NVARCHAR (50), 
	@MS_HE_THONG INT ,
	@MS_LOAI_MAY NVARCHAR(30),
	@MS_MAY NVARCHAR (30),
	@MS_TINH NVARCHAR(100),
	@MS_QUAN NVARCHAR(100),
	@MS_DUONG NVARCHAR(100)
AS

DECLARE @NgayHT DATETIME
SET @NgayHT = CONVERT(DATE,GETDATE())

SELECT * INTO #MAY_USER
	FROM [dbo].[MGetMayUserNgay](@NgayHT,@USERNAME,@MS_NHA_XUONG,@MS_HE_THONG,-1,@MS_LOAI_MAY,'-1',@MS_MAY,@LANGUAGE)
	--Ngày BĐKH <= Ngày hiện tại <+ Ngày KT kế 


SELECT DISTINCT T7.MS_PHIEU_BAO_TRI,T1.MS_MAY,T1.TEN_MAY,T9.TEN_LOAI_BT,  CONVERT(DATE,T7.NGAY_BD_KH) AS NGAY_BD_KH  
,CONVERT(DATE,T7.NGAY_KT_KH) AS NGAY_KT_KH,T1.Ten_N_XUONG, 
CASE @LANGUAGE WHEN 0 THEN T2.TEN_TINH_TRANG WHEN 1 THEN T2.TEN_TINH_TRANG_ANH ELSE T2.TEN_TINH_TRANG_HOA END AS TEN_TINH_TRANG
FROM            #MAY_USER AS T1 INNER JOIN
                         dbo.PHIEU_BAO_TRI AS T7 ON T1.MS_MAY = T7.MS_MAY INNER JOIN
                         dbo.LOAI_BAO_TRI AS T9 ON T7.MS_LOAI_BT = T9.MS_LOAI_BT INNER JOIN 
						 TINH_TRANG_PBT T2 ON T7.TINH_TRANG_PBT = T2.STT
WHERE        (T7.NGAY_BD_KH <= @NgayHT) AND (T7.NGAY_KT_KH >= @NgayHT) AND T7.TINH_TRANG_PBT = 2
ORDER BY T7.MS_PHIEU_BAO_TRI


	
