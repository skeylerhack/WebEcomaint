
 ----exec sp_TinhHinhYeuCauBT 2, 'admin',1
ALTER PROC [dbo].[sp_TinhHinhYeuCauBT]
	@LoaiOption int, 
	@sUser nvarchar(50),
	@NNgu int,
	@TenTT  nvarchar(250) = NULL
as
begin


	--declare @TableMayUser table (MS_MAY nvarchar(50))
	--insert into @TableMayUser (MS_MAY)
	--SELECT distinct MS_MAY FROM [dbo].[MashjGetMayUser] (@sUser)
	DECLARE @NgayHT DATETIME
	SET @NgayHT = GETDATE()
	
	SELECT  * INTO #MAY_USER FROM [dbo].[MGetMayUserNgay]( @NgayHT,@sUser,'-1',-1,-1,'-1','-1','-1',@NNgu)

	DECLARE @TABLEDS Table (STT INT,STT_VAN_DE INT,MS_MAY nvarchar(300),TEN_MAY nvarchar(300) ,MO_TA_TINH_TRANG nvarchar(300),
		YEU_CAU nvarchar(300),MS_UU_TIEN nvarchar(300),TEN_UU_TIEN nvarchar(300),USERNAME_DSX nvarchar(300) ,THOI_GIAN_DSX datetime,
		Y_KIEN_DSX nvarchar(300),USERNAME_DBT nvarchar(300),NGAY_DBT datetime,Y_KIEN_DBT nvarchar(300),MS_CACH_TH nvarchar(300),TEN_TIENG_VIET nvarchar(300),
		MS_PBT nvarchar(300) , EMAIL_DBT nvarchar(300),MS_CONG_NHAN nvarchar(300),NGUOI_PHU_TRACH nvarchar(300),NGAY_GIO_YEU_CAU datetime, 
		NGAY_BD_KH datetime, NGAY_KT_KH datetime, TEN_TINH_TRANG nvarchar(300) ,TINH_TRANG_PBT nvarchar(300),THUC_HIEN_DSX BIT,
		MS_YEU_CAU NVARCHAR(50),SO_YEU_CAU NVARCHAR(250),Ten_N_XUONG NVARCHAR(100),HANG_MUC_ID_KE_HOACH INT,TEN_HANG_MUC nvarchar(50),
		TEN_LOAI_YEU_CAU_BT nvarchar(250),TEN_NGUYEN_NHAN nvarchar(250))



	INSERT INTO @TABLEDS (STT,STT_VAN_DE,MS_MAY ,TEN_MAY,MO_TA_TINH_TRANG ,YEU_CAU,MS_UU_TIEN ,TEN_UU_TIEN ,USERNAME_DSX ,THOI_GIAN_DSX ,
					Y_KIEN_DSX ,USERNAME_DBT ,NGAY_DBT ,Y_KIEN_DBT ,MS_CACH_TH ,TEN_TIENG_VIET , MS_PBT , EMAIL_DBT ,MS_CONG_NHAN, 
					NGUOI_PHU_TRACH,NGAY_GIO_YEU_CAU,NGAY_BD_KH,NGAY_KT_KH,TEN_TINH_TRANG,TINH_TRANG_PBT,THUC_HIEN_DSX,
					MS_YEU_CAU,SO_YEU_CAU,Ten_N_XUONG,HANG_MUC_ID_KE_HOACH,TEN_HANG_MUC,TEN_LOAI_YEU_CAU_BT,TEN_NGUYEN_NHAN)
	SELECT     T2.STT, T2.STT_VAN_DE, T2.MS_MAY, T3.TEN_MAY, T2.MO_TA_TINH_TRANG, T2.YEU_CAU, T2.MS_UU_TIEN, T6.TEN_UU_TIEN, T2.USERNAME_DSX, T2.THOI_GIAN_DSX, T2.Y_KIEN_DSX, 
						  T2.USERNAME_DBT, T2.NGAY_DBT, T2.Y_KIEN_DBT, T2.MS_CACH_TH, T9.TEN_TIENG_VIET, T2.MS_PBT, T2.EMAIL_DBT, 
						  T2.MS_CONG_NHAN, T1.HO + ' ' + T1.TEN AS NGUOI_PHU_TRACH, 
						  CONVERT(DATETIME, CONVERT(nvarchar(10), T4.NGAY, 20) + ' ' + CONVERT(nvarchar(10), T4.GIO_YEU_CAU, 108)) AS NGAY_GIO, 
						  T8.NGAY_BD_KH, T8.NGAY_KT_KH, T7.TEN_TINH_TRANG, 
						  T8.TINH_TRANG_PBT, T2.THUC_HIEN_DSX, T4.MS_YEU_CAU, T4.SO_YEU_CAU, 
						  T3.Ten_N_XUONG, T2.HANG_MUC_ID_KE_HOACH, T10.TEN_HANG_MUC,TEN_LOAI_YEU_CAU_BT,T12.TEN_NGUYEN_NHAN
	FROM         dbo.CONG_NHAN AS T1 RIGHT OUTER JOIN
						  dbo.YEU_CAU_NSD_CHI_TIET AS T2 INNER JOIN
						  #MAY_USER AS T3 ON T2.MS_MAY = T3.MS_MAY INNER JOIN
						  dbo.YEU_CAU_NSD AS T4 ON T2.STT = T4.STT LEFT OUTER JOIN
						  dbo.MUC_UU_TIEN AS T6 ON T2.MS_UU_TIEN = T6.MS_UU_TIEN ON T1.MS_CONG_NHAN = T2.MS_CONG_NHAN LEFT OUTER JOIN
						  dbo.TINH_TRANG_PBT AS T7 INNER JOIN
						  dbo.PHIEU_BAO_TRI AS T8 ON T7.STT = T8.TINH_TRANG_PBT ON T2.MS_PBT = T8.MS_PHIEU_BAO_TRI LEFT OUTER JOIN
						  dbo.CACH_THUC_HIEN AS T9 ON T2.MS_CACH_TH = T9.MS_CACH_TH LEFT OUTER JOIN
						  dbo.KE_HOACH_TONG_THE AS T10 ON T2.HANG_MUC_ID_KE_HOACH = T10.HANG_MUC_ID LEFT JOIN 
						  LOAI_YEU_CAU_BAO_TRI T11 ON T2.MS_LOAI_YEU_CAU_BT = T11.MS_LOAI_YEU_CAU_BT LEFT JOIN 
						  NGUYEN_NHAN_DUNG_MAY T12 ON T12.MS_NGUYEN_NHAN = T2.MS_NGUYEN_NHAN
	      
	  if @LoaiOption =0     
		  SELECT STT ,STT_VAN_DE ,MS_MAY ,TEN_MAY,TEN_LOAI_YEU_CAU_BT,TEN_NGUYEN_NHAN, MO_TA_TINH_TRANG ,YEU_CAU ,MS_YEU_CAU,SO_YEU_CAU,Ten_N_XUONG,MS_UU_TIEN ,TEN_UU_TIEN, @TenTT AS  TEN_TINH_TRANG  ,USERNAME_DSX ,THOI_GIAN_DSX ,
				Y_KIEN_DSX ,USERNAME_DBT ,NGAY_DBT ,Y_KIEN_DBT ,MS_CACH_TH ,TEN_TIENG_VIET ,TEN_HANG_MUC,MS_PBT , EMAIL_DBT ,
				MS_CONG_NHAN ,NGUOI_PHU_TRACH ,NGAY_GIO_YEU_CAU ,NGAY_BD_KH , NGAY_KT_KH , TINH_TRANG_PBT ,HANG_MUC_ID_KE_HOACH
		  FROM @TABLEDS 
		  WHERE THUC_HIEN_DSX=1 and MS_CACH_TH is null
		  
	  if @LoaiOption =1     
		  SELECT STT ,STT_VAN_DE ,MS_MAY ,TEN_MAY,TEN_LOAI_YEU_CAU_BT,TEN_NGUYEN_NHAN,MO_TA_TINH_TRANG ,YEU_CAU ,MS_YEU_CAU,SO_YEU_CAU,Ten_N_XUONG,MS_UU_TIEN ,TEN_UU_TIEN , @TenTT AS TEN_TINH_TRANG ,USERNAME_DSX ,THOI_GIAN_DSX ,
				Y_KIEN_DSX ,USERNAME_DBT ,NGAY_DBT ,Y_KIEN_DBT ,MS_CACH_TH ,TEN_TIENG_VIET ,TEN_HANG_MUC,MS_PBT , EMAIL_DBT ,
				MS_CONG_NHAN ,NGUOI_PHU_TRACH ,NGAY_GIO_YEU_CAU ,NGAY_BD_KH , NGAY_KT_KH , TINH_TRANG_PBT ,HANG_MUC_ID_KE_HOACH
		  FROM @TABLEDS
		  WHERE MS_CACH_TH ='06'
	  if @LoaiOption =2
		  SELECT STT ,STT_VAN_DE ,MS_MAY ,TEN_MAY,TEN_LOAI_YEU_CAU_BT,TEN_NGUYEN_NHAN,MO_TA_TINH_TRANG ,YEU_CAU ,MS_YEU_CAU,SO_YEU_CAU,Ten_N_XUONG,MS_UU_TIEN ,TEN_UU_TIEN ,@TenTT AS TEN_TINH_TRANG ,USERNAME_DSX ,THOI_GIAN_DSX ,
				Y_KIEN_DSX ,USERNAME_DBT ,NGAY_DBT ,Y_KIEN_DBT ,MS_CACH_TH ,TEN_TIENG_VIET ,TEN_HANG_MUC,MS_PBT , EMAIL_DBT ,
				MS_CONG_NHAN ,NGUOI_PHU_TRACH ,NGAY_GIO_YEU_CAU ,NGAY_BD_KH , NGAY_KT_KH , TINH_TRANG_PBT ,HANG_MUC_ID_KE_HOACH
		  FROM @TABLEDS
		  WHERE MS_CACH_TH ='01'  AND ISNULL(MS_PBT,'') = ''
	   if @LoaiOption =3
		  SELECT STT ,STT_VAN_DE ,MS_MAY ,TEN_MAY,TEN_LOAI_YEU_CAU_BT,TEN_NGUYEN_NHAN,MO_TA_TINH_TRANG ,YEU_CAU ,MS_YEU_CAU,SO_YEU_CAU,Ten_N_XUONG,MS_UU_TIEN ,TEN_UU_TIEN , TEN_TINH_TRANG ,USERNAME_DSX ,THOI_GIAN_DSX ,
				Y_KIEN_DSX ,USERNAME_DBT ,NGAY_DBT ,Y_KIEN_DBT ,MS_CACH_TH ,TEN_TIENG_VIET,TEN_HANG_MUC ,MS_PBT , EMAIL_DBT ,
				MS_CONG_NHAN ,NGUOI_PHU_TRACH ,NGAY_GIO_YEU_CAU ,NGAY_BD_KH , NGAY_KT_KH ,TINH_TRANG_PBT ,HANG_MUC_ID_KE_HOACH
		  FROM @TABLEDS
		  WHERE (MS_CACH_TH ='04' OR MS_CACH_TH ='01') AND (TINH_TRANG_PBT <3) AND (ISNULL(MS_PBT,'') <> '')
	   if @LoaiOption =4     
		  SELECT STT ,STT_VAN_DE ,MS_MAY ,TEN_MAY,TEN_LOAI_YEU_CAU_BT,TEN_NGUYEN_NHAN,MO_TA_TINH_TRANG ,YEU_CAU ,MS_YEU_CAU,SO_YEU_CAU,Ten_N_XUONG,MS_UU_TIEN ,TEN_UU_TIEN , TEN_TINH_TRANG ,USERNAME_DSX ,THOI_GIAN_DSX ,
				Y_KIEN_DSX ,USERNAME_DBT ,NGAY_DBT ,Y_KIEN_DBT ,MS_CACH_TH ,TEN_TIENG_VIET,TEN_HANG_MUC ,MS_PBT , EMAIL_DBT ,
				MS_CONG_NHAN ,NGUOI_PHU_TRACH ,NGAY_GIO_YEU_CAU ,NGAY_BD_KH , NGAY_KT_KH ,TINH_TRANG_PBT ,HANG_MUC_ID_KE_HOACH
		  FROM @TABLEDS
		  WHERE (MS_CACH_TH = '04' OR MS_CACH_TH ='01') AND (TINH_TRANG_PBT >=3) AND (ISNULL(MS_PBT,'') <> '') 
	    if @LoaiOption =5
		  SELECT STT ,STT_VAN_DE ,MS_MAY ,TEN_MAY,TEN_LOAI_YEU_CAU_BT,TEN_NGUYEN_NHAN,MO_TA_TINH_TRANG ,YEU_CAU ,MS_YEU_CAU,SO_YEU_CAU,Ten_N_XUONG,MS_UU_TIEN ,TEN_UU_TIEN , @TenTT AS TEN_TINH_TRANG ,USERNAME_DSX ,THOI_GIAN_DSX ,
				Y_KIEN_DSX ,USERNAME_DBT ,NGAY_DBT ,Y_KIEN_DBT ,MS_CACH_TH ,TEN_TIENG_VIET ,TEN_HANG_MUC,MS_PBT , EMAIL_DBT ,
				MS_CONG_NHAN ,NGUOI_PHU_TRACH ,NGAY_GIO_YEU_CAU ,NGAY_BD_KH , NGAY_KT_KH , TINH_TRANG_PBT ,HANG_MUC_ID_KE_HOACH
		  FROM @TABLEDS
		  WHERE MS_CACH_TH ='03'
  end		
      
