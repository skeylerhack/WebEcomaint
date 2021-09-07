
ALTER procedure [dbo].[GetMS_MAY_DINH_TINHs] 
	@MS_LOAI_MAY NVARCHAR(20),
	@USERNAME NVARCHAR(50)
AS
	/*SELECT DISTINCT MAY_THONG_SO_GSTT.MS_MAY, MAY_THONG_SO_GSTT.MS_MAY AS TEN_MAY
FROM         MAY_THONG_SO_GSTT INNER JOIN
                      MAY ON MAY_THONG_SO_GSTT.MS_MAY = MAY.MS_MAY INNER JOIN
                      MAY_NHA_XUONG ON MAY_THONG_SO_GSTT.MS_MAY = MAY_NHA_XUONG.MS_MAY INNER JOIN
                      NHOM_MAY ON MAY.MS_NHOM_MAY = NHOM_MAY.MS_NHOM_MAY INNER JOIN
                      GIA_TRI_TS_GSTT ON MAY_THONG_SO_GSTT.MS_TS_GSTT = GIA_TRI_TS_GSTT.MS_TS_GSTT INNER JOIN
                      THONG_SO_GSTT ON MAY_THONG_SO_GSTT.MS_TS_GSTT = THONG_SO_GSTT.MS_TS_GSTT AND 
                      GIA_TRI_TS_GSTT.MS_TS_GSTT = THONG_SO_GSTT.MS_TS_GSTT
WHERE     (NHOM_MAY.MS_LOAI_MAY = @MS_LOAI_MAY) AND (THONG_SO_GSTT.LOAI_TS = 1)*/
SELECT DISTINCT CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY, CASE WHEN dbo.MAY.TEN_MAY IS NULL OR  dbo.MAY.TEN_MAY = '' THEN dbo.MAY.MS_MAY ELSE dbo.MAY.MS_MAY + ' ('  + dbo.MAY.TEN_MAY + ')'  END AS TEN_MAY
FROM         CAU_TRUC_THIET_BI_TS_GSTT INNER JOIN
                      MAY ON CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY = MAY.MS_MAY INNER JOIN
                      MAY_NHA_XUONG ON MAY.MS_MAY = MAY_NHA_XUONG.MS_MAY INNER JOIN
                      NHOM_MAY ON MAY.MS_NHOM_MAY = NHOM_MAY.MS_NHOM_MAY INNER JOIN
                      THONG_SO_GSTT ON CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT = THONG_SO_GSTT.MS_TS_GSTT INNER JOIN
                      GIA_TRI_TS_GSTT ON THONG_SO_GSTT.MS_TS_GSTT = GIA_TRI_TS_GSTT.MS_TS_GSTT INNER JOIN
                      LOAI_MAY ON NHOM_MAY.MS_LOAI_MAY = LOAI_MAY.MS_LOAI_MAY INNER JOIN
                      NHOM_NHA_XUONG ON MAY_NHA_XUONG.MS_N_XUONG = NHOM_NHA_XUONG.MS_N_XUONG INNER JOIN
                      USERS ON NHOM_NHA_XUONG.GROUP_ID = USERS.GROUP_ID
WHERE     (NHOM_MAY.MS_LOAI_MAY = @MS_LOAI_MAY OR @MS_LOAI_MAY = '-1') AND USERS.USERNAME=@USERNAME
