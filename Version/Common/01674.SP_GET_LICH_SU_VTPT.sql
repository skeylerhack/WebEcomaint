IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GET_LICH_SU_VTPT')
exec('CREATE PROCEDURE SP_GET_LICH_SU_VTPT AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[SP_GET_LICH_SU_VTPT]
 @MS_MAY NVARCHAR(25) = 'HAM-0010' ,
 @MS_BO_PHAN NVARCHAR(50) = '01.04',
 @MS_PT NVARCHAR(25) = 'HAM-SC-030'
AS
SELECT DISTINCT
        T4.MS_MAY + ' - ' + CONVERT(NVARCHAR(128), T4.TEN_MAY) AS MAY ,
        dbo.CAU_TRUC_THIET_BI.MS_BO_PHAN + ' - '
        + dbo.CAU_TRUC_THIET_BI.TEN_BO_PHAN AS TEN_BO_PHAN ,  
        T6.NGAY_HOAN_THANH AS NGAY_THAY_THE ,T1.MS_DH_NHAP_PT,
		    T4.NGAY_MUA ,
			TEN_CONG_TY,
        dbo.IC_PHU_TUNG.MS_PT + ' - ' + dbo.IC_PHU_TUNG.TEN_PT AS PHU_TUNG ,
        T1.BAO_HANH_DEN_NGAY ,T1.DON_GIA,
        T3.MS_VI_TRI_PT ,
        T7.MS_CONG_NHAN + ' - ' + T7.TEN AS NGUOI_THAY ,
        T3.MS_PHIEU_BAO_TRI ,
        CONVERT(BIT, 0) AS PT_CHA ,
        T2.MS_PTTT ,
        IC_PHU_TUNG_1.TEN_PT ,
        CASE WHEN T6.STT_SERVICE IS NULL THEN T2.SL_TT
             ELSE T3.SL_TT
        END AS SL_TT ,
        T1.XUAT_XU ,
        T3.GHI_CHU ,
        0.0 AS THOI_GIAN_SU_DUNG
FROM    dbo.IC_DON_HANG_NHAP_VAT_TU AS T1
        INNER JOIN dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT
                                                              AND T1.MS_PT = T2.MS_PTTT
        INNER JOIN dbo.IC_PHU_TUNG AS IC_PHU_TUNG_1 ON T2.MS_PTTT = IC_PHU_TUNG_1.MS_PT
        RIGHT  JOIN dbo.IC_PHU_TUNG
        INNER JOIN dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET AS T3 ON dbo.IC_PHU_TUNG.MS_PT = T3.MS_PT
        INNER JOIN dbo.CAU_TRUC_THIET_BI ON T3.MS_BO_PHAN = dbo.CAU_TRUC_THIET_BI.MS_BO_PHAN
        INNER JOIN dbo.MAY AS T4
        INNER JOIN dbo.PHIEU_BAO_TRI AS T5 ON T4.MS_MAY = T5.MS_MAY ON dbo.CAU_TRUC_THIET_BI.MS_MAY = T5.MS_MAY
        INNER JOIN dbo.PHIEU_BAO_TRI_CONG_VIEC AS T6 ON T5.MS_PHIEU_BAO_TRI = T6.MS_PHIEU_BAO_TRI
                                                        AND T3.MS_PHIEU_BAO_TRI = T6.MS_PHIEU_BAO_TRI
                                                        AND T3.MS_CV = T6.MS_CV ON T2.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI
                                                              AND T2.MS_CV = T3.MS_CV
                                                              AND T2.MS_BO_PHAN = T3.MS_BO_PHAN
                                                              AND T2.MS_PT = T3.MS_PT
                                                              AND T2.STT = T3.STT
        LEFT  JOIN dbo.CONG_NHAN AS T7 ON T3.NGUOI_THAY_THE = T7.MS_CONG_NHAN
		LEFT JOIN dbo.KHACH_HANG ON KHACH_HANG.MS_KH = IC_PHU_TUNG_1.MS_KH
WHERE   ( T5.MS_MAY = @MS_MAY )
        AND ( dbo.CAU_TRUC_THIET_BI.MS_BO_PHAN = @MS_BO_PHAN )
        AND ( dbo.IC_PHU_TUNG.MS_PT = @MS_PT )
        AND ( T5.TINH_TRANG_PBT = 3
              OR T5.TINH_TRANG_PBT = 4
            )
ORDER BY NGAY_THAY_THE DESC


--
--1 note có trong nhiều lĩnh vực

--table FIELD(ID_FIE,TEN_FIE)
--table SPECIES(ID_SPE,ID_FIE,NAME)
--table NOTE(ID_NOTE,ID_SPE,NAME,IMAGE,CONTENT,NOTE)