
Create Procedure SP_Dergi_Sayi_Arama
@dergi_id nvarchar(40)
AS
Select * from Dergi_Sayisi where dergi_id = @dergi_id
GO
