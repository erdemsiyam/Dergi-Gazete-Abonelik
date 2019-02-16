---Trigger 2 ---- Abonelik(Delete) --> Iptal_Abonelik(insert) YADA Silinen_Abonelik(insert)


CREATE TRIGGER TR_Abonelik_Sil ON Abonelik INSTEAD OF DELETE --> Instead Of : abonelik Zaten bitmişse Silinenlere At , Bitmemişse Abonelik İptal İşlemleri Yap
AS
	DECLARE @kullanici_id int,@dergi_id int,@abonelik_id int
	Select @kullanici_id=deleted.kullanici_id from deleted
	Select @dergi_id=deleted.dergi_id from deleted
	SELECT @abonelik_id=deleted.id from Deleted 
	
	--Aboneliğin bitip bitmediği kontrol ediliyor.
	--Bitmişse -> Silinen Aboneliğe gidecek.
	--Bitmemişse -> İptal Aboneliğe gidecek.
	
	Declare @bas_tarih date,@taahut_gun int,@son_tarih date
	Select @taahut_gun=taahut_gun from Abonelik where (id=@abonelik_id)
	SELECT @bas_tarih=baslangic_tarih from Abonelik where (id=@abonelik_id)
	Set @son_tarih = DATEADD(day,@taahut_gun + 1 ,@bas_tarih)
	
	if(@abonelik_id is not null AND @kullanici_id is not null AND @dergi_id is not null)-- SİLİNMEYE ÇALIŞILAN BİR ŞEY YOKSA , VE BU TRIGGER A GİRİLMİŞSE BUNU ENGELLEYECEK OLAN IF' YAZILIR
	BEGIN
		if(@son_tarih > GETDATE())
		BEGIN -- abonelik iptal ediliyor demektir.
		
				Insert Into Iptal_Abonelik values(@abonelik_id,@kullanici_id,@dergi_id,@bas_tarih,@taahut_gun,GETDATE(),@son_tarih) -- 3_TR : insert(for) Iptal_Abonelik -> INSERT Fatura Iade , Delete Fatura
				
				Delete From Abonelik where (id=@abonelik_id) -- abonelik silinir...
			
		END
		ELSE -- abonelik zaten bitmiş, silinenlere gönder demektir.
		BEGIN
		
			
				INSERT INTO Silinen_Abonelik values(@abonelik_id,@kullanici_id,@dergi_id,@bas_tarih,@son_tarih,@taahut_gun) -- 4_TR  : insert(for) Silinen_Abonelik -> Delete Fatura 
			
				Delete From Abonelik where (id=@abonelik_id) -- abonelik silinir...
			
		END
	END	
	
GO
	
	
	