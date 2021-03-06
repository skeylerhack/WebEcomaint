IF NOT EXISTS ( SELECT  *
                FROM    sys.objects
                WHERE   type = 'P'
                        AND name = 'spGetcbNhomMayByItem' )
    EXEC('CREATE PROCEDURE spGetcbNhomMayByItem AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetcbNhomMayByItem]
    @MS_LOAI_MAY NVARCHAR(20) = '-1',
    @Username NVARCHAR(100) = 'admin' ,
    @NNgu INT = 0 ,
    @CoAll BIT = 1 
AS
    BEGIN
        IF @CoAll = 1
            SELECT  *
            FROM    ( SELECT    MS_NHOM_MAY,
                                CASE @NNgu
                                  WHEN 0 THEN TEN_NHOM_MAY
                                  WHEN 1
                                  THEN ISNULL(TEN_NHOM_MAY_ANH, TEN_NHOM_MAY)
                                  ELSE ISNULL(TEN_NHOM_MAY_HOA, TEN_NHOM_MAY)
                                END AS TEN_NHOM_MAY
                      FROM      dbo.NHOM_MAY
                      WHERE     MS_NHOM_MAY IN (
                                SELECT DISTINCT
                                        MS_NHOM_MAY
                                FROM    dbo.MAY
                                WHERE   MS_MAY IN ( SELECT DISTINCT
                                                            MS_MAY
                                                    FROM    dbo.ItemMay ) )
                                AND (MS_LOAI_MAY = @MS_LOAI_MAY
                                OR @MS_LOAI_MAY = '-1')
                      UNION
                      SELECT    '-1', '<ALL>'
                    ) A
            ORDER BY A.TEN_NHOM_MAY
        ELSE
            SELECT  MS_NHOM_MAY,
                    CASE @NNgu
                      WHEN 0 THEN TEN_NHOM_MAY
                      WHEN 1 THEN ISNULL(TEN_NHOM_MAY_ANH, TEN_NHOM_MAY)
                      ELSE ISNULL(TEN_NHOM_MAY_HOA, TEN_NHOM_MAY)
                    END AS TEN_NHOM_MAY
            FROM    dbo.NHOM_MAY
            WHERE   MS_NHOM_MAY IN ( SELECT DISTINCT
                                            MS_NHOM_MAY
                                     FROM   dbo.MAY
                                     WHERE  MS_MAY IN ( SELECT DISTINCT
                                                              MS_MAY
                                                        FROM  dbo.ItemMay ) )
                    AND (MS_LOAI_MAY = @MS_LOAI_MAY
                    OR @MS_LOAI_MAY = '-1')
            ORDER BY TEN_NHOM_MAY
    END	


