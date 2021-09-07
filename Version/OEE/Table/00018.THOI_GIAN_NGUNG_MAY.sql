if not exists(select * from sys.columns 
where Name = N'ProductionRunID' and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY'))
begin
    ALTER TABLE dbo.THOI_GIAN_NGUNG_MAY ADD ProductionRunID BIGINT
END    
GO

if not exists(select * from sys.columns 
where Name = N'ProductionRunDetailsID' and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY'))
begin
    ALTER TABLE dbo.THOI_GIAN_NGUNG_MAY ADD ProductionRunDetailsID BIGINT
END    
GO

if not exists(select * from sys.columns 
where Name = N'Planned' and Object_ID = Object_ID(N'NGUYEN_NHAN_DUNG_MAY'))
begin
    ALTER TABLE dbo.NGUYEN_NHAN_DUNG_MAY ADD Planned BIT
END    
GO

if not exists(select * from sys.columns 
where Name = N'DownTimeTypeID' and Object_ID = Object_ID(N'NGUYEN_NHAN_DUNG_MAY'))
begin
    ALTER TABLE dbo.NGUYEN_NHAN_DUNG_MAY ADD DownTimeTypeID INT
END    
GO
