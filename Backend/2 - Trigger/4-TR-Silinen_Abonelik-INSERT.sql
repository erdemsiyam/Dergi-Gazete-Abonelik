---Trigger 4 ---- Silinen_Abonelik(INSERT) -> Fatura(delete)

CREATE TRIGGER TR_Silinen_Abonelik_Ekle ON Silinen_Abonelik AFTER INSERT
AS
	Declare @abonelik_id int
	
	Select @abonelik_id=inserted.abonelik_id from inserted
	
	Delete from Fatura where (abonelik_id=@abonelik_id) -- 5_TR delete(instead) Fatura - >  INSERT silinen_fatura 
GO