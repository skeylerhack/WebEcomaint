if not exists(select * from sys.objects where type = 'P' AND name = 'spBaoCaoVatTuKhoExportExcel')
   exec('create proc spBaoCaoVatTuKhoExportExcel as begin set nocount on; end')
go
alter proc spBaoCaoVatTuKhoExportExcel
	@ms_kho int,
	@TNgay nvarchar(10),
	@DNgay nvarchar(10)
as
begin

	select T.Date, T.Item, SUM(T.Qty) as Qty, T.Price, 0 as Amount, T.ConvertFactor, T.ConvertQty, T.Note  from (

		select convert(date, T.NGAY)  as [Date], T1.MS_PT as Item, sum(T1.SL_VT) as  Qty, '' AS Price, 
		0 As Amount, 1 as ConvertFactor, 
		sum(T1.SL_VT) as ConvertQty,T.GHI_CHU as Note from IC_DON_HANG_XUAT T
		inner join IC_DON_HANG_XUAT_VAT_TU_CHI_TIET T1 on T.MS_DH_XUAT_PT = T1.MS_DH_XUAT_PT 
		inner join IC_DON_HANG_NHAP_VAT_TU T2 ON T2.MS_DH_NHAP_PT = T1.MS_DH_NHAP_PT AND T2.MS_PT = T1.MS_PT 
		where convert(date, T.NGAY) between convert(date, @TNgay) and convert(date, @DNgay) and (T.MS_KHO = @ms_kho or @ms_kho = -1)
		group by T.NGAY,T1.MS_PT, T.MS_DH_XUAT_PT,T2.DON_GIA, T.GHI_CHU
	) T
	group by T.Date, T.Item, T.Qty, T.Amount, T.ConvertFactor, T.ConvertQty , T.Note, T.Price
	ORDER BY T.Item 
end


