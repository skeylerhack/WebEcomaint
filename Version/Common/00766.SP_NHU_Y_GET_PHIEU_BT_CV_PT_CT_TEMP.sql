

--EXEC SP_NHU_Y_GET_PHIEU_BT_CV_PT_CT_TEMP  'WO-201112001',319,'1','130010001','PHIEU_BAO_TRI_CONG_VIEC_TMPadmin','PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_TMPadmin','PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_TMPadmin'
ALTER PROC [dbo].[SP_NHU_Y_GET_PHIEU_BT_CV_PT_CT_TEMP]
(
	@MS_PHIEU_BAO_TRI NVARCHAR(20),
	@MS_CV INT,
	@MS_BO_PHAN NVARCHAR(50),
	@MS_PT NVARCHAR(30),
	@TABLE_NAME_TEMP NVARCHAR(100),
	@TABLE_NAME NVARCHAR(100),
	@TABLE_NAME_CHI_TIET NVARCHAR(100)
)
AS
DECLARE @SQL NVARCHAR (4000)
SET @SQL='
SELECT DISTINCT T1.MS_PHIEU_BAO_TRI,
             T1.MS_CV, T1.MS_BO_PHAN, T1.MS_PT,T1.STT, T1.MS_VI_TRI_PT,
             T1.SL_KH, T1.SL_TT,T3.NGAY_HOAN_THANH
            FROM ' + @TABLE_NAME_CHI_TIET  + ' AS T1 
            INNER JOIN ' + @TABLE_NAME +  ' AS T2
             ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI AND T1.MS_CV = T2.MS_CV 
             AND T1.MS_BO_PHAN = T2.MS_BO_PHAN AND T1.MS_PT = T2.MS_PT  
             INNER JOIN ' + @TABLE_NAME_TEMP + ' AS T3 ON T1.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI AND T1.MS_CV = T3.MS_CV 
             AND T1.MS_BO_PHAN = T3.MS_BO_PHAN
            WHERE  (T1.MS_PHIEU_BAO_TRI =' + CHAR(39) + @MS_PHIEU_BAO_TRI + CHAR(39) + ') 
            
            --AND T1.MS_PHIEU_BAO_TRI + CONVERT (NVARCHAR (8), T1.MS_CV) + T1.MS_BO_PHAN + T1.MS_PT 
            --NOT IN (SELECT T2.MS_PHIEU_BAO_TRI + CONVERT (NVARCHAR (8), T2.MS_CV) + T2.MS_BO_PHAN + T2.MS_PT 
            --         FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET T2)
                     
                     AND T1.MS_PT =' + CHAR(39) + @MS_PT + CHAR(39) + ' AND T1.MS_CV =' + CHAR(39) + CONVERT(NVARCHAR(8),@MS_CV) + CHAR(39) + ' 
AND T1.MS_BO_PHAN =' + CHAR(39) + @MS_BO_PHAN  + CHAR(39) + ' AND T1.MS_PHIEU_BAO_TRI =' + CHAR(39) + @MS_PHIEU_BAO_TRI + CHAR(39) + ' ORDER BY T1.MS_VI_TRI_PT '
EXEC(@SQL)
