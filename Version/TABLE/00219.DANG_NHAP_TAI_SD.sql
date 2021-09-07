IF (SELECT COUNT(*) FROM dbo.DANG_NHAP WHERE MS_DANG_NHAP =10) = 0
BEGIN 
INSERT INTO	dbo.DANG_NHAP ( MS_DANG_NHAP, DANG_NHAP_VIET, DANG_NHAP_ANH,
                             DANG_NHAP_HOA )
VALUES  ( 10, -- MS_DANG_NHAP - int
          N'Nhập tái sử dụng', -- DANG_NHAP_VIET - nvarchar(255)
          N'Enter reuse', -- DANG_NHAP_ANH - nvarchar(255)
          N'Enter reuse'  -- DANG_NHAP_HOA - nvarchar(255)
          )
END	

