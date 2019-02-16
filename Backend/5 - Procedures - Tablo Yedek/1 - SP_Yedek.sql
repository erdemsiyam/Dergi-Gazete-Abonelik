CREATE PROCEDURE SP_Yedek 
@tablo nvarchar(30)
AS

if(@tablo='dergi_sayisi')
BEGIN
	Delete From Dergi_Sayisi_Yedek -- eski yedek silinir.
	INSERT INTO Dergi_Sayisi_Yedek Select * FROM Dergi_Sayisi; -- dergi_sayi'daki tüm veriler dergi_sayi_yedek tablosuna kopyalanır.
END

if(@tablo='yetki')
BEGIN
	Delete From Yetki_Yedek -- eski yedek silinir.
	INSERT INTO Yetki_Yedek Select * FROM Yetki; -- dergi_sayi'daki tüm veriler dergi_sayi_yedek tablosuna kopyalanır.
END