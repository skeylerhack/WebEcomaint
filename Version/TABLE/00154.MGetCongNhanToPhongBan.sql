IF  EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'MGetCongNhanToPhongBan')
  DROP  FUNCTION [dbo].MGetCongNhanToPhongBan
GO

---SELECT * FROM dbo.MGetCongNhanToPhongBan('dannc','-1','HN',-1,-1,0)
CREATE FUNCTION [dbo].MGetCongNhanToPhongBan
(
	@UserName NVARCHAR(50) = 'admin',
	@MsCN NVARCHAR(50) = '-1',
	@MsDVi NVARCHAR(100) = '-1',
	@MsPhongBan int = -1,
	@MsTo int = -1,
	@NNgu int = 0
)

returns @NLMTMP TABLE (
	[MS_CONG_NHAN] [nvarchar](9) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](50) NULL,
	[NGAY_SINH] [datetime] NULL,
	[NOI_SINH] [nvarchar](255) NULL,
	[PHAI] [bit] NOT NULL,
	[DIA_CHI_THUONG_TRU] [nvarchar](100) NULL,
	[SO_CMND] [nvarchar](10) NULL,
	[NGAY_CAP] [datetime] NULL,
	[NOI_CAP] [nvarchar](50) NULL,
	[NGAY_VAO_LAM] [datetime] NULL,
	[BO_VIEC] [bit] NOT NULL,
	[NGAY_NGHI_VIEC] [datetime] NULL,
	[LY_DO_NGHI] [nvarchar](255) NULL,
	[MS_TRINH_DO] [smallint] NULL,
	[NGOAI_NGU] [nvarchar](20) NULL,
	[HINH_CN] [nvarchar](255) NULL,
	[GHI_CHU] [nvarchar](255) NULL,
	[MS_THE_CC] [nvarchar](9) NULL,
	[SO_DT_NHA_RIENG] [nvarchar](15) NULL,
	[SO_DTDD] [nvarchar](15) NULL,
	[TEN_NGUOI_THAN] [nvarchar](50) NULL,
	[QUAN_HE] [nvarchar](50) NULL,
	[BANG_CAP] [nvarchar](255) NULL,
	[USER_MAIL] [nvarchar](150) NULL,
	[TEN_TO] [nvarchar](50) NULL,
	[TEN_PHONG_BAN] [nvarchar](50) NULL,
	[MS_TO] [int] NOT NULL,
	[MS_PHONG_BAN] [int] NOT NULL,
	[USERNAME] [nvarchar](50) NOT NULL,
	[TEN_DON_VI] [nvarchar](500) NOT NULL,
	[TEN_NGAN] [nvarchar](20) NULL,
	[MS_DON_VI] [nvarchar](6) NOT NULL,
	[HOTEN] [nvarchar](500) NOT NULL
)
as 
begin

	INSERT INTO @NLMTMP([MS_CONG_NHAN],[HO],[TEN],[NGAY_SINH],[NOI_SINH],[PHAI],[DIA_CHI_THUONG_TRU],[SO_CMND],[NGAY_CAP],[NOI_CAP],[NGAY_VAO_LAM],[BO_VIEC],[NGAY_NGHI_VIEC],[LY_DO_NGHI],[MS_TRINH_DO],[NGOAI_NGU],[HINH_CN],[GHI_CHU],[MS_THE_CC],[SO_DT_NHA_RIENG],[SO_DTDD],[TEN_NGUOI_THAN],[QUAN_HE],[BANG_CAP],[USER_MAIL],[TEN_TO],[TEN_PHONG_BAN],[MS_TO],[MS_PHONG_BAN],[USERNAME],[TEN_DON_VI],[TEN_NGAN],[MS_DON_VI],HOTEN)
	SELECT        T1.MS_CONG_NHAN, T1.HO, T1.TEN, T1.NGAY_SINH, T1.NOI_SINH, T1.PHAI, T1.DIA_CHI_THUONG_TRU, T1.SO_CMND, T1.NGAY_CAP, T1.NOI_CAP, T1.NGAY_VAO_LAM, T1.BO_VIEC, T1.NGAY_NGHI_VIEC, T1.LY_DO_NGHI, 
                        T1.MS_TRINH_DO, T1.NGOAI_NGU, T1.HINH_CN, T1.GHI_CHU, T1.MS_THE_CC, T1.SO_DT_NHA_RIENG, T1.SO_DTDD, T1.TEN_NGUOI_THAN, T1.QUAN_HE, T1.BANG_CAP, T1.USER_MAIL, T2.TEN_TO, 
                        T3.TEN_TO AS TEN_PHONG_BAN, T1.MS_TO, T2.MS_TO AS MS_PHONG_BAN, T5.USERNAME, 
						CASE @NNgu WHEN 0 THEN T6.TEN_DON_VI WHEN 1 THEN ISNULL(NULLIF(T6.TEN_DON_VI_ANH, ''), T6.TEN_DON_VI) ELSE ISNULL(NULLIF(T6.TEN_DON_VI_HOA, ''), T6.TEN_DON_VI) END AS TEN_DON_VI					
						, T6.TEN_NGAN, T3.MS_DON_VI, HO + ' ' + TEN AS HOTEN
	FROM            dbo.CONG_NHAN AS T1 INNER JOIN
								dbo.[TO] AS T2 ON T1.MS_TO = T2.MS_TO1 INNER JOIN
								dbo.TO_PHONG_BAN AS T3 ON T2.MS_TO = T3.MS_TO INNER JOIN
								dbo.NHOM_TO_PHONG_BAN AS T4 ON T3.MS_TO = T4.MS_TO INNER JOIN
								dbo.USERS AS T5 ON T4.GROUP_ID = T5.GROUP_ID INNER JOIN
								dbo.DON_VI AS T6 ON T3.MS_DON_VI = T6.MS_DON_VI
	WHERE        (T5.USERNAME = @UserName OR @UserName = '-1') 
	AND (T1.MS_CONG_NHAN = @MsCN OR @MsCN = '-1') AND (T3.MS_DON_VI = @MsDVi OR @MsDVi = '-1')  AND (T2.MS_TO = @MsPhongBan OR @MsPhongBan = -1)  AND (T1.MS_TO = @MsTo OR @MsTo = -1) 
	ORDER BY MS_CONG_NHAN

return
END
