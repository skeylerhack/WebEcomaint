﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmTinhHinhTonKho' AND KEYWORD =N'msgDuLieuLon3000') UPDATE LANGUAGES SET VIETNAM=N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)', ENGLISH=N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)',CHINESE=N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)', VIETNAM_OR=N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)', ENGLISH_OR=N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)' , CHINESE_OR=N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)' WHERE FORM=N'frmTinhHinhTonKho' AND KEYWORD=N'msgDuLieuLon3000' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmTinhHinhTonKho',N'msgDuLieuLon3000',N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)',N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)',N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)',N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)',N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)',N'Dữ liệu chọn in lớn hơn 3000 dòng. In rất lâu bạn muốn tiếp tục (Y/N) (Có thể hơn 20ph)','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmTinhHinhTonKho' AND KEYWORD =N'msgDuLieuLon5000') UPDATE LANGUAGES SET VIETNAM=N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.', ENGLISH=N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.',CHINESE=N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.', VIETNAM_OR=N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.', ENGLISH_OR=N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.' , CHINESE_OR=N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.' WHERE FORM=N'frmTinhHinhTonKho' AND KEYWORD=N'msgDuLieuLon5000' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmTinhHinhTonKho',N'msgDuLieuLon5000',N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.',N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.',N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.',N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.',N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.',N'Dữ liệu chọn in lớn hơn 5000 dòng. Không thể in. Vui lòng chọn kho hay loại vật tư.','ECOMAIN')