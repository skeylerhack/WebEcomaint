--exec SP_Y_GET_DCDDHHC 'administrator',0,'01/01/2011','12/31/2015','-1','-1','-1','-1','administrator','-1','-1','-1',-1
--exec SP_Y_GET_DCDDHHC 'administrator',0,'01/01/2011','01/31/2016','-1','-1','-1','-1','administrator','-1','-1','-1',-1

ALTER procedure [dbo].[SP_Y_GET_DCDDHHC]
	@USERNAME NVARCHAR (64), 
	@LANGUAGE INT,
	@TU_NGAY DATETIME,
	@DEN_NGAY DATETIME,
	@MS_N_XUONG NVARCHAR (50), 
	@MS_HE_THONG INT ,
	@MS_LOAI_MAY NVARCHAR(30),
	@MS_MAY NVARCHAR (30), 
	@IDIP NVARCHAR (64),
	@MS_TINH NVARCHAR(50),
	@MS_QUAN NVARCHAR(50),
	@MS_DUONG NVARCHAR(50), 
	@LHC INT	
AS
BEGIN 

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE [NAME] = 'Nhac_viec_temp' AND XTYPE = 'U' )
BEGIN DROP TABLE Nhac_viec_temp END ;
IF @MS_N_XUONG='-1'
BEGIN
	SELECT MS_N_XUONG  INTO Nhac_viec_temp FROM NHA_XUONG 
END
ELSE
BEGIN
CREATE TABLE Nhac_viec_temp(MS_N_XUONG NVARCHAR(50))
DECLARE @NewInsertCount int;
INSERT INTO Nhac_viec_temp(MS_N_XUONG)
SELECT MS_N_XUONG FROM NHA_XUONG  WHERE MS_N_XUONG = @MS_N_XUONG;
SET @NewInsertCount = @@ROWCOUNT;
WHILE @NewInsertCount > 0
BEGIN
    -- I am not going to describe all the SQL, but the idea is
    -- that we insert into #Nhac_viec_temp all Folder Ids which are “Nhac_viec_temp” to
    INSERT INTO Nhac_viec_temp(MS_N_XUONG) 
        SELECT MS_N_XUONG FROM NHA_XUONG  WHERE EXISTS
               (SELECT MS_N_XUONG  FROM Nhac_viec_temp
                WHERE NHA_XUONG.MS_CHA = Nhac_viec_temp.MS_N_XUONG)
         AND  NOT EXISTS
              (SELECT MS_N_XUONG FROM Nhac_viec_temp
               WHERE NHA_XUONG.MS_N_XUONG  = Nhac_viec_temp.MS_N_XUONG);    
    
         SET @NewInsertCount = @@ROWCOUNT;
         -- if the value is 0 then there were no new
         -- Nhac_viec_temp inserted thus no "grandNhac_viec_temp" expected;
END
END

