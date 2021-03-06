
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetChuyenMonBacTho_CONGNHAN')
   exec('CREATE PROCEDURE spGetChuyenMonBacTho_CONGNHAN AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC spGetChuyenMonBacTho_CONGNHAN
	@MS_CONG_NHAN NVARCHAR(20)
AS

BEGIN

	SELECT T.MS_CONG_NHAN, T.MS_CHUYEN_MON,T3.TEN_CHUYEN_MON, ISNULL(T1.MS_BAC_THO, -1) AS MS_BAC_THO, ISNULL(T2.TEN_BAC_THO, '') AS  TEN_BAC_THO, CONVERT(NVARCHAR(20), T1.NGAY, 103) AS NGAY, CONVERT(INT, 0) AS DEL FROM CONG_NHAN_CHUYEN_MON T LEFT JOIN CONG_NHAN_CHUYEN_MON_BAC_THO T1
	ON T.MS_CHUYEN_MON = T1.MS_CHUYEN_MON AND T.MS_CONG_NHAN = T1.MS_CONG_NHAN 
	LEFT JOIN BAC_THO T2 ON T2.MS_BAC_THO = T1.MS_BAC_THO 
	LEFT JOIN CHUYEN_MON T3 ON T3.MS_CHUYEN_MON = T.MS_CHUYEN_MON 
	WHERE T.MS_CONG_NHAN = @MS_CONG_NHAN 
END