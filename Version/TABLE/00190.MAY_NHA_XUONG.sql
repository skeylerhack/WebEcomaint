if not exists(select * from sys.columns 
           where Name = N'GC_NX' and Object_ID = Object_ID(N'MAY_NHA_XUONG'))
begin
   ALTER TABLE MAY_NHA_XUONG ADD GC_NX NVARCHAR(500)
END    
GO
if not exists(select * from sys.columns 
           where Name = N'GC_HT' and Object_ID = Object_ID(N'MAY_HE_THONG'))
begin
   ALTER TABLE dbo.MAY_HE_THONG ADD GC_HT NVARCHAR(500)
END    
GO
if not exists(select * from sys.columns 
           where Name = N'GC_BPCP' and Object_ID = Object_ID(N'MAY_BO_PHAN_CHIU_PHI'))
begin
   ALTER TABLE dbo.MAY_BO_PHAN_CHIU_PHI ADD GC_BPCP NVARCHAR(500)
END    
GO
