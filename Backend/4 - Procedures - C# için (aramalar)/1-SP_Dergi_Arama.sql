
Create Procedure SP_Dergi_Arama
@arama nvarchar(40)
AS
Select id,ad,fiyat,periyot_gun,baslangic_tarih,max_taahut from dergi where ad like '%'+@arama+'%'
GO
