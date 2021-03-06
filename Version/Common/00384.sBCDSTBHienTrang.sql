
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sBCDSTBHienTrang')
   exec('CREATE PROCEDURE sBCDSTBHienTrang AS BEGIN SET NOCOUNT ON; END')
GO



--	exec [sBCDSTBHienTrang] 'TRUNGNV','GF-03'

--EXEC sBCDSTBHienTrang
ALTER procedure sBCDSTBHienTrang
--ALTER PROC [dbo].[SP_DSTBLDHT]
	 @UserName NVARCHAR(50)  = 'ADMIN',
	 @MsNX NVARCHAR(50) = '-1' , 
	 @NNgu int = 0
 AS

 declare @DenNgay datetime
 set @DenNgay = getdate()

SELECT DISTINCT * INTO #MAY_USER 
	FROM dbo.MGetMayUserNgay(@DenNgay,@UserName,@MsNX,-1,-1,'-1','-1','-1',@NNgu) 
--SELECT MS_N_XUONG_FINAL=NHA_XUONG.MS_N_XUONG,isnull(nha_xuong.ms_cha,'') MS_CHA
--	  ,MS_MAY_FINAL= CASE WHEN MS_MAY IS NULL THEN dbo.[Get_1MS_MAY_FROMNX](NHA_XUONG.MS_N_Xuong) ELSE TEMP.MS_MAY end
--	  ,MS_TINH=[dbo].[Get_CityCode](NHA_XUONG.MS_QG),MS_QUAN = NHA_XUONG.MS_QG,NHA_XUONG.MS_DUONG
--	  ,TEMP.*
--FROM NHA_XUONG LEFT JOIN

--(
SELECT        dbo.NHA_XUONG.MS_N_XUONG,MS_NHOM_MAY, T1.MS_MAY, T1.SO_THE, TEN_NHOM_MAY, dbo.HIEN_TRANG_SU_DUNG_MAY.TEN_HIEN_TRANG, T1.NUOC_SX, 
                         T1.TY_LE_CON_LAI, dbo.V_MAY_NHA_XUONG_MAX.NGAY_NHAP, dbo.NHA_XUONG.Ten_N_XUONG, T1.MO_TA
FROM           #MAY_USER AS T1 INNER JOIN
                         dbo.V_MAY_NHA_XUONG_MAX ON T1.MS_MAY = dbo.V_MAY_NHA_XUONG_MAX.MS_MAY INNER JOIN
                         dbo.HIEN_TRANG_SU_DUNG_MAY ON T1.MS_HIEN_TRANG = dbo.HIEN_TRANG_SU_DUNG_MAY.MS_HIEN_TRANG INNER JOIN
                         dbo.NHA_XUONG ON dbo.V_MAY_NHA_XUONG_MAX.MS_N_XUONG = dbo.NHA_XUONG.MS_N_XUONG
GROUP BY dbo.NHA_XUONG.MS_N_XUONG, MS_NHOM_MAY, T1.MS_MAY, T1.SO_THE, TEN_NHOM_MAY, dbo.HIEN_TRANG_SU_DUNG_MAY.TEN_HIEN_TRANG, T1.NUOC_SX, 
                         T1.TY_LE_CON_LAI, dbo.V_MAY_NHA_XUONG_MAX.NGAY_NHAP, dbo.NHA_XUONG.Ten_N_XUONG, T1.MO_TA
--)TEMP ON NHA_XUONG.MS_N_XUONG=TEMP.MS_N_XUONG
