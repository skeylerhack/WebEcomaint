USE [msdb]
GO

/****** Object:  Job [JobDeleteDataLan]    Script Date: 21/11/2016 14:41:35 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 21/11/2016 14:41:35 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'JobDeleteDataLan', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DeleteData]    Script Date: 21/11/2016 14:41:36 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DeleteData', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT DISTINCT STT INTO #BTSTT FROM LANGUAGES A WHERE EXISTS(SELECT form,KEYWORD ,count(stt) FROM LANGUAGES B 
	WHERE  A.FORM = B.FORM AND A.KEYWORD = B.KEYWORD group by form,KEYWORD having count(stt) >1)
AND STT NOT IN(
SELECT DISTINCT A.STT FROM LANGUAGES A 
INNER JOIN
(SELECT MIN(STT) AS STT,FORM,KEYWORD  FROM LANGUAGES A WHERE EXISTS(SELECT form,KEYWORD ,count(stt) FROM LANGUAGES B 
	WHERE  A.FORM = B.FORM AND A.KEYWORD = B.KEYWORD group by form,KEYWORD having count(stt) >1)
GROUP BY FORM,KEYWORD ) B ON A.FORM = B.FORM AND A.KEYWORD = B.KEYWORD AND A.STT = B.STT
)
GO
DELETE FROM LANGUAGES WHERE EXISTS
(SELECT * FROM #BTSTT A WHERE LANGUAGES.STT = A.STT)
', 
		@database_name=N'CMMS_TEST', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


