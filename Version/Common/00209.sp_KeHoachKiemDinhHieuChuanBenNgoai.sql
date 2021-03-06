--exec sp_KeHoachKiemDinhHieuChuanBenNgoai 2016,'-1','KHKDBNadmin'
--SELECT CONVERT(BIT,1) AS CHON ,MS_MAY INTO aaaadministrator FROM MAY
--	exec sp_KeHoachKiemDinhHieuChuanBenNgoai 2016,'-1','aaaadministrator'
ALTER PROC [dbo].[sp_KeHoachKiemDinhHieuChuanBenNgoai]
 @Nam int,
 @LoaiVT nvarchar(50),
 @TableMaMay nvarchar(200)
 as
begin

declare @NgayDauNam nvarchar(20)
set @NgayDauNam= CONVERT(nvarchar,@Nam) + '0101'

declare @chuoi nvarchar(4000)

CREATE TABLE #TableMay (MS_MAY nvarchar(100))

set @chuoi='insert into #TableMay (MS_MAY) select MS_MAY from ' + @TableMaMay  + ' where isnull(chon,0) <>0 '
exec(@chuoi)

declare @Table Table (MS_MAY nvarchar(200), MS_PT nvarchar(100),TEN_PT nvarchar(500),MS_VI_TRI nvarchar(50),TEN_HSX nvarchar(500),MS_PT_NCC nvarchar(500),
					  QUY_CACH nvarchar(500),TON_TOI_THIEU nvarchar (50),GIAY_CHUNG_NHAN nvarchar(500),NGAY  datetime,
					  LAN_TOI datetime,CHU_KY_KD int,TEN_DV_TG  NVARCHAR(300),GHI_CHU NVARCHAR(500),MS_DV_TG int,NGAY_HT datetime,CHU_KY INT,MS_LOAI_VT nvarchar(100),TEN_MAY NVARCHAR(200) )
					  
declare @TableNgay Table (MS_MAY nvarchar(200), MS_PT nvarchar(100),TEN_PT nvarchar(500),MS_VI_TRI nvarchar(50),TEN_HSX nvarchar(500),MS_PT_NCC nvarchar(500),
					  QUY_CACH nvarchar(500),TON_TOI_THIEU nvarchar (50),GIAY_CHUNG_NHAN nvarchar(500),NGAY  datetime,
					  LAN_TOI datetime,CHU_KY_KD int,TEN_DV_TG  NVARCHAR(300),GHI_CHU NVARCHAR(500),MS_DV_TG int,NGAY_HT datetime )

declare @TableTuan Table (MS_MAY nvarchar(200), MS_PT nvarchar(100),TEN_PT nvarchar(500),MS_VI_TRI nvarchar(50),TEN_HSX nvarchar(500),MS_PT_NCC nvarchar(500),
					  QUY_CACH nvarchar(500),TON_TOI_THIEU nvarchar (50),GIAY_CHUNG_NHAN nvarchar(500),NGAY  datetime,
					  LAN_TOI datetime,CHU_KY_KD int,TEN_DV_TG  NVARCHAR(300),GHI_CHU NVARCHAR(500),MS_DV_TG int,NGAY_HT datetime )


declare @TableThang Table (MS_MAY nvarchar(200), MS_PT nvarchar(100),TEN_PT nvarchar(500),MS_VI_TRI nvarchar(50),TEN_HSX nvarchar(500),MS_PT_NCC nvarchar(500),
					  QUY_CACH nvarchar(500),TON_TOI_THIEU nvarchar (50),GIAY_CHUNG_NHAN nvarchar(500),NGAY  datetime,
					  LAN_TOI datetime,CHU_KY_KD int,TEN_DV_TG  NVARCHAR(300),GHI_CHU NVARCHAR(500),MS_DV_TG int,NGAY_HT datetime )
					  
