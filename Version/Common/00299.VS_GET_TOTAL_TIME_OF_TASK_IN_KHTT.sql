IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'VS_GET_TOTAL_TIME_OF_TASK_IN_KHTT')
   exec('CREATE FUNCTION  dbo.VS_GET_TOTAL_TIME_OF_TASK_IN_KHTT () RETURNS  nvarchar(50) as Begin return null end')
GO


ALTER function [dbo].[VS_GET_TOTAL_TIME_OF_TASK_IN_KHTT]
(
 @HANG_MUC_ID INT
)
returns FLOAT
as 
begin
DECLARE @TOTAL_TIME FLOAT

SELECT @TOTAL_TIME= ( SELECT SUM(ISNULL(THOI_GIAN_DU_KIEN,0)) 
					  FROM KE_HOACH_TONG_CONG_VIEC WHERE HANG_MUC_ID = @HANG_MUC_ID
					  AND  (MS_PHIEU_BAO_TRI IS NULL) AND (EOR_ID IS NULL) AND (KHONG_GQ = 0 OR KHONG_GQ IS NULL) AND (THUE_NGOAI = 0 OR
                                                                                   THUE_NGOAI IS NULL) )

return ISNULL(@TOTAL_TIME,0)
end
