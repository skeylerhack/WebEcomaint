
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'VS_ST_StopCard2')
   exec('CREATE PROCEDURE VS_ST_StopCard2 AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC  [dbo].[VS_ST_StopCard2]
(
	@ID int = 22107
)
AS	
	BEGIN
		UPDATE [dbo].[ST_StopCard2]
		SET [Status]=N'Overdue-Quá hạn'
		WHERE ISNULL([CompletedDate],'01/01/1990') ='01/01/1990'
			AND DATEDIFF(day,getdate(),[Deadline])<0
				AND [Status] <> N'Reject-Hủy bỏ'
		UPDATE [dbo].[ST_StopCard2]
		SET [Status]=N'Ongoing-Đang xử lý'
		WHERE ISNULL([CompletedDate],'01/01/1990') ='01/01/1990'
			AND DATEDIFF(day,getdate(),[Deadline])>=0
				AND [Status] <> N'Reject-Hủy bỏ'
		UPDATE [dbo].[ST_StopCard2]
		SET [Status]=N'Done-Đã hoàn thành'
		WHERE ISNULL([CompletedDate],'01/01/1990') <>'01/01/1990'
			AND [Status] <> N'Reject-Hủy bỏ'

		SELECT 
			A.ID
			,PermanentAction
			,[PersonIncharge]
			,(SELECT Staffname FROM ST_Safety WHERE ID = A.PersonIncharge) AS TENPersonIncharge
			,[MUCUUTIEN]
			,CASE A.MUCUUTIEN WHEN 1 THEN N'Mức 1(1 ngày) Chắc chắn sẽ xảy ra tai nạn' WHEN 2 THEN N'Mức 2(7 ngày) Hoàn toàn có thể xảy ra tai nạn' WHEN 3 THEN N'Mức 3(14 ngày) Xem như có thể xảy ra tai nạn' WHEN 4 THEN N'Mức 4(42 ngày) Rất khó có thể xảy ra tai nạn'  ELSE N'Mức 5(99 ngày) Được thực hiện khi có cơ hội làm được'  END as [TENMUCUUTIEN]
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
		FROM [dbo].[ST_StopCard2] A WHERE A.StopCardID =@ID
		END