declare @TableNam Table (MS_MAY nvarchar(200), MS_PT nvarchar(100),TEN_PT nvarchar(500),MS_VI_TRI nvarchar(50),TEN_HSX nvarchar(500),MS_PT_NCC nvarchar(500),
					  QUY_CACH nvarchar(500),TON_TOI_THIEU nvarchar (50),GIAY_CHUNG_NHAN nvarchar(500),NGAY  datetime,
					  LAN_TOI datetime,CHU_KY_KD int,TEN_DV_TG  NVARCHAR(300),GHI_CHU NVARCHAR(500),MS_DV_TG int,NGAY_HT datetime )

					  
					  INSERT INTO  @Table (MS_MAY,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,CHU_KY_KD,TEN_DV_TG,MS_DV_TG,MS_LOAI_VT)
					  SELECT    dbo.CHU_KY_HIEU_CHUAN.MS_MAY, dbo.CHU_KY_HIEU_CHUAN.MS_PT,dbo.IC_PHU_TUNG.TEN_PT, dbo.CHU_KY_HIEU_CHUAN.MS_VI_TRI, dbo.HANG_SAN_XUAT.TEN_HSX, dbo.IC_PHU_TUNG.MS_PT_NCC, 
                              dbo.IC_PHU_TUNG.QUY_CACH, dbo.IC_PHU_TUNG.TON_TOI_THIEU, dbo.CHU_KY_HIEU_CHUAN.CHU_KY_KD, dbo.DON_VI_THOI_GIAN.TEN_DV_TG, dbo.CHU_KY_HIEU_CHUAN.MS_DV_TG,dbo.IC_PHU_TUNG.MS_LOAI_VT
					  FROM    dbo.IC_PHU_TUNG INNER JOIN  dbo.CHU_KY_HIEU_CHUAN ON dbo.IC_PHU_TUNG.MS_PT = dbo.CHU_KY_HIEU_CHUAN.MS_PT INNER JOIN
							  dbo.HIEU_CHUAN_DHD ON dbo.CHU_KY_HIEU_CHUAN.MS_MAY = dbo.HIEU_CHUAN_DHD.MS_MAY AND 
							  dbo.CHU_KY_HIEU_CHUAN.MS_PT = dbo.HIEU_CHUAN_DHD.MS_PT AND dbo.CHU_KY_HIEU_CHUAN.MS_VI_TRI = dbo.HIEU_CHUAN_DHD.MS_VI_TRI INNER JOIN
							  dbo.DON_VI_THOI_GIAN ON dbo.CHU_KY_HIEU_CHUAN.MS_DV_TG = dbo.DON_VI_THOI_GIAN.MS_DV_TG LEFT OUTER JOIN
							  dbo.HANG_SAN_XUAT ON dbo.IC_PHU_TUNG.MS_HSX = dbo.HANG_SAN_XUAT.MS_HSX
					WHERE MS_LOAI_HIEU_CHUAN = 3							  
						  
					 delete from @Table where isnull(MS_MAY,'') not in (select MS_MAY FROM #TableMay)	
					 if @LoaiVT <>'-1'
						delete from @Table where 	 ISNULL(MS_LOAI_VT,'') <> @LoaiVT
					 
					 -- tinh max ngay
					 update @Table set NGAY=A.NGAY FROM @Table B INNER JOIN
					 (  SELECT     MS_MAY, MS_PT, MS_VI_TRI, MAX(NGAY) AS NGAY
					    FROM         dbo.HIEU_CHUAN_DHD
						WHERE     (MS_LOAI_HIEU_CHUAN = 3)
						GROUP BY MS_MAY, MS_PT, MS_VI_TRI) A on a.MS_MAY =b.MS_MAY and a.MS_PT =b.MS_PT and a.MS_VI_TRI =b.MS_VI_TRI 
						
						
					delete from @Table where ISNULL(NGAY,'')=''	 OR CHU_KY_KD IS NULL
					
					
					-- tim giay chung nhan
					update @Table set GIAY_CHUNG_NHAN =A.GIAY_CHUNG_NHAN, GHI_CHU=A.GHI_CHU FROM @Table B inner join
 						( SELECT     MS_MAY, MS_PT, MS_VI_TRI,NGAY, GIAY_CHUNG_NHAN, GHI_CHU
  						  FROM         dbo.HIEU_CHUAN_DHD
						  WHERE     (MS_LOAI_HIEU_CHUAN = 3)) A on a.MS_MAY =b.MS_MAY and a.MS_PT =b.MS_PT and a.MS_VI_TRI =b.MS_VI_TRI and a.NGAY=b.NGAY 
					--
					
						UPDATE @TABLE SET CHU_KY =(CASE WHEN NGAY < @NgayDauNam THEN
						  ROUND(CONVERT(FLOAT,CASE MS_DV_TG 
						  WHEN 1 THEN DATEDIFF(DAY,NGAY,@NgayDauNam) 
						  WHEN 2 THEN DATEDIFF(WEEK,NGAY,@NgayDauNam) 
						  WHEN 3 THEN DATEDIFF(MONTH,NGAY,@NgayDauNam) 
						  WHEN 4 THEN DATEDIFF(YEAR,NGAY,@NgayDauNam) END )  / CHU_KY_KD + 0.49,0) * CHU_KY_KD  
						  ELSE CHU_KY_KD END )
					
					
					UPDATE @Table SET LAN_TOI=DATEADD(DAY,CHU_KY ,NGAY)  WHERE MS_DV_TG =1
					UPDATE @Table SET LAN_TOI=DATEADD(WEEK,CHU_KY,NGAY)   WHERE MS_DV_TG =2
					UPDATE @Table SET LAN_TOI=DATEADD(MONTH,CHU_KY,NGAY)   WHERE MS_DV_TG =3
					UPDATE @Table SET LAN_TOI=DATEADD(YEAR,CHU_KY,NGAY)   WHERE MS_DV_TG =4
					
					
					insert into @TableNgay  (MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU,NGAY_HT)
					select  MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
							LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU,NGAY_HT 
					from @Table where MS_DV_TG =1
					DELETE FROM @Table WHERE MS_DV_TG =1
					  

					insert into @TableTUAN  (MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU,NGAY_HT)
					select  MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
							LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU,NGAY_HT 
					from @Table where MS_DV_TG =2
					DELETE FROM @Table WHERE MS_DV_TG =2
					
					insert into @TableThang (MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU,NGAY_HT)
					select  MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
							LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU,NGAY_HT 
					from @Table where MS_DV_TG =3
					DELETE FROM @Table WHERE MS_DV_TG =3
					
					insert into @TableNam (MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU,NGAY_HT)
					select  MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
							LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU,NGAY_HT 
					from @Table where MS_DV_TG =4
					DELETE FROM @Table WHERE MS_DV_TG =4
					
					
					declare @i int
					--NGAY
					set @i=1
					while @i <=367				
						begin
							INSERT INTO @Table (MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU)
							SELECT MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  DATEADD(day,isnull(CHU_KY_KD,0)*@i,ISNULL(NGAY ,getdate())) ,CHU_KY_KD,TEN_DV_TG,GHI_CHU
							FROM @TableNgay 
							SET @i=@i+1	 				  				  
						end
					-- TUAN
					set @i=1
					while @i <=60				
						begin
							INSERT INTO @Table (MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU)
							SELECT MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  DATEADD(WEEK ,isnull(CHU_KY_KD,0)*@i,ISNULL(NGAY ,getdate())) ,CHU_KY_KD,TEN_DV_TG,GHI_CHU
							FROM @Tabletuan 
							SET @i=@i+1	 				  				  
						end	
					-- thang
					set @i=1
					while @i <=12				
						begin
							INSERT INTO @Table (MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU)
							SELECT MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  DATEADD(month,isnull(CHU_KY_KD,0)*@i,ISNULL(NGAY ,getdate())) ,CHU_KY_KD,TEN_DV_TG,GHI_CHU
							FROM @TableThang  
							SET @i=@i+1	 				  				  
						end		
					-- nam
					INSERT INTO @Table (MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
											  LAN_TOI,CHU_KY_KD,TEN_DV_TG,GHI_CHU)
					SELECT MS_MAY ,MS_PT,TEN_PT,MS_VI_TRI,TEN_HSX,MS_PT_NCC,QUY_CACH,TON_TOI_THIEU,GIAY_CHUNG_NHAN,NGAY,
									  DATEADD(year,isnull(CHU_KY_KD,0),ISNULL(NGAY ,getdate())) ,CHU_KY_KD,TEN_DV_TG,GHI_CHU
					FROM @TableNam  	
					
					DELETE FROM @Table WHERE YEAR (LAN_TOI) <> @NAM
					
					UPDATE @Table SET TEN_MAY =A.TEN_MAY FROM @Table B INNER JOIN
					(SELECT MS_MAY, ISNULL(TEN_MAY,'') AS TEN_MAY FROM MAY) A ON A.TEN_MAY =B.MS_MAY 
					   			  
                   	select TEN_MAY,MS_MAY , MS_PT ,TEN_PT ,MS_VI_TRI ,TEN_HSX ,MS_PT_NCC ,
						   QUY_CACH ,TON_TOI_THIEU ,GIAY_CHUNG_NHAN,NGAY,
						   LAN_TOI,CHU_KY_KD ,TEN_DV_TG  ,GHI_CHU 
					from @Table  order by MS_MAY , MS_PT,LAN_TOI
end 
