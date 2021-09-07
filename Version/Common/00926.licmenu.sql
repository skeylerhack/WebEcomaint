if not exists (select * from LIC_MENU where MENU_ID = N'ΞΠήͤΔΆΠͬΖΊΔ͠͠͠͞')
begin
	insert into lic_menu (TYPE_LIC, MENU_ID) select N'̦', N'ΞΠήͤΔΆΠͬΖΊΔ͠͠͠͞'
end


