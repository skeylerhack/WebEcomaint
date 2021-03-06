
--exec mgetdxdvveco 'DX-1612-0002', 1
ALTER procedure [dbo].[MGetDXDVVECO]
	@MS_DE_XUAT NVARCHAR (50),
	@NNGU INT 
AS
BEGIN

--hen 2 then isnull(a4.TEN_PT_HOA,a4.Ten_PT) end as TEN_PT, a4.MS_PT, NHA_CUNG_CAP, 
--		--case @NNGU when 0 then a3.Ten_N_XUONG when 1 then isnull(a3.TEN_N_XUONG_A,a3.Ten_N_XUONG) when 2 then isnull(a3.TEN_N_XUONG_H,a3.Ten_N_XUONG) end as
--		 a1.TEN_N_XUONG , TEN_MAY, SL_DE_XUAT, 
--		case @NNGU when 0 then a2.TEN_1 when 1 then is




SELECT    ROW_NUMBER() OVER (Order by MS_DE_XUAT) AS [No],  TEN_DICH_VU AS [Name], LY_DO AS [Remark / SPEC],	NHA_CUNG_CAP AS [Suggessted Supplier]
, TEN_N_XUONG AS [Used area],  TEN_MAY AS [Units No.], SL_DE_XUAT AS [Quantity], 	
A.DVT  AS Unit ,
		
                       
                       LIFE_TIME AS [Estimated lifetime (Month)], Case BUYING_NEW when 1 then 'v' else '' end as [Buying new]	 ,
                       Case REPLACING_FOR when 1 then 'v' else '' end as  [Replacing for]	,
                       Case SPARE when 1 then 'v' else '' end as  [Spare]	,
                       Case MAINTENANCE when 1 then 'v' else '' end as [Maintenance] ,
                       
                       DUONG_DAN_TL AS [Picture to refer], ' ' + convert(nvarchar(10), NGAY_GIAO_HANG, 103) [Expected delivery date],  BY_WHOM [By whom], TRANSFER_TO [Transfer to]


FROM DE_XUAT_MUA_HANG_DICH_VU AS A
	WHERE A.MS_DE_XUAT = @MS_DE_XUAT  
end