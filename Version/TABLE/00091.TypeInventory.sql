--DECLARE @TonKho AS TypeInventory;
--INSERT INTO @TonKho 
--exec MTinhTonKhoTheoViTri '01/01/2016','12/31/2017','-1',-1,'ADMIN',0
--SELECT * FROM @TonKho

IF EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TypeInventory' AND ss.name = N'dbo')
	DROP TYPE [dbo].[TypeInventory]

GO
CREATE TYPE [dbo].[TypeInventory] AS TABLE(
	[MS_PT] [nvarchar](50),
	[TEN_PT] [nvarchar](1000),
	[MS_LOAI_VT] [NVARCHAR](250), 
	[TEN_LOAI_VT] [NVARCHAR](1000),
	[MS_KHO] [int] ,
	[MS_VI_TRI] [int] ,
	[TON_DAU_KY] [float],
	[GT_DAU_KY] [float] ,
	[SL_NHAP_TNDN] [float] ,
	[GT_NHAP_TNDN] [float] ,
	[SL_XUAT_TNDN] [float] ,
	[GT_XUAT_TNDN] [float] ,
	[SL_CHUYEN_DI_TNDN] [float] ,
	[GT_CHUYEN_DI_TNDN] [float] ,
	[SL_CHUYEN_DEN_TNDN] [float] ,
	[GT_CHUYEN_DEN_TNDN] [float] ,
	[CHENH_LECH_KIEM_KE_TNDN] [float] ,
	[GT_KIEM_KE_TNDN] [float] ,
	[TON_CUOI_KY] [float] NULL,
	[GT_CUOI_KY] [float] 
)
GO
