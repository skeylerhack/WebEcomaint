
--LẤY DANH SÁCH GIÁM SÁT THEO NGÀY BẮC ĐẦU VÀ NGÀY KẾT THÚC
ALTER proc [dbo].[sp_GetLOAIDSGSTT]
	@NgayBD DATETIME= '12/01/2018',
	@NgayKT DATETIME ='12/30/2020',
	@UserName NVARCHAR(100)='CHA12',
	--@HoanThanh INT =-1,
	@NNgu INT = NULL
AS

SELECT T1.* INTO #GSTT FROM GIAM_SAT_TINH_TRANG T1 INNER JOIN dbo.USERS T2 ON T1.USERNAME = T2.USERNAME INNER JOIN dbo.NHOM T3 ON T2.GROUP_ID = T3.GROUP_ID WHERE (T2.GROUP_ID = (SELECT TOP 1 GROUP_ID FROM dbo.USERS WHERE USERNAME = @UserName)) AND (T1.NGAY_KT BETWEEN CONVERT(DATETIME,@NgayBD) AND CONVERT(DATETIME,@NgayKT))


SELECT SO_PHIEU,
	gs.NGAY_KT,
	gs.GIO_KT,
	CONVERT(VARCHAR,(gs.NGAY_KT +' '+ gs.GIO_KT),105) + ' '+CONVERT(VARCHAR,(gs.NGAY_KT +' '+ gs.GIO_KT),108) NGAY_GIO,
	(cn.HO+' '+cn.TEN) AS TEN_CN,	
	dbo.GetMSMayGSTT(STT) AS MS_MAY,
	dbo.GettenMayGSTT(STT) AS Ten_May,
	gs.HOAN_THANH,
	gs.USERNAME,
	gs.MS_CONG_NHAN,
	gs.NHAN_XET AS GHI_CHU,
	(SELECT SUM(TG_TT) FROM GIAM_SAT_TINH_TRANG_TS WHERE STT = gs.STT) AS TONG_TG,
	gs.STT
FROM  #GSTT gs 
JOIN dbo.CONG_NHAN cn ON gs.MS_CONG_NHAN = cn.MS_CONG_NHAN 

