
if exists(select * from sys.columns 
            where  Object_ID = Object_ID(N'DS_IMPORT'))
begin

		IF not exists (select * from DS_IMPORT where  MS_IMPORT = 105)
		BEGIN
			INSERT INTO DS_IMPORT (MS_IMPORT, TEN_IMPORT, TEN_IMPORT_A, TEN_IMPORT_H, SU_DUNG, IMPORT, MS_IMPORT_CHA) VALUES 
			(105, N'00 - Dữ liệu khởi tạo', N'00 - Dữ liệu khởi tạo', N'00 - Dữ liệu khởi tạo', 1, 1, 105)

			UPDATE DS_IMPORT
			SET MS_IMPORT_CHA = 105
			WHERE MS_IMPORT IN (1, 2, 3, 4, 5)
		END
END   


