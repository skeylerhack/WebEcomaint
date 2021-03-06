
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IsCheckAutomaticInsertSparepartAndTypeOfSparepart')
   exec('CREATE PROCEDURE IsCheckAutomaticInsertSparepartAndTypeOfSparepart AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROC IsCheckAutomaticInsertSparepartAndTypeOfSparepart
	@workOrderID NVARCHAR(20)
AS	
DECLARE @iCount NVARCHAR(20)


SELECT DISTINCT MS_PT INTO #BT_PT FROM (SELECT * FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG WHERE MS_PHIEU_BAO_TRI = @workOrderID) A 

DECLARE @MsLMay NVARCHAR(20)
SELECT  @MsLMay =   dbo.NHOM_MAY.MS_LOAI_MAY
FROM         dbo.PHIEU_BAO_TRI INNER JOIN
                      dbo.MAY ON dbo.PHIEU_BAO_TRI.MS_MAY = dbo.MAY.MS_MAY INNER JOIN
                      dbo.NHOM_MAY ON dbo.MAY.MS_NHOM_MAY = dbo.NHOM_MAY.MS_NHOM_MAY
WHERE     (dbo.PHIEU_BAO_TRI.MS_PHIEU_BAO_TRI = @workOrderID)

Declare @MsPT nvarchar(25)
Declare  TTNhap CURSOR FOR
	SELECT DISTINCT MS_PT FROM #BT_PT
Open TTNhap
FETCH NEXT FROM TTNhap
	INTO @MsPT
	While @@Fetch_Status = 0
	Begin
		SELECT @iCount = COUNT(*) FROM IC_PHU_TUNG_LOAI_MAY WHERE MS_PT = @MsPT AND MS_LOAI_MAY = @MsLMay
		if @iCount = 0 
			INSERT INTO [IC_PHU_TUNG_LOAI_MAY]([MS_PT],[MS_LOAI_MAY]) VALUES (@MsPT,@MsLMay)

		FETCH NEXT FROM TTNhap
	INTO  @MsPT
	End

Close TTNhap
Deallocate TTNhap

--Bước 2:	
--Nếu là phụ tùng, Kiểm tra nếu trên CAU_TRUC_THIET_BI_PHU_TUNG tương ứng với bộ phận của công việc đang chọn 
--(kèm theo khóa MS_MAY của phieu bảo trì) thì insert vào với giá trị như sau: 
--MS_MAY=May phieu bao trì; MS_BO_PHAN=bộ phận của công việc; 
--MS_PHU_TUNG=phụ tùng đang chọn; MS_VI_TRI="A", 
--SO_LUONG=sum (số lượng chọn), ACTIVE=1, CHUC_NANG=NULL
declare @MsMay nvarchar(30)
SELECT @MsMay = MS_MAY FROM PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = @workOrderID
DECLARE @MsBoPhan	nvarchar(50)
DECLARE @MS_PT	nvarchar(50)
Declare @MS_VTRI nvarchar(50)
DECLARE @SLBP float

Declare  TTBoPhan CURSOR FOR
	SELECT DISTINCT A.MS_BO_PHAN, SUM(SL_KH) AS SL,A.MS_PT,A.MS_VI_TRI_PT   FROM 
	(SELECT * FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET WHERE MS_PHIEU_BAO_TRI = @workOrderID)
	 AS A INNER JOIN dbo.IC_PHU_TUNG AS B ON A.MS_PT = B.MS_PT INNER JOIN
						  dbo.LOAI_VT AS C ON B.MS_LOAI_VT = C.MS_LOAI_VT
	WHERE     (ISNULL(C.VAT_TU, 0) = 0) 
	GROUP BY A.MS_BO_PHAN, A.MS_PT,A.MS_VI_TRI_PT
	
	Open TTBoPhan
	FETCH NEXT FROM TTBoPhan
		INTO @MsBoPhan,@SLBP, @MS_PT, @MS_VTRI
		While @@Fetch_Status = 0
		Begin
						SELECT @iCount = COUNT(*) FROM CAU_TRUC_THIET_BI_PHU_TUNG WHERE  MS_BO_PHAN = @MsBoPhan AND
						MS_MAY = @MsMay  AND MS_PT = @MS_PT AND MS_VI_TRI_PT = @MS_VTRI
						if @iCount = 0 
						BEGIN
							IF NOT EXISTS (SELECT * FROM CAU_TRUC_THIET_BI WHERE 
							MS_BO_PHAN = @MsBoPhan AND MS_MAY = @MsMay AND MS_PT = @MS_PT)	
							BEGIN					
								INSERT INTO [CAU_TRUC_THIET_BI_PHU_TUNG]([MS_MAY],[MS_BO_PHAN],
								[MS_PT],[MS_VI_TRI_PT],[SO_LUONG],[ACTIVE]) 
								VALUES (@MsMay,@MsBoPhan,@MS_PT,@MS_VTRI,@SLBP,1)			
							END
						END

				
		FETCH NEXT FROM TTBoPhan
		INTO  @MsBoPhan,@SLBP, @MS_PT, @MS_VTRI
		End

	Close TTBoPhan
	Deallocate TTBoPhan


--Cap nhap cong viec vao Cau Truc Thiet Bi Cong Viec Doi voi nhung cong viec moi
INSERT INTO [dbo].[CAU_TRUC_THIET_BI_CONG_VIEC] ([MS_MAY],[MS_BO_PHAN],[MS_CV],[GHI_CHU],[ACTIVE], TG_KH)
SELECT @MsMay AS [MS_MAY],[MS_BO_PHAN],[MS_CV],GHI_CHU,1,SO_GIO_KH 
FROM PHIEU_BAO_TRI_CONG_VIEC T1 WHERE (MS_PHIEU_BAO_TRI = @workOrderID) AND NOT EXISTS 
(SELECT * FROM CAU_TRUC_THIET_BI_CONG_VIEC T2 WHERE MS_MAY = @MsMay AND T2.MS_BO_PHAN = T1.MS_BO_PHAN AND T2.MS_CV = T1.MS_CV )