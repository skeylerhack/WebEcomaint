
-- EXEC S_Duong '-1','-1'
ALTER proc [dbo].[S_Duong]
(
	@Tinh nvarchar(100),
	@District nvarchar(100)
)
as
 if @District ='-1'
	begin
		select MS_Duong,ten_V as Duong_TV from View_Duong_Not_District
		where ms_tinh = @Tinh
		union select '-1',' < ALL > '
		ORDER BY Duong_TV
	end
else
	begin
		select MS_Duong,Duong_TV from Y_Duong where ms_Quan = @District
		union select '-1',' < ALL > '
		ORDER BY Duong_TV
	end
