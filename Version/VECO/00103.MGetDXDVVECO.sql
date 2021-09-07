
--exec mgetdxdvveco 'DX-1612-0002', 1
alter procedure [dbo].[MGetDXDVVECO]
	@MS_DE_XUAT NVARCHAR (50),
	@NNGU INT 
AS
BEGIN

--hen 2 then isnull(a4.TEN_PT_HOA,a4.Ten_PT) end as TEN_PT, a4.MS_PT, NHA_CUNG_CAP, 
--		--case @NNGU when 0 then a3.Ten_N_XUONG when 1 then isnull(a3.TEN_N_XUONG_A,a3.Ten_N_XUONG) when 2 then isnull(a3.TEN_N_XUONG_H,a3.Ten_N_XUONG) end as
--		 a1.TEN_N_XUONG , TEN_MAY, SL_DE_XUAT, 
--		case @NNGU when 0 then a2.TEN_1 when 1 then is




SELECT    ROW_NUMBER() OVER (Order by MS_DE_XUAT) AS [No],  TEN_DICH_VU, 	NHA_CUNG_CAP, TEN_N_XUONG,  TEN_MAY, SL_DE_XUAT,
CASE @NNGU WHEN 1 THEN TEN_1
					WHEN 2 THEN TEN_2
					ELSE TEN_3 END AS DVT ,
		
                       
                       LIFE_TIME, Case BUYING_NEW when 1 then 'v' else '' end as BUYING_NEW,
                       Case REPLACING_FOR when 1 then 'v' else '' end as REPLACING_FOR,
                       Case SPARE when 1 then 'v' else '' end as SPARE,
                       Case MAINTENANCE when 1 then 'v' else '' end as MAINTENANCE,
                       
                       DUONG_DAN_TL, ' ' + convert(nvarchar(10), NGAY_GIAO_HANG, 103) as NGAY_GIAO_HANG,  BY_WHOM, TRANSFER_TO 
FROM DE_XUAT_MUA_HANG_DICH_VU AS A
 LEFT JOIN DON_VI_TINH B ON A.DVT = B.DVT
 --LEFT JOIN CONG_NHAN C ON C.MS_CONG_NHAN = A.BY_WHOM
	WHERE A.MS_DE_XUAT = @MS_DE_XUAT  
end