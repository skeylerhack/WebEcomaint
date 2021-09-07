
-- exec GetDXMHADC 'DX-1411-0033',0
ALTER proc [dbo].[GetDXMHADC]
	@MS_DE_XUAT NVARCHAR(50),
	@NNgu int
as

SELECT DISTINCT   ROW_NUMBER () OVER (ORDER BY A.SO_DE_XUAT, A.MS_DE_XUAT,A.NGAY_LAP,  A.PHONG_BAN, B.MS_PT, D.TEN_PT, D.QUY_CACH, D.MS_PT_NCC) AS STT, 
                      A.SO_DE_XUAT, A.MS_DE_XUAT, A.NGAY_LAP, A.PHONG_BAN, B.MS_PT,    
                      ISNULL(D.TEN_PT,'') + CASE ISNULL(D.QUY_CACH,'') WHEN '' THEN '' ELSE ' / ' + ISNULL(D.QUY_CACH,'') END
                      + CASE ISNULL(D.MS_PT_NCC,'') WHEN '' THEN '' ELSE ' / ' + ISNULL(D.MS_PT_NCC,'') END AS TEN_PT, D.QUY_CACH, D.MS_PT_NCC, 
                      CASE @NNgu WHEN 0 THEN E.TEN_1 WHEN 1 THEN E.TEN_2 ELSE TEN_3 END AS TEN_DVT, B.SL_DE_XUAT, 
                      B.TON_KHO, B.SL_DA_DUYET, B.DON_GIA, B.NGAY_GIAO_HANG, B.NHA_CUNG_CAP, 
                      A.GHI_CHU, A.NGUOI_NHAN, A.NGUOI_DE_XUAT, A.NGAY_NHAN, A.NGUOI_GIAO, A.NGAY_GIAO
FROM         dbo.DE_XUAT_MUA_HANG AS A INNER JOIN
                      dbo.DE_XUAT_MUA_HANG_CHI_TIET AS B ON A.MS_DE_XUAT = B.MS_DE_XUAT INNER JOIN
                      dbo.IC_PHU_TUNG AS D ON B.MS_PT = D.MS_PT INNER JOIN
                      dbo.DON_VI_TINH AS E ON D.DVT = E.DVT LEFT OUTER JOIN
                      dbo.IC_KHO AS C ON A.MS_KHO = C.MS_KHO
WHERE A.MS_DE_XUAT = @MS_DE_XUAT                      
ORDER BY A.SO_DE_XUAT, A.MS_DE_XUAT,A.NGAY_LAP,  A.PHONG_BAN, B.MS_PT, ISNULL(D.TEN_PT,'') + 
                      CASE ISNULL(D.QUY_CACH,'') WHEN '' THEN '' ELSE ' / ' + ISNULL(D.QUY_CACH,'') END
                      + 
                      CASE ISNULL(D.MS_PT_NCC,'') WHEN '' THEN '' ELSE ' / ' + ISNULL(D.MS_PT_NCC,'') END, D.QUY_CACH, D.MS_PT_NCC
                      
                      
SELECT DISTINCT A.TEN_DICH_VU, A.DVT, A.SL_DE_XUAT, A.DON_GIA, A.THANH_TIEN, NGAY_GIAO,A.GHI_CHU
FROM         dbo.DE_XUAT_MUA_HANG_DICH_VU AS A INNER JOIN
                      dbo.DE_XUAT_MUA_HANG AS B ON A.MS_DE_XUAT = B.MS_DE_XUAT
WHERE     (A.MS_DE_XUAT = @MS_DE_XUAT)
ORDER BY A.TEN_DICH_VU, A.DVT                      