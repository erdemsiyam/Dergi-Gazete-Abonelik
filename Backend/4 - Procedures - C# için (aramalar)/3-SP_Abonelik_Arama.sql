
Create Procedure SP_Abonelik_Ara
@kullanici_id int
As

Select 
	a.id,k.kullanici_ad,d.ad,a.baslangic_tarih,a.taahut_gun,f.ucret

from  Abonelik a inner join Kullanicilar k on a.kullanici_id=k.id inner join Dergi d on a.dergi_id=d.id  inner join Fatura f on f.abonelik_id=a.id
where kullanici_id =@kullanici_id