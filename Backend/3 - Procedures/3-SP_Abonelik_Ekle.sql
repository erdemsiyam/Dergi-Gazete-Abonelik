
create procedure SP_Abonelik_Ekle
@kullanici_id int,
@dergi_ad nvarchar(30),
@baslangic_tarih date,
@taahut_gun int
AS

--kullanýcý varmý
declare @kullanici int
Select @kullanici=id from Kullanicilar where (id=@kullanici_id)
if(@kullanici is null)
	return;
	
--dergi varmý
declare @dergi_id int
Select @dergi_id=id from Dergi where (ad=@dergi_ad)
if(@dergi_id is null)
	return;


-- zaten böyle bir abonelik varsa  VE HÂLÂ  TAAHUT ZAMANI ÝÇERÝSÝNDE ÝSE
	IF EXISTS(select * from Abonelik where kullanici_id=@kullanici_id and dergi_id=@dergi_id and taahut_gun>=DATEDIFF(day,baslangic_tarih,GETDATE()))
		BEGIN
			return --abonelik baþvurusunu iptal et.
		END
	ELSE -- eðer TAAHUT ZAMANI ÝÇERÝSÝNDE BÖYLE BÝR ABONELÝK YOKSA , TAAHUT ZAMANI ÝÇERÝSÝNDE OLMAYAN O ABONELÝÐÝ SÝL ve iþlemlere devam et
		BEGIN
		DELETE FROM Abonelik where kullanici_id=@kullanici_id and dergi_id=@dergi_id
		END




--girilen baslangic tarihi nul ise getdate yap.
if(@baslangic_tarih is null)
	Set @baslangic_tarih = GETDATE()

declare @dergi_baslangic_tarih date,@periyot_gun int
Select @dergi_baslangic_tarih=baslangic_tarih, @periyot_gun=periyot_gun from Dergi where (id=@dergi_id)
--baþlangýç tarih dergi baþlangýç tarihinden önce olamaz
if(@baslangic_tarih<@dergi_baslangic_tarih)
	return;

--taahüt günü derginin periyot gününden az olamaz.
if(@taahut_gun<@periyot_gun)
	return;

-- tüm Kontroller bitti, abonelik eklenebilir.
INSERT INTO Abonelik values(@kullanici_id,@dergi_id,@baslangic_tarih,@taahut_gun)

GO