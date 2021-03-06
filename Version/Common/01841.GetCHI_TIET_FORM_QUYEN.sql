-- GetCHI_TIET_FORM_QUYEN 1, 2
ALTER proc [dbo].[GetCHI_TIET_FORM_QUYEN]
 @GROUP_ID INT =3,
 @TYPELANGUAGE INT = 0
AS
SELECT        TOP (100) PERCENT T1.FORM_NAME, CASE @TYPELANGUAGE WHEN 0 THEN T1.TEN_FORMS_VIET WHEN 1 THEN ISNULL(NULLIF (T1.TEN_FORMS_ANH, ''), 
                         T1.TEN_FORMS_VIET) ELSE ISNULL(NULLIF (T1.TEN_FORMS_ANH, ''), T1.TEN_FORMS_HOA) END AS TEN_FORM, ISNULL(T2.QUYEN, N'') AS QUYEN, CONVERT(BIT, 'False') AS IS_UPDATE,
                          @GROUP_ID AS GROUP_ID INTO #TMP
FROM            dbo.CHI_TIET_FORMS  AS T1  
				LEFT OUTER JOIN dbo.NHOM_FORM AS T2 ON T1.FORM_NAME = T2.FORM_NAME
WHERE        (T2.GROUP_ID = @GROUP_ID) AND ISNULL(T1.AN_HIEN,0) = 0
SELECT * FROM  #TMP
UNION
SELECT FORM_NAME,CASE @TYPELANGUAGE WHEN 0 THEN TEN_FORMS_VIET WHEN 1 THEN ISNULL(NULLIF (TEN_FORMS_ANH, ''), 
                         TEN_FORMS_VIET) ELSE ISNULL(NULLIF (TEN_FORMS_ANH, ''), TEN_FORMS_HOA) END AS TEN_FORM,N'No access' AS QUYEN,CONVERT(BIT, 'False') AS IS_UPDATE,@GROUP_ID AS GROUP_ID  FROM CHI_TIET_FORMS  WHERE NOT EXISTS (SELECT * FROM #TMP B WHERE CHI_TIET_FORMS.FORM_NAME = B.FORM_NAME)
						 ORDER BY TEN_FORM



						 

