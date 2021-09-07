
--exec getALL_Kehoachnhanvienchinh 'WO-201704000004'
ALTER procedure [dbo].[getALL_Kehoachnhanvienchinh]
	@MS_PHIEU_BAO_TRI NVARCHAR(20)
AS

SELECT  X.MS_CONG_NHAN, X.MS_CONG_NHAN AS MS_CN, C.HO + ' ' + C.TEN AS TEN_CONG_NHAN, A.MS_CV, A.MS_BO_PHAN,A.NGAY_KH, A.TU_GIO_KH , A.DEN_NGAY_KH, A.DEN_GIO_KH, a.TONG_GIO_KH,
A.NGAY, A.TU_GIO AS TU_GIO, A.DEN_NGAY, A.DEN_GIO AS DEN_GIO, CONVERT(bit, CASE THUE_NGOAI WHEN 0 THEN 1 ELSE 0 END) AS THUE_NGOAI, A.HOAN_THANH, A.STT, A.SO_GIO
FROM dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET AS A 
RIGHT OUTER JOIN dbo.PHIEU_BAO_TRI_CONG_VIEC AS B 
INNER JOIN dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU AS X ON B.MS_PHIEU_BAO_TRI = X.MS_PHIEU_BAO_TRI AND B.MS_CV = X.MS_CV AND B.MS_BO_PHAN = X.MS_BO_PHAN 
INNER JOIN dbo.[TO] AS D 
INNER JOIN dbo.CONG_NHAN AS C ON D.MS_TO1 = C.MS_TO 
INNER JOIN dbo.TO_PHONG_BAN AS E ON D.MS_TO = E.MS_TO 
INNER JOIN dbo.DON_VI AS F ON E.MS_DON_VI = F.MS_DON_VI ON X.MS_CONG_NHAN = C.MS_CONG_NHAN ON A.MS_PHIEU_BAO_TRI = X.MS_PHIEU_BAO_TRI AND A.MS_CV = X.MS_CV AND A.MS_BO_PHAN = X.MS_BO_PHAN AND A.MS_CONG_NHAN = X.MS_CONG_NHAN
WHERE (B.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)