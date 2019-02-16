---Trigger 5 ---- Fatura(DELETE) -> Silinen_Fatura(insert)

Create TRIGGER TR_Fatura_Sil  ON Fatura Instead of DELETE
AS
	   
	declare @abonelik_id int,@ucret float,@siparis_tarih datetime,@fatura_id int
	
	Select @abonelik_id=deleted.abonelik_id from deleted
	Select @ucret=deleted.ucret from deleted
	Select @siparis_tarih=deleted.siparis_tarih from deleted
	Select @fatura_id=deleted.id from deleted
	
	INSERT INTO Silinen_Fatura values(@abonelik_id,@ucret,@siparis_tarih) -- Silinen_Fatura 'ya insert yaptık.
	
	DELETE FROM Fatura where (id=@fatura_id) -- ve şuan işlemini yaptığımız faturayı sildik.
	
GO