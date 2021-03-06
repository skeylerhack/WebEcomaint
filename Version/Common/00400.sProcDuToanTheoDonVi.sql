
--exec sProcDuToanTheoDonVi 6,2016,'BD', 'ADMIN'
ALTER Proc [dbo].[sProcDuToanTheoDonVi]
	@Thang int,
	@Nam int,
	@DonVi nvarchar(100),
	@User nvarchar(100)
as
	begin

	
SELECT DISTINCT T1.* INTO #DV_USER
FROM            dbo.DON_VI AS T1 INNER JOIN
                         dbo.TO_PHONG_BAN AS T2 ON T1.MS_DON_VI = T2.MS_DON_VI INNER JOIN
                         dbo.NHOM_TO_PHONG_BAN AS T3 ON T2.MS_TO = T3.MS_TO INNER JOIN
                         dbo.USERS AS T4 ON T3.GROUP_ID = T4.GROUP_ID
WHERE        (T4.USERNAME = @User)

		create table #TableDLDuToan ( MS_TO nvarchar(100), THANH_TIEN_VND numeric(19,6),MS_LOAI_VT nvarchar(100))
		create table #TableDLThucTe ( MS_TO nvarchar(100), THANH_TIEN_VND numeric(19,6),MS_LOAI_VT nvarchar(100))
		create table #LOAI_VT ( MS_LOAI_VT NVARCHAR(100), TEN_LOAI_VT NVARCHAR(1000), DVT NVARCHAR(10),TONG_DU_TOAN NUMERIC(19,6), TONG_THUC_TE NUMERIC(19,6),TONG_CHENH_LECH NUMERIC(19,6))
		
		insert into #TableDLDuToan (MS_TO,THANH_TIEN_VND,MS_LOAI_VT)
		SELECT     dbo.TO_PHONG_BAN.MS_TO, SUM(dbo.DE_XUAT_MUA_HANG_CHI_TIET.THANH_TIEN_VND) AS THANH_TIEN_VND, dbo.LOAI_VT.MS_LOAI_VT
		FROM         #DV_USER AS T1 INNER JOIN
							  dbo.TO_PHONG_BAN ON T1.MS_DON_VI = dbo.TO_PHONG_BAN.MS_DON_VI INNER JOIN
							  dbo.IC_PHU_TUNG INNER JOIN
							  dbo.DE_XUAT_MUA_HANG_CHI_TIET ON dbo.IC_PHU_TUNG.MS_PT = dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT INNER JOIN
							  dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT INNER JOIN
							  dbo.LOAI_VT ON dbo.IC_PHU_TUNG.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT INNER JOIN
							  dbo.DE_XUAT_MUA_HANG ON dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT = dbo.DE_XUAT_MUA_HANG.MS_DE_XUAT ON 
							  dbo.TO_PHONG_BAN.TEN_TO = dbo.DE_XUAT_MUA_HANG.PHONG_BAN
		where month(DE_XUAT_MUA_HANG.NGAY_LAP)=@Thang and year(DE_XUAT_MUA_HANG.NGAY_LAP)=@Nam and TO_PHONG_BAN.MS_DON_VI like @DonVi 
		GROUP BY dbo.TO_PHONG_BAN.MS_TO, dbo.LOAI_VT.MS_LOAI_VT
		
		insert into #TableDLThucTe (MS_TO,THANH_TIEN_VND,MS_LOAI_VT)
		SELECT     dbo.TO_PHONG_BAN.MS_TO, SUM(dbo.DON_DAT_HANG_CHI_TIET.THANH_TIEN_VND) AS THANH_TIEN_VND, dbo.LOAI_VT.MS_LOAI_VT
		FROM         #DV_USER T1 INNER JOIN
                      dbo.TO_PHONG_BAN ON T1.MS_DON_VI = dbo.TO_PHONG_BAN.MS_DON_VI INNER JOIN
                      dbo.IC_PHU_TUNG INNER JOIN
                      dbo.DE_XUAT_MUA_HANG_CHI_TIET ON dbo.IC_PHU_TUNG.MS_PT = dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT INNER JOIN
                      dbo.LOAI_VT ON dbo.IC_PHU_TUNG.MS_LOAI_VT = dbo.LOAI_VT.MS_LOAI_VT INNER JOIN
                      dbo.DE_XUAT_MUA_HANG ON dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT = dbo.DE_XUAT_MUA_HANG.MS_DE_XUAT ON 
                      dbo.TO_PHONG_BAN.TEN_TO = dbo.DE_XUAT_MUA_HANG.PHONG_BAN INNER JOIN
                      dbo.DON_DAT_HANG_CHI_TIET ON dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT = dbo.DON_DAT_HANG_CHI_TIET.MS_PT AND 
                      dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT = dbo.DON_DAT_HANG_CHI_TIET.MS_DE_XUAT
        where month(DE_XUAT_MUA_HANG.NGAY_LAP)=@Thang and year(DE_XUAT_MUA_HANG.NGAY_LAP)=@Nam and TO_PHONG_BAN.MS_DON_VI like @DonVi             
		GROUP BY dbo.TO_PHONG_BAN.MS_TO, dbo.LOAI_VT.MS_LOAI_VT
		
		
		INSERT INTO #LOAI_VT (MS_LOAI_VT,TEN_LOAI_VT,DVT )
		SELECT MS_LOAI_VT, TEN_LOAI_VT_TV,N'đ' FROM LOAI_VT 
		
		declare @MS_TO nvarchar(100)
		declare @chuoi nvarchar(4000)
		declare @ChuoiDuToan nvarchar(4000)
		declare @chuoiThucTe nvarchar(4000)
		declare @chuoiChenhLech nvarchar(4000)
		set @ChuoiDuToan=''
		set @chuoiThucTe=''
		set @chuoiChenhLech =''
		
		declare @i int
		
		set @i=1	
		declare curMSTO cursor for
				SELECT MS_TO FROM TO_PHONG_BAN T1 INNER JOIN #DV_USER T2 ON T1.MS_DON_VI = T2.MS_DON_VI  where T1.MS_DON_VI like @DonVi order by TEN_TO
		open curMSTO
		fetch next from curMSTO into @MS_TO
		while @@FETCH_STATUS =0
			begin
				set @ChuoiDuToan =@ChuoiDuToan + ',Du_toan_' + CONVERT(nvarchar,@i) 
				set @chuoiThucTe =@chuoiThucTe + ',Thuc_te_' + CONVERT(nvarchar,@i) 
				set @chuoiChenhLech=@chuoiChenhLech + ', Chenh_Lech' + CONVERT(nvarchar,@i) 
				
				set @chuoi='alter table #LOAI_VT add Du_toan_' + CONVERT(nvarchar,@i) +' numeric(19,6)'
				exec (@chuoi)
				set @chuoi='update #LOAI_VT set Du_toan_' + CONVERT(nvarchar,@i) +' =a.THANH_TIEN_VND from #LOAI_VT  B inner join
							( select THANH_TIEN_VND,MS_LOAI_VT from #TableDLDuToan where MS_TO =' + CHAR(39) + @MS_TO + CHAR(39) + ' ) A ON A.MS_LOAI_VT=B.MS_LOAI_VT'
				EXEC (@CHUOI)
				set @chuoi ='update #LOAI_VT set TONG_DU_TOAN = isnull(TONG_DU_TOAN,0) + ISNULL(Du_toan_' + CONVERT(nvarchar,@i) +',0)'
				EXEC (@CHUOI)
				 			
				set @chuoi='alter table #LOAI_VT add Thuc_te_' + CONVERT(nvarchar,@i) +' numeric(19,6)'
				exec (@chuoi) 
				set @chuoi='update #LOAI_VT set Thuc_te_' + CONVERT(nvarchar,@i) +' =a.THANH_TIEN_VND from #LOAI_VT  B inner join
							( select THANH_TIEN_VND,MS_LOAI_VT from #TableDLThucTe where MS_TO =' + CHAR(39) + @MS_TO + CHAR(39) + ' ) A ON A.MS_LOAI_VT=B.MS_LOAI_VT'
				EXEC (@CHUOI)
				set @chuoi ='update #LOAI_VT set TONG_THUC_TE = isnull(TONG_THUC_TE,0) + ISNULL(Thuc_te_' + CONVERT(nvarchar,@i) +',0)'
				EXEC (@CHUOI)
						
				set @chuoi='alter table #LOAI_VT add Chenh_Lech' + CONVERT(nvarchar,@i) +' numeric(19,6)'
				exec (@chuoi)
				
				set @chuoi='update #LOAI_VT set Chenh_Lech' + CONVERT(nvarchar,@i) +' = isnull(Thuc_te_' + CONVERT(nvarchar,@i) +',0) - isnull(Du_toan_' + CONVERT(nvarchar,@i) +',0)'
				exec (@chuoi)
				
				set @chuoi ='update #LOAI_VT set TONG_CHENH_LECH = isnull(TONG_CHENH_LECH,0) + ISNULL(Chenh_Lech' + CONVERT(nvarchar,@i) +',0)'
				EXEC (@CHUOI)
				
				set @i=@i+1
				fetch next from curMSTO into @MS_TO
			end
		close curMSTO
		deallocate curMSTO
		
		SELECT T1.MS_TO,T1.TEN_TO  FROM TO_PHONG_BAN T1 INNER JOIN #DV_USER T2 ON T1.MS_DON_VI = T2.MS_DON_VI 
			where T1.MS_DON_VI like @DonVi order by TEN_TO
		
		set @chuoi='select ROW_NUMBER() OVER( ORDER BY TEN_LOAI_VT asc) as STT, TEN_LOAI_VT,DVT' + @ChuoiDuToan + ',TONG_DU_TOAN ' + @chuoiThucTe + ',TONG_THUC_TE ' + @chuoiChenhLech + ', TONG_CHENH_LECH 
					from #LOAI_VT ORDER BY TEN_LOAI_VT '
		exec(@chuoi)
		
		drop table #LOAI_VT				
		DROP TABLE #TableDLDuToan
		DROP TABLE #TableDLThucTe

	end	
