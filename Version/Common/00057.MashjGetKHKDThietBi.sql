--	exec MashjGetKHKDThietBi 'ADMIN', '-1','01/01/2015' , '01/01/2016'			--GF-01		GF-03-06
ALTER proc[dbo].[MashjGetKHKDThietBi]
(
	@UserName NVARCHAR(50),
	@MS_NHA_XUONG NVARCHAR(50),
	@TNgay datetime,
	@DNgay datetime
)
AS


SELECT * INTO #MAY_USER FROM [dbo].[MGetMayUserNgay]( @DNgay,@UserName,@MS_NHA_XUONG,-1,-1,'-1','-1','-1',0)



SELECT   ROW_NUMBER() OVER (ORDER BY A.MS_MAY ASC) AS STT,
  A.TEN_MAY, N'- Số seri: ' + A.SERIAL_NUMBER + CHAR(13) + CHAR(10) + + N'- Model: ' + A.MO_TA + CHAR(13) + CHAR(10) 
                      + N'- Thông số Thiết bị: ' + A.MODEL AS THONG_SO, B.NGAY_HC, 
DATEADD(day,A.CHU_KY_HC_TB,B.NGAY_HC)  AS NGAY_TT,A.Ten_N_XUONG
FROM         #MAY_USER AS A INNER JOIN
                          (SELECT     MS_MAY, MAX(NGAY_HC) AS NGAY_HC
                            FROM          dbo.HIEU_CHUAN_MAY WHERE MS_LOAI_HIEU_CHUAN = 3
                            GROUP BY MS_MAY) AS B ON A.MS_MAY = B.MS_MAY 
AND (DATEADD(day, A.CHU_KY_HC_TB, B.NGAY_HC) BETWEEN @TNgay AND @DNgay)
ORDER BY A.MS_MAY
