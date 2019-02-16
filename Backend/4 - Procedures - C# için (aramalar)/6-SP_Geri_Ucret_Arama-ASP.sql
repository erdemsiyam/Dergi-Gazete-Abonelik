CREATE PROCEDURE SP_Geri_Ucret_Arama
@kullanici_id int,
@dergi_id int
as
	declare @abone_kaldigi_gun float

	Select @abone_kaldigi_gun=DATEDIFF(day,baslangic_tarih,GETDATE()) from Abonelik where kullanici_id=@kullanici_id and dergi_id=@dergi_id

	declare @dergi_periyot_gunu float,@dergi_fiyat float

	Select @dergi_periyot_gunu = periyot_gun,@dergi_fiyat=fiyat from Dergi where id=@dergi_id

	declare @ucret float

	Set @ucret = (@abone_kaldigi_gun / @dergi_periyot_gunu)* @dergi_fiyat


	Declare @fatura_ucret float,@fatura_id int,@geri_ucret float

	Select @fatura_ucret = ucret from Fatura where abonelik_id=(Select id from Abonelik where (kullanici_id=@kullanici_id and dergi_id=@dergi_id))

	Set @geri_ucret =  @fatura_ucret-@ucret
	if(@geri_ucret<0)
		Set @geri_ucret=0

	Select @geri_ucret
go