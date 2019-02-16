
CREATE PROCEDURE SP_Dergi_Ekle
@ad nvarchar(30),
@fiyat float,
@periyot_gun int,
@baslangic_tarih date,
@max_taahut int,
@sayi_link nvarchar(50)
AS

declare @dergi_id int
Select @dergi_id=id from dergi where (ad=@ad)

if(@dergi_id is not null)
	return
if(@fiyat<1)
	return
if(@periyot_gun<1)
	return
if(@baslangic_tarih is null)
	Set @baslangic_tarih = GETDATE()
	
--eğer en faazla 1 periyot gün KADAR(yani 0.999 periyot gününü ele alacaz) eski bir tarihten bahsediyorsa onu ekletmeyelim. çünkü -1'inci Sayı diye bir şey yok
declare @min_tarih date
Set @min_tarih = DATEADD(day,(-1)*@periyot_gun,GETDATE())

if(@baslangic_tarih<@min_tarih)
	return
	
INSERT INTO Dergi values(@ad,@fiyat,@periyot_gun,@baslangic_tarih,@max_taahut)

declare @dergi int
Select @dergi=id from Dergi where (ad=@ad)

exec SP_Dergi_Sayi_Ekle @dergi,@sayi_link

GO
