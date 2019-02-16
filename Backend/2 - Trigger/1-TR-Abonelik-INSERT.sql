---Trigger 1 ----  Abonelik(insert) -> Fatura(insert)  || (instead of : böyle bir abonelik var mý kontrol)

CREATE TRIGGER TR_Abonelik_Ekle ON Abonelik INSTEAD OF INSERT
AS
	DECLARE @kullanici_id int,@dergi_id int,@taahut_gun float -- Önce bu dersin id'sini elimize alalým.
	
	SELECT @kullanici_id = inserted.kullanici_id,@dergi_id=inserted.dergi_id,@taahut_gun=inserted.taahut_gun FROM inserted 

	Declare @max_taahut int
	Select @max_taahut=max_taahut from Dergi where (id=@dergi_id)
	if(@taahut_gun>@max_taahut)
		return 
		
	declare @abonelik_id int
	Select @abonelik_id = id from Abonelik where (kullanici_id=@kullanici_id and dergi_id=@dergi_id)

	if(@abonelik_id is not null)
		return
		
		--ABONELÝK EKLENÝR.
		
		INSERT INTO Abonelik VALUES(@kullanici_id,@dergi_id,GETDATE(),@taahut_gun)

		Select @abonelik_id= id from Abonelik where (kullanici_id=@kullanici_id and dergi_id=@dergi_id) --biraz önce eklenen aboneliðin id'sini aldýk


		Declare @ucret float,@ay float,@dergi_fiyat int,@dergi_periyot int-- Ücret Hesaplamasý için
		--Aboneliklere Uygulanan Kampanya :  abone olduðun ay kadar %(2,5 x Ay) lýk indirim al. Örneðin , 12 ay taahüt = %30 ay indirim.

		Select @dergi_fiyat = fiyat,@dergi_periyot=periyot_gun from Dergi where (id=@dergi_id) -- dergimizin fiyatýný ve dergi çýkma periyot gün sayýsýný aldýk, toplam ücret tahsilatý için.

		Set @ay = (@taahut_gun / 30)

		--en fazla 24 ay taahüt diyip %24 indirimle sýnýrlamak mantýklý, yoksa 100 ay abone olur %100 indirim mantýksýz olur.
		if(@ay>24) -- ay'ýn 24 ten fazla olup olmadýðýna bakarýz
		begin
			Set @ucret = (( @ay * @dergi_fiyat * (30 / @dergi_periyot))*(0.01))*(100-(24*(2.5)))--24 ten fazla ise 24 olarak iþlem yap.
		end
		else
		begin
			Set @ucret = (( @ay * @dergi_fiyat * (30 / @dergi_periyot))*(0.01))*(100-(@ay*(2.5)))--24 'e eþit veya az ise , okadarlýk iþlem yap.
		end


		INSERT INTO Fatura Values(@abonelik_id,@ucret,GETDATE()) -- fatura eklenir.


GO