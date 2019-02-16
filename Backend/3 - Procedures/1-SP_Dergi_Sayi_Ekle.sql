
CREATE PROCEDURE SP_Dergi_Sayi_Ekle
@dergi_id int,
@dergi_sayi_link nvarchar(50)
AS

declare @dergi int
Select @dergi=id from Dergi where (id=@dergi_id)
if(@dergi is null)
	return;

declare @dergi_sayisi int
Select @dergi_sayisi=COUNT(*) from Dergi_Sayisi where (dergi_id=@dergi_id) -- derginin kaç tane sayısı olduğunu aldık.
Set @dergi_sayisi=@dergi_sayisi 

declare @baslangic_tarih date,@periyot_gun int
Select @baslangic_tarih=baslangic_tarih from Dergi where (id=@dergi_id) -- derginin başlangıç tarihi
Select @periyot_gun=periyot_gun from Dergi where (id=@dergi_id) -- derginin periyot gün sayısı


declare @olmasi_gereken_tarih date -- sayi eklemesi için olması gereken tarihi kontrol ederiz
Set @olmasi_gereken_tarih = DATEADD(day,@periyot_gun*@dergi_sayisi,@baslangic_tarih)

Set @dergi_sayisi=@dergi_sayisi + 1

INSERT INTO Dergi_Sayisi values(@dergi_id,@dergi_sayisi,@olmasi_gereken_tarih,@dergi_sayi_link)

GO