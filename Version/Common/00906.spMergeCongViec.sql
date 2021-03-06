
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spMergeCongViec')
   exec('CREATE PROCEDURE spMergeCongViec AS BEGIN SET NOCOUNT ON; END')
GO


alter PROC  spMergeCongViec
	@MsCVGoc int,
	@MsCVCopy int
AS	
-- Chu y' 1 so data se khong co table  KE_HOACH_TONG_CONG_VIEC_PHU_TUNG_CHI_TIET va KE_HOACH_TONG_CONG_VIEC_CHI_TIET
--@MsCVGoc MSCV Merge

-- CAU_TRUC_THIET_BI_CONG_VIEC, Loc ra trung delete truoc rui moi update
DELETE T1 FROM CAU_TRUC_THIET_BI_CONG_VIEC T1 INNER JOIN
(
SELECT MS_MAY, MS_BO_PHAN, @MsCVGoc AS  MS_CV FROM
(
SELECT MS_MAY, MS_BO_PHAN, MS_CV FROM CAU_TRUC_THIET_BI_CONG_VIEC WHERE MS_CV = @MsCVGoc
UNION
SELECT MS_MAY, MS_BO_PHAN, MS_CV FROM CAU_TRUC_THIET_BI_CONG_VIEC WHERE MS_CV = @MsCVCopy
) A
GROUP BY MS_MAY, MS_BO_PHAN
HAVING COUNT(*) > 1
) T2 ON T1.MS_MAY = T2.MS_MAY AND T1.MS_BO_PHAN = T2.MS_BO_PHAN AND T1.MS_CV = T2.MS_CV
UPDATE CAU_TRUC_THIET_BI_CONG_VIEC SET MS_CV = @MsCVCopy WHERE MS_CV = @MsCVGoc

-- EOR_CONG_VIEC
DELETE T1 FROM EOR_CONG_VIEC T1 INNER JOIN
(
SELECT EOR_ID, MS_BO_PHAN, @MsCVGoc AS  MS_CV FROM
(
SELECT EOR_ID, MS_BO_PHAN, MS_CV FROM EOR_CONG_VIEC WHERE MS_CV = @MsCVGoc
UNION
SELECT EOR_ID, MS_BO_PHAN, MS_CV FROM EOR_CONG_VIEC WHERE MS_CV = @MsCVCopy
) A
GROUP BY EOR_ID, MS_BO_PHAN
HAVING COUNT(*) > 1
) T2 ON T1.EOR_ID = T2.EOR_ID AND T1.MS_BO_PHAN = T2.MS_BO_PHAN AND T1.MS_CV = T2.MS_CV
UPDATE EOR_CONG_VIEC SET MS_CV = @MsCVCopy WHERE MS_CV = @MsCVGoc



--KE_HOACH_TONG_CONG_VIEC_PHU_TUNG
DELETE T1 FROM KE_HOACH_TONG_CONG_VIEC_PHU_TUNG T1 INNER JOIN
	(
		SELECT MS_MAY,HANG_MUC_ID,@MsCVGoc AS MS_CV, MS_BO_PHAN,MS_PT FROM
			(
				SELECT MS_MAY,HANG_MUC_ID,MS_CV, MS_BO_PHAN,MS_PT FROM KE_HOACH_TONG_CONG_VIEC_PHU_TUNG WHERE MS_CV = @MsCVGoc
				UNION
				SELECT MS_MAY,HANG_MUC_ID,MS_CV, MS_BO_PHAN,MS_PT FROM KE_HOACH_TONG_CONG_VIEC_PHU_TUNG WHERE MS_CV = @MsCVCopy
			) A
		GROUP BY MS_MAY,HANG_MUC_ID, MS_BO_PHAN,MS_PT
		HAVING COUNT(*) > 1
	) T2 ON T1.MS_MAY = T2.MS_MAY AND T1.HANG_MUC_ID = T2.HANG_MUC_ID AND T1.MS_CV = T2.MS_CV AND 
		T1.MS_BO_PHAN = T2.MS_BO_PHAN AND T1.MS_PT = T2.MS_PT
UPDATE KE_HOACH_TONG_CONG_VIEC_PHU_TUNG SET MS_CV = @MsCVCopy WHERE MS_CV = @MsCVGoc




