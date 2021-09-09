﻿

--	SELECT * FROM [dbo].[MGetNgayHieuChuanKeBaoTri]('01/01/2016','01/20/2016','Administrator','-1',-1,'-1','-1',1) ORDER BY MS_MAY,MS_LOAI_BT,NGAY_HC_CUOI,CHU_KY,MS_DV_TG,NGAY_KE

ALTER FUNCTION [dbo].[MGetNgayHieuChuanKeBaoTri]
(
	@NgayBD DATETIME,
	@NgayKT DATETIME,
	@UserName NVARCHAR(255),
	@MsNXuong nvarchar(50),
	@NHeThong int,
	@LoaiMay NVARCHAR (20),
	@NhomMay NVARCHAR (20),
	@MLoai bit
)
returns  @MAY_NGAY_CUOI TABLE (
	[MS_MAY] [nvarchar](30) NOT NULL,
	[MS_LOAI_BT] [int] NOT NULL,
	[NGAY_HC_CUOI] [datetime] NULL,
	[CHU_KY] [int] NULL,
	[MS_DV_TG] [int] NULL,	
	[NGAY_KE] [datetime] NULL)
as
begin	

--Lấy dữ liệu theo nha xuong, he thong và tính ngày bảo trì định kỳ cuoi
DECLARE @MAY_USER TABLE (MS_MAY NVARCHAR(30))
INSERT INTO @MAY_USER
SELECT DISTINCT MS_MAY FROM [dbo].[MGetMayUserNgay](@NgayBD,@UserName,@MsNXuong,@NHeThong,-1,@LoaiMay,@NhomMay,'-1',0)

INSERT INTO @MAY_NGAY_CUOI
SELECT DISTINCT MS_MAY ,MS_LOAI_BT, NGAY_HC_CUOI , CHU_KY, MS_DV_TG, 
	CASE MS_DV_TG WHEN 1 THEN CASE WHEN NGAY_HC_CUOI >= @NgayBD THEN DATEADD (DAY,CHU_KY,NGAY_HC_CUOI) 
						ELSE DATEADD (DAY,CASE ISNULL(SO_NGAY_CK,0) WHEN 0 THEN CHU_KY ELSE ISNULL(SO_NGAY_CK,0) END,NGAY_HC_CUOI)	END 
					WHEN 2 THEN CASE WHEN NGAY_HC_CUOI >= @NgayBD THEN DATEADD (WEEK,CHU_KY,NGAY_HC_CUOI)
						ELSE DATEADD (WEEK,CASE ISNULL(SO_NGAY_CK,0) WHEN 0 THEN CHU_KY ELSE ISNULL(SO_NGAY_CK,0) END,NGAY_HC_CUOI) END 							
					WHEN 3 THEN CASE WHEN NGAY_HC_CUOI >= @NgayBD THEN DATEADD (MONTH,CHU_KY,NGAY_HC_CUOI)
							ELSE DATEADD (MONTH,  CASE ISNULL(SO_NGAY_CK,0) WHEN 0 THEN CHU_KY ELSE ISNULL(SO_NGAY_CK,0) END  ,NGAY_HC_CUOI) END 
					WHEN 4 THEN CASE WHEN NGAY_HC_CUOI >= @NgayBD THEN DATEADD (YEAR,CHU_KY,NGAY_HC_CUOI)
							ELSE DATEADD (YEAR,CASE ISNULL(SO_NGAY_CK,0) WHEN 0 THEN CHU_KY ELSE ISNULL(SO_NGAY_CK,0) END,NGAY_HC_CUOI) END END AS NGAY_KE
