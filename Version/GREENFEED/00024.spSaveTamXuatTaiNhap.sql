--SELECT * FROM dbo.BTDetailsadmin
IF NOT EXISTS ( SELECT  *
                FROM    sys.objects
                WHERE   type = 'P'
                        AND name = 'spSaveTamXuatTaiNhap' )
    EXEC('CREATE PROCEDURE spSaveTamXuatTaiNhap AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE spSaveTamXuatTaiNhap
    @ID BIGINT =2,
    @MS_TX_TN NVARCHAR(12) ='231ds',
    @NGUOI_DE_NGHI NVARCHAR(50) ='dá' ,
    @MS_NHAN_VIEN NVARCHAR(50) ='',
    @TEN_BO_PHAN NCHAR(50) ='',
    @CNMD NVARCHAR(50) ='',
    @NGUOI_MANG_RA NVARCHAR(50) ='',
    @NOI_NHAN NVARCHAR(50) ='',
    @PHUONG_TIEN_VC NVARCHAR(50) ='',
    @TG_MANG_VE DATETIME ='01/01/2020',
    @NGAY_LAP DATETIME ='01/01/2020',
    @GHI_CHU NVARCHAR(250)  ='',
    @UserName NVARCHAR(20) ='admin',
    @sBT NVARCHAR(50) ='BTDetailsadmin'
AS
    BEGIN
        IF ( @ID = -1 )
            BEGIN
---THÊM
                INSERT  INTO dbo.PHIEU_TAM_XUAT_TAI_NHAP ( MS_TX_TN,
                                                           NGUOI_DE_NGHI,
                                                           MS_NHAN_VIEN,
                                                           TEN_BO_PHAN, CNMD,
                                                           NGUOI_MANG_RA,
                                                           NOI_NHAN,
                                                           PHUONG_TIEN_VC,
                                                           TG_MANG_VE,
                                                           NGUOI_LAP, NGAY_LAP,
                                                           GHI_CHU )
                VALUES  ( @MS_TX_TN, @NGUOI_DE_NGHI, @MS_NHAN_VIEN,
                          @TEN_BO_PHAN, @CNMD, @NGUOI_MANG_RA, @NOI_NHAN,
                          @PHUONG_TIEN_VC, @TG_MANG_VE, @UserName, @NGAY_LAP,
                          @GHI_CHU )

                SET @ID = ( SELECT  SCOPE_IDENTITY()
                          )

            END	
        ELSE
            BEGIN
---SỬA
                UPDATE  dbo.PHIEU_TAM_XUAT_TAI_NHAP
                SET     MS_TX_TN = @MS_TX_TN, NGUOI_DE_NGHI = @NGUOI_DE_NGHI,
                        MS_NHAN_VIEN = @MS_NHAN_VIEN,
                        TEN_BO_PHAN = @TEN_BO_PHAN, CNMD = @CNMD,
                        NGUOI_MANG_RA = @NGUOI_MANG_RA, NOI_NHAN = @NOI_NHAN,
                        PHUONG_TIEN_VC = @PHUONG_TIEN_VC,
                        TG_MANG_VE = @TG_MANG_VE, NGUOI_LAP = @UserName,
                        NGAY_LAP = @NGAY_LAP, GHI_CHU = @GHI_CHU
                WHERE   ID = @ID



----

            END	

--
CREATE TABLE #TEMPT_TX (
[ID] [bigint] NULL,
[ID_TNX] [bigint] NULL,
[MS_TAI_SAN] [NVARCHAR](50)NULL ,
[TEN_TAI_SAN] [NVARCHAR](50)NULL ,
[DVT] [nvarchar] (10)NULL ,
[SL_XUAT] DECIMAL(18,2) NULL,
[LY_DO_XUAT] [nvarchar] (150)NULL ,
[NGAY_XUAT] [datetime] NULL,
[SL_NHAP] DECIMAL(18,2) NULL,
[LY_DO_NHAP] [nvarchar] (150) ,
[NGAY_NHAP] [datetime] NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
BEGIN

set @sSql = 'INSERT INTO #TEMPT_TX (ID, ID_TNX, MS_TAI_SAN, TEN_TAI_SAN, DVT, SL_XUAT,
                         LY_DO_XUAT, NGAY_XUAT, SL_NHAP, LY_DO_NHAP, NGAY_NHAP ) SELECT ID, ID_TNX, MS_TAI_SAN, TEN_TAI_SAN, DVT, SL_XUAT, LY_DO_XUAT, NGAY_XUAT,
                 SL_NHAP, LY_DO_NHAP, NGAY_NHAP FROM ' + @SBT 
EXEC (@sSql)

set @sSql = 'DROP TABLE ' + @SBT
EXEC (@sSql)

--Thêm những mã nào chưa tồn tại

INSERT INTO dbo.PHIEU_TAM_XUAT_TAI_NHAP_CHI_TIET ( ID_TNX, MS_TAI_SAN,
                                                TEN_TAI_SAN, DVT, SL_XUAT,
                                                LY_DO_XUAT, NGAY_XUAT, SL_NHAP,
                                                LY_DO_NHAP, NGAY_NHAP )
SELECT @ID, MS_TAI_SAN,TEN_TAI_SAN, DVT, SL_XUAT, LY_DO_XUAT, NGAY_XUAT, SL_NHAP, LY_DO_NHAP, NGAY_NHAP FROM #TEMPT_TX A WHERE ISNULL(A.ID_TNX,'') = ''


--sửa những cái nào đã tồn tại
UPDATE  A
SET 
A.MS_TAI_SAN =B.MS_TAI_SAN,
A.TEN_TAI_SAN =B.TEN_TAI_SAN,
A.DVT =B.DVT,
A.SL_XUAT =B.SL_XUAT,
A.LY_DO_XUAT =B.LY_DO_XUAT,
A.NGAY_XUAT =B.NGAY_XUAT,
A.SL_NHAP =B.SL_NHAP,
A.LY_DO_NHAP =B.LY_DO_NHAP,
A.NGAY_NHAP =B.NGAY_NHAP
FROM PHIEU_TAM_XUAT_TAI_NHAP_CHI_TIET A
INNER JOIN #TEMPT_TX B ON A.ID =B.ID
WHERE A.ID_TNX = @ID
SELECT @ID
END
END
