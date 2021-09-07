IF NOT EXISTS ( SELECT  *
                FROM    sys.objects
                WHERE   type = 'P'
                        AND name = 'spGetcbLoaiMayByItem' )
    EXEC('CREATE PROCEDURE spGetcbLoaiMayByItem AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetcbLoaiMayByItem]
    @Username NVARCHAR(100) = 'admin' ,
    @NNgu INT = 0 ,
    @CoAll BIT = 1
AS
    BEGIN
        IF @CoAll = 1
            SELECT * FROM (SELECT  A.MS_LOAI_MAY,CASE @NNgu
                      WHEN 0 THEN B.TEN_LOAI_MAY
                      WHEN 1 THEN ISNULL(B.TEN_LOAI_MAY_ANH, B.TEN_LOAI_MAY)
                      ELSE ISNULL(B.TEN_LOAI_MAY_HOA, B.TEN_LOAI_MAY)
                    END AS TEN_LOAI_MAY
            FROM    ( SELECT    MS_LOAI_MAY
                      FROM      dbo.NHOM_MAY
                      WHERE     MS_NHOM_MAY IN (
                                SELECT DISTINCT
                                        MS_NHOM_MAY
                                FROM    dbo.MAY
                                WHERE   MS_MAY IN ( SELECT DISTINCT
                                                            MS_MAY
                                                    FROM    dbo.ItemMay ) )
                              ) AS A
								INNER JOIN dbo.LOAI_MAY B ON B.MS_LOAI_MAY = A.MS_LOAI_MAY
                      UNION
                      SELECT    '-1', '<ALL>')C
					  ORDER BY C.TEN_LOAI_MAY
                    
        ELSE
           SELECT  A.MS_LOAI_MAY,CASE @NNgu
                      WHEN 0 THEN B.TEN_LOAI_MAY
                      WHEN 1 THEN ISNULL(B.TEN_LOAI_MAY_ANH, B.TEN_LOAI_MAY)
                      ELSE ISNULL(B.TEN_LOAI_MAY_HOA, B.TEN_LOAI_MAY)
                    END AS TEN_LOAI_MAY
            FROM    ( SELECT    MS_LOAI_MAY
                      FROM      dbo.NHOM_MAY
                      WHERE     MS_NHOM_MAY IN (
                                SELECT DISTINCT
                                        MS_NHOM_MAY
                                FROM    dbo.MAY
                                WHERE   MS_MAY IN ( SELECT DISTINCT
                                                            MS_MAY
                                                    FROM    dbo.ItemMay ) )
                              ) AS A
								INNER JOIN dbo.LOAI_MAY B ON B.MS_LOAI_MAY = A.MS_LOAI_MAY
								ORDER BY TEN_LOAI_MAY
    END	


