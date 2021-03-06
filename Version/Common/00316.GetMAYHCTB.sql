

--exec GetMAYHCTB 'administrator'
ALTER PROC [dbo].[GetMAYHCTB]
	@USERLOGED  NVARCHAR(50)
AS


DECLARE @NgayHT DATETIME
SET @NgayHT = GETDATE()

SELECT * into #MAY FROM [dbo].[MGetMayUserNgay]( @NgayHT,@USERLOGED,'-1',-1,-1,'-1','-1','-1',0)



SELECT DISTINCT A.MS_MAY, A.TEN_MAY AS MSMAY
	FROM         #MAY A
	WHERE     ((isnull(CHU_KY_HC_TB,0) > 0)or(isnull( CHU_KY_HIEU_CHUAN_TB_NGOAI,0)>0) or (isnull(CHU_KY_KD_TB,0)>0))
	AND     (A.MS_HIEN_TRANG = 2)		
	ORDER BY A.MS_MAY, A.TEN_MAY