
CREATE PROCEDURE SP_Fatura_Iade_Arama
@abonelik_id int
AS
Select 

k.isim AS 'İsim',
k.soyisim AS 'Soyisim',
k.tel AS 'Telefon',
d.ad AS 'Ürün',
a.taahut_gun AS 'Taahüt Süresi(Gün)',
a.baslangic_tarih AS 'Başlangıç Tarihi', 
DATEADD(day, a.taahut_gun, a.baslangic_tarih) as 'Asıl Bitiş Tarihi',
a.iptal_tarih AS 'İptal Tarihi',
f.geri_ucret AS 'Geri Ödeme Ücreti' 
	


From Iptal_Abonelik a inner join Fatura_Iade f on a.id=f.iptal_abonelik_id inner join Kullanicilar k on a.kullanici_id=k.id inner join Dergi d on a.dergi_id=d.id

where a.abonelik_id=@abonelik_id

GO