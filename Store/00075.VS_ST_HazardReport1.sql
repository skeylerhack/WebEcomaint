IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'VS_ST_HazardReport1')
   exec('CREATE PROCEDURE VS_ST_HazardReport1 AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC  [dbo].[VS_ST_HazardReport1]
(
	@ID int = 22064
)
AS	
	BEGIN
		UPDATE [dbo].[ST_HazardReport1]
		SET [Status]=N'Overdue-Quá hạn'
		WHERE ISNULL([CompletedDate],'01/01/1990') ='01/01/1990'
			AND DATEDIFF(day,getdate(),[Deadline])<0
				AND [Status] <> N'Reject-Hủy bỏ'
		UPDATE [dbo].[ST_HazardReport1]
		SET [Status]=N'Ongoing-Đang xử lý'
		WHERE ISNULL([CompletedDate],'01/01/1990') ='01/01/1990'
			AND DATEDIFF(day,getdate(),[Deadline])>=0
				AND [Status] <> N'Reject-Hủy bỏ'
		UPDATE [dbo].[ST_HazardReport1]
		SET [Status]=N'Done-Đã hoàn thành'
		WHERE ISNULL([CompletedDate],'01/01/1990') <>'01/01/1990'
			AND [Status] <> N'Reject-Hủy bỏ'
		
		SELECT 
			A.ID
			,[PreventiveAction]
			,[PersonIncharge]
			,(SELECT Staffname FROM ST_Safety WHERE ID = A.PersonIncharge) AS TENPersonIncharge
			,[MUCUUTIEN]
			,[Deadline]
			,[CompletedDate]
			,[Status]
			,[PersonReport]
			,A.[Description]
			,THIETBI
			,(SELECT TEN_MAY FROM dbo.MAY WHERE MS_MAY = A.THIETBI) AS TENTHIETBI
			,LOAIYEUCAU
,(SELECT TEN_LOAI_YEU_CAU_BT FROM dbo.LOAI_YEU_CAU_BAO_TRI WHERE MS_LOAI_YEU_CAU_BT = A.LOAIYEUCAU) AS TENLOAIYEUCAU 
			,A.NGUYENNHAN
			,(SELECT TEN_NGUYEN_NHAN FROM dbo.NGUYEN_NHAN_DUNG_MAY WHERE MS_NGUYEN_NHAN = A.NGUYENNHAN) AS TENNGUYENNHAN 
		FROM [dbo].[ST_HazardReport1] A WHERE A.HazardReportID =@ID
		END

		