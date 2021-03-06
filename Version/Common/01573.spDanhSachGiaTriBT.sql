IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spDanhSachGiaTriBT')
   exec('CREATE PROCEDURE spDanhSachGiaTriBT AS BEGIN SET NOCOUNT ON; END')
GO
--DANH SÁCH GIÁ TRỊ THEO BẢNG TẠM
ALTER PROCEDURE [dbo].[spDanhSachGiaTriBT]
    @STT INT = 6095,
    @MsThonsSo INT = 17 ,
    @LoaiTS INT = 1 ,
 -- 1 DINH TINH  0 DINH LUONG
    @MsMay NVARCHAR(100) = '10-01-OCO-001-00' ,
    @MsBP NVARCHAR(100) = '01.01' ,
	@BT NVARCHAR(100) = 'GIA_TRI_TMPADMIN',
    @UserName NVARCHAR(50) = 'admin',
    @NNgu INT = 0
AS
BEGIN

CREATE TABLE #BTGT 
(
	[CHON] [BIT] NULL,
	[TEN_GIA_TRI] [NVARCHAR](255) NOT NULL,
	[DAT] [BIT] NULL,
	[GHI_CHU] [NVARCHAR](255) NULL,
	[STT] [INT] NOT NULL,
	[MS_MAY] [NVARCHAR](30) NOT NULL,
	[MS_TS_GSTT] [NVARCHAR](10) NOT NULL,
	[MS_BO_PHAN] [NVARCHAR](50) NOT NULL,
	[MS_TT] [INT] NOT NULL,
	[THOI_GIAN] FLOAT,
	[TG_TT] FLOAT
)
DECLARE @sSql	NVARCHAR(MAX)
SET @sSql	= 'INSERT INTO #BTGT ([CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],[STT],[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT]) SELECT [CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],[STT],[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT] FROM ' + @BT 
EXEC (@sSql)

IF @LoaiTS = 1
        BEGIN
            SELECT DISTINCT TEN_GIA_TRI,GHI_CHU, STT
            FROM   GIA_TRI_TMPADMIN
            WHERE    MS_MAY = @MsMay
					AND MS_TS_GSTT =@MsThonsSo
					AND MS_BO_PHAN =@MsBP
					AND CHON =1
            ORDER BY TEN_GIA_TRI,GHI_CHU,STT
        END
    ELSE
        BEGIN
            SELECT  TEN_GT ,
                    GIA_TRI_DUOI ,
                    GIA_TRI_TREN
            FROM    dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T1
            WHERE   ( MS_MAY = @MsMay )
                    AND ( MS_BO_PHAN = @MsBP )
                    AND ( MS_TS_GSTT = @MsThonsSo ) 
			ORDER BY TEN_GT ,GIA_TRI_DUOI ,GIA_TRI_TREN				
        END
		END
        