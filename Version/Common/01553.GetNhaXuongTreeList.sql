

--exec GetNhaXuongTreeList 0,'administrator',1
ALTER proc [dbo].[GetNhaXuongTreeList]
	@CoALL BIT = 1,	
	@UserName nvarchar(50) = 'admin',
	@NNgu INT = 1
AS

if @CoALL = 0
	SELECT MS_N_XUONG,TEN_N_XUONG,temp.MS_CHA MS_CHA
	FROM
	(
		SELECT DISTINCT NHA_XUONG.MS_N_XUONG,CASE @NNgu WHEN 0 THEN Ten_N_XUONG WHEN 1 THEN ISNULL(NULLIF(TEN_N_XUONG_A,''),Ten_N_XUONG) ELSE ISNULL(NULLIF(TEN_N_XUONG_H,''),Ten_N_XUONG) END AS TEN_N_XUONG , MS_CHA
		FROM NHA_XUONG INNER JOIN  NHOM_NHA_XUONG ON
		NHA_XUONG.MS_N_XUONG = NHOM_NHA_XUONG.MS_N_XUONG  INNER JOIN USERS ON NHOM_NHA_XUONG.GROUP_ID=USERS.GROUP_ID 
		WHERE USERS.USERNAME=@USERNAME
	)temp
	ORDER BY Ten_N_XUONG ,MS_N_XUONG 
else
	SELECT MS_N_XUONG,TEN_N_XUONG,ISNULL(temp.MS_CHA, '-1') MS_CHA
	FROM
	(
		SELECT DISTINCT NHA_XUONG.MS_N_XUONG,CASE @NNgu WHEN 0 THEN Ten_N_XUONG WHEN 1 THEN ISNULL(NULLIF(TEN_N_XUONG_A,''),Ten_N_XUONG) ELSE ISNULL(NULLIF(TEN_N_XUONG_H,''),Ten_N_XUONG) END AS TEN_N_XUONG,MS_CHA
		FROM NHA_XUONG INNER JOIN  NHOM_NHA_XUONG ON
		NHA_XUONG.MS_N_XUONG = NHOM_NHA_XUONG.MS_N_XUONG  INNER JOIN USERS ON NHOM_NHA_XUONG.GROUP_ID=USERS.GROUP_ID 
		WHERE USERS.USERNAME=@USERNAME
	)temp
	UNION
	SELECT '-1', ' < ALL > ', NULL
	ORDER BY Ten_N_XUONG ,MS_N_XUONG 

