

--exec SP_GET_PT_XUAT_PTSD 'WO-201507000903'
--PX-1502-0001	T3888487013	2	1
ALTER procedure [dbo].[SP_GET_PT_XUAT_PTSD] 
	@MS_PHIEU_BAO_TRI NVARCHAR (20)
AS
BEGIN

SELECT DISTINCT B.MS_PT AS PT_GOC, D.TEN_PT, B.MS_PT, D.TEN_PT AS TEN_PT_SD, B.MS_DH_XUAT_PT, B.MS_DH_NHAP_PT, SUM(ISNULL(A_1.SL_TT, 0)) AS SL_TT, 
                      SUM(ISNULL(B.SL_VT, 0)) - SUM(ISNULL(C.SL_TRA, 0)) AS SL_VT, B.ID_XUAT, A_1.ID
FROM         (SELECT     T1.MS_PHIEU_BAO_TRI, T1.MS_DH_XUAT_PT, T3.MS_PT, T3.SL_VT, T3.ID_XUAT, T3.MS_DH_NHAP_PT
                       FROM          dbo.IC_DON_HANG_XUAT AS T1 INNER JOIN
                                              dbo.IC_DON_HANG_XUAT_VAT_TU AS T2 ON T1.MS_DH_XUAT_PT = T2.MS_DH_XUAT_PT INNER JOIN
                                              dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T3 ON T2.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT AND T2.MS_PT = T3.MS_PT
                       GROUP BY T1.MS_PHIEU_BAO_TRI, T1.MS_DH_XUAT_PT, T3.MS_PT, T3.SL_VT, T3.ID_XUAT, T3.MS_DH_NHAP_PT
                       HAVING      (T1.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)) AS B INNER JOIN
                      dbo.LOAI_VT AS E INNER JOIN
                      dbo.IC_PHU_TUNG AS D ON E.MS_LOAI_VT = D.MS_LOAI_VT ON B.MS_PT = D.MS_PT LEFT OUTER JOIN
                          (SELECT     MS_PHIEU_BAO_TRI, MS_PT, MS_DH_XUAT_PT, MS_DH_NHAP_PT, ID, SUM(SL_TT) AS SL_TT
                            FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS T2
                            WHERE      (MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)
                            GROUP BY ID, MS_PHIEU_BAO_TRI, MS_PT, MS_DH_XUAT_PT, MS_DH_NHAP_PT) AS A_1 ON B.MS_PHIEU_BAO_TRI = A_1.MS_PHIEU_BAO_TRI AND B.MS_PT = A_1.MS_PT AND 
                      B.ID_XUAT = A_1.ID AND B.MS_DH_XUAT_PT = A_1.MS_DH_XUAT_PT AND B.MS_DH_NHAP_PT = A_1.MS_DH_NHAP_PT LEFT OUTER JOIN
                          (SELECT     A.MS_PHIEU_BAO_TRI, SUM(B_1.SL_TRA) AS SL_TRA, B_1.MS_PT, A.MS_DH_XUAT_PT, B_1.ID
                            FROM          (SELECT     T1.MS_DHX, T2.MS_PT, SUM(T2.SL_THUC_NHAP) AS SL_TRA, T2.ID
                                                    FROM          dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                                                                           dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT
                                                    WHERE      (T1.MS_DANG_NHAP = 6)
                                                    GROUP BY T2.MS_PT, T1.MS_DHX, T2.ID) AS B_1 INNER JOIN
                                                   dbo.IC_DON_HANG_XUAT AS A ON B_1.MS_DHX = A.MS_DH_XUAT_PT
                            GROUP BY A.MS_PHIEU_BAO_TRI, B_1.MS_PT, A.MS_DH_XUAT_PT, B_1.ID
                            HAVING      (A.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)) AS C ON A_1.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI AND A_1.MS_PT = C.MS_PT AND A_1.ID = C.ID
WHERE     (ISNULL(E.VAT_TU, 0) = 0) AND (B.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)
GROUP BY D.TEN_PT, B.MS_PT, B.MS_DH_XUAT_PT, B.MS_DH_NHAP_PT, B.ID_XUAT, A_1.ID
ORDER BY B.MS_PT, D.TEN_PT           
END
