﻿IF((SELECT COUNT(*) FROM dbo.DANG_XUAT WHERE DANG_XUAT_VIET = N'Xuất thanh lý') = 0)
BEGIN
INSERT INTO dbo.DANG_XUAT ( DANG_XUAT_VIET, DANG_XUAT_ANH, DANG_XUAT_HOA )
VALUES  ( N'Xuất thanh lý', -- DANG_XUAT_VIET - nvarchar(100)
          N'Xuất thanh lý', -- DANG_XUAT_ANH - char(100)
          N'Xuất thanh lý'  -- DANG_XUAT_HOA - char(100)
          )
END

SELECT MS_DANG_NHAP, DANG_NHAP_VIET, DANG_NHAP_ANH, DANG_NHAP_HOA FROM dbo.DANG_NHAP