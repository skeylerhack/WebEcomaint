--INSERT INTO dbo.IC_PHU_TUNG_KHO(MS_PT, MS_KHO, MS_VI_TRI, TON_TOI_THIEU, TON_KHO_MAX, GHI_CHU, SO_NGAY_DAT_MUA_HANG)
SELECT MS_PT, MS_KHO, MS_VI_TRI, 0 AS TON_TOI_THIEU,0 AS TON_KHO_MAX, NULL AS GHI_CHU,0 AS  SO_NGAY_DAT_MUA_HANG FROM 
(SELECT MS_PT,T2.MS_KHO,T2.MS_VI_TRI FROM dbo.IC_PHU_TUNG T1, VI_TRI_KHO T2) T1
WHERE NOT EXISTS (SELECT * FROM dbo.IC_PHU_TUNG_KHO T2 WHERE T1.MS_PT = T2.MS_PT AND T1.MS_KHO = T2.MS_KHO AND T1.MS_VI_TRI = T2.MS_VI_TRI)
ORDER BY T1.MS_PT
