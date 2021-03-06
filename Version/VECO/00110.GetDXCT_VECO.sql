
-- exec [GetDXCT_VECO] 'DX-1611-0002','0'
ALTER proc [dbo].[GetDXCT_VECO]
	@MS_DX nvarchar(50),
	@NNGU nvarchar(5)
as

select ROW_NUMBER() OVER(ORDER BY a1.MS_DE_XUAT DESC) AS [No], case @NNGU when 0 then a4.TEN_PT when 1 then isnull(a4.TEN_PT_ANH,a4.Ten_PT) when 2 then isnull(a4.TEN_PT_HOA,a4.Ten_PT) end as [Name], a4.QUY_CACH [Remark / SPEC], NHA_CUNG_CAP as [Suggessted Supplier], 
	
		 a1.TEN_N_XUONG [Used area], TEN_MAY [Units No.], SL_DE_XUAT [Quantity], 
		case @NNGU when 0 then a2.TEN_1 when 1 then isnull(a2.TEN_2,a2.TEN_1) when 2 then isnull(a2.TEN_3,a2.TEN_1) end as [Unit] , LIFE_TIME [Estimated lifetime (Month)],
		case BUYING_NEW when 0 then '' when 1 then 'v' END as [Buying new], case REPLACING_FOR when 0 then '' when 1 then 'v' END as [Replacing for], case SPARE when 0 then '' when 1 then 'v' END as Spare, case MAINTENANCE when 0 then '' when 1 then 'v' END as Maintenance,
		 DUONG_DAN_TL [Picture to refer], ' ' + convert(nvarchar(10), NGAY_GIAO_HANG, 103) as [Expected delivery date], BY_WHOM [By whom], TRANSFER_TO [Transfer to] from DE_XUAT_MUA_HANG_CHI_TIET a1 left join DON_VI_TINH a2 on a1.DVT = a2.TEN_1 join IC_PHU_TUNG a4 on a1.MS_PT = a4.MS_PT
	--left join cong_nhan t on t.MS_CONG_NHAN = a1.BY_WHOM 
where MS_DE_XUAT = @MS_DX
		 

		
