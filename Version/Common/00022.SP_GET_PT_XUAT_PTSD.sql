
--exec SP_GET_PT_XUAT_PTSD 'WO-201506000043'
--PX-1502-0001	T3888487013	2	1
ALTER procedure [dbo].[SP_GET_PT_XUAT_PTSD] 
	@MS_PHIEU_BAO_TRI NVARCHAR (20)
AS
BEGIN


SELECT     A.MS_PT AS PT_GOC, D.TEN_PT, B.MS_PT, D.TEN_PT AS TEN_PT_SD, 
                      A.MS_DH_XUAT_PT, A.MS_DH_NHAP_PT, SUM(ISNULL(A.SL_TT,0)) AS SL_TT, 
                      SUM(ISNULL(B.SL_VT,0)) -  SUM(ISNULL(SL_TRA,0)) AS SL_VT,
                      B.ID_XUAT, A.ID
                      

 FROM 
(
SELECT     MS_PHIEU_BAO_TRI, MS_PT, MS_DH_XUAT_PT, MS_DH_NHAP_PT, ID, SUM(SL_TT) AS SL_TT
FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS T2
WHERE     (MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)
GROUP BY ID, MS_PHIEU_BAO_TRI, MS_PT, MS_DH_XUAT_PT, MS_DH_NHAP_PT
) A INNER JOIN IC_PHU_TUNG D ON A.MS_PT = D.MS_PT INNER JOIN LOAI_VT E ON D.MS_LOAI_VT = E.MS_LOAI_VT

INNER JOIN 
(
SELECT     T1.MS_PHIEU_BAO_TRI, T1.MS_DH_XUAT_PT, T3.MS_PT, T3.SL_VT, T3.ID_XUAT
FROM         dbo.IC_DON_HANG_XUAT AS T1 INNER JOIN
                      dbo.IC_DON_HANG_XUAT_VAT_TU AS T2 ON T1.MS_DH_XUAT_PT = T2.MS_DH_XUAT_PT INNER JOIN
                      dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T3 ON T2.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT AND T2.MS_PT = T3.MS_PT
GROUP BY T1.MS_PHIEU_BAO_TRI, T1.MS_DH_XUAT_PT, T3.MS_PT, T3.SL_VT, T3.ID_XUAT
HAVING      (T1.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)
) B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI AND A.MS_PT = B.MS_PT AND A.ID = B.ID_XUAT  AND A.MS_DH_XUAT_PT = B.MS_DH_XUAT_PT LEFT JOIN 
(SELECT     A.MS_PHIEU_BAO_TRI, SUM(B.SL_TRA) AS SL_TRA, B.MS_PT, A.MS_DH_XUAT_PT, B.ID
FROM         (SELECT     T1.MS_DHX, T2.MS_PT, SUM(T2.SL_THUC_NHAP) AS SL_TRA, T2.ID
                       FROM          dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                                              dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT
                       WHERE      (T1.MS_DANG_NHAP = 6)
                       GROUP BY T2.MS_PT, T1.MS_DHX, T2.ID) AS B INNER JOIN
                      dbo.IC_DON_HANG_XUAT AS A ON B.MS_DHX = A.MS_DH_XUAT_PT
GROUP BY A.MS_PHIEU_BAO_TRI, B.MS_PT, A.MS_DH_XUAT_PT, B.ID
HAVING      (A.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)
) C ON A.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI AND A.MS_PT = C.MS_PT AND A.ID = C.ID
WHERE     (ISNULL(E.VAT_TU,0) = 0) AND (A.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)                      
GROUP BY   A.MS_PT , D.TEN_PT, B.MS_PT, A.MS_DH_XUAT_PT, A.MS_DH_NHAP_PT,B.ID_XUAT, A.ID                       
END
