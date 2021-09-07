IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'VS_GET_DATA_KTTT_MONITORING')
   exec('CREATE PROCEDURE VS_GET_DATA_KTTT_MONITORING AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROC [dbo].[VS_GET_DATA_KTTT_MONITORING]
	@FROMDATE DATETIME,
	@TODATE DATETIME,
	@OPTION INT,
	@hangmuc  VS_Hang_Muc_KHTT READONLY
AS 
--DECLARE @FROMDATE DATETIME 
--DECLARE @TODATE DATETIME
--DECLARE @OPTION INT
--declare @hangmuc  dbo.[VS_Hang_Muc_KHTT]

--SET @FROMDATE = '20151201'
--SET @TODATE = '20160131'
--SET @OPTION = -1
----insert into @hangmuc (hang_muc_id)values(2063)
----insert into @hangmuc (hang_muc_id)values(1820)
----insert into @hangmuc (hang_muc_id)values(1806)
----insert into @hangmuc (hang_muc_id)values(1718)
----insert into @hangmuc (hang_muc_id)values(1717)
--insert into @hangmuc (hang_muc_id)values(1565)
--insert into @hangmuc (hang_muc_id)values(1566)
----insert into @hangmuc (hang_muc_id)values(1571)

--select t2.HANG_MUC_ID, t2.NGAY , t2.NGAY_DK_HT , t0.THOI_GIAN_DU_KIEN ,
-- DATEDIFF(DAY,t2.NGAY , t2.NGAY_DK_HT)+ 1 AS KC_NGAY , DATEPART(wk,t2.NGAY) as FROM_WEEK,DATEPART(wk,t2.NGAY_DK_HT)AS TO_WEEK,
-- MONTH(t2.NGAY) AS FROM_MONTH , MONTH(T2.NGAY_DK_HT) AS TO_MONTH,
--CASE WHEN DATEDIFF(DAY,t2.NGAY , t2.NGAY_DK_HT) + 1 <> 0 THEN  ROUND(ISNULL (t0.THOI_GIAN_DU_KIEN ,0) / (DATEDIFF(DAY,t2.NGAY , t2.NGAY_DK_HT) + 1),2) ELSE  ISNULL (t0.THOI_GIAN_DU_KIEN ,0) END AS TG_PER_DAY 
--from KE_HOACH_TONG_CONG_VIEC t0 inner join @hangmuc as t1 on  t0.hang_muc_id = t1.hang_muc_id
--inner join KE_HOACH_TONG_THE as t2 on t2.hang_muc_id = t1.hang_muc_id
--WHERE t2.NGAY >= @FROMDATE AND t2.NGAY <= @TODATE

DECLARE @DATARESULT TABLE (OBJDATA NVARCHAR(20),OBJVALUE FLOAT , OBJOPTION INT )

IF @OPTION = 1  OR @OPTION = -1 -- XEM THEO NGAY
BEGIN
			DECLARE @NGAY1 DATETIME
			DECLARE @NGAY_DK_HT1 DATETIME
			DECLARE @THOI_GIAN_DU_KIEN1 FLOAT
			DECLARE @KG_NGAY1 INT
			DECLARE @TG_PER_DAY FLOAT
			
			DECLARE FROM_TO CURSOR FOR 
				SELECT TB.NGAY,TB.NGAY_DK_HT , SUM(ISNULL(TB.THOI_GIAN_DU_KIEN,0)) AS THOI_GIAN_DU_KIEN,
				TB.KC_NGAY,
				CASE WHEN DATEDIFF(DAY,TB.NGAY , TB.NGAY_DK_HT) + 1 <> 0 THEN  ROUND(SUM(ISNULL(TB.THOI_GIAN_DU_KIEN,0)) / (DATEDIFF(DAY,TB.NGAY , TB.NGAY_DK_HT) + 1),2) ELSE  0 END AS TG_PER_DAY 
				FROM (
								select t2.HANG_MUC_ID, t2.NGAY , t2.NGAY_DK_HT , t0.THOI_GIAN_DU_KIEN ,
								DATEDIFF(DAY,t2.NGAY , t2.NGAY_DK_HT)+ 1 AS KC_NGAY , DATEPART(wk,t2.NGAY) as FROM_WEEK,DATEPART(wk,t2.NGAY_DK_HT)AS TO_WEEK,
								MONTH(t2.NGAY) AS FROM_MONTH , MONTH(T2.NGAY_DK_HT) AS TO_MONTH
								from KE_HOACH_TONG_CONG_VIEC t0 inner join @hangmuc as t1 on  t0.hang_muc_id = t1.hang_muc_id
								inner join KE_HOACH_TONG_THE as t2 on t2.hang_muc_id = t1.hang_muc_id
								WHERE t2.NGAY >= @FROMDATE AND t2.NGAY <= @TODATE
								) AS TB 
				GROUP BY TB.NGAY,TB.NGAY_DK_HT , TB.KC_NGAY,TB.KC_NGAY 

			OPEN FROM_TO
			FETCH NEXT FROM FROM_TO
			INTO @NGAY1,@NGAY_DK_HT1,@THOI_GIAN_DU_KIEN1,@KG_NGAY1,@TG_PER_DAY
			WHILE @@FETCH_STATUS = 0
			BEGIN
		
					IF @KG_NGAY1 = 1 
					BEGIN 
						INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES (CONVERT(NVARCHAR(10), @NGAY1,103) ,@THOI_GIAN_DU_KIEN1,1)
					END
					ELSE
					BEGIN 
						DECLARE @TMPDATE1 DATETIME
						SET @TMPDATE1 = @NGAY1
						WHILE @TMPDATE1 <= @NGAY_DK_HT1
						BEGIN
							INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES (CONVERT(NVARCHAR(10), @TMPDATE1,103) ,@TG_PER_DAY,1)
							SET @TMPDATE1 = DATEADD(DAY,1,@TMPDATE1)
						END
					END
					
					FETCH NEXT FROM FROM_TO
					INTO @NGAY1,@NGAY_DK_HT1,@THOI_GIAN_DU_KIEN1,@KG_NGAY1,@TG_PER_DAY
			END
			CLOSE FROM_TO
			DEALLOCATE FROM_TO
			
			-- LAY TAT CA CAC NGAY TRONG KHOANG THOI GIAN DC CHON
			DECLARE @FULLDATE1 DATETIME
			SET @FULLDATE1 = @FROMDATE
			WHILE @FULLDATE1 <= @TODATE
			BEGIN
				
				INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES (CONVERT(NVARCHAR(10), @FULLDATE1,103) ,0,1)
				SET @FULLDATE1 = DATEADD(DAY,1,@FULLDATE1)
										
			END


END

IF @OPTION = 2 OR @OPTION = -1 -- WEEK
BEGIN 
			DECLARE @NGAY2 DATETIME
			DECLARE @NGAY_DK_HT2 DATETIME
			DECLARE @THOI_GIAN_DU_KIEN2 FLOAT
			DECLARE @KG_NGAY2 INT
			DECLARE @FROM_WEEK2 INT
			DECLARE @TO_WEEK2 INT
			DECLARE @TG_PER_DAY2 FLOAT
			
			DECLARE FROM_TO CURSOR FOR 
				SELECT TB.NGAY,TB.NGAY_DK_HT , SUM(ISNULL(TB.THOI_GIAN_DU_KIEN,0)) AS THOI_GIAN_DU_KIEN,
				TB.KC_NGAY,TB.FROM_WEEK , TB.TO_WEEK ,
				CASE WHEN DATEDIFF(DAY,TB.NGAY , TB.NGAY_DK_HT) + 1 <> 0 THEN  ROUND(SUM(ISNULL(TB.THOI_GIAN_DU_KIEN,0)) / (DATEDIFF(DAY,TB.NGAY , TB.NGAY_DK_HT) + 1),2) ELSE  0 END AS TG_PER_DAY 
				FROM (
								select t2.HANG_MUC_ID, t2.NGAY , t2.NGAY_DK_HT , t0.THOI_GIAN_DU_KIEN ,
								DATEDIFF(DAY,t2.NGAY , t2.NGAY_DK_HT)+ 1 AS KC_NGAY , DATEPART(wk,t2.NGAY) as FROM_WEEK,DATEPART(wk,t2.NGAY_DK_HT)AS TO_WEEK,
								MONTH(t2.NGAY) AS FROM_MONTH , MONTH(T2.NGAY_DK_HT) AS TO_MONTH--								
								from KE_HOACH_TONG_CONG_VIEC t0 inner join @hangmuc as t1 on  t0.hang_muc_id = t1.hang_muc_id
								inner join KE_HOACH_TONG_THE as t2 on t2.hang_muc_id = t1.hang_muc_id
								WHERE t2.NGAY >= @FROMDATE AND t2.NGAY <= @TODATE
								) AS TB 
				GROUP BY TB.NGAY,TB.NGAY_DK_HT , TB.KC_NGAY,TB.KC_NGAY,TB.FROM_WEEK , TB.TO_WEEK 

			OPEN FROM_TO
			FETCH NEXT FROM FROM_TO
			INTO @NGAY2,@NGAY_DK_HT2,@THOI_GIAN_DU_KIEN2,@KG_NGAY2,@FROM_WEEK2, @TO_WEEK2,@TG_PER_DAY2
			WHILE @@FETCH_STATUS = 0
			BEGIN
		
					IF @FROM_WEEK2 = @TO_WEEK2
					BEGIN 
						INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES ( RIGHT( '00' + CONVERT(NVARCHAR(10), @FROM_WEEK2),2) +'/'+ CONVERT(NVARCHAR(4),YEAR(@NGAY2)) ,@THOI_GIAN_DU_KIEN2,2)
					END
					ELSE
					BEGIN 
						DECLARE @FIRST_DAY_OF_WEEK DATETIME
						SET @FIRST_DAY_OF_WEEK = DATEADD(wk,DATEDIFF(wk,0,@NGAY2),0)
					
						DECLARE @TMPWEEK2 INT
						SET @TMPWEEK2 =  DATEPART(wk,@FIRST_DAY_OF_WEEK) 
						DECLARE @TMPDATE2 DATETIME
						SET @TMPDATE2 = @NGAY2
						DECLARE @TMPYEAR2 INT 
						SET @TMPYEAR2 = YEAR(@FIRST_DAY_OF_WEEK)
						
						--SELECT @FIRST_DAY_OF_WEEK , @TMPWEEK2,@TMPDATE2,@TMPYEAR2,YEAR(@NGAY_DK_HT2),@TO_WEEK2
						WHILE @TMPWEEK2 -1 <> @TO_WEEK2 AND @TMPYEAR2 <= YEAR(@NGAY_DK_HT2)
						BEGIN
						
						--SELECT @FIRST_DAY_OF_WEEK , @TMPWEEK2,@TMPDATE2,@TMPYEAR2,YEAR(@NGAY_DK_HT2),@TO_WEEK2
							-- TINH SO NGAY TRONG TUAN
							DECLARE @LAST_DAY_OF_WEEK2 DATETIME 
							SET @LAST_DAY_OF_WEEK2 = dateadd(wk, datediff(wk, 0, @TMPDATE2), 0) + 6
							
							DECLARE @KC2 INT = 0
							
							IF @LAST_DAY_OF_WEEK2 < @NGAY_DK_HT2  
								SET @KC2 = DATEDIFF(DAY,@TMPDATE2 , @LAST_DAY_OF_WEEK2) + 1
							ELSE
								SET @KC2 = DATEDIFF(DAY,@TMPDATE2 , @NGAY_DK_HT2) + 1
							
							INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES ( RIGHT( '00' + CONVERT(NVARCHAR(10), @TMPWEEK2),2) +'/'+ CONVERT(NVARCHAR(4),YEAR(@FIRST_DAY_OF_WEEK)) ,@KC2 * @TG_PER_DAY2 ,2)
							
							SET @TMPDATE2 = @FIRST_DAY_OF_WEEK
							SET @FIRST_DAY_OF_WEEK =  DATEADD(WK,1,@FIRST_DAY_OF_WEEK)
							SET @TMPDATE2 = DATEADD(DAY,7,@TMPDATE2)
							SET @TMPWEEK2 =  DATEPART(wk,@TMPDATE2) -- @TMPWEEK2 + 1
							SET @TMPYEAR2 = YEAR(@TMPDATE2)
						END
					END
					
					FETCH NEXT FROM FROM_TO
					INTO  @NGAY2,@NGAY_DK_HT2,@THOI_GIAN_DU_KIEN2,@KG_NGAY2,@FROM_WEEK2, @TO_WEEK2,@TG_PER_DAY2
			END
			CLOSE FROM_TO
			DEALLOCATE FROM_TO
			-- LAY TAT CA CAC TUAN TRONG KHOANG THOI GIAN DC CHON
			DECLARE @FULL_FROM_WEEk2 INT
			DECLARE @FULL_TO_WEEK2 INT
			DECLARE @FULL_FROM_YEAR2 INT
			DECLARE @FULL_TO_YEAR2 INT
			DECLARE @FULL_FIRST_DAY_OF_WEEK2 DATETIME 
			
			SET @FULL_FIRST_DAY_OF_WEEK2 = DATEADD(wk,DATEDIFF(wk,0,@FROMDATE),0)
			
			SET @FULL_FROM_WEEk2 = DATEPART(wk,@FULL_FIRST_DAY_OF_WEEK2)
			SET @FULL_TO_WEEK2 = DATEPART(wk,@TODATE)
			SET @FULL_FROM_YEAR2 = YEAR(@FULL_FIRST_DAY_OF_WEEK2)		
			SET @FULL_TO_YEAR2 = YEAR(@TODATE)			
			
			WHILE @FULL_FROM_WEEk2 <> @FULL_TO_WEEK2 AND @FULL_FROM_YEAR2 <= @FULL_TO_YEAR2
			BEGIN
				
				INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES ( RIGHT( '00' + CONVERT(NVARCHAR(10), @FULL_FROM_WEEk2),2) +'/'+ CONVERT(NVARCHAR(4),YEAR(@FULL_FIRST_DAY_OF_WEEK2)) ,0 ,2)
				SET @FULL_FIRST_DAY_OF_WEEK2 = DATEADD(WEEK,1,@FULL_FIRST_DAY_OF_WEEK2)
				SET @FULL_FROM_WEEk2 = 	DATEPART(wk,@FULL_FIRST_DAY_OF_WEEK2)	
				SET @FULL_FROM_YEAR2 = YEAR(@FULL_FIRST_DAY_OF_WEEK2)				
			END
END

IF @OPTION = 3 OR @OPTION = -1 -- Month
BEGIN 
			DECLARE @NGAY3 DATETIME
			DECLARE @NGAY_DK_HT3 DATETIME
			DECLARE @THOI_GIAN_DU_KIEN3 FLOAT
			DECLARE @KG_NGAY3 INT
			DECLARE @FROM_MONTH3 INT
			DECLARE @TO_MONTH3 INT
			DECLARE @TG_PER_DAY3 FLOAT
			
			DECLARE FROM_TO CURSOR FOR 
				SELECT TB.NGAY,TB.NGAY_DK_HT , SUM(ISNULL(TB.THOI_GIAN_DU_KIEN,0)) AS THOI_GIAN_DU_KIEN,TB.KC_NGAY,TB.FROM_MONTH , TB.TO_MONTH ,
				CASE WHEN DATEDIFF(DAY,TB.NGAY , TB.NGAY_DK_HT) + 1 <> 0 THEN  ROUND(SUM(ISNULL(TB.THOI_GIAN_DU_KIEN,0)) / (DATEDIFF(DAY,TB.NGAY , TB.NGAY_DK_HT) + 1),2) ELSE  0 END AS TG_PER_DAY 
				FROM (
								select t2.HANG_MUC_ID, t2.NGAY , t2.NGAY_DK_HT , t0.THOI_GIAN_DU_KIEN ,
								DATEDIFF(DAY,t2.NGAY , t2.NGAY_DK_HT)+ 1 AS KC_NGAY , DATEPART(wk,t2.NGAY) as FROM_WEEK,DATEPART(wk,t2.NGAY_DK_HT)AS TO_WEEK,
								MONTH(t2.NGAY) AS FROM_MONTH , MONTH(T2.NGAY_DK_HT) AS TO_MONTH
								
								from KE_HOACH_TONG_CONG_VIEC t0 inner join @hangmuc as t1 on  t0.hang_muc_id = t1.hang_muc_id
								inner join KE_HOACH_TONG_THE as t2 on t2.hang_muc_id = t1.hang_muc_id
								WHERE t2.NGAY >= @FROMDATE AND t2.NGAY <= @TODATE
								) AS TB 
				GROUP BY TB.NGAY,TB.NGAY_DK_HT , TB.KC_NGAY,TB.KC_NGAY,TB.FROM_MONTH , TB.TO_MONTH 

			OPEN FROM_TO
			FETCH NEXT FROM FROM_TO
			INTO @NGAY3,@NGAY_DK_HT3,@THOI_GIAN_DU_KIEN3,@KG_NGAY3,@FROM_MONTH3, @TO_MONTH3,@TG_PER_DAY3
			WHILE @@FETCH_STATUS = 0
			BEGIN
		
					IF @FROM_MONTH3 = @TO_MONTH3
					BEGIN 
						INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES ( RIGHT( '00' + CONVERT(NVARCHAR(10), @FROM_MONTH3),2) +'/'+ CONVERT(NVARCHAR(4),YEAR(@NGAY3)) ,@THOI_GIAN_DU_KIEN3,3)
					END
					ELSE
					BEGIN 
						DECLARE @TMPMONTH3 INT
						SET @TMPMONTH3 = @FROM_MONTH3
						DECLARE @TMPDATE3 DATETIME
						SET @TMPDATE3 = @NGAY3
						DECLARE @TMPYEAR3 INT 
						SET @TMPYEAR3 = YEAR(@TMPDATE3)
						
						WHILE @TMPMONTH3 -1 <> @TO_MONTH3 AND @TMPYEAR3 <= YEAR(@NGAY_DK_HT3)
						BEGIN
							-- TINH SO NGAY TRONG THANG
							DECLARE @LAST_DAY_OF_MONTH3 DATETIME 
							SET @LAST_DAY_OF_MONTH3 = dateadd(month,1+datediff(month,0,@TMPDATE3),-1)
							
							DECLARE @KC3 INT = 0
							
							IF @LAST_DAY_OF_MONTH3 < @NGAY_DK_HT3  
								SET @KC3 = DATEDIFF(DAY,@TMPDATE3 , @LAST_DAY_OF_MONTH3) + 1
							ELSE
								SET @KC3 = DATEDIFF(DAY,@TMPDATE3 , @NGAY_DK_HT3) + 1
							
							INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES ( RIGHT( '00' + CONVERT(NVARCHAR(10), @TMPMONTH3),2) +'/'+ CONVERT(NVARCHAR(4),YEAR(@TMPDATE3)) ,@KC3 * @TG_PER_DAY3,3 )
							
							
							SET @TMPDATE3 = DATEADD(DAY,1,@LAST_DAY_OF_MONTH3)
							SET @TMPMONTH3 =  MONTH(@TMPDATE3) -- @TMPWEEK2 + 1
							SET @TMPYEAR3 = YEAR(@TMPDATE3)
						END
					END
					
					FETCH NEXT FROM FROM_TO
					INTO @NGAY3,@NGAY_DK_HT3,@THOI_GIAN_DU_KIEN3,@KG_NGAY3,@FROM_MONTH3, @TO_MONTH3,@TG_PER_DAY3
			END
			CLOSE FROM_TO
			DEALLOCATE FROM_TO
			
			-- LAY TAT CA CAC THANG TRONG KHOANG THOI GIAN DC CHON
			DECLARE @FULL_FROM_MONTH3 INT
			DECLARE @FULL_TO_MONTH3 INT
			DECLARE @FULL_FROM_YEAR3 INT
			DECLARE @FULL_TO_YEAR3 INT
			DECLARE @DAY_OF_MONTH3 DATETIME
			
			SET @FULL_FROM_MONTH3 = MONTH(@FROMDATE)
			SET @FULL_TO_MONTH3 = MONTH(@TODATE)
			SET @FULL_FROM_YEAR3 =YEAR(@FROMDATE)
			SET @FULL_TO_YEAR3 =YEAR(@TODATE)
			SET @DAY_OF_MONTH3 = @FROMDATE
			
			WHILE @FULL_FROM_MONTH3-1 <> @FULL_TO_MONTH3 AND @FULL_FROM_YEAR3 <= @FULL_TO_YEAR3
			BEGIN
				
				INSERT INTO @DATARESULT (OBJDATA,OBJVALUE,OBJOPTION) VALUES ( RIGHT( '00' + CONVERT(NVARCHAR(10), @FULL_FROM_MONTH3),2) +'/'+ CONVERT(NVARCHAR(4),YEAR(@DAY_OF_MONTH3)) ,0,3 )
							
				SET @DAY_OF_MONTH3 = DATEADD(MONTH,1,@DAY_OF_MONTH3)
				SET @FULL_FROM_MONTH3 = MONTH(	@DAY_OF_MONTH3)
				SET @FULL_FROM_YEAR3 = YEAR(@DAY_OF_MONTH3)				
			END
END




SELECT OBJDATA , SUM(OBJVALUE) AS OBJVALUE ,OBJOPTION  
FROM @DATARESULT  GROUP BY OBJDATA,OBJOPTION
ORDER BY OBJOPTION,RIGHT(OBJDATA,4) , LEFT(OBJDATA,2)