use dergi
---------------------------------------------DEFAULT EKLEMELER
---Örnek Kullanıcı Ekleme -- İsteğe Bağlı
insert into kullanicilar values('fatih','sifre','fatih','yılmaz','adres','fatihyilmaz@hotmail.com','(555) 111-2233','12345678912') -- kullanıcıad,sifre,ismi,soyismi,adresi,mail,telefon,tc

-- YETKİLİ EKLEME - admin kullanıcısı mecburi.(c# kısmında admin kullanıcı isimliler için yetki güncelleme yaparken engel yapılmakta.) 
exec SP_Yetkili_Ekle 'admin','sifre' -- kullaniciad,sifre, 
exec SP_Yetkili_Ekle 'ali','sifre'
-- Yetkili Guncelle
exec SP_Yetkili_Guncelle 'admin',1,1,1,1,1,1,1,1,1,1,1,1 -- Yetkilere , Yetki Tablosundan bakabilirsiniz.
exec SP_Yetkili_Guncelle 'ali',1,0,1,1,0,1,1,1,0,1,0,1
-- DERGİ EKLEME - Örnektir
exec SP_Dergi_Ekle 'leman',10,10,NULL,180,'ilk sayı link'  -- dergi ismi, fiyatı, kaç günde bir çıkacağı periyotu, Derginin Nezaman Başladığı(periyot gününden fazla , geçmiş tarihte açılamaz), derginin ilk sayısının içerik linki.
exec SP_Dergi_Ekle 'Penguen',10,10,NULL,90,'ilk sayı link' 

-- MEVCUT DERGİYE 'SAYI' EKLEME : mevcut dergiye periyot günü kadar zaman ekleyerek yeni sayı oluşturulur, sadece linki girmeniz yeterli.
exec SP_Dergi_Sayi_Ekle 1,'2.sayi link'  -- dergi_id,derginin o sayısının içerik linki.


------------DİĞER ÖRNEKLER

-- MEVCUT KULLANICIYA ABONELİK EKLEME
	-- exec SP_Abonelik_Ekle 1,'Leman',NULL,180 -- kullanıcı id , dergi ismi, başlangıç tarihi(Null = Bugün),kullanıcıların yapabileceği maximum taahut

-- Mevcut Aboneliği Silme 
	-- delete from Abonelik where (id=DEGER YAZ) -- tr2 ->tr3/tr4->tr5 , id= (kullanıcı_id ve dergi_id ile kişinin abonelik_id'si bulunur.Buraya yazılıp silinir.)

-- Mevcut Dergiyi Silme
	-- delete from Dergi where (id=DEGER YAZ) -- tr6 , id = (derginin'id si bulunup. Buraya Yazılır.)
	
	
	
