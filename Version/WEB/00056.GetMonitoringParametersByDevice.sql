IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetMonitoringParametersByDevice')
   exec('CREATE PROCEDURE GetMonitoringParametersByDevice AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC [dbo].[GetMonitoringParametersByDevice]
    @deviceID NVARCHAR(50) = 'HCSHCM0101' ,
    @tungay NVARCHAR(20) = '10/03/2019' ,
    @ms_loaicv INT = '-1' ,
    @isDue INT = 1,
    @stt INT = -1
	-- isdue = 1 xem theo ngày đến hạn
	--0 là xem tất cả
AS
    BEGIN
--sữa thì update những cái đã có vào
        SELECT  T1.MS_MAY ,
                T1.MS_BO_PHAN ,
                T1.MS_TS_GSTT ,
                T2.TEN_GIA_TRI ,
                T1.GHI_CHU ,
                T1.STT_GT
        INTO    #TEMPT1
        FROM    dbo.GIAM_SAT_TINH_TRANG_TS_DT T1
                LEFT JOIN dbo.GIA_TRI_TS_GSTT T2 ON T2.MS_TS_GSTT = T1.MS_TS_GSTT
                                                    AND T1.STT_GT = T2.STT
        WHERE   T1.STT = @stt
                AND T1.MS_MAY = @deviceID
        ORDER BY T1.MS_MAY

        IF ( @isDue = 0 )
            BEGIN
			--định tính
                SELECT DISTINCT
                        @deviceID DeviceID ,
                        THONG_SO_GSTT.TEN_TS_GSTT MonitoringParamsName ,
                        CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT MonitoringParamsID ,
                        T.MS_BO_PHAN ComponentID ,
                        T.TEN_BO_PHAN ComponentName ,
                        THONG_SO_GSTT.LOAI_TS TypeOfParam ,
                        '' MeasurementUnitName ,
                        GIA_TRI_TS_GSTT.TEN_GIA_TRI ValueParamName ,
                        GIA_TRI_TS_GSTT.DAT Pass ,
                        CONVERT(FLOAT, 0) Measurement ,
                        GIA_TRI_TS_GSTT.STT ValueParamID ,
                        '' Note
                INTO    #TEMPTA
                FROM    THONG_SO_GSTT
                        INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT ON CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT = THONG_SO_GSTT.MS_TS_GSTT
                        INNER JOIN CAU_TRUC_THIET_BI T ON T.MS_MAY = CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY
                                                          AND T.MS_BO_PHAN = CAU_TRUC_THIET_BI_TS_GSTT.MS_BO_PHAN
                        LEFT JOIN GIA_TRI_TS_GSTT ON THONG_SO_GSTT.MS_TS_GSTT = GIA_TRI_TS_GSTT.MS_TS_GSTT
                WHERE   ( CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY = @deviceID )
                        AND THONG_SO_GSTT.LOAI_TS = 1
                        AND ( MS_LOAI_CV = @ms_loaicv
                              OR @ms_loaicv = -1
                            )
                UNION
	--định lượng
                SELECT DISTINCT
                        @deviceID DeviceID ,
                        THONG_SO_GSTT.TEN_TS_GSTT MonitoringParamsName ,
                        CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT MonitoringParamsID ,
                        T.MS_BO_PHAN ComponentID ,
                        T.TEN_BO_PHAN ComponentName ,
                        THONG_SO_GSTT.LOAI_TS TypeOfParam ,
                        ISNULL(T4.TEN_DV_DO, '') MeasurementUnitName ,
                        dbo.GetGiaTriThongSo(@deviceID, T.MS_BO_PHAN,
                                             CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT) ValueParamName ,
                        -1 Pass ,
                        CONVERT(FLOAT, 0) Measurement ,
                        -1 ValueParamID ,
                        '' Note
                FROM    THONG_SO_GSTT
                        INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT ON CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT = THONG_SO_GSTT.MS_TS_GSTT
                        INNER JOIN CAU_TRUC_THIET_BI T ON T.MS_MAY = CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY
                                                          AND T.MS_BO_PHAN = CAU_TRUC_THIET_BI_TS_GSTT.MS_BO_PHAN
                        LEFT JOIN dbo.DON_VI_DO AS T4 ON THONG_SO_GSTT.MS_DV_DO = T4.MS_DV_DO
                WHERE   ( CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY = @deviceID )
                        AND THONG_SO_GSTT.LOAI_TS = 0
                        AND ( MS_LOAI_CV = @ms_loaicv
                              OR @ms_loaicv = -1
                            )
                GROUP BY THONG_SO_GSTT.TEN_TS_GSTT ,
                        CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT ,
                        T.MS_BO_PHAN ,
                        T.TEN_BO_PHAN ,
                        THONG_SO_GSTT.LOAI_TS ,
                        TEN_DV_DO ,
                        CAU_TRUC_THIET_BI_TS_GSTT.MS_TT 

                IF @stt = -1 -- thêm thì lấy mới
                    BEGIN
                        SELECT  *
                        FROM    #TEMPTA
                    END
                ELSE
				--sữa thì update cái đã có vào cái mới
                    BEGIN
                        UPDATE  #TEMPTA
                        SET     Measurement = 1
                        WHERE   EXISTS ( SELECT *
                                         FROM   #TEMPT1
                                         WHERE  MS_MAY = #TEMPTA.DeviceID
                                                AND MS_BO_PHAN = #TEMPTA.ComponentID
                                                AND MS_TS_GSTT = #TEMPTA.MonitoringParamsID
                                                AND STT_GT = #TEMPTA.ValueParamID )
                        SELECT  *
                        FROM    #TEMPTA 
                    END
            END
        ELSE
		-- lấy theo thời gian đến hạn kiểm tra
            BEGIN
                SELECT DISTINCT
                        @deviceID DeviceID ,
                        THONG_SO_GSTT.TEN_TS_GSTT MonitoringParamsName ,
                        CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT MonitoringParamsID ,
                        T.MS_BO_PHAN ComponentID ,
                        T.TEN_BO_PHAN ComponentName ,
                        THONG_SO_GSTT.LOAI_TS TypeOfParam ,
                        '' MeasurementUnitName ,
                        GIA_TRI_TS_GSTT.TEN_GIA_TRI ValueParamName ,
                        GIA_TRI_TS_GSTT.DAT Pass ,
                        CONVERT(FLOAT, 0) Measurement ,
                        GIA_TRI_TS_GSTT.STT ValueParamID ,
                        '' Note
                INTO    #TEMPTB
                FROM    THONG_SO_GSTT
                        INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT ON CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT = THONG_SO_GSTT.MS_TS_GSTT
                        INNER JOIN CAU_TRUC_THIET_BI T ON T.MS_MAY = CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY
                                                          AND T.MS_BO_PHAN = CAU_TRUC_THIET_BI_TS_GSTT.MS_BO_PHAN
                        LEFT JOIN GIA_TRI_TS_GSTT ON THONG_SO_GSTT.MS_TS_GSTT = GIA_TRI_TS_GSTT.MS_TS_GSTT
                        INNER JOIN dbo.GIAM_SAT_TINH_TRANG_TS ON GIAM_SAT_TINH_TRANG_TS.MS_MAY = CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY
                                                              AND GIAM_SAT_TINH_TRANG_TS.MS_BO_PHAN = CAU_TRUC_THIET_BI_TS_GSTT.MS_BO_PHAN
                                                              AND GIAM_SAT_TINH_TRANG_TS.MS_TS_GSTT = CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT
                                                              AND GIAM_SAT_TINH_TRANG_TS.MS_TT = CAU_TRUC_THIET_BI_TS_GSTT.MS_TT
                        INNER JOIN dbo.GIAM_SAT_TINH_TRANG ON GIAM_SAT_TINH_TRANG.STT = GIAM_SAT_TINH_TRANG_TS.STT
                WHERE   ( CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY = @deviceID )
                        AND THONG_SO_GSTT.LOAI_TS = 1
                        AND ( CASE MS_DV_TG
                                WHEN 1 THEN DATEADD(DAY, CHU_KY_DO, NGAY_KT)
                                WHEN 2 THEN DATEADD(WEEK, CHU_KY_DO, NGAY_KT)
                                WHEN 3 THEN DATEADD(MONTH, CHU_KY_DO, NGAY_KT)
                                ELSE DATEADD(YEAR, CHU_KY_DO, NGAY_KT)
                              END <= @tungay )
                        AND ( MS_LOAI_CV = @ms_loaicv
                              OR @ms_loaicv = -1
                            )
                IF @stt = -1 -- thêm thì lấy mới
                    BEGIN
                        SELECT  *
                        FROM    #TEMPTB
                    END
                ELSE
                    BEGIN
                        UPDATE  #TEMPTB
                        SET     Measurement = 1
                        WHERE   EXISTS ( SELECT *
                                         FROM   #TEMPT1
                                         WHERE  MS_MAY = #TEMPTB.DeviceID
                                                AND MS_BO_PHAN = #TEMPTB.ComponentID
                                                AND MS_TS_GSTT = #TEMPTB.MonitoringParamsID
                                                AND STT_GT = #TEMPTB.ValueParamID )
                        SELECT  *
                        FROM    #TEMPTB
                    END
            END
    END
