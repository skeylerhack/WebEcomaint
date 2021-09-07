
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetHeThongTreeListAll')
   exec('CREATE PROCEDURE GetHeThongTreeListAll AS BEGIN SET NOCOUNT ON; END')
GO

-- GetHeThongTreeListAll 1,'ADMIN',0
ALTER proc [dbo].[GetHeThongTreeListAll]
	@CoALL bit,	
	@UserName nvarchar(50),
	@NNgu int
AS
if @CoALL = 0
	SELECT DISTINCT T1.MS_HE_THONG, CASE @NNgu WHEN 0 THEN T1.TEN_HE_THONG WHEN 1 THEN T1.TEN_HE_THONG_ANH ELSE T1.TEN_HE_THONG_HOA END AS TEN_HE_THONG, T1.MS_CHA, ISNULL(STT,9999) AS STT
	FROM            HE_THONG AS T1 INNER JOIN
								dbo.NHOM_HE_THONG AS T2 ON T1.MS_HE_THONG = T2.MS_HE_THONG INNER JOIN
								dbo.USERS AS T3 ON T2.GROUP_ID = T3.GROUP_ID
	WHERE        (T3.USERNAME = @UserName)	
	ORDER BY ISNULL(STT,9999) ,CASE @NNgu WHEN 0 THEN T1.TEN_HE_THONG WHEN 1 THEN T1.TEN_HE_THONG_ANH ELSE T1.TEN_HE_THONG_HOA END

else

	SELECT DISTINCT T1.MS_HE_THONG, CASE @NNgu WHEN 0 THEN T1.TEN_HE_THONG WHEN 1 THEN T1.TEN_HE_THONG_ANH ELSE T1.TEN_HE_THONG_HOA END AS TEN_HE_THONG, ISNULL(T1.MS_CHA,-1) AS MS_CHA, ISNULL(STT,9999) AS STT
	FROM            HE_THONG AS T1 INNER JOIN
								dbo.NHOM_HE_THONG AS T2 ON T1.MS_HE_THONG = T2.MS_HE_THONG INNER JOIN
								dbo.USERS AS T3 ON T2.GROUP_ID = T3.GROUP_ID
	WHERE        (T3.USERNAME = @UserName)
	UNION
	SELECT '-1', ' < ALL > ', NULL,-1
	ORDER BY ISNULL(STT,9999) ,CASE @NNgu WHEN 0 THEN T1.TEN_HE_THONG WHEN 1 THEN T1.TEN_HE_THONG_ANH ELSE T1.TEN_HE_THONG_HOA END