SELECT TEMP.MS_MAY,TEMP.TEN_MAY,TEMP.MS_PT,TEMP.TEN_PT,TEMP.MS_VI_TRI,CONVERT(NVARCHAR(10),TEMP.NGAY,103)NGAY,TEMP.CHU_KY_HC,CONVERT(NVARCHAR(10),TEMP.NGAY_HC_KE,103)NGAY_HC_KE,TEMP.NOI,TEMP.LOAI_HC  FROM
(
		SELECT MS_TINH=[dbo].[Get_CityCode](NHA_XUONG.MS_QG),MS_QUAN = NHA_XUONG.MS_QG,NHA_XUONG.MS_DUONG, TEMP.* FROM
		(
				SELECT X.MS_N_XUONG,A.MS_MAY, CASE @LANGUAGE WHEN 1 THEN A.TEN_MAY WHEN 2 THEN A.TEN_MAY ELSE A.TEN_MAY END AS TEN_MAY, 
						B.MS_PT, CASE @LANGUAGE WHEN 1 THEN C.TEN_PT WHEN 2 THEN C.TEN_PT ELSE C.TEN_PT END AS TEN_PT,
						B.MS_VI_TRI, B.NGAY, 
						CONVERT(VARCHAR(8),
							CASE 
								WHEN B.MS_LOAI_HIEU_CHUAN = 1 THEN ISNULL(D.CHU_KY_HC_NOI, 0) 								
								WHEN B.MS_LOAI_HIEU_CHUAN = 2 THEN ISNULL(D.CHU_KY_HC_NGOAI, 0) 
								WHEN B.MS_LOAI_HIEU_CHUAN = 3 THEN ISNULL(D.CHU_KY_KD, 0) 								
								WHEN B.MS_LOAI_HIEU_CHUAN = 4 THEN ISNULL(D.CHU_KY_KT, 0) END
								) + ' ' + E.TEN_DV_TG AS CHU_KY_HC, 
							
							
					  CONVERT(DATETIME, dbo.MashjGetNgayDHHC(A.MS_MAY, B.MS_PT, B.MS_VI_TRI, B.MS_LOAI_HIEU_CHUAN, B.NOI)) AS NGAY_HC_KE, 					  
					  B.MS_LOAI_HIEU_CHUAN AS NOI,
					  
					  
						TEN_LOAI_HIEU_CHUAN AS LOAI_HC
						
				FROM         dbo.MAY AS A INNER JOIN
										  (SELECT     MS_MAY, MS_PT, MS_VI_TRI, MAX(NGAY) AS NGAY, MS_LOAI_HIEU_CHUAN, NOI
											FROM          dbo.HIEU_CHUAN_DHD AS T
											GROUP BY MS_MAY, MS_PT, MS_VI_TRI, MS_LOAI_HIEU_CHUAN, NOI
											) AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
									  dbo.IC_PHU_TUNG AS C ON B.MS_PT = C.MS_PT INNER JOIN
									  dbo.CHU_KY_HIEU_CHUAN AS D ON B.MS_MAY = D.MS_MAY AND B.MS_PT = D.MS_PT AND B.MS_VI_TRI = D.MS_VI_TRI INNER JOIN
									  dbo.DON_VI_THOI_GIAN AS E ON D.MS_DV_TG = E.MS_DV_TG INNER JOIN
									  dbo.NHOM_MAY AS F ON A.MS_NHOM_MAY = F.MS_NHOM_MAY INNER JOIN
										  (SELECT     T1.MS_MAY, T2.MS_N_XUONG, T1.NGAY_NHAP
											FROM          (SELECT     MS_MAY, MAX(NGAY_NHAP) AS NGAY_NHAP
																	FROM          dbo.MAY_NHA_XUONG AS T
																	GROUP BY MS_MAY) AS T1 INNER JOIN
																   dbo.MAY_NHA_XUONG AS T2 ON T1.MS_MAY = T2.MS_MAY AND T1.NGAY_NHAP = T2.NGAY_NHAP) AS X ON 
									  A.MS_MAY = X.MS_MAY INNER JOIN
									  dbo.LOAI_MAY AS G ON F.MS_LOAI_MAY = G.MS_LOAI_MAY INNER JOIN
									  dbo.NHOM_LOAI_MAY AS H ON G.MS_LOAI_MAY = H.MS_LOAI_MAY INNER JOIN
									  dbo.USERS AS K ON H.GROUP_ID = K.GROUP_ID INNER JOIN
									  dbo.NHOM_NHA_XUONG AS L ON H.GROUP_ID = L.GROUP_ID AND X.MS_N_XUONG = L.MS_N_XUONG INNER JOIN
										  (SELECT     T1_1.MS_MAY, T2.MS_HE_THONG, T1_1.NGAY_NHAP
											FROM          (SELECT     MS_MAY, MAX(NGAY_NHAP) AS NGAY_NHAP
																	FROM          dbo.MAY_HE_THONG AS T
																	GROUP BY MS_MAY) AS T1_1 INNER JOIN
																   dbo.MAY_HE_THONG AS T2 ON T1_1.MS_MAY = T2.MS_MAY AND T1_1.NGAY_NHAP = T2.NGAY_NHAP) AS MAY_HE_THONG_TMP ON 
									  A.MS_MAY = MAY_HE_THONG_TMP.MS_MAY INNER JOIN
									  dbo.NHOM_HE_THONG AS M ON H.GROUP_ID = M.GROUP_ID AND MAY_HE_THONG_TMP.MS_HE_THONG = M.MS_HE_THONG INNER JOIN
									  dbo.NHA_XUONG AS Y ON L.MS_N_XUONG = Y.MS_N_XUONG INNER JOIN LOAI_HIEU_CHUAN ON B.MS_LOAI_HIEU_CHUAN = LOAI_HIEU_CHUAN.MS_LOAI_HIEU_CHUAN 
									  INNER JOIN Nhac_viec_temp T1 ON Y.MS_N_XUONG = T1.MS_N_XUONG
				WHERE     (K.USERNAME = @USERNAME) 
							AND CONVERT(DATETIME, dbo.MashjGetNgayDHHC(A.MS_MAY, B.MS_PT, B.MS_VI_TRI, 
								B.MS_LOAI_HIEU_CHUAN, B.NOI)) BETWEEN @TU_NGAY AND @DEN_NGAY
							AND '1'=(CASE WHEN @MS_HE_THONG='-1' THEN '1' WHEN @MS_HE_THONG<>'-1' AND MAY_HE_THONG_TMP.MS_HE_THONG =  CONVERT (NVARCHAR (4), @MS_HE_THONG) THEN '1' ELSE '0' END) 
							AND '1'=(CASE WHEN @MS_LOAI_MAY='-1' THEN '1' WHEN @MS_LOAI_MAY<>'-1' AND G.MS_LOAI_MAY =@MS_LOAI_MAY THEN '1' ELSE '0' END)
							AND '1'=(CASE WHEN @MS_MAY='-1' THEN '1' WHEN @MS_MAY<>'-1' AND A.MS_MAY =@MS_MAY THEN '1' ELSE '0' END)
							AND (B.MS_LOAI_HIEU_CHUAN = @LHC OR @LHC = -1)
		)TEMP INNER JOIN NHA_XUONG ON TEMP.MS_N_XUONG=NHA_XUONG.MS_N_XUONG

)TEMP WHERE '1'='1'
AND '1'=(CASE WHEN @MS_TINH='-1' THEN '1' WHEN @MS_TINH<>'-1' AND TEMP.MS_TINH =@MS_TINH THEN '1' ELSE '0' END)
AND '1'=(CASE WHEN @MS_QUAN='-1' THEN '1' WHEN @MS_QUAN<>'-1' AND TEMP.MS_QUAN  =@MS_QUAN THEN '1' ELSE '0' END)
AND '1'=(CASE WHEN @MS_DUONG='-1' THEN '1' WHEN @MS_DUONG<>'-1' AND TEMP.MS_DUONG =@MS_DUONG THEN '1' ELSE '0' END)
END
