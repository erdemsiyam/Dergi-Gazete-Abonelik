---Trigger 6 ---- Dergi(DELETE) -->KONTROL(abone var mı) - YOKSA -> Dergi(delete) , Dergi_Sayi(delete)

CREATE TRIGGER TR_Dergi_Sil ON Dergi Instead OF DELETE --> Instead of sebebi : o dergiye abone varsa dergiyi silmeyecek.
AS

Declare @dergi_id int,@abone_sayi int
Select  @dergi_id=deleted.id from deleted

--derginin abonesi varsa silme
Select @abone_sayi=count(*) from Abonelik where (dergi_id = @dergi_id)
if(@abone_sayi>0)
	return -- rollback çalışmadı? return kullanıldı
	
--derginin sayılarını sil
Delete from Dergi_Sayisi where (dergi_id=@dergi_id)

--derginin kendisini sil.
Delete from Dergi where (id=@dergi_id)

GO