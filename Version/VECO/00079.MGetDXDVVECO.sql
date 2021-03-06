
--EXEC MGetDXDVVECO 'DX-1611-0001' , 1
ALTER procedure [dbo].[MGetDXDVVECO]
	@MS_DE_XUAT NVARCHAR (50),
	@NNGU INT 
AS
BEGIN



SELECT    ROW_NUMBER() OVER (Order by MS_DE_XUAT) AS [No],  TEN_DICH_VU, 	NHA_CUNG_CAP, TEN_N_XUONG,  SL_DE_XUAT,
0 AS Quality,
 DVT ,
		
                       
                       LIFE_TIME, Case BUYING_NEW when 1 then 'x' else '' end as BUYING_NEW,
                       Case REPLACING_FOR when 1 then 'x' else '' end as REPLACING_FOR,
                       Case SPARE when 1 then 'x' else '' end as SPARE,
                       Case MAINTENANCE when 1 then 'x' else '' end as MAINTENANCE,
                       DUONG_DAN_TL,  NGAY_GIAO_HANG, C.HO + ' ' + C.TEN AS BY_WHOM, TRANSFER_TO
FROM DE_XUAT_MUA_HANG_DICH_VU AS A
 
 LEFT JOIN CONG_NHAN C ON C.MS_CONG_NHAN = A.BY_WHOM
	
	WHERE A.MS_DE_XUAT = @MS_DE_XUAT     


      
END           