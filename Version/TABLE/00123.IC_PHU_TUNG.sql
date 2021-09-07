if not exists(select * from sys.columns 
            where Name = N'VAT_TU_PT' and Object_ID = Object_ID(N'IC_PHU_TUNG'))
begin
    ALTER TABLE IC_PHU_TUNG ADD VAT_TU_PT BIT DEFAULT(0)
END    

GO


UPDATE IC_PHU_TUNG SET VAT_TU_PT = 0 
FROM IC_PHU_TUNG T1 INNER JOIN LOAI_VT T2 ON T1.MS_LOAI_VT = T2.MS_LOAI_VT
WHERE VAT_TU = 0

UPDATE IC_PHU_TUNG SET VAT_TU_PT = 1
FROM IC_PHU_TUNG T1 INNER JOIN LOAI_VT T2 ON T1.MS_LOAI_VT = T2.MS_LOAI_VT
WHERE VAT_TU = 1
