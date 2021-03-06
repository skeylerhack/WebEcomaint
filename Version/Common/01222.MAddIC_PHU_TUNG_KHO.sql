ALTER proc [dbo].[MAddIC_PHU_TUNG_KHO]
		@MS_PT nvarchar(25),
		@MS_KHO int,
		@MS_VI_TRI int,
		@TON_TOI_THIEU float,
		@TON_KHO_MAX float,
		@GHI_CHU nvarchar(100),
		@SO_NGAY_DAT_MUA_HANG int

AS


	INSERT INTO [dbo].[IC_PHU_TUNG_KHO]
           ([MS_PT]
           ,[MS_KHO]
           ,[MS_VI_TRI]
           ,[TON_TOI_THIEU]
           ,[TON_KHO_MAX]
           ,[GHI_CHU],SO_NGAY_DAT_MUA_HANG)
     VALUES
           (@MS_PT,
           @MS_KHO,
           (SELECT TOP 1 ISNULL(MS_VI_TRI, NULL) FROM VI_TRI_KHO WHERE MS_KHO = @MS_KHO AND (GHI_CHU <> '' OR GHI_CHU IS NOT NULL)),
           @TON_TOI_THIEU,
           @TON_KHO_MAX,
           @GHI_CHU,@SO_NGAY_DAT_MUA_HANG)


