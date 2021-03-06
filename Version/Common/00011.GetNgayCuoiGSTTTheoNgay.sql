IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetNgayCuoiGSTTTheoNgay')
   exec('CREATE FUNCTION  dbo.GetNgayCuoiGSTTTheoNgay () RETURNS  nvarchar(50) as Begin return null end')
GO


ALTER FUNCTION  GetNgayCuoiGSTTTheoNgay
(
	@MS_MAY nvarchar(50), 
	@MS_BO_PHAN nvarchar(50), 
	@MS_TS_GSTT nvarchar(50)) 
RETURNS  datetime 
as 
Begin 
return (
SELECT  max(dbo.GIAM_SAT_TINH_TRANG.NGAY_KT) as ngaylonnhat
FROM         dbo.GIAM_SAT_TINH_TRANG_TS INNER JOIN
                      dbo.GIAM_SAT_TINH_TRANG ON dbo.GIAM_SAT_TINH_TRANG_TS.STT = dbo.GIAM_SAT_TINH_TRANG.STT where dbo.GIAM_SAT_TINH_TRANG_TS.MS_MAY= @MS_MAY  
                      and  dbo.GIAM_SAT_TINH_TRANG_TS.MS_BO_PHAN=@MS_BO_PHAN and dbo.GIAM_SAT_TINH_TRANG_TS.MS_TS_GSTT= @MS_TS_GSTT 
						) 
  
end
