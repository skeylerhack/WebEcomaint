
--EXEC GetThongTinVatTu -1, N'',0,'ADMIN','',N''

ALTER procedure [dbo].[GetThongTinVatTu]
	@LOAI INT,
	@GIA_TRI NVARCHAR(150),
	@Type int,
	@USERNAME NVARCHAR(50),
	@GT_MSPT NVARCHAR(150),
	@GT_TPT NVARCHAR(150)
AS

--DECLARE @TenViTri nvarchar(250)
--IF @LOAI = 6 
--	SET @TenViTri = @GIA_TRI
--ELSE
--	SET @TenViTri = '-1'

--SELECT * INTO #PTUNG FROM IC_PHU_TUNG WHERE MS_PT = '-1'
--IF @LOAI = 6	-- TIM ALL
--	INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG
--ELSE
--	if @Type=0 -- Tim gan dung like
--		BEGIN
--			IF @LOAI = -1 --	-1 All
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE (MS_PT LIKE '%' + @GIA_TRI + '%') OR (MS_PT_CTY LIKE '%' + @GIA_TRI + '%') 
--					OR (MS_PT_NCC LIKE '%' + @GIA_TRI + '%') OR (TEN_PT LIKE N'%' + @GIA_TRI + '%') OR (QUY_CACH LIKE '%' + @GIA_TRI + '%')
--			IF @LOAI = 1 --1 MS vật tư, phụ tùng
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE MS_PT LIKE '%' + @GIA_TRI + '%'
--			IF @LOAI = 2	--2	Item Code MS_PT_CTY 
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE MS_PT_CTY LIKE '%' + @GIA_TRI + '%'
--			IF @LOAI = 3	--3	Part Number MS_PT_NCC 
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE MS_PT_NCC LIKE '%' + @GIA_TRI + '%'
--			IF @LOAI = 4	--4	Tên vật tư, phụ tùng
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE TEN_PT LIKE '%' + @GIA_TRI + '%'
--			IF @LOAI = 5	--5	Quy cách
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE QUY_CACH LIKE '%' + @GIA_TRI + '%'
--		END 			
--	ELSE	-- TIM CHINH XAC
--		BEGIN
--			IF @LOAI = -1 --	-1 All
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE  (MS_PT = @GIA_TRI ) OR (MS_PT_CTY = @GIA_TRI ) 
--					OR (MS_PT_NCC = @GIA_TRI ) OR (TEN_PT = @GIA_TRI ) OR (QUY_CACH = @GIA_TRI )
--			IF @LOAI = 1 --1 MS vật tư, phụ tùng
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE MS_PT =  @GIA_TRI 
--			IF @LOAI = 2	--2	Item Code MS_PT_CTY 
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE MS_PT_CTY =  @GIA_TRI 
--			IF @LOAI = 3	--3	Part Number MS_PT_NCC 
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE MS_PT_NCC = @GIA_TRI 
--			IF @LOAI = 4	--4	Tên vật tư, phụ tùng
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE TEN_PT = @GIA_TRI 
--			IF @LOAI = 5	--5	Quy cách
--				INSERT INTO #PTUNG SELECT * FROM IC_PHU_TUNG WHERE QUY_CACH = @GIA_TRI 

--		END 

SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC,  TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, NGAY, 
			TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
			TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY, TMP1.ID 
from (
	SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH ,C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, 
			C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, A.DON_GIA, I.TEN_NGOAI_TE, 
			A.XUAT_XU,T1.TEN_HSX, X.NGAY
	FROM dbo.NGOAI_TE AS I INNER JOIN
			  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
			  IC_PHU_TUNG AS D INNER JOIN
			  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
			  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
			  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
			  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
			  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID 
			  LEFT OUTER JOIN dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
			  INNER JOIN dbo.IC_DON_HANG_NHAP AS X ON A.MS_DH_NHAP_PT = X.MS_DH_NHAP_PT 
	WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) 
union all
	SELECT     MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
			NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
			NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, 
			NULL AS XUAT_XU,T1.TEN_HSX, NULL AS NGAY
	FROM         IC_PHU_TUNG AS D LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
	WHERE     (MS_PT NOT IN
		(SELECT     MS_PT
			FROM          dbo.VI_TRI_KHO_VAT_TU
			WHERE      (SL_VT > 0))) 
) TMP1
ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
		
		

