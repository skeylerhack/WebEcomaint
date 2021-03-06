if not exists(select * from sys.columns 
            where Name = N'MS_KHO_DEN' and Object_ID = Object_ID(N'IC_DON_HANG_XUAT_X'))
begin
    ALTER TABLE dbo.IC_DON_HANG_XUAT_X ADD MS_KHO_DEN INT;
END    
GO	
if not exists(select * from sys.columns 
            where Name = N'MS_VI_TRI_DEN' and Object_ID = Object_ID(N'IC_DON_HANG_XUAT_X'))
begin
    ALTER TABLE IC_DON_HANG_XUAT_X ADD MS_VI_TRI_DEN INT;
END    

if not exists(select * from sys.columns 
            where Name = N'MS_VI_TRI' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP'))
begin
    ALTER TABLE IC_DON_HANG_NHAP ADD MS_VI_TRI INT;

END    

if not exists(select * from sys.columns 
            where Name = N'MS_VI_TRI' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP_X'))
begin
    ALTER TABLE IC_DON_HANG_NHAP_X ADD MS_VI_TRI INT;

END    


GO
	UPDATE dbo.IC_DON_HANG_NHAP SET MS_VI_TRI = T2.MS_VI_TRI 
	FROM dbo.IC_DON_HANG_NHAP T1 INNER JOIN 
	(SELECT DISTINCT T1.MS_DH_NHAP_PT,T1.MS_KHO,T3.MS_VI_TRI FROM dbo.IC_DON_HANG_NHAP T1 INNER JOIN dbo.IC_DON_HANG_NHAP_VAT_TU T2 ON T2.MS_DH_NHAP_PT = T1.MS_DH_NHAP_PT INNER JOIN dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET T3 ON T3.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T3.MS_PT = T2.MS_PT AND T3.ID = T2.ID WHERE MS_DANG_NHAP = 9) T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T2.MS_KHO = T1.MS_KHO
	WHERE MS_DANG_NHAP = 9 AND T1.MS_VI_TRI IS NULL