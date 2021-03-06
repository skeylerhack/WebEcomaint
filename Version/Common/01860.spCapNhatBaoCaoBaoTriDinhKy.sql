 

 --EXEC spCapNhatspBaoCaoGiamSatTinhTrang '2018', 'admin', '-1', -1, '-1',-1,GSTTAdmin
  IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCapNhatBaoCaoBaoTriDinhKy')
   exec('CREATE PROCEDURE spCapNhatBaoCaoBaoTriDinhKy AS BEGIN SET NOCOUNT ON; END')
 GO
ALTER PROCEDURE [dbo].[spCapNhatBaoCaoBaoTriDinhKy]
	@NAM NVARCHAR(4) = 2021,
	@sBTam NVARCHAR(200) ='BTDKAdmin',
	@sBTamChon NVARCHAR(200) ='BTDKCHONAdmin'
AS
    BEGIN
		CREATE TABLE [#tempt]
		(
		[MS_MAY] NVARCHAR(30),
		[MS_LOAI_BT] INT,
		[SO_LUONG] INT,
		[CO_BT] BIT
		)
		DECLARE @sSql NVARCHAR(4000);
        DECLARE @tNgay AS NVARCHAR(15) = '01/01/' + @NAM;
		DECLARE @Month CHAR(10);
		SET @Month = MONTH(GETDATE());
		set @sSql = ' INSERT INTO #tempt(MS_MAY,MS_LOAI_BT,SO_LUONG,CO_BT)  SELECT MS_MAY,MS_LOAI_BT, COUNT(*) AS SO_LUONG ,CO_BT
		 FROM '+@sBTamChon+'
		WHERE   CONVERT(DATE, NGAY_KE) BETWEEN CONVERT(DATE, '''+@tNgay+''') AND CONVERT(DATE, GETDATE())AND MONTH(NGAY_KE) = MONTH(GETDATE())
		GROUP BY MS_MAY,MS_LOAI_BT,CO_BT'
		EXEC (@sSql)
		SELECT ABS(-1)
		--Nếu là năm hiện tại thì cập nhật cho tháng giao nhâu 
		-- cập nhật cho .1 = bảng tạm trừ số lượng
		--tháng hiện tại chính là số lượng trong quá khứ
		set @sSql = '
		UPDATE T1
		SET
			T1.['+RTRIM(@Month)+'.1] = ABS(T1.['+RTRIM(@Month)+']) - ABS(T2.SO_LUONG),
			T1.['+RTRIM(@Month)+'] = T2.SO_LUONG
		FROM
			'+@sBTam+' AS T1
			INNER JOIN #tempt AS T2 ON T1.MS_MAY = T2.MS_MAY AND T2.MS_LOAI_BT = T1.MS_LOAI_BT 
		WHERE
			T1.['+RTRIM(@Month)+']>0	
		UPDATE t2
		SET t2.['+RTRIM(@Month)+'.1] = t2.['+RTRIM(@Month)+'],
		t2.['+RTRIM(@Month)+'] = 0
		FROM '+@sBTam+' t2
		WHERE NOT EXISTS (SELECT MS_MAY,MS_LOAI_BT FROM  #tempt t1 WHERE t1.MS_MAY = t2.MS_MAY AND t1.MS_LOAI_BT = t2.MS_LOAI_BT)
		UPDATE  '+@sBTam+'
		SET ['+RTRIM(@Month)+'.1] = null
		WHERE ['+RTRIM(@Month)+'.1] = 0	'
	EXEC (@sSql)
	END;	

