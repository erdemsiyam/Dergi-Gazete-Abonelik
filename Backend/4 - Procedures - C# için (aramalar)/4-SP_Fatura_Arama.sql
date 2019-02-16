
CREATE PROCEDURE SP_Fatura_Arama
@abonelik_id int
AS

	SELECT
		f.id,
		k.isim AS 'İsim',
		k.soyisim AS 'Soyisim',
		k.tel AS 'Telefon',
		d.ad AS 'Ürün',
		a.taahut_gun AS 'Taahüt Süresi(Gün)',
		a.baslangic_tarih AS 'Başlangıç Tarihi',
		DATEADD(day,a.taahut_gun,a.baslangic_tarih) as 'Bitiş Tarihi',
		f.ucret AS 'Ücreti'
	
	FROM  Fatura f inner join Abonelik a on a.id=f.abonelik_id inner join Kullanicilar k on a.kullanici_id=k.id inner join dergi d on a.dergi_id=d.id
	where a.id=@abonelik_id
	
GO