-- KE_HOACH_TONG_CONG_VIEC, Loc ra trung delete truoc rui moi update
DELETE T1 FROM KE_HOACH_TONG_CONG_VIEC T1 INNER JOIN
	(
		SELECT MS_MAY,HANG_MUC_ID,@MsCVGoc AS MS_CV, MS_BO_PHAN FROM
			(
				SELECT MS_MAY,HANG_MUC_ID,MS_CV, MS_BO_PHAN FROM KE_HOACH_TONG_CONG_VIEC WHERE MS_CV = @MsCVGoc
				UNION
				SELECT MS_MAY,HANG_MUC_ID,MS_CV, MS_BO_PHAN FROM KE_HOACH_TONG_CONG_VIEC WHERE MS_CV = @MsCVCopy
			) A
		GROUP BY MS_MAY,HANG_MUC_ID, MS_BO_PHAN
		HAVING COUNT(*) > 1
	) T2 ON T1.MS_MAY = T2.MS_MAY AND T1.HANG_MUC_ID = T2.HANG_MUC_ID AND T1.MS_CV = T2.MS_CV AND T1.MS_BO_PHAN = T2.MS_BO_PHAN	
UPDATE KE_HOACH_TONG_CONG_VIEC SET MS_CV = @MsCVCopy WHERE MS_CV = @MsCVGoc

--MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG
DELETE T1 FROM MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG T1 INNER JOIN
	(
		SELECT MS_MAY,MS_LOAI_BT,@MsCVGoc AS MS_CV,MS_BO_PHAN,MS_PT	FROM
			(
				SELECT MS_MAY,MS_LOAI_BT,MS_CV,MS_BO_PHAN,MS_PT FROM MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG WHERE MS_CV = @MsCVGoc
				UNION
				SELECT MS_MAY,MS_LOAI_BT,MS_CV,MS_BO_PHAN,MS_PT FROM MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG WHERE MS_CV = @MsCVCopy
			) A
		GROUP BY MS_MAY,MS_LOAI_BT,MS_BO_PHAN,MS_PT
		HAVING COUNT(*) > 1
	) T2 ON T1.MS_MAY = T2.MS_MAY AND T1.MS_LOAI_BT = T2.MS_LOAI_BT AND T1.MS_CV = T2.MS_CV 
		AND T1.MS_BO_PHAN = T2.MS_BO_PHAN AND T1.MS_PT = T2.MS_PT
UPDATE MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG SET MS_CV = @MsCVCopy WHERE MS_CV = @MsCVGoc

--MAY_LOAI_BTPN_CONG_VIEC
DELETE T1 FROM MAY_LOAI_BTPN_CONG_VIEC T1 INNER JOIN
	(
		SELECT MS_MAY,MS_LOAI_BT,@MsCVGoc AS MS_CV,MS_BO_PHAN	FROM
			(
				SELECT MS_MAY,MS_LOAI_BT,MS_CV,MS_BO_PHAN FROM MAY_LOAI_BTPN_CONG_VIEC WHERE MS_CV = @MsCVGoc
				UNION
				SELECT MS_MAY,MS_LOAI_BT,MS_CV,MS_BO_PHAN FROM MAY_LOAI_BTPN_CONG_VIEC WHERE MS_CV = @MsCVCopy
			) A
		GROUP BY MS_MAY,MS_LOAI_BT,MS_BO_PHAN
		HAVING COUNT(*) > 1
	) T2 ON T1.MS_MAY = T2.MS_MAY AND T1.MS_LOAI_BT = T2.MS_LOAI_BT AND T1.MS_CV = T2.MS_CV AND T1.MS_BO_PHAN = T2.MS_BO_PHAN
UPDATE MAY_LOAI_BTPN_CONG_VIEC SET MS_CV = @MsCVCopy WHERE MS_CV = @MsCVGoc

--PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO
--PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET
--PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG
--PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET
--PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU
--PHIEU_BAO_TRI_CONG_VIEC_KE_HOACH
--PHIEU_BAO_TRI_CONG_VIEC
UPDATE PHIEU_BAO_TRI_CONG_VIEC SET MS_CV = @MsCVCopy WHERE MS_CV = @MsCVGoc





