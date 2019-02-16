
---Trigger 3 ---- Iptal_Abonelik(INSERT) - > Fatura_Iade(insert) ve Fatura(Delete)

CREATE TRIGGER TR_Iptal_Abonelik_Ekle ON Iptal_Abonelik AFTER INSERT
AS
	DECLARE @kullanici_id int,@dergi_id int,@taahut_gun int,@bas_tarih date,@asil_bitis_tarih date,@abonelik_id int,@iptal_abonelik_id int
	Select @kullanici_id=inserted.kullanici_id from inserted
	Select @dergi_id=inserted.dergi_id from inserted
	Select @taahut_gun=inserted.taahut_gun from inserted
	Select @bas_tarih=inserted.baslangic_tarih from inserted
	Select @asil_bitis_tarih=inserted.asil_bitis_tarihi from inserted
	Select @abonelik_id = inserted.abonelik_id from inserted
	Select @iptal_abonelik_id=inserted.id from inserted 
	
	
	-- Geri Ödenecek Fiyat Hesaplanır.
	Declare @dergi_periyot_gunu float,@dergi_fiyat float
	Select @dergi_periyot_gunu = periyot_gun,@dergi_fiyat=fiyat from dergi where (id=@dergi_id)
	
	-- Hesaplanış mantığı : bugüne kadar aldığı dergiler indirimsizmiş gibi hesaplanır
	Declare @ucret float,@geri_ucret float,@abone_kaldigi_gun float
	
	Set @abone_kaldigi_gun = DATEDIFF(day,@bas_tarih,GETDATE())
	
	Set @ucret = (@abone_kaldigi_gun / @dergi_periyot_gunu)* @dergi_fiyat --dergiyi normal almış olsaydı bu kadar para harcardı.
	 
	--dergi için ödediği indirimli miktarı bulalım.
	Declare @fatura_ucret float,@fatura_id int
	Select @fatura_ucret = ucret,@fatura_id=id from Fatura where (abonelik_id=@abonelik_id)
	
	-- faturaya gerek kalmadı , Fatura silinir.
	Delete from Fatura where (id=@fatura_id) -- 5_TR delete(instead) Fatura - >  INSERT silinen_fatura 
	
	Set @geri_ucret = @fatura_ucret-@ucret -- geri iade parası = taahüt toplam ücreti - dergiyi bu zamana kadar indirimsiz aldığı para toplamı (GÜN BAŞINA fiyat belirlenir.dergi periyot gününe göre değil.)
	
	-- olduda aboneliğinin bitmesine 1 gün kala abonelik iptal ederse, geri ödeme eksiye düşer, 
	-- bu da ondan para alacağımız anlamına gelir, bu mantıksız durum karşılığında , marka vizyonunu da düşünerek bu ücreti sıfır yaparız. [Müşteri Memnuniyeti Amaçlı.]

	if(@geri_ucret < 0) 
	BEGIN
		Set @geri_ucret = 0
	END
	
	Insert INTO Fatura_Iade values(@iptal_abonelik_id,@geri_ucret) -- iade edilen para ,fatura_iade ye eklenir.
	
GO