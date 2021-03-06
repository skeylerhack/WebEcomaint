IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetTimNhanVienUser')
   exec('CREATE PROCEDURE GetTimNhanVienUser AS BEGIN SET NOCOUNT ON; END')
GO




-- exec GetTimNhanVienUser -1,-1,'-1',-1,'TRUNGNV'
ALTER procedure [dbo].[GetTimNhanVienUser]
	@MS_TO INT,
	@MS_PB INT, 
	@MS_DV NVARCHAR(6),
	@VAI_TRO INT = -1,
	@Username NVARCHAR(50)
AS
--SET @MS_TO = -1
--SET @MS_PB = 13
--SET @MS_DV = '-1'
--PRINT @VAI_TRO

SELECT     T2.* INTO #PB_USER
FROM         dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
                      dbo.TO_PHONG_BAN AS T2 ON T1.MS_TO = T2.MS_TO INNER JOIN
                      dbo.USERS AS T3 ON T1.GROUP_ID = T3.GROUP_ID
WHERE        (T3.USERNAME = @Username)  and (T2.MS_DON_VI = @MS_DV or @MS_DV = '-1')

IF @VAI_TRO = -1
BEGIN
PRINT 'A'
	SELECT DISTINCT 
						  TOP (100) PERCENT D.HO + ' ' + D.TEN AS HO_TEN, D.MS_CONG_NHAN, D.NGAY_SINH, D.MS_THE_CC, dbo.Gettenchuyenmon(D.MS_CONG_NHAN) AS CHUYEN_MON, 
						  dbo.Getnhantenbactho(D.MS_CONG_NHAN) AS BAC_THO, C.TEN_TO, A.TEN_TO AS TO_PB, B.TEN_DON_VI, D.HO, D.TEN, 
						  ISNULL(E.TEN_GOI,'') AS TRINH_DO_VH
	FROM         #PB_USER AS A INNER JOIN
						  dbo.DON_VI AS B ON A.MS_DON_VI = B.MS_DON_VI INNER JOIN
						  dbo.[TO] AS C ON A.MS_TO = C.MS_TO INNER JOIN
						  dbo.CONG_NHAN AS D ON C.MS_TO1 = D.MS_TO LEFT JOIN
						  dbo.TRINH_DO_VAN_HOA E ON D.MS_TRINH_DO = E.MS_TRINH_DO						  
	WHERE     (C.MS_TO1 = @MS_TO OR @MS_TO = -1) AND (A.MS_TO = @MS_PB OR @MS_PB = -1) AND (B.MS_DON_VI = @MS_DV OR @MS_DV = '-1')
	ORDER BY D.HO, D.TEN, D.MS_CONG_NHAN
END
ELSE
BEGIN
	SELECT DISTINCT 
						  TOP (100) PERCENT D.HO + ' ' + D.TEN AS HO_TEN, D.MS_CONG_NHAN, D.NGAY_SINH, D.MS_THE_CC, dbo.Gettenchuyenmon(D.MS_CONG_NHAN) AS CHUYEN_MON, 
						  dbo.Getnhantenbactho(D.MS_CONG_NHAN) AS BAC_THO, C.TEN_TO, A.TEN_TO AS TO_PB, B.TEN_DON_VI, D.HO, D.TEN, 
						  ISNULL(E.TEN_GOI,'') AS TRINH_DO_VH
	FROM         #PB_USER AS A INNER JOIN
						  dbo.DON_VI AS B ON A.MS_DON_VI = B.MS_DON_VI INNER JOIN
						  dbo.[TO] AS C ON A.MS_TO = C.MS_TO INNER JOIN
						  dbo.CONG_NHAN AS D ON C.MS_TO1 = D.MS_TO LEFT JOIN
						  dbo.TRINH_DO_VAN_HOA E ON D.MS_TRINH_DO = E.MS_TRINH_DO INNER JOIN                      
						  CONG_NHAN_VAI_TRO F ON D.MS_CONG_NHAN = F.MS_CONG_NHAN
	WHERE     (C.MS_TO1 = @MS_TO OR @MS_TO = -1) AND (A.MS_TO = @MS_PB OR @MS_PB = -1) AND (B.MS_DON_VI = @MS_DV OR @MS_DV = '-1') 
	AND MS_VAI_TRO = COALESCE(@VAI_TRO, MS_VAI_TRO) 
	ORDER BY D.HO, D.TEN, D.MS_CONG_NHAN
END