FROM 
(
	SELECT MS_MAY ,MS_LOAI_BT, NGAY_HC_CUOI , CHU_KY, MS_DV_TG, SO_NGAY, 
	ISNULL( CASE MS_DV_TG WHEN 1 THEN CONVERT(int,SO_NGAY / CHU_KY ) * CHU_KY 
						WHEN 2 THEN CONVERT(int,(SO_NGAY / 7 ) / CHU_KY ) * CHU_KY
						WHEN 3 THEN CONVERT(int,dbo.MGetSoThang(NGAY_HC_CUOI,@NgayBD) / CHU_KY ) * CHU_KY 				
						WHEN 4 THEN CONVERT(int,(SO_NGAY / 12 ) / CHU_KY ) * CHU_KY END,0) AS SO_NGAY_CK
	FROM 
		(
			SELECT     T1.MS_MAY,T1.MS_LOAI_BT, T1.MS_DV_TG, T1.NGAY_HC_CUOI , 
					CHU_KY,
					CASE MS_DV_TG WHEN 1 THEN DATEDIFF (DAY, NGAY_HC_CUOI,@NgayBD) 
											WHEN 2 THEN DATEDIFF (DAY,NGAY_HC_CUOI,@NgayBD)
											WHEN 3 THEN dbo.MGetSoThang(NGAY_HC_CUOI,@NgayBD)
											ELSE  dbo.MGetSoThang(NGAY_HC_CUOI,@NgayBD) END 

					AS SO_NGAY 		
				FROM        (
				
								SELECT     dbo.MAY_LOAI_BTPN.MS_MAY, dbo.MAY_LOAI_BTPN.MS_LOAI_BT, T_1.MS_DV_TG, T_1.CHU_KY, ISNULL(NGAY_CUOI,T1.NGAY_DUA_VAO_SD) AS NGAY_HC_CUOI
								FROM         dbo.MAY_LOAI_BTPN INNER JOIN
														  (SELECT     T2.MS_MAY, T2.MS_LOAI_BT, T2.CHU_KY, T2.MS_DV_TG
															FROM          (SELECT     T1.MS_MAY, MS_LOAI_BT, MAX(NGAY_AD) AS NGAY_AD
																					FROM          dbo.MAY_LOAI_BTPN_CHU_KY AS T1 INNER JOIN 
															@MAY_USER T3 ON T1.MS_MAY = T3.MS_MAY	
																					GROUP BY T1.MS_MAY, MS_LOAI_BT) AS T1 INNER JOIN
																				   dbo.MAY_LOAI_BTPN_CHU_KY AS T2 ON T1.MS_MAY = T2.MS_MAY AND T1.MS_LOAI_BT = T2.MS_LOAI_BT AND 
																				   T1.NGAY_AD = T2.NGAY_AD) AS T_1 ON dbo.MAY_LOAI_BTPN.MS_MAY = T_1.MS_MAY AND 
													  dbo.MAY_LOAI_BTPN.MS_LOAI_BT = T_1.MS_LOAI_BT INNER JOIN MAY T1 ON T1.MS_MAY = MAY_LOAI_BTPN.MS_MAY	
								WHERE     (T_1.CHU_KY IS NOT NULL) AND ISNULL(MS_DV_TG, 0 ) <> 0	
								
								
							) AS T1  
		) AS SO_NGAY WHERE CHU_KY <> 0
) TINH_SO_NGAY 


IF @MLoai = 1
	BEGIN
		DECLARE @MS_MAY nvarchar(30),@MS_LOAI_BT int ,@NGAY_HC_CUOI datetime ,@CHU_KY int ,@MS_DV_TG int ,@NGAY_KE datetime
		
		DECLARE BTDK_CURSOR CURSOR FOR
			SELECT DISTINCT MS_MAY,MS_LOAI_BT,NGAY_HC_CUOI,CHU_KY ,MS_DV_TG,NGAY_KE FROM @MAY_NGAY_CUOI 	
				WHERE MS_DV_TG IN (1,2,3,4) AND CHU_KY IS NOT NULL AND CHU_KY > 0
		OPEN BTDK_CURSOR
		FETCH NEXT FROM BTDK_CURSOR 
		INTO @MS_MAY,@MS_LOAI_BT,@NGAY_HC_CUOI,@CHU_KY,@MS_DV_TG,@NGAY_KE
		WHILE @@FETCH_STATUS = 0  
		BEGIN	
			SET @NGAY_KE = (SELECT CASE @MS_DV_TG
						WHEN 1 THEN  DATEADD(DAY,@CHU_KY,@NGAY_KE)
						WHEN 2 THEN DATEADD(DAY,7 * @CHU_KY ,@NGAY_KE)
						WHEN 3 THEN DATEADD(MONTH,@CHU_KY,@NGAY_KE) 
						WHEN 4 THEN DATEADD(YEAR,@CHU_KY,@NGAY_KE)												
						ELSE 
							DATEADD(YEAR,1,@NgayKT)												
						END )
			
			WHILE @NGAY_KE <= @NgayKT	
				BEGIN	
					INSERT INTO @MAY_NGAY_CUOI (MS_MAY,MS_LOAI_BT,NGAY_HC_CUOI,CHU_KY,MS_DV_TG,NGAY_KE) 
					VALUES (@MS_MAY,@MS_LOAI_BT,@NGAY_HC_CUOI,@CHU_KY,@MS_DV_TG,@NGAY_KE ) 

					SET @NGAY_KE = (SELECT CASE @MS_DV_TG
						WHEN 1 THEN  DATEADD(DAY,@CHU_KY,@NGAY_KE)
						WHEN 2 THEN DATEADD(DAY,7 * @CHU_KY ,@NGAY_KE)
						WHEN 3 THEN DATEADD(MONTH,@CHU_KY,@NGAY_KE) 
						WHEN 4 THEN DATEADD(YEAR,@CHU_KY,@NGAY_KE)												
						ELSE 
							DATEADD(YEAR,1,@NgayKT)												
						END )
							
				 END	
			FETCH NEXT FROM BTDK_CURSOR 
			INTO @MS_MAY,@MS_LOAI_BT,@NGAY_HC_CUOI,@CHU_KY,@MS_DV_TG,@NGAY_KE
		END	
		CLOSE BTDK_CURSOR 
		DEALLOCATE  BTDK_CURSOR 
	END
	
	return 
	
	
END