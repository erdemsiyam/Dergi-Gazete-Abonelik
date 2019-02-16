CREATE PROCEDURE SP_Dergi_Sayisi_Yedek_Geri AS

Delete From Dergi_Sayisi -- yedek ger almadan önce Dergi_Sayisi verileri silinir.



-- tablo yedekten dön için , yedekteki her satır kontrol edilerek asıl tabloya eklenecektir, her satırın kontrolü için ise cursor yapısı kullanılır.

declare @sayac int,@sayac2 int
declare cursor1 cursor for SELECT dergi_id,dergi_sayi from Dergi_Sayisi_Yedek -- @sayac , dergi_id ' yi tutacak. , @sayac2 de dergi_sayi'yı

	OPEN cursor1

		FETCH NEXT FROM cursor1 INTO @sayac,@sayac2
			WHILE @@FETCH_STATUS = 0
				BEGIN
				
						--dergi halen var mı kontrol.- yoksa BEGIN içine girme ki sahipsiz bu sayıyı ekleme.
						if EXISTS( Select id from dergi where (id=@sayac)) -- eğer böyle bir dergi varsa
						BEGIN
							Insert Into Dergi_Sayisi Select * from Dergi_Sayisi_Yedek where(dergi_id=@sayac and dergi_sayi=@sayac2)
						END
					
					FETCH NEXT FROM cursor1 INTO @sayac,@sayac2-- sayac artırıcı (sıradaki dergi_id'yi alır. ve dergi_sayiyi)
				END
	CLOSE cursor1

DEALLOCATE cursor1