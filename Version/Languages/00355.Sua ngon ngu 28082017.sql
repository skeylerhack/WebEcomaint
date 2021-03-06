

update DS_REPORT set TEN_REPORT_VIET = N'Báo cáo số lượng hàng tồn kho tối thiểu (Chỉ cty lớn dùng)' where REPORT_NAME = 'ucSafetyStock'
update DS_REPORT set TEN_REPORT_ANH = N'Min stock report' where REPORT_NAME = 'ucSafetyStock'
update DS_REPORT set Note = N'Tính toán số lượng tồn kho tối thiểu cho các vật tư, phụ tùng (phù hợp cho những VTPT thường xuyên sử dụng và cho nhu cầu sửa chữa hư hỏng). Dữ liệu tồn kho tối thiểu tính toán được so sánh với số lượng tồn kho tối thiểu đang được sử dụng trong hệ thống. Là công cụ giúp giảm chi phí tồn kho và giảm thời gian dừng máy do thiếu VTPT' where REPORT_NAME = 'ucSafetyStock'

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucSafetyStock' AND KEYWORD =N'TieuDe') UPDATE LANGUAGES SET VIETNAM=N'TỒN KHO TỐI THIỂU ', ENGLISH=N'MIN STOCK', VIETNAM_OR=N'TỒN KHO TỐI THIỂU ', ENGLISH_OR=N'MIN STOCK' WHERE FORM=N'ucSafetyStock' AND KEYWORD=N'TieuDe' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'ucSafetyStock',N'TieuDe',N'TỒN KHO TỐI THIỂU ',N'MIN STOCK',N'TỒN KHO TỐI THIỂU ',N'MIN STOCK')
