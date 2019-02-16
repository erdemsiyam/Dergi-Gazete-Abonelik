---Trigger 1 ----  Abonelik(insert) -> Fatura(insert)  || (instead of : b�yle bir abonelik var m� kontrol)

CREATE TRIGGER TR_Abonelik_Ekle ON Abonelik INSTEAD OF INSERT
AS
	DECLARE @kullanici_id int,@dergi_id int,@taahut_gun float -- �nce bu dersin id'sini elimize alal�m.
	
	SELECT @kullanici_id = inserted.kullanici_id,@dergi_id=inserted.dergi_id,@taahut_gun=inserted.taahut_gun FROM inserted 

	Declare @max_taahut int
	Select @max_taahut=max_taahut from Dergi where (id=@dergi_id)
	if(@taahut_gun>@max_taahut)
		return 
		
	declare @abonelik_id int
	Select @abonelik_id = id from Abonelik where (kullanici_id=@kullanici_id and dergi_id=@dergi_id)

	if(@abonelik_id is not null)
		return
		
		--ABONEL�K EKLEN�R.
		
		INSERT INTO Abonelik VALUES(@kullanici_id,@dergi_id,GETDATE(),@taahut_gun)

		Select @abonelik_id= id from Abonelik where (kullanici_id=@kullanici_id and dergi_id=@dergi_id) --biraz �nce eklenen aboneli�in id'sini ald�k


		Declare @ucret float,@ay float,@dergi_fiyat int,@dergi_periyot int-- �cret Hesaplamas� i�in
		--Aboneliklere Uygulanan Kampanya :  abone oldu�un ay kadar %(2,5 x Ay) l�k indirim al. �rne�in , 12 ay taah�t = %30 ay indirim.

		Select @dergi_fiyat = fiyat,@dergi_periyot=periyot_gun from Dergi where (id=@dergi_id) -- dergimizin fiyat�n� ve dergi ��kma periyot g�n say�s�n� ald�k, toplam �cret tahsilat� i�in.

		Set @ay = (@taahut_gun / 30)

		--en fazla 24 ay taah�t diyip %24 indirimle s�n�rlamak mant�kl�, yoksa 100 ay abone olur %100 indirim mant�ks�z olur.
		if(@ay>24) -- ay'�n 24 ten fazla olup olmad���na bakar�z
		begin
			Set @ucret = (( @ay * @dergi_fiyat * (30 / @dergi_periyot))*(0.01))*(100-(24*(2.5)))--24 ten fazla ise 24 olarak i�lem yap.
		end
		else
		begin
			Set @ucret = (( @ay * @dergi_fiyat * (30 / @dergi_periyot))*(0.01))*(100-(@ay*(2.5)))--24 'e e�it veya az ise , okadarl�k i�lem yap.
		end


		INSERT INTO Fatura Values(@abonelik_id,@ucret,GETDATE()) -- fatura eklenir.


GO