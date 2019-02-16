CREATE PROCEDURE SP_Yetki_Yedek_Geri AS

Delete From Yetki -- yedek ger almadan önce Dergi_Sayisi verileri silinir.



-- tablo yedekten dön için , yedekteki her satır kontrol edilerek asıl tabloya eklenecektir, her satırın kontrolü için ise cursor yapısı kullanılır.

declare @sayac nvarchar(20)
declare cursor1 cursor for SELECT ad from Yetki_Yedek -- @sayac , dergi_id ' yi tutacak. , @sayac2 de dergi_sayi'yı

	OPEN cursor1

		FETCH NEXT FROM cursor1 INTO @sayac
			WHILE @@FETCH_STATUS = 0
				BEGIN
				
						--Yetkili halen var mı kontrol.- yoksa BEGIN içine girme ki sahipsiz bu yetki satırını ekleme.
						if EXISTS( Select ad from Yetkililer where (ad=@sayac)) -- eğer böyle bir dergi varsa
						BEGIN
							Insert Into Yetki Select * from Yetki_Yedek where(ad=@sayac)
						END
					
					FETCH NEXT FROM cursor1 INTO @sayac-- sayac artırıcı (sıradaki dergi_id'yi alır. ve dergi_sayiyi)
				END
	CLOSE cursor1

DEALLOCATE cursor1