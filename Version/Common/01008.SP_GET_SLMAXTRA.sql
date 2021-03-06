
--SP_get_slmaxtra 'PN-1704-0008', 'PX-1704-0003', 'BAF-BF-007', 'PN-1704-0006', 3

ALTER procedure [dbo].[SP_GET_SLMAXTRA]
@MS_DH_NHAP_PT NVARCHAR (14),
@MS_DH_XUAT_PT	nvarchar(14),
@MS_PT NVARCHAR (25),
@MS_DH_NHAP_PT_GOC NVARCHAR (14),
@ID_GOC INT

AS
BEGIN

 SELECT  ISNULL(A_1.SLX, 0) - (ISNULL(B.SLBT, 0) + ISNULL(C.SLN, 0)) AS SLCL
                         
                            FROM          (
                   
                       SELECT DISTINCT  IC_DON_HANG_XUAT_VAT_TU.MS_DH_XUAT_PT, T.MS_PT, T.MS_DH_NHAP_PT , SL_VT AS SLX, T1.DON_GIA, T1.NGOAI_TE 
                      , ID_XUAT FROM dbo.IC_DON_HANG_XUAT_VAT_TU INNER JOIN IC_DON_HANG_XUAT_VAT_TU_CHI_TIET T ON
                       T.MS_DH_XUAT_PT = IC_DON_HANG_XUAT_VAT_TU.MS_DH_XUAT_PT 
                       inner join IC_DON_HANG_NHAP_VAT_TU T1 on T.MS_DH_NHAP_PT = T1.MS_DH_NHAP_PT AND T1.MS_PT = T.MS_PT 
                       AND T1.ID = T.ID_XUAT                 
                       GROUP BY IC_DON_HANG_XUAT_VAT_TU.MS_DH_XUAT_PT, T.MS_PT,T.MS_DH_NHAP_PT ,ID_XUAT, SL_VT ,T1.DON_GIA, T1.NGOAI_TE                                               
                       )                                              
                        AS A_1 
                       
                       LEFT OUTER JOIN (SELECT     MS_DH_XUAT_PT, MS_PT, ISNULL(SUM(SL_TT), 0) AS SLBT
                                        FROM dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO
                                        GROUP BY MS_DH_XUAT_PT, MS_PT) AS B ON A_1.MS_DH_XUAT_PT = B.MS_DH_XUAT_PT AND A_1.MS_PT = B.MS_PT LEFT OUTER JOIN (
SELECT DISTINCT MS_DHX, MS_PT, MS_DH_NHAP_PT_GOC , ID, SUM(SLN) AS SLN FROM (
   SELECT  distinct T.MS_DH_NHAP_PT , T.MS_DHX, T3.MS_PT,t2.ID , t2.MS_DH_NHAP_PT_GOC ,
 T3.SL_VT AS SLN
 FROM          dbo.IC_DON_HANG_NHAP AS T
   INNER JOIN   dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT
   inner join IC_DON_HANG_NHAP_VAT_TU_CHI_TIET T3 on  T3.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT and T2.MS_PT = T3.MS_PT and t2.ID = t3.ID 
  WHERE      (ISNULL(T.MS_DHX, N'') <> '') --AND T.MS_DH_NHAP_PT <> @MS_DH_NHAP_PT
GROUP BY T.MS_DHX, T3.MS_PT,t2.ID, T3.SL_VT,T.MS_DH_NHAP_PT , t2.MS_DH_NHAP_PT_GOC 
) A
GROUP BY MS_DHX, MS_PT,  MS_DH_NHAP_PT_GOC , ID
)

  AS C  ON A_1.MS_DH_XUAT_PT = C.MS_DHX AND A_1.MS_PT = C.MS_PT and  a_1.MS_DH_NHAP_PT = c.MS_DH_NHAP_PT_GOC  --AND A_1.ID_XUAT = C.ID
                            WHERE      (ISNULL(A_1.SLX, 0) - (ISNULL(B.SLBT, 0) + ISNULL(C.SLN, 0)) > 0) AND 
                            (A_1.MS_DH_XUAT_PT = @MS_DH_XUAT_PT AND
                             A_1.ID_XUAT = @ID_GOC AND A_1.MS_PT = @MS_PT AND A_1.MS_DH_NHAP_PT = @MS_DH_NHAP_PT_GOC 
)
--SELECT DISTINCT ISNULL(A_1.SLX, 0) - (ISNULL(B.SLBT, 0) + ISNULL(C.SLN, 0)) AS SLCL

--FROM          (SELECT     T1.MS_DH_XUAT_PT, T1.MS_DH_NHAP_PT, T1.MS_PT, SUM(SL_VT) AS SLX, ID_XUAT
--            FROM          dbo.IC_DON_HANG_XUAT_VAT_TU T 
--            INNER JOIN IC_DON_HANG_XUAT_VAT_TU_CHI_TIET T1 ON T.MS_PT = T1.MS_PT AND T.MS_DH_XUAT_PT = T1.MS_DH_XUAT_PT
--            GROUP BY T1.MS_DH_XUAT_PT, T1.MS_DH_NHAP_PT, T1.MS_PT, ID_XUAT)
            
--             AS A_1 LEFT OUTER JOIN
--               (SELECT     MS_DH_XUAT_PT, MS_PT, ISNULL(SUM(SL_TT), 0) AS SLBT
--                 FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO
--                 GROUP BY MS_DH_XUAT_PT, MS_PT) AS B ON A_1.MS_DH_XUAT_PT = B.MS_DH_XUAT_PT AND A_1.MS_PT = B.MS_PT LEFT OUTER JOIN
--               (
               
--               SELECT     IC_DON_HANG_NHAP_1.MS_DHX, IC_DON_HANG_NHAP_VAT_TU_1.MS_PT, SUM(IC_DON_HANG_NHAP_VAT_TU_1.SL_THUC_NHAP) 
--                                        AS SLN, ID , MS_DH_NHAP_PT_GOC 
--                 FROM          dbo.IC_DON_HANG_NHAP AS IC_DON_HANG_NHAP_1 INNER JOIN
--                                        dbo.IC_DON_HANG_NHAP_VAT_TU AS IC_DON_HANG_NHAP_VAT_TU_1 ON 
--                                        IC_DON_HANG_NHAP_1.MS_DH_NHAP_PT = IC_DON_HANG_NHAP_VAT_TU_1.MS_DH_NHAP_PT
--                 WHERE      (ISNULL(IC_DON_HANG_NHAP_1.MS_DHX, N'') <> '' 
--						AND IC_DON_HANG_NHAP_1.MS_DH_NHAP_PT <> @MS_DH_NHAP_PT)
--                 GROUP BY IC_DON_HANG_NHAP_1.MS_DHX, IC_DON_HANG_NHAP_VAT_TU_1.MS_PT, ID , MS_DH_NHAP_PT_GOC ) AS C ON A_1.MS_DH_XUAT_PT = C.MS_DHX AND 
--           A_1.MS_PT = C.MS_PT AND A_1.ID_XUAT = C.ID
--WHERE      (ISNULL(A_1.SLX, 0) - (ISNULL(B.SLBT, 0) + ISNULL(C.SLN, 0)) > 0) AND (A_1.MS_DH_XUAT_PT = @MS_DH_XUAT_PT)
--AND A_1.MS_PT = @MS_PT AND A_1.MS_DH_NHAP_PT = @MS_DH_NHAP_PT_GOC AND A_1.ID_XUAT = @ID_GOC
	
END