--if @Type=0
--begin
--	---1	 < ALL > 
--	IF @LOAI = -1
--		SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC,  TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--					 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX, TMP1.BAO_HANH_DEN_NGAY,TMP1.ID 
--			from (
--				SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH, C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--						F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, 
--						C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU, T1.TEN_HSX
--				FROM         dbo.NGOAI_TE AS I INNER JOIN
--                      dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--                      dbo.IC_PHU_TUNG AS D INNER JOIN
--                      dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--                      dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--                      dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--                      dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--                      dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--                      dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--                WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) AND ( 
--					(C.MS_PT LIKE '%' + @GIA_TRI + '%') OR (D.MS_PT_CTY LIKE '%' + @GIA_TRI + '%') 
--					OR (D.MS_PT_NCC LIKE '%' + @GIA_TRI + '%') OR (D.TEN_PT LIKE N'%' + @GIA_TRI + '%') 
--					OR (D.QUY_CACH LIKE '%' + @GIA_TRI + '%') OR  (F.TEN_VI_TRI LIKE '%' + @GIA_TRI + '%')  )
--			union all
--				SELECT DISTINCT 
--					  C.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--					  F.TEN_VI_TRI, SUM(C.SL_VT) AS SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, NULL AS BAO_HANH_DEN_NGAY, 
--					  C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU, T1.TEN_HSX				
--				FROM dbo.NGOAI_TE AS I INNER JOIN
--						  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--						  dbo.IC_PHU_TUNG AS D INNER JOIN
--						  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--						  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--						  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--						  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--						  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--						  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--				WHERE     (H.USERNAME = @USERNAME)
--				GROUP BY C.MS_PT, TEN_PT, QUY_CACH, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, 
--						D.MS_PT_NCC, D.MS_PT_CTY, C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU ,T1.TEN_HSX
--				HAVING      (SUM(C.SL_VT) = 0) AND (
--					(C.MS_PT LIKE '%' + @GIA_TRI + '%') OR (D.MS_PT_CTY LIKE '%' + @GIA_TRI + '%') 
--					OR (D.MS_PT_NCC LIKE '%' + @GIA_TRI + '%')  OR (D.TEN_PT LIKE '%' + @GIA_TRI + '%') 
--					OR (D.QUY_CACH LIKE '%' + @GIA_TRI + '%') OR (F.TEN_VI_TRI LIKE '%' + @GIA_TRI + '%') )
--			)TMP1 
--			WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--			ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--	ELSE IF @LOAI=1 --1	MS vật tư, phụ tùng
--			SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC,  TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--					 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY, TMP1.ID  
--			from (
--				SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH ,
--					  C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, 
--					  A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU, T1.TEN_HSX
--				FROM dbo.NGOAI_TE AS I INNER JOIN
--						  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--						  dbo.IC_PHU_TUNG AS D INNER JOIN
--						  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--						  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--						  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--						  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--						  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--						  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--				WHERE     (C.SL_VT > 0) AND (C.MS_PT LIKE '%' + @GIA_TRI + '%') AND (H.USERNAME = @USERNAME)
--			union all
--				SELECT     D.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--						NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--						NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU, T1.TEN_HSX
--				FROM         dbo.IC_PHU_TUNG D  LEFT JOIN 
--					  HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--				WHERE     (MS_PT NOT IN
--					(SELECT     MS_PT
--						FROM          dbo.VI_TRI_KHO_VAT_TU
--						WHERE      (SL_VT > 0))) AND (MS_PT LIKE '%' + @GIA_TRI + '%')
--			) TMP1
--			WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--			ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--		ELSE
--			--2	Item Code MS_PT_CTY 
--			IF @LOAI=2
--				SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--						 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY,TMP1.ID  
--				from (
--				SELECT DISTINCT 
--					  C.MS_PT, TEN_PT, QUY_CACH, C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, 
--					  C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--				FROM dbo.NGOAI_TE AS I INNER JOIN
--						  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--						  dbo.IC_PHU_TUNG AS D INNER JOIN
--						  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--						  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--						  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--						  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--						  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--						  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--				WHERE     (H.USERNAME = @USERNAME) AND (C.SL_VT > 0) AND (D.MS_PT_CTY LIKE '%' + @GIA_TRI + '%')
--				union all
--					SELECT     D.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--							NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--							NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU,T1.TEN_HSX
--					FROM         dbo.IC_PHU_TUNG D LEFT JOIN 
--						HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--					WHERE     (MS_PT_CTY LIKE '%' + @GIA_TRI + '%') AND (MS_PT NOT IN
--							  (SELECT     MS_PT
--								FROM          dbo.VI_TRI_KHO_VAT_TU
--								WHERE      (SL_VT > 0)))				
--						) TMP1
--						WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--						ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--			ELSE
--				--3	Part Number MS_PT_NCC 
--				IF @LOAI=3
--					SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--						 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY,TMP1.ID 
--					from (
--					SELECT DISTINCT 
--						  C.MS_PT, TEN_PT, QUY_CACH, C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--						  F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, 
--						  A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--					FROM dbo.NGOAI_TE AS I INNER JOIN
--							  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--							  dbo.IC_PHU_TUNG AS D INNER JOIN
--							  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--							  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--							  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--							  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--							  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--							  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--					WHERE     (H.USERNAME = @USERNAME) AND (C.SL_VT > 0) AND (D.MS_PT_NCC LIKE '%' + @GIA_TRI + '%')
--					union all
--					SELECT     D.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--							NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--							NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU,T1.TEN_HSX
--					FROM         dbo.IC_PHU_TUNG AS D  LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--					WHERE     (MS_PT_NCC LIKE '%' + @GIA_TRI + '%') AND (MS_PT NOT IN
--							  (SELECT     MS_PT
--								FROM          dbo.VI_TRI_KHO_VAT_TU
--								WHERE      (SL_VT > 0)))
--						) TMP1
--						WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--						ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--				ELSE
--					--4	Tên vật tư, phụ tùng
--					IF @LOAI=4
--						SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--								 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX, TMP1.BAO_HANH_DEN_NGAY, TMP1.ID 
--						from (
--							SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH,
--								  C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, 
--								  A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX 
--							FROM dbo.NGOAI_TE AS I INNER JOIN
--									  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--									  dbo.IC_PHU_TUNG AS D INNER JOIN
--									  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--									  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--									  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--									  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--									  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--									  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--							WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) AND (TEN_PT LIKE '%' + @GIA_TRI + '%')
--						union all
--									SELECT     D.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--											NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--											NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU,T1.TEN_HSX
--									FROM         dbo.IC_PHU_TUNG AS D  LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--									WHERE     (TEN_PT LIKE '%' + @GIA_TRI + '%') AND (MS_PT NOT IN
--											  (SELECT     MS_PT
--												FROM          dbo.VI_TRI_KHO_VAT_TU
--												WHERE      (SL_VT > 0)))
--						) TMP1
--						WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--						ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--					ELSE
--						--5	Quy cách
--						IF @LOAI=5
--							SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--									 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX, TMP1.BAO_HANH_DEN_NGAY, TMP1.ID 
--							from (
--								SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH,
--									  C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, 
--									  A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--								FROM dbo.NGOAI_TE AS I INNER JOIN
--										  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--										  dbo.IC_PHU_TUNG AS D INNER JOIN
--										  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--										  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--										  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--										  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--										  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--										  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--								WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) AND (QUY_CACH LIKE '%' + @GIA_TRI + '%')
--							union all
--										SELECT     D.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--												NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--												NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU,T1.TEN_HSX
--										FROM         dbo.IC_PHU_TUNG AS D  LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--										WHERE     (QUY_CACH LIKE '%' + @GIA_TRI + '%') AND (MS_PT NOT IN
--												  (SELECT     MS_PT
--													FROM          dbo.VI_TRI_KHO_VAT_TU
--													WHERE      (SL_VT > 0)))
--							) TMP1
--							WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--							ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--						ELSE
--							--6	Vị trí kho
--							SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--									 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY,TMP1.ID 
--							from (
--								SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH, C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--										F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, 
--										C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--								FROM dbo.NGOAI_TE AS I INNER JOIN
--										  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--										  dbo.IC_PHU_TUNG AS D INNER JOIN
--										  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--										  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--										  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--										  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--										  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--										  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--								WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) AND (F.TEN_VI_TRI LIKE '%' + @GIA_TRI + '%')
--							union all
--								SELECT DISTINCT 
--									  C.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--									  F.TEN_VI_TRI, SUM(C.SL_VT) AS SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, NULL AS BAO_HANH_DEN_NGAY, 
--									  C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--								FROM dbo.NGOAI_TE AS I INNER JOIN
--										  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--										  dbo.IC_PHU_TUNG AS D INNER JOIN
--										  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--										  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--										  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--										  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--										  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--										  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--								WHERE     (H.USERNAME = @USERNAME)
--								GROUP BY C.MS_PT, TEN_PT, QUY_CACH, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, 
--										D.MS_PT_NCC, D.MS_PT_CTY, C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--								HAVING      (SUM(C.SL_VT) = 0) AND (F.TEN_VI_TRI LIKE '%' + @GIA_TRI + '%')
--							)TMP1
--							WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--							ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--end

