
--UPDATE dbo.GIA_TRI_TS_GSTT SET TEN_GIA_TRI = N'Tốt (A)' WHERE TEN_GIA_TRI = N'Đạt'
--UPDATE dbo.GIA_TRI_TS_GSTT SET TEN_GIA_TRI = N'Trung Bình(B)' WHERE TEN_GIA_TRI = N'Không đạt'

--INSERT INTO dbo.GIA_TRI_TS_GSTT
--        ( MS_TS_GSTT ,
--          TEN_GIA_TRI ,
--          DAT ,
--          GHI_CHU
--        )
--SELECT MS_TS_GSTT,N'Kém(C)',dat,GHI_CHU FROM dbo.GIA_TRI_TS_GSTT WHERE TEN_GIA_TRI = N'Trung Bình(B)'

--INSERT INTO dbo.GIA_TRI_TS_GSTT
--        ( MS_TS_GSTT ,
--          TEN_GIA_TRI ,
--          DAT ,
--          GHI_CHU
--        )
--SELECT MS_TS_GSTT,N'DHỏng(D)',dat,GHI_CHU FROM dbo.GIA_TRI_TS_GSTT WHERE TEN_GIA_TRI = N'Trung Bình(B)'




