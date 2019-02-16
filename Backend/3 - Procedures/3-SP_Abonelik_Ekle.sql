
create procedure SP_Abonelik_Ekle
@kullanici_id int,
@dergi_ad nvarchar(30),
@baslangic_tarih date,
@taahut_gun int
AS

--kullan�c� varm�
declare @kullanici int
Select @kullanici=id from Kullanicilar where (id=@kullanici_id)
if(@kullanici is null)
	return;
	
--dergi varm�
declare @dergi_id int
Select @dergi_id=id from Dergi where (ad=@dergi_ad)
if(@dergi_id is null)
	return;


-- zaten b�yle bir abonelik varsa  VE H�L�  TAAHUT ZAMANI ��ER�S�NDE �SE
	IF EXISTS(select * from Abonelik where kullanici_id=@kullanici_id and dergi_id=@dergi_id and taahut_gun>=DATEDIFF(day,baslangic_tarih,GETDATE()))
		BEGIN
			return --abonelik ba�vurusunu iptal et.
		END
	ELSE -- e�er TAAHUT ZAMANI ��ER�S�NDE B�YLE B�R ABONEL�K YOKSA , TAAHUT ZAMANI ��ER�S�NDE OLMAYAN O ABONEL��� S�L ve i�lemlere devam et
		BEGIN
		DELETE FROM Abonelik where kullanici_id=@kullanici_id and dergi_id=@dergi_id
		END




--girilen baslangic tarihi nul ise getdate yap.
if(@baslangic_tarih is null)
	Set @baslangic_tarih = GETDATE()

declare @dergi_baslangic_tarih date,@periyot_gun int
Select @dergi_baslangic_tarih=baslangic_tarih, @periyot_gun=periyot_gun from Dergi where (id=@dergi_id)
--ba�lang�� tarih dergi ba�lang�� tarihinden �nce olamaz
if(@baslangic_tarih<@dergi_baslangic_tarih)
	return;

--taah�t g�n� derginin periyot g�n�nden az olamaz.
if(@taahut_gun<@periyot_gun)
	return;

-- t�m Kontroller bitti, abonelik eklenebilir.
INSERT INTO Abonelik values(@kullanici_id,@dergi_id,@baslangic_tarih,@taahut_gun)

GO