--else
--begin
--	---1	 < ALL > 
--	IF @LOAI = -1
--			SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC,  TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--					 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY,TMP1.ID  
--			from (
--				SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH, C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--						F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, 
--						C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--				FROM dbo.NGOAI_TE AS I INNER JOIN
--						  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--						  dbo.IC_PHU_TUNG AS D INNER JOIN
--						  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--						  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--						  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--						  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--						  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--						  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--				WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) AND ( 
--					(C.MS_PT =  @GIA_TRI ) OR (D.MS_PT_CTY =  @GIA_TRI ) 
--					OR (D.MS_PT_NCC =  @GIA_TRI ) OR (D.TEN_PT =  @GIA_TRI ) 
--					OR (D.QUY_CACH =  @GIA_TRI ) OR  (F.TEN_VI_TRI =  @GIA_TRI )  )
--			union all
--				SELECT DISTINCT 
--					  C.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--					  F.TEN_VI_TRI, SUM(C.SL_VT) AS SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, NULL AS BAO_HANH_DEN_NGAY, 
--					  C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--				FROM dbo.NGOAI_TE AS I INNER JOIN
--						  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--						  dbo.IC_PHU_TUNG AS D INNER JOIN
--						  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--						  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--						  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--						  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--						  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--						  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--				WHERE     (H.USERNAME = @USERNAME)
--				GROUP BY C.MS_PT, TEN_PT, QUY_CACH, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, 
--						D.MS_PT_NCC, D.MS_PT_CTY, C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--				HAVING      (SUM(C.SL_VT) = 0) AND (
--					(C.MS_PT =  @GIA_TRI ) OR (D.MS_PT_CTY =  @GIA_TRI ) 
--					OR (D.MS_PT_NCC =  @GIA_TRI )  OR (D.TEN_PT =  @GIA_TRI ) 
--					OR (D.QUY_CACH =  @GIA_TRI ) OR (F.TEN_VI_TRI =  @GIA_TRI ) )
--			)TMP1
--			WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--			ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--	ELSE 
--		--1	MS vật tư, phụ tùng
--		IF @LOAI=1 
--			SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC,  TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--					 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY, TMP1.ID 
--			from (
--				SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH ,
--					  C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, 
--					  A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--				FROM dbo.NGOAI_TE AS I INNER JOIN
--						  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--						  dbo.IC_PHU_TUNG AS D INNER JOIN
--						  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--						  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--						  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--						  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--						  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--						  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--				WHERE     (C.SL_VT > 0) AND (C.MS_PT =  @GIA_TRI ) AND (H.USERNAME = @USERNAME)
--			union all
--				SELECT     MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--						NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--						NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU,T1.TEN_HSX
--				FROM         dbo.IC_PHU_TUNG AS D LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--				WHERE     (MS_PT NOT IN
--					(SELECT     MS_PT
--						FROM          dbo.VI_TRI_KHO_VAT_TU
--						WHERE      (SL_VT > 0))) AND (MS_PT =  @GIA_TRI )
--			) TMP1
--			WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--			ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--		ELSE
--			--2	Item Code MS_PT_CTY 
--			IF @LOAI=2
--				SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--						 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY,TMP1.ID 
--				from (
--				SELECT DISTINCT 
--					  C.MS_PT, TEN_PT, QUY_CACH, C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, 
--					  C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--				FROM dbo.NGOAI_TE AS I INNER JOIN
--						  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--						  dbo.IC_PHU_TUNG AS D INNER JOIN
--						  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--						  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--						  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--						  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--						  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--						  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--				WHERE     (H.USERNAME = @USERNAME) AND (C.SL_VT > 0) AND (D.MS_PT_CTY =  @GIA_TRI )
--				union all
--					SELECT     MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--							NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--							NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU,T1.TEN_HSX
--					FROM         dbo.IC_PHU_TUNG AS D  LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--					WHERE     (MS_PT_CTY =  @GIA_TRI ) AND (MS_PT NOT IN
--							  (SELECT     MS_PT
--								FROM          dbo.VI_TRI_KHO_VAT_TU
--								WHERE      (SL_VT > 0)))				
--						) TMP1
--						WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--						ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--			ELSE
--				--3	Part Number MS_PT_NCC 
--				IF @LOAI=3
--					SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--						 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY,TMP1.ID 
--					from (
--					SELECT DISTINCT 
--						  C.MS_PT, TEN_PT, QUY_CACH, C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--						  F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, 
--						  A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--					FROM dbo.NGOAI_TE AS I INNER JOIN
--							  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--							  dbo.IC_PHU_TUNG AS D INNER JOIN
--							  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--							  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--							  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--							  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--							  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--							  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--					WHERE     (H.USERNAME = @USERNAME) AND (C.SL_VT > 0) AND (D.MS_PT_NCC =  @GIA_TRI )
--					union all
--					SELECT     D.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--							NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--							NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU,T1.TEN_HSX
--					FROM         dbo.IC_PHU_TUNG AS D  LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--					WHERE     (MS_PT_NCC =  @GIA_TRI ) AND (MS_PT NOT IN
--							  (SELECT     MS_PT
--								FROM          dbo.VI_TRI_KHO_VAT_TU
--								WHERE      (SL_VT > 0)))
--						) TMP1
--						WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--						ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--				ELSE
--					--4	Tên vật tư, phụ tùng
--					IF @LOAI=4
--						SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--								 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY, TMP1.ID 
--						from (
--							SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH,
--								  C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, 
--								  A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--							FROM dbo.NGOAI_TE AS I INNER JOIN
--									  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--									  dbo.IC_PHU_TUNG AS D INNER JOIN
--									  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--									  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--									  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--									  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--									  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--									  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--							WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) AND (TEN_PT =  @GIA_TRI )
--						union all
--									SELECT     D.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--											NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--											NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU, T1.TEN_HSX
--									FROM         dbo.IC_PHU_TUNG AS D LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--									WHERE     (TEN_PT =  @GIA_TRI ) AND (MS_PT NOT IN
--											  (SELECT     MS_PT
--												FROM          dbo.VI_TRI_KHO_VAT_TU
--												WHERE      (SL_VT > 0)))
--						) TMP1
--						WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--						ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--					ELSE
--						--5	Quy cách
--						IF @LOAI=5
--							SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--									 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY, TMP1.ID 
--							from (
--								SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH,
--									  C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, C.ID, 
--									  A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--								FROM dbo.NGOAI_TE AS I INNER JOIN
--										  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--										  dbo.IC_PHU_TUNG AS D INNER JOIN
--										  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--										  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--										  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--										  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--										  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--										  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--								WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) AND (QUY_CACH =  @GIA_TRI )
--							union all
--										SELECT     D.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, NULL AS MS_KHO, NULL AS TEN_KHO, 
--												NULL AS MS_VI_TRI, NULL AS TEN_VI_TRI, 0 AS SL_VT, MS_PT_NCC, MS_PT_CTY, 
--												NULL AS BAO_HANH_DEN_NGAY, 0 AS ID, 0 AS DON_GIA,NULL AS TEN_NGOAI_TE, NULL AS XUAT_XU,T1.TEN_HSX
--										FROM         dbo.IC_PHU_TUNG AS D LEFT JOIN HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX
--										WHERE     (QUY_CACH =  @GIA_TRI ) AND (MS_PT NOT IN
--												  (SELECT     MS_PT
--													FROM          dbo.VI_TRI_KHO_VAT_TU
--													WHERE      (SL_VT > 0)))
--							) TMP1
--							WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--							ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--						ELSE
--							--6	Vị trí kho
--							SELECT DISTINCT  TMP1.MS_PT,TMP1.MS_PT_CTY,TMP1.MS_PT_NCC, TEN_PT, QUY_CACH , TMP1.MS_DH_NHAP_PT, TMP1.MS_KHO, TMP1.TEN_KHO,TMP1.MS_VI_TRI,  TMP1.TEN_VI_TRI, 
--									 TMP1.SL_VT,DON_GIA,TEN_NGOAI_TE,XUAT_XU,TMP1.TEN_HSX,TMP1.BAO_HANH_DEN_NGAY,TMP1.ID 
--							from (
--								SELECT DISTINCT C.MS_PT, TEN_PT, QUY_CACH, C.MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--										F.TEN_VI_TRI, C.SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, A.BAO_HANH_DEN_NGAY, 
--										C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--								FROM dbo.NGOAI_TE AS I INNER JOIN
--										  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--										  dbo.IC_PHU_TUNG AS D INNER JOIN
--										  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--										  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--										  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--										  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--										  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--										  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--								WHERE     (C.SL_VT > 0) AND (H.USERNAME = @USERNAME) AND (F.TEN_VI_TRI =  @GIA_TRI )
--							union all
--								SELECT DISTINCT 
--									  C.MS_PT, TEN_PT, QUY_CACH, NULL AS MS_DH_NHAP_PT, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, 
--									  F.TEN_VI_TRI, SUM(C.SL_VT) AS SL_VT, D.MS_PT_NCC, D.MS_PT_CTY, NULL AS BAO_HANH_DEN_NGAY, 
--									  C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU,T1.TEN_HSX
--								FROM dbo.NGOAI_TE AS I INNER JOIN
--										  dbo.IC_DON_HANG_NHAP_VAT_TU AS A ON I.NGOAI_TE = A.NGOAI_TE INNER JOIN
--										  dbo.IC_PHU_TUNG AS D INNER JOIN
--										  dbo.VI_TRI_KHO_VAT_TU AS C ON D.MS_PT = C.MS_PT INNER JOIN
--										  dbo.IC_KHO AS E ON C.MS_KHO = E.MS_KHO INNER JOIN
--										  dbo.VI_TRI_KHO AS F ON C.MS_VI_TRI = F.MS_VI_TRI INNER JOIN
--										  dbo.NHOM_KHO AS G ON E.MS_KHO = G.MS_KHO INNER JOIN
--										  dbo.USERS AS H ON G.GROUP_ID = H.GROUP_ID ON A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.MS_PT = C.MS_PT AND A.ID = C.ID LEFT OUTER JOIN
--										  dbo.HANG_SAN_XUAT AS T1 ON D.MS_HSX = T1.MS_HSX				
--								WHERE     (H.USERNAME = @USERNAME)
--								GROUP BY C.MS_PT, TEN_PT, QUY_CACH, C.MS_KHO, E.TEN_KHO, C.MS_VI_TRI, F.TEN_VI_TRI, 
--										D.MS_PT_NCC, D.MS_PT_CTY, C.ID, A.DON_GIA, I.TEN_NGOAI_TE, A.XUAT_XU ,T1.TEN_HSX
--								HAVING      (SUM(C.SL_VT) = 0) AND (F.TEN_VI_TRI =  @GIA_TRI )
--							)TMP1
--							WHERE (MS_PT LIKE '%' + @GT_MSPT + '%')  AND  (TEN_PT LIKE '%' + @GT_TPT + '%' ) 
--							ORDER BY MS_PT, MS_DH_NHAP_PT, TEN_KHO
--end
