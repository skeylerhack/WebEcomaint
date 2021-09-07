IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetAllTuanTrongThang')
exec('CREATE PROCEDURE GetAllTuanTrongThang AS BEGIN SET NOCOUNT ON; END')
GO
ALTER procedure [dbo].[GetAllTuanTrongThang]
@TU_NGAY DATE = '05/01/2019'
AS
Begin 
select * from MGetWeeksOfMonth(@TU_NGAY,0)
union
select 0 as TT,Week,WeekStart,WeekEnd from MGetWeeksOfMonth(DATEADD(MONTH,-1, @TU_NGAY),0) where tt = (select max(TT) from MGetWeeksOfMonth(DATEADD(MONTH,-1, @TU_NGAY),0))
End