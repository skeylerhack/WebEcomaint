
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetDXCT_VECO')
   exec('CREATE PROCEDURE GetDXCT_VECO AS BEGIN SET NOCOUNT ON; END')
GO


-- exec [GetDXCT_VECO] 'DX-1611-0002','0'
alter proc [GetDXCT_VECO]
	@MS_DX nvarchar(50),
	@NNGU nvarchar(5)
as

select ROW_NUMBER() OVER(ORDER BY a1.MS_DE_XUAT DESC) AS STT, case @NNGU when 0 then a4.TEN_PT when 1 then isnull(a4.TEN_PT_ANH,a4.Ten_PT) when 2 then isnull(a4.TEN_PT_HOA,a4.Ten_PT) end as TEN_PT, a4.QUY_CACH , NHA_CUNG_CAP, 
		--case @NNGU when 0 then a3.Ten_N_XUONG when 1 then isnull(a3.TEN_N_XUONG_A,a3.Ten_N_XUONG) when 2 then isnull(a3.TEN_N_XUONG_H,a3.Ten_N_XUONG) end as
		 a1.TEN_N_XUONG , TEN_MAY, SL_DE_XUAT, 
		case @NNGU when 0 then a2.TEN_1 when 1 then isnull(a2.TEN_2,a2.TEN_1) when 2 then isnull(a2.TEN_3,a2.TEN_1) end as DVT , LIFE_TIME,
		case BUYING_NEW when 0 then '' when 1 then 'v' END as BUYING_NEW, case REPLACING_FOR when 0 then '' when 1 then 'v' END as REPLACING_FOR, case SPARE when 0 then '' when 1 then 'v' END as SPARE, case MAINTENANCE when 0 then '' when 1 then 'v' END as MAINTENANCE,
		 DUONG_DAN_TL, ' ' + convert(nvarchar(10), NGAY_GIAO_HANG, 103) as NGAY_GIAO_HANG, BY_WHOM , TRANSFER_TO from DE_XUAT_MUA_HANG_CHI_TIET a1 left join DON_VI_TINH a2 on a1.DVT = a2.TEN_1 join IC_PHU_TUNG a4 on a1.MS_PT = a4.MS_PT
	--left join cong_nhan t on t.MS_CONG_NHAN = a1.BY_WHOM 
where MS_DE_XUAT = @MS_DX
		 
		 


