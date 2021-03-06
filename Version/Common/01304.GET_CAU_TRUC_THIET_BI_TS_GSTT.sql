

--exec [GET_CAU_TRUC_THIET_BI_TS_GSTT] 'BHCA-01',1,0,1


ALTER procedure [dbo].[GET_CAU_TRUC_THIET_BI_TS_GSTT]
	@MS_MAY NVARCHAR(30),
	@MS_BO_PHAN NVARCHAR(50),
	@NGON_NGU INT,
	@LOAI_TS BIT
AS
declare @sql nvarchar(4000)
set @sql ='
SELECT     T12.TEN_TS_GSTT, T1.MS_MAY, T1.MS_BO_PHAN, T1.MS_TS_GSTT, T1.MS_TT, 
                      T1.TEN_GT, T1.GIA_TRI_TREN, T1.GIA_TRI_DUOI, T1.CHU_KY_DO, T1.MS_DV_TG, T1.MS_UU_TIEN
                      T1.DAT, T1.GHI_CHU , ISNULL(T1.THOI_GIAN, 0) THOI_GIAN, T1.CACH_THUC_HIEN,T1.TIEU_CHUAN_KT, T1.YEU_CAU_NS, T1.YEU_CAU_DUNG_CU, T1.PATH_HD, NULL AS CT_CVIEC '
if  @LOAI_TS=0
	set @sql=@sql+', dbo.DON_VI_DO.TEN_DV_DO '
set @sql=@sql+', T1.ACTIVE FROM dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T1 INNER JOIN
                      dbo.THONG_SO_GSTT AS T12 ON T1.MS_TS_GSTT = T12.MS_TS_GSTT '
        
if  @LOAI_TS=0
	set @sql=@sql+' INNER JOIN dbo.DON_VI_DO ON T12.MS_DV_DO = dbo.DON_VI_DO.MS_DV_DO'

set @sql=@sql+' WHERE MS_MAY=N'''+@MS_MAY+'''  AND MS_BO_PHAN='''+@MS_BO_PHAN+''' AND LOAI_TS='+cast(@LOAI_TS as varchar(1))
exec (@sql)
