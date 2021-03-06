
--exec [NHA_XUONG_DEVICE_INFO] 'admin','-1','-1','-1'
ALTER proc [dbo].[NHA_XUONG_DEVICE_INFO]
	@USERNAME nvarchar(50),
	@ms_tinh nvarchar(30),
	@ms_quan nvarchar(30),
	@ms_duong nvarchar(30)
AS
SELECT MS_N_XUONG,TEN_N_XUONG
FROM
(
SELECT DISTINCT NHA_XUONG.MS_N_XUONG, NHA_XUONG.TEN_N_XUONG,MS_QG,MS_DUONG
FROM NHA_XUONG INNER JOIN  NHOM_NHA_XUONG ON
NHA_XUONG.MS_N_XUONG = NHOM_NHA_XUONG.MS_N_XUONG  INNER JOIN USERS ON NHOM_NHA_XUONG.GROUP_ID=USERS.GROUP_ID 
WHERE USERS.USERNAME=@USERNAME
)temp
left join IC_QUOC_GIA
ON TEMP.MS_QG = IC_QUOC_GIA.MA_QG
where '1'=(CASE WHEN @ms_tinh='-1' THEN '1' WHEN @ms_tinh<>'-1' AND IC_QUOC_GIA.MS_CHA =@ms_tinh THEN '1' ELSE '0' END) 
and '1'=(CASE WHEN @ms_quan='-1' THEN '1' WHEN @ms_quan<>'-1' AND TEMP.MS_QG =@ms_quan THEN '1' ELSE '0' END) 
and '1'=(CASE WHEN @ms_duong='-1' THEN '1' WHEN @ms_duong<>'-1' AND TEMP.MS_DUONG =@ms_duong THEN '1' ELSE '0' END) 
union select '-1',' < ALL > '
ORDER BY Ten_N_XUONG ,MS_N_XUONG
