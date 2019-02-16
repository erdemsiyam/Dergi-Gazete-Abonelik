
CREATE PROCEDURE SP_Yetkili_Guncelle
@ad nvarchar(20),
@dergi_ekle bit ,
@dergi_guncelle bit,
@dergi_sil bit ,
@dergi_sayi_ekle bit,
@dergi_sayi_guncelle bit,
@kullanici_ekle bit ,
@kullanici_guncelle bit ,
@kullanici_abonelik_ekle bit,
@kullanici_abonelik_sil bit ,
@otomasyon_kullanici_ekle bit,
@otomasyon_kullanici_guncelle bit,
@tablo_yedek bit
AS

	IF( NOT EXISTS(Select * from Yetkililer where (ad=@ad) ))
		return
		

	UPDATE Yetki SET dergi_ekle=@dergi_ekle,dergi_guncelle=@dergi_guncelle,dergi_sil=@dergi_sil,dergi_sayi_ekle=@dergi_sayi_ekle,dergi_sayi_guncelle=@dergi_sayi_guncelle,kullanici_ekle=@kullanici_ekle,kullanici_guncelle=@kullanici_guncelle,kullanici_abonelik_ekle=@kullanici_abonelik_ekle,kullanici_abonelik_sil=@kullanici_abonelik_sil,otomasyon_kullanici_ekle=@otomasyon_kullanici_ekle,otomasyon_kullanici_guncelle=@otomasyon_kullanici_guncelle,tablo_yedek=@tablo_yedek WHERE (ad=@ad)
	

